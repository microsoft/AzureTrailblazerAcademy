param(
    [string]$RGName
)

$appName = (Get-AzWebApp -ResourceGroupName $RGName).name

for($i=0;$i -lt 1000;$i++) {
   curl "https://$appName.azurewebsites.net/"
   curl "https://$appName.azurewebsites.net/#about"
   curl "https://$appName.azurewebsites.net/#abouts"
   curl "https://$appName.azurewebsites.net/tmz"
   curl "https://$appName.azurewebsites.net/#contact"
}