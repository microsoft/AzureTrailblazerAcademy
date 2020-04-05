# Azure Data Services Lab

## Prerequisites

- Microsoft Azure subscription
- SQL Management Studio (install on your local machine prior to DATA30) 
  [SQL Server Management Studio](https://docs.microsoft.com/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-2017) 


# Lab Setup

## Automated Deployment


## Step 1: Automated Deployment

Press the "*Deploy to Azure*" button below, to provision the Azure Services required required for this lab.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2FAzureTrailblazerAcademy%2Fmaster%2Fmonth2%2Fscripts%2Flab2_data_deployment.json" target="_blank"><img src="https://azuredeploy.net/deploybutton.png"/></a>

## Step 2: Deploy Azure Data Factory

Follow these steps to manually deploy Azure Data Factory.

1. In the Azure Portal, search for "Data Factories"
2. Click on the "Add" button
3. Fill out the form:
- **Name:** Choose a unique name for your Data Factory
- **Version:** V2
- **Subscription:** Choose your subscription
- **Resource Group:** Use the same Resource Group you used for the automated deployment in Step 1.
- **Location:** East US
- Uncheck the "Enable GIT" checkbox
4. Click the **Create** button


## Step 3: Validation of services

## Validate Correct provisioning of services

Estimated Time: 15 minutes
 
1. Once the automated deployment is complete, expand the resource group you used previosly and review that the following services are provisioned:

- Azure Synapse Analytics (SQL Data Warehouse)
- Azure Storage Accounts
- Azure Data Facotry

2. Click on the storage account, browse to Containers and confirm that *****
3. Capture the name of your storage acccount (Data Lake Storage)

## DO I WANT TO ADD THIS????
4. CLick on the SQL Data Warehouse
1. In the SQL Data Warehouse Window, click Pause to pause the service

## CHECK TEXT ABOVE


## Step 4: Populate the Azure Storage container Azure CloudShell

1. In the Azure Portal, open an Azure Cloudshell window.
   Complete the configuration process as needed

1. Type the following command to copy the deployment script to Azure Cloud Shell

   This will copy the deployment script that will populate the Azure Data Lake Storage Containers with sample files

```
curl -OL https://raw.githubusercontent.com/microsoft/AzureTrailblazerAcademy/master/month2/labs/lab_data/scripts/data_script.sh
```
1. Type the following to upload the sample files:

```
bash data_script.sh <storageaccountname>
```
Example: bash data_script.sh mdwdemostoredl

**NOTE:** You have now succesfully validated the demo setup and can go back to the demo script
