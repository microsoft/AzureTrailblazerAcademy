import logging
import azure.functions as func
import json
import time
from azure.storage.blob import BlobClient
from tempfile import NamedTemporaryFile
from requests import get, post

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    try:
        body = json.dumps(req.get_json())
        logging.info(body)
    except ValueError:
        return func.HttpResponse(
             "Invalid body",
             status_code=400
        )
    
    if body:
        result = compose_response(body)
        return func.HttpResponse(result, mimetype="application/json")
    else:
        return func.HttpResponse(
             "Invalid body",
             status_code=400
        )


def compose_response(json_data):
    #formurl = json.loads(json_data)['invoiceurl']
    values = json.loads(json_data)['values']
    # Prepare the Output before the loop
    results = {}
    results["values"] = []
    
    for value in values:
        output_record = process_form(value)
    #return json.dumps(output_record)
        if output_record != None:
            results["values"].append(output_record)
    return json.dumps(results, ensure_ascii=False)

##
def process_form(value):
    try:
        recordId = value['recordId']
        logging.info(recordId)
    except AssertionError as error:
        return (
                    {
                        "recordId": recordId,
                        "data":{
                            "text": errorr
                        }
                    }
                ) 

    data = value['data']
    logging.info(data)
    fullpath = value['data']['metadata_storage_path']
    logging.info(fullpath)

    # Endpoint URL for your form recognizer service
    endpoint = r"https://mcwformrecognizer.cognitiveservices.azure.com/"
    #Key for the Form Recognizer Service
    apim_key = "bc0c8f4327e64124862d915d9187d277"
    #Insert the ID for the form recognizer model
    model_id = "214abe60-51a7-43e9-bbfa-16856de34449"
    post_url = endpoint + "/formrecognizer/v2.0/custom/models/%s/analyze" % model_id
    #Azure storage connection string where files will be uploaded
    connectionstring = "DefaultEndpointsProtocol=https;AccountName=asastorecep321;AccountKey=A2v/AebxRyOfHOg9ZKOBOiI09i++twmZJbao/mm3B+Pq0j5f9oIg/eFjV9YV4g3eI912kKCBSjcUb0ggxOMmHw==;EndpointSuffix=core.windows.net"
    path = fullpath.split(".net/",1)
    path = path[1]
    blobpath = path.split("/",1)
    container = blobpath[0]
    name_of_blob = blobpath[1]
    blob = BlobClient.from_connection_string(connectionstring, container_name=container, blob_name=name_of_blob)
    local_file = NamedTemporaryFile()
    with open(local_file.name,"wb") as invoice_blob:
        download_stream = blob.download_blob()
        invoice_blob.write(download_stream.readall())

    logging.info("Loaded the files")
    #with open(invoice_blob,"rb") as f:
    #    data_bytes = f.read()

    #OR
    with open(local_file.name,"rb") as f:
        data_bytes = f.read()

    headers = {
        # Request headers
        'Content-Type': 'application/pdf',
        'Ocp-Apim-Subscription-Key': apim_key,
    }
    params = {
        "includeTextDetails": True
    }

    try:
        resp = post(url = post_url, data = data_bytes, headers = headers, params = params)
        if resp.status_code != 202:
            logging.info("POST analyze failed:\n%s" % json.dumps(resp.json()))
            return(
                    {
                        "recordId": recordId,
                        "data":{
                            "text": resp_json
                        }
                    }
                ) 
            #return 'POST analyze failed'
        logging.info("POST analyze succeeded:\n%s" % resp.headers)
        get_url = resp.headers["operation-location"]
    except Exception as e:
        logging.info("POST analyze failed:\n%s" % str(e))
        return(
                    {
                        "recordId": recordId,
                        "data":{
                            "text": str(e)
                        }
                    }
                ) 
        #return 'POST analyze failed'

    n_tries = 15
    n_try = 0
    wait_sec = 5
    max_wait_sec = 60
    while n_try < n_tries:
        try:
            resp = get(url = get_url, headers = {"Ocp-Apim-Subscription-Key": apim_key})
            resp_json = resp.json()
            if resp.status_code != 200:
                logging.info("GET analyze results failed:\n%s" % json.dumps(resp_json))
                return(
                    {
                        "recordId": recordId,
                        "data":{
                            "text": resp_json
                        }
                    }
                ) 
                #return 'GET analyze results failed'
            status = resp_json["status"]
            if status == "succeeded":
                logging.info("Analysis succeeded")
                #logging.info(json.dumps(resp_json, indent=4))
                return(
                    {
                        "recordId": recordId,
                        "data":{
                            "text": resp_json
                        }
                    }
                ) 
                #resp_json
                #return json.dumps(resp_json, indent=4)
            if status == "failed":
                logging.info("Analysis failed")
                return(
                    {
                        "recordId": recordId,
                        "data":{
                            "text": "Analysis failed"
                        }
                    }
                ) 
                #return 'Analysis failed:\n%s' % json.dumps(resp_json)
            # Analysis still running. Wait and retry.
            time.sleep(wait_sec)
            n_try += 1
            wait_sec = min(2*wait_sec, max_wait_sec)     
        except Exception as e:
            msg = "GET analyze results failed:\n%s" % str(e)
            logging.info(msg)
            return(
                    {
                        "recordId": recordId,
                        "data":{
                            "text": msg
                        }
                    }
                ) 
            #return 'Exception'
    logging.info("Analyze operation did not complete within the allocated time.")