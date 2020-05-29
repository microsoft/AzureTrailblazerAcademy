param(
    [string]$RGName,
    [string]$ScaleSetName
)

# Define the script for your Desired Configuration to download and run
$dscConfig = @{
  "wmfVersion" = "latest";
  "configuration" = @{
    "url" = "https://github.com/Azure-Samples/compute-automation-configurations/raw/master/dsc.zip";
    "script" = "configure-http.ps1";
    "function" = "WebsiteTest";
  };
}

# Get information about the scale set
$vmss = Get-AzVmss `
                -ResourceGroupName "$RGName" `
                -VMScaleSetName "$ScaleSetName"

# Add the Desired State Configuration extension to install IIS and configure basic website
$vmss = Add-AzVmssExtension `
    -VirtualMachineScaleSet $vmss `
    -Publisher Microsoft.Powershell `
    -Type DSC `
    -TypeHandlerVersion 2.24 `
    -Name "DSC" `
    -Setting $dscConfig

# Update the scale set and apply the Desired State Configuration extension to the VM instances
Update-AzVmss `
    -ResourceGroupName "$RGName" `
    -Name "$ScaleSetName"  `
$vmss = Add-AzVmssExtension `
    -VirtualMachineScaleSet $vmss

Update-AzVmssInstance -ResourceGroupName $RGName -VMScaleSetName $ScaleSetName -InstanceId *