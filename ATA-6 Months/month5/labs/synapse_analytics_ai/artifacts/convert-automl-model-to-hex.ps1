$resourceGroupName = Read-Host -Prompt "Enter the name of the resource group containing the Azure Synapse Analytics Workspace"
$uniqueId = Read-Host -Prompt "Enter the unique suffix you used in the deployment"

function convert-to-hex($InputFile) {
    [string]$inputFilePath = Resolve-Path $InputFile -ErrorAction Stop
    [string]$outputFilePath = $inputFilePath + ".hex"
    $inputFileStream = [System.IO.File]::Open($inputFilePath, [System.IO.FileMode]::Open)
    try
    {
        $reader = New-Object System.IO.BinaryReader($inputFileStream)
        $writer = New-Object System.IO.StreamWriter($outputFilePath)
        if ($reader -and $writer)
        {
            while ($inputFileStream.Position -lt $inputFileStream.Length)
            {
                $byte = $reader.ReadByte()
                $writer.Write([System.BitConverter]::ToString($byte))
            }
            Write-Host "Generated '$outputFilePath'"
        }
    }
    catch {
        Write-Host $_
    }
    finally
    {
        if ($inputFileStream)
        {
            $inputFileStream.Close()
        }
        if ($reader)
        {
            $reader.Close()
        }
        if ($writer)
        {
            $writer.Close()
        }
    }
}

$dataLakeAccountName = "asadatalake$($uniqueId)"
$dataLakeAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $dataLakeAccountName
New-Item -Path './modelconversion' -ItemType Directory
Get-AzDataLakeGen2ItemContent -Context $dataLakeAccount.Context -FileSystem 'wwi-02' -Path 'ml/onnx-hex/product_seasonality_classifier.onnx' -Destination './modelconversion/product_seasonality_classifier.onnx' -Force
convert-to-hex('./modelconversion/product_seasonality_classifier.onnx')
New-AzDataLakeGen2Item -Context $dataLakeAccount.Context -FileSystem 'wwi-02' -Path 'ml/onnx-hex/product_seasonality_classifier.onnx.hex' -Source './modelconversion/product_seasonality_classifier.onnx.hex' -Force
Remove-AzDataLakeGen2Item -Context $dataLakeAccount.Context -FileSystem 'wwi-02' -Path 'ml/onnx-hex/product_seasonality_classifier.onnx' -Force
Write-Host 'Model Conversion to Hex Completed'