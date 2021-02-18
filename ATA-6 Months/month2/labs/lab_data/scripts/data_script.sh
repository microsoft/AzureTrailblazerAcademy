  
curl -OL https://raw.githubusercontent.com/microsoft/AzureTrailblazerAcademy/master/month2/labs/lab_data/data/logs/weblogsQ1.log
curl -OL https://raw.githubusercontent.com/microsoft/AzureTrailblazerAcademy/master/month2/labs/lab_data/data/logs/weblogsQ2.log
curl -OL https://raw.githubusercontent.com/microsoft/AzureTrailblazerAcademy/master/month2/labs/lab_data/data/logs/preferences.json
curl -OL https://raw.githubusercontent.com/microsoft/AzureTrailblazerAcademy/master/month2/labs/lab_data/data/Staticfiles/DimDate2.txt
az storage copy --source-local-path "$PWD/weblog*.log" --destination-account-name $1 --destination-container logs
az storage copy --source-local-path "$PWD/Dim*.txt" --destination-account-name $1 --destination-container data
az storage copy --source-local-path "$PWD/prefer*.json" --destination-account-name $1 --destination-container data
az storage copy --source-local-path "$PWD/prefer*.json" --destination-account-name $1 --destination-container logs
