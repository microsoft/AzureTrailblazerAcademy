function List-StorageAccountKeys {

    param(
    [parameter(Mandatory=$true)]
    [String]
    $SubscriptionId,

    [parameter(Mandatory=$true)]
    [String]
    $ResourceGroupName,

    [parameter(Mandatory=$true)]
    [String]
    $Name
    )

    $uri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourcegroups/$($ResourceGroupName)/providers/Microsoft.Storage/storageAccounts/$($Name)/listKeys?api-version=2015-05-01-preview"

    Write-Debug "Calling endpoint $uri"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method POST -Headers @{ Authorization="Bearer $managementToken" } -ContentType "application/json"
 
    Write-Debug $result

    return $result.key1
}

function List-CosmosDBKeys {

    param(
    [parameter(Mandatory=$true)]
    [String]
    $SubscriptionId,

    [parameter(Mandatory=$true)]
    [String]
    $ResourceGroupName,

    [parameter(Mandatory=$true)]
    [String]
    $Name
    )

    $uri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourcegroups/$($ResourceGroupName)/providers/Microsoft.DocumentDB/databaseAccounts/$($Name)/listKeys?api-version=2016-03-31"

    Write-Debug "Calling endpoint $uri"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method POST -Headers @{ Authorization="Bearer $managementToken" } -ContentType "application/json"
 
    Write-Debug $result

    return $result.primaryMasterKey
}

function Create-KeyVaultLinkedService {
    
    param(
    [parameter(Mandatory=$true)]
    [String]
    $TemplatesPath,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $Name
    )

    $keyVaultTemplate = Get-Content -Path "$($TemplatesPath)/key_vault_linked_service.json"
    $keyVault = $keyVaultTemplate.Replace("#LINKED_SERVICE_NAME#", $Name).Replace("#KEY_VAULT_NAME#", $Name)
    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/linkedservices/$($Name)?api-version=2019-06-01-preview"


    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $keyVault -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
 
    return $result
}

function Create-BlobStorageLinkedService {
    
    param(
    [parameter(Mandatory=$true)]
    [String]
    $TemplatesPath,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $Name,

    [parameter(Mandatory=$true)]
    [String]
    $Key
    )

    $keyVaultTemplate = Get-Content -Path "$($TemplatesPath)/blob_storage_linked_service.json"
    $keyVault = $keyVaultTemplate.Replace("#LINKED_SERVICE_NAME#", $Name).Replace("#STORAGE_ACCOUNT_NAME#", $Name).Replace("#STORAGE_ACCOUNT_KEY#", $Key)
    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/linkedservices/$($Name)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $keyVault -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
 
    return $result
}

function Create-DataLakeLinkedService {
    
    param(
    [parameter(Mandatory=$true)]
    [String]
    $TemplatesPath,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $Name,

    [parameter(Mandatory=$true)]
    [String]
    $Key
    )

    $itemTemplate = Get-Content -Path "$($TemplatesPath)/data_lake_linked_service.json"
    $item = $itemTemplate.Replace("#LINKED_SERVICE_NAME#", $Name).Replace("#STORAGE_ACCOUNT_NAME#", $Name).Replace("#STORAGE_ACCOUNT_KEY#", $Key)
    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/linkedservices/$($Name)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $item -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
    
    return $result
}

function Create-CosmosDBLinkedService {
    
    param(
    [parameter(Mandatory=$true)]
    [String]
    $TemplatesPath,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $Name,

    [parameter(Mandatory=$true)]
    [String]
    $Database,

    [parameter(Mandatory=$true)]
    [String]
    $Key
    )

    $cosmosDbTemplate = Get-Content -Path "$($TemplatesPath)/cosmos_db_linked_service.json"
    $cosmosDb = $cosmosDbTemplate.Replace("#LINKED_SERVICE_NAME#", $Name).Replace("#COSMOSDB_ACCOUNT_NAME#", $Name).Replace("#COSMOSDB_DATABASE_NAME#", $Database).Replace("#COSMOSDB_ACCOUNT_KEY#", $Key)
    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/linkedServices/$($Name)?api-version=2019-06-01-preview"

    Write-Information "Calling endpoint $uri"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $cosmosDb -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
 
    Write-Information $result

    return $result
}

function Create-SQLPoolKeyVaultLinkedService {
    
    param(
    [parameter(Mandatory=$true)]
    [String]
    $TemplatesPath,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $Name,

    [parameter(Mandatory=$true)]
    [String]
    $DatabaseName,

    [parameter(Mandatory=$true)]
    [String]
    $UserName,

    [parameter(Mandatory=$true)]
    [String]
    $KeyVaultLinkedServiceName,

    [parameter(Mandatory=$true)]
    [String]
    $SecretName
    )

    $itemTemplate = Get-Content -Path "$($TemplatesPath)/sql_pool_key_vault_linked_service.json"
    $item = $itemTemplate.Replace("#LINKED_SERVICE_NAME#", $Name).Replace("#WORKSPACE_NAME#", $WorkspaceName).Replace("#DATABASE_NAME#", $DatabaseName).Replace("#USER_NAME#", $UserName).Replace("#KEY_VAULT_LINKED_SERVICE_NAME#", $KeyVaultLinkedServiceName).Replace("#SECRET_NAME#", $SecretName)
    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/linkedServices/$($Name)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $item -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"

    return $result
}

function Create-IntegrationRuntime {
    
    param(
    [parameter(Mandatory=$true)]
    [String]
    $TemplatesPath,

    [parameter(Mandatory=$true)]
    [String]
    $SubscriptionId,

    [parameter(Mandatory=$true)]
    [String]
    $ResourceGroupName,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $Name,

    [parameter(Mandatory=$true)]
    [Int32]
    $CoreCount,

    [parameter(Mandatory=$true)]
    [Int32]
    $TimeToLive
    )

    $integrationRuntimeTemplate = Get-Content -Path "$($TemplatesPath)/integration_runtime.json"
    $integrationRuntime = $integrationRuntimeTemplate.Replace("#INTEGRATION_RUNTIME_NAME#", $Name).Replace("#CORE_COUNT#", $CoreCount).Replace("#TIME_TO_LIVE#", $TimeToLive)
    $uri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourcegroups/$($ResourceGroupName)/providers/Microsoft.Synapse/workspaces/$($WorkspaceName)/integrationruntimes/$($Name)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $integrationRuntime -Headers @{ Authorization="Bearer $managementToken" } -ContentType "application/json"
 
    return $result
}

function Get-Workspace {
    
    param(
    [parameter(Mandatory=$true)]
    [String]
    $SubscriptionId,

    [parameter(Mandatory=$true)]
    [String]
    $ResourceGroupName,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName
    )

    $uri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourcegroups/$($ResourceGroupName)/providers/Microsoft.Synapse/workspaces/$($WorkspaceName)?api-version=2019-06-01-preview"

    Ensure-ValidTokens

    try {
        $result = Invoke-RestMethod  -Uri $uri -Method GET -Headers @{ Authorization="Bearer $managementToken" }  
        return $result  
    }
    catch {
        return $null
    }
}

function Get-IntegrationRuntime {
    
    param(
    [parameter(Mandatory=$true)]
    [String]
    $SubscriptionId,

    [parameter(Mandatory=$true)]
    [String]
    $ResourceGroupName,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $Name
    )

    $uri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourcegroups/$($ResourceGroupName)/providers/Microsoft.Synapse/workspaces/$($WorkspaceName)/integrationruntimes/$($Name)?api-version=2019-06-01-preview"

    Ensure-ValidTokens

    try {
        $result = Invoke-RestMethod  -Uri $uri -Method GET -Headers @{ Authorization="Bearer $managementToken" }  
        return $result  
    }
    catch {
        return $null
    }
}

function Delete-IntegrationRuntime {
    
    param(
    [parameter(Mandatory=$true)]
    [String]
    $SubscriptionId,

    [parameter(Mandatory=$true)]
    [String]
    $ResourceGroupName,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $Name
    )

    $uri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourcegroups/$($ResourceGroupName)/providers/Microsoft.Synapse/workspaces/$($WorkspaceName)/integrationruntimes/$($Name)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method DELETE -Headers @{ Authorization="Bearer $managementToken" }
 
    return $result
}

function Create-Dataset {
    
    param(
    [parameter(Mandatory=$true)]
    [String]
    $DatasetsPath,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $Name,

    [parameter(Mandatory=$true)]
    [String]
    $LinkedServiceName
    )

    $itemTemplate = Get-Content -Path "$($DatasetsPath)/$($Name).json"
    $item = $itemTemplate.Replace("#LINKED_SERVICE_NAME#", $LinkedServiceName)
    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/datasets/$($Name)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $item -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
    
    return $result
}

function Create-Pipeline {
    
    param(
    [parameter(Mandatory=$true)]
    [String]
    $PipelinesPath,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $Name,

    [parameter(Mandatory=$true)]
    [String]
    $FileName,

    [parameter(Mandatory=$false)]
    [Hashtable]
    $Parameters = $null
    )

    $item = Get-Content -Path "$($PipelinesPath)/$($FileName).json"
    
    if ($Parameters -ne $null) {
        foreach ($key in $Parameters.Keys) {
            $item = $item.Replace("#$($key)#", $Parameters[$key])
        }
    }

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/pipelines/$($Name)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $item -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
    
    return $result
}

function Run-Pipeline {
    
    param(

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $Name
    )

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/pipelines/$($Name)/createRun?api-version=2018-06-01"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method POST -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
    
    return $result
}

function Get-PipelineRun {
    
    param(

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $RunId
    )

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/pipelineruns/$($RunId)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method GET -Headers @{ Authorization="Bearer $synapseToken" }
    
    return $result
}

function Wait-ForPipelineRun {
    
    param(

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $RunId
    )

    Write-Information "Waiting for any pending operation to be properly triggered..."
    Start-Sleep -Seconds 20

    $result = Get-PipelineRun -WorkspaceName $WorkspaceName -RunId $RunId

    while ($result.status -eq "InProgress") {
        
        Write-Information "Waiting for operation to complete..."
        Start-Sleep -Seconds 10
        $result = Get-PipelineRun -WorkspaceName $WorkspaceName -RunId $RunId
    }

    return $result
}

function Get-OperationResult {
    
    param(

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $OperationId
    )

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/operationResults/$($OperationId)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method GET -Headers @{ Authorization="Bearer $synapseToken" }
    
    return $result
}

function Wait-ForOperation {
    
    param(

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$false)]
    [String]
    $OperationId
    )

    if ([string]::IsNullOrWhiteSpace($OperationId)) {
        Write-Information "Cannot wait on an empty operation id."
        return
    }

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/operationResults/$($OperationId)?api-version=2019-06-01-preview"
    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method GET -Headers @{ Authorization="Bearer $synapseToken" }

    while ($result.status -ne $null) {
        
        if ($result.status -eq "Failed") {
            throw $result.error
        }

        Write-Information "Waiting for operation to complete (status is $($result.status))..."
        Start-Sleep -Seconds 10
        Ensure-ValidTokens
        $result = Invoke-RestMethod  -Uri $uri -Method GET -Headers @{ Authorization="Bearer $synapseToken" }
    }

    return $result
}

function Delete-ASAObject {
    
    param(
   
    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $Category,

    [parameter(Mandatory=$true)]
    [String]
    $Name
    )

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/$($Category)/$($Name)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method DELETE -Headers @{ Authorization="Bearer $synapseToken" }
    
    return $result
}

function Get-ASAObject {
    
    param(
   
    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $Category,

    [parameter(Mandatory=$true)]
    [String]
    $Name
    )

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/$($Category)/$($Name)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method GET -Headers @{ Authorization="Bearer $synapseToken" }
    
    return $result
}

function Control-SQLPool {

    param(
    [parameter(Mandatory=$true)]
    [String]
    $SubscriptionId,

    [parameter(Mandatory=$true)]
    [String]
    $ResourceGroupName,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SQLPoolName,

    [parameter(Mandatory=$true)]
    [String]
    $Action,

    [parameter(Mandatory=$false)]
    [String]
    $SKU
    )

    $uri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourcegroups/$($ResourceGroupName)/providers/Microsoft.Synapse/workspaces/$($WorkspaceName)/sqlPools/$($SQLPoolName)#ACTION#?api-version=2019-06-01-preview"
    $method = "POST"
    $body = $null

    if (($Action.ToLowerInvariant() -eq "pause") -or ($Action.ToLowerInvariant() -eq "resume")) {

        $uri = $uri.Replace("#ACTION#", "/$($Action)")

    } elseif ($Action.ToLowerInvariant() -eq "scale") {
        
        $uri = $uri.Replace("#ACTION#", "")
        $method = "PATCH"
        $body = "{""sku"":{""name"":""$($SKU)""}}"

    } else {
        
        throw "The $($Action) control action is not supported."

    }

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method $method -Body $body -Headers @{ Authorization="Bearer $managementToken" } -ContentType "application/json"

    return $result
}

function Get-SQLPool {

    param(
    [parameter(Mandatory=$true)]
    [String]
    $SubscriptionId,

    [parameter(Mandatory=$true)]
    [String]
    $ResourceGroupName,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SQLPoolName
    )

    $uri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourcegroups/$($ResourceGroupName)/providers/Microsoft.Synapse/workspaces/$($WorkspaceName)/sqlPools/$($SQLPoolName)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method GET -Headers @{ Authorization="Bearer $managementToken" } -ContentType "application/json"

    return $result
}

function Wait-ForSQLPool {

    param(
    [parameter(Mandatory=$true)]
    [String]
    $SubscriptionId,

    [parameter(Mandatory=$true)]
    [String]
    $ResourceGroupName,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SQLPoolName,

    [parameter(Mandatory=$false)]
    [String]
    $TargetStatus
    )

    Write-Information "Waiting for any pending operation to be properly triggered..."
    Start-Sleep -Seconds 20

    $result = Get-SQLPool -SubscriptionId $SubscriptionId -ResourceGroupName $ResourceGroupName -WorkspaceName $WorkspaceName -SQLPoolName $SQLPoolName

    if ($TargetStatus) {
        while ($result.properties.status -ne $TargetStatus) {
            Write-Information "Current status is $($result.properties.status). Waiting for $($TargetStatus) status..."
            Start-Sleep -Seconds 10
            $result = Get-SQLPool -SubscriptionId $SubscriptionId -ResourceGroupName $ResourceGroupName -WorkspaceName $WorkspaceName -SQLPoolName $SQLPoolName
        }
    }

    Write-Information "The SQL pool has now the $($TargetStatus) status."
    return $result
}

function Wait-ForSQLQuery {

    param(
    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SQLPoolName,

    [parameter(Mandatory=$true)]
    [String]
    $Label,

    [parameter(Mandatory=$false)]
    [DateTime]
    $ReferenceTime
    )

    Write-Information "Waiting for any pending operation to be properly triggered..."
    Start-Sleep -Seconds 20
    
    $sql = "select status from sys.dm_pdw_exec_requests where [label] = '$($Label)' and submit_time > '$($ReferenceTime.ToString("yyyy-MM-dd HH:mm:ss"))'"

    $result = Execute-SQLQuery -WorkspaceName $workspaceName -SQLPoolName $sqlPoolName -SQLQuery $sql
    while (($result.data[0][0] -ne "Cancelled") -and ($result.data[0][0] -ne "Completed")) {
        Write-Information "Current status is $($result.data[0][0]). Waiting for query to finish..."
            Start-Sleep -Seconds 10
            $result = Execute-SQLQuery -WorkspaceName $workspaceName -SQLPoolName $sqlPoolName -SQLQuery $sql
    }

    if ($result.data[0][0] -eq "Cancelled") {
        throw "There was an error executing the query."
    }

    Write-Information "The query was successfully executed."
}

function CallJavascript($message, $secret)
{
    $url = "https://ciprian-hash.azurewebsites.net/hash.html"
 
    $ie = New-Object -comobject InternetExplorer.Application
    $ie.visible = $true;

    $ie.Navigate($url)
    $ie.visible = $false;
 
    while($ie.Busy) 
    {
        start-sleep -m 100
    } 

    $inputs = $ie.Document.body.getElementsByTagName("input");

    $msgInput = $inputs | where {$_.name -eq "msg"}
    $secretInput = $inputs | where {$_.name -eq "secret"}
    $outputInput = $inputs | where {$_.name -eq "output"}

    $buttons = $ie.Document.body.getElementsByTagName("button");
    $btnGo = $buttons | where {$_.name -eq "btnGo"}
 
    $msgInput.value = $message.replace("`r","\r").replace("`n","\n");
    $secretInput.value = $secret;
    $btnGo.click();
    
    $ret = $outputInput.value;
    $ie.quit();

    if (!$ret)
    {
        write-host "Error getting CSRF" -ForegroundColor red;
    }
 
    return $ret;
}

function GetCSRF($token, $azurehost, $msTime)
{
    $start = [Datetime]::UtcNow.tostring("yyyy-MM-ddTHH:mm:ssZ");
    $end = [Datetime]::UtcNow.AddMilliseconds($msTime).tostring("yyyy-MM-ddTHH:mm:ssZ");

    <#
    # Test values
    $start = "2020-05-13T19:46:18Z";
    $end = "2020-05-13T19:56:18Z";
    $token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IkN0VHVoTUptRDVNN0RMZHpEMnYyeDNRS1NSWSIsImtpZCI6IkN0VHVoTUptRDVNN0RMZHpEMnYyeDNRS1NSWSJ9.eyJhdWQiOiJodHRwczovL3NxbC5henVyZXN5bmFwc2UubmV0IiwiaXNzIjoiaHR0cHM6Ly9zdHMud2luZG93cy5uZXQvY2VmY2I4ZTctZWUzMC00OWI4LWIxOTAtMTMzZjFkYWFmZDg1LyIsImlhdCI6MTU4OTM5NjQ2NCwibmJmIjoxNTg5Mzk2NDY0LCJleHAiOjE1ODk0MDAzNjQsImFjciI6IjEiLCJhaW8iOiI0MmRnWUVpS1BHSnQ0S2lUZCtxSXdmNEhpeC81clZ4Z29MUEFsY2RGNEkvL1V2MHdIaU1BIiwiYW1yIjpbInB3ZCJdLCJhcHBpZCI6ImVjNTJkMTNkLTJlODUtNDEwZS1hODlhLThjNzlmYjZhMzJhYyIsImFwcGlkYWNyIjoiMCIsImZhbWlseV9uYW1lIjoiMTc3OTA0IiwiZ2l2ZW5fbmFtZSI6Ik9ETF9Vc2VyIiwiaWR0eXAiOiJ1c2VyIiwiaXBhZGRyIjoiMTA0LjIuODUuMTM3IiwibmFtZSI6Ik9ETF9Vc2VyIDE3NzkwNCIsIm9pZCI6IjQ1YWYyNWIwLTRlZjAtNDczNS04YWY5LTUzYWMzZmVmYTA3YiIsInB1aWQiOiIxMDAzMjAwMEJDMTIyN0QwIiwic2NwIjoidXNlcl9pbXBlcnNvbmF0aW9uIiwic3ViIjoiTWRIYjZ0a0tfVXdHOVNTdnE0Szd2UmdkUmF5c0pkQlB4QmxWdzk5SkNTUSIsInRpZCI6ImNlZmNiOGU3LWVlMzAtNDliOC1iMTkwLTEzM2YxZGFhZmQ4NSIsInVuaXF1ZV9uYW1lIjoib2RsX3VzZXJfMTc3OTA0QG1zYXp1cmVsYWJzLm9ubWljcm9zb2Z0LmNvbSIsInVwbiI6Im9kbF91c2VyXzE3NzkwNEBtc2F6dXJlbGFicy5vbm1pY3Jvc29mdC5jb20iLCJ1dGkiOiJ0VnJ5Qi1ab3AwaWlmUlNHeWVzUUFBIiwidmVyIjoiMS4wIn0.E1RLg9Od_Mk63apevX-lf4NQCF-5Y-9kgKLUxLBYxp9wlTXpiXZdL8VaWLMQLro3ox7ZbYDUSv5WGq9fAC_sET74KM-J_Bx7Ks-qyFmYErAoNtMUG1_YfjeQlbfj4Ar5PxVQB0radZtTtWY2xvx4c_F-9cZR-4duap3PIsSW4yYfTuaoglsgIUjscetlXARkdwweAiAyYlxNYbIys6S6HXNFAM1Kaqa0mF4y49NQBsLgK5A8DpPmfw-hqou9Z6du_W_Wp4igpvPDsg_BjWfUvq29v0JLWCmIls_YR75q0p0ASTX50hLOcKuRJc9LmehNTcjevWzN4YI-_LXdXi7S6g";
    $azureHost = "asaworkspace177904-ondemand.sql.azuresynapse.net:1443";
    #>

    $rawsig = "not-before=$($start)`r`nnot-after=$($end)`r`nauthorization: $($token)`r`nhost: $($azurehost)`r`n";

    #$hash = Hash $rawsig $token;
    #$signed = ToBase64 $hash;

    $signed = CallJavascript $rawsig $token;

    $sig = "$($signed); not-before=$($start); not-after=$($end); signed-headers=authorization,host"
    
    #test result : u3fEvp2502DbFuSArb0sPGB7ODi40KxrsYVTjlVQlhQ=
    return $sig;
}

function Execute-SQLQuery {

    param(
    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SQLPoolName,

    [parameter(Mandatory=$true)]
    [String]
    $SQLQuery,

    [parameter(Mandatory=$false)]
    [Boolean]
    $ForceReturn
    )

    $uri = "https://$($WorkspaceName).sql.azuresynapse.net:1443/databases/$($SQLPoolName)/query?api-version=2018-08-01-preview&application=ArcadiaSqlEditor&topRows=5000&queryTimeoutInMinutes=59&allResultSets=true"

    $headers = @{ 
        Authorization="Bearer $($synapseSQLToken)"
    }

    if ($ForceReturn) {
        try {
            Ensure-ValidTokens
            $result = Invoke-WebRequest -Uri $uri -Method POST -Body $SQLQuery -Headers $headers -ContentType "application/x-www-form-urlencoded; charset=UTF-8" -UseBasicParsing -TimeoutSec 15
        } catch {}
        return
    }

    Ensure-ValidTokens;

    $csrf = GetCSRF "Bearer $synapseSQLToken" "$($WorkspaceName).sql.azuresynapse.net:1443" 300000;

    $headers.add("X-CSRF-Signature", $csrf);

    $rawResult = Invoke-WebRequest -Uri $uri -Method POST -Body $SQLQuery -Headers $headers -ContentType "application/x-www-form-urlencoded; charset=UTF-8" -UseBasicParsing

    $result = ConvertFrom-Json $rawResult.Content

    $errors = @()
    foreach ($partialResult in $result) {
        if (-not $partialResult.isSuccess) {

            $errors += $partialResult.message
        }
    }

    if ($errors.Count -gt 0) {
        throw (-join $errors)
    }

    return $result
}

function Execute-SQLScriptFile {

    param(
    [parameter(Mandatory=$true)]
    [String]
    $SQLScriptsPath,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SQLPoolName,

    [parameter(Mandatory=$true)]
    [String]
    $FileName,

    [parameter(Mandatory=$false)]
    [Hashtable]
    $Parameters,

    [parameter(Mandatory=$false)]
    [Boolean]
    $ForceReturn
    )

    $vals = $filename.split("_");
    $sqlpoolname = $vals[1];

    $sqlQuery = Get-Content -Raw -Path "$($SQLScriptsPath)/$($FileName).sql"

    if ($Parameters) {
        foreach ($key in $Parameters.Keys) {
            $sqlQuery = $sqlQuery.Replace("#$($key)#", $Parameters[$key])
        }
    }

    return Execute-SQLQuery -WorkspaceName $WorkspaceName -SQLPoolName $SQLPoolName -SQLQuery $sqlQuery -ForceReturn $ForceReturn
}

function Execute-SQLScriptFile-SqlCmd {

    param(
    [parameter(Mandatory=$true)]
    [String]
    $SQLScriptsPath,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SQLPoolName,

    [parameter(Mandatory=$true)]
    [String]
    $SQLUserName,

    [parameter(Mandatory=$true)]
    [String]
    $SQLPassword,

    [parameter(Mandatory=$true)]
    [String]
    $FileName,

    [parameter(Mandatory=$false)]
    [Hashtable]
    $Parameters
    )

    $vals = $filename.split("_");
    $sqlpoolname = $vals[1];

    $sqlQuery = Get-Content -Raw -Path "$($SQLScriptsPath)/$($FileName).sql"

    if ($Parameters) {
        foreach ($key in $Parameters.Keys) {
            $sqlQuery = $sqlQuery.Replace("#$($key)#", $Parameters[$key])
        }
    }

    $result = 0
    $sqlConnectionString = "Server=tcp:$($WorkspaceName).sql.azuresynapse.net,1433;Initial Catalog=$($SQLPoolName);Persist Security Info=False;User ID=$($SQLUserName);Password=$($SQLPassword);MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
    ForEach ($line in $($sqlQuery -split "`r`n"))  
    {        
        $result = Invoke-SqlCmd -Query $SQLQuery -ConnectionString $sqlConnectionString
    }
    return $result
}

function Create-SQLScript {
    
    param(
    [parameter(Mandatory=$true)]
    [String]
    $TemplatesPath,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $Name,

    [parameter(Mandatory=$true)]
    [String]
    $ScriptFileName
    )

    $item = Get-Content -Raw -Path "$($TemplatesPath)/sql_script.json"
    $item = $item.Replace("#SQL_SCRIPT_NAME#", $Name)
    $jsonItem = ConvertFrom-Json $item

    $query = Get-Content -Raw -Path $ScriptFileName -Encoding utf8
    $query = ConvertFrom-Json (ConvertTo-Json $query)

    $jsonItem.properties.content.query = $query.value
    $item = ConvertTo-Json $jsonItem -Depth 100

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/sqlscripts/$($Name)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $item -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
    
    return $result
}

function Get-SparkPool {

    param(
    [parameter(Mandatory=$true)]
    [String]
    $SubscriptionId,

    [parameter(Mandatory=$true)]
    [String]
    $ResourceGroupName,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SparkPoolName
    )

    $uri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourcegroups/$($ResourceGroupName)/providers/Microsoft.Synapse/workspaces/$($WorkspaceName)/bigDataPools/$($SparkPoolName)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method GET -Headers @{ Authorization="Bearer $managementToken" } -ContentType "application/json"

    return $result
}

function Create-SparkNotebook {
    
    param(
    [parameter(Mandatory=$true)]
    [String]
    $TemplatesPath,

    [parameter(Mandatory=$true)]
    [String]
    $SubscriptionId,

    [parameter(Mandatory=$true)]
    [String]
    $ResourceGroupName,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SparkPoolName,

    [parameter(Mandatory=$true)]
    [String]
    $Name,

    [parameter(Mandatory=$true)]
    [String]
    $NotebookFileName,

    [parameter(Mandatory=$false)]
    [String]
    $TemplateFileName = "spark_notebook",

    [parameter(Mandatory=$false)]
    [Hashtable]
    $CellParams
    )


    $item = Get-Content -Raw -Path "$($TemplatesPath)/$($TemplateFileName).json"
    $params = @{
        "#NOTEBOOK_NAME#" = $Name
        "#SPARK_POOL_NAME#" = $SparkPoolName
        "#SUBSCRIPTION_ID#" = $SubscriptionId
        "#RESOURCE_GROUP_NAME#" = $ResourceGroupName
        "#WORKSPACE_NAME#" = $WorkspaceName
    }
    foreach ($paramName in $params.Keys) {
        $item = $item.Replace($paramName, $params[$paramName])
    }
    $jsonItem = ConvertFrom-Json $item
    
    $notebook = Get-Content -Raw -Path $NotebookFileName
    $jsonNotebook = ConvertFrom-Json $notebook
    
    $jsonItem.properties.cells = $jsonNotebook.cells

    if ($CellParams) {
        foreach ($cellParamName in $cellParams.Keys) {
            foreach ($cell in $jsonItem.properties.cells) {
                for ($i = 0; $i -lt $cell.source.Count; $i++) {
                    $cell.source[$i] = $cell.source[$i].Replace($cellParamName, $CellParams[$cellParamName])
                }
            }
        }
    }
    
    $item = ConvertTo-Json $jsonItem -Depth 100

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/notebooks/$($Name)?api-version=2019-06-01-preview"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method PUT -Body $item -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
    
    return $result
}

function Start-SparkNotebookSession {
    param(
    [parameter(Mandatory=$true)]
    [String]
    $TemplatesPath,

    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SparkPoolName,

    [parameter(Mandatory=$true)]
    [String]
    $NotebookName,

    [parameter(Mandatory=$false)]
    [String]
    $TemplateFileName = "spark_notebook_session"
    )
    
    $item = Get-Content -Raw -Path "$($TemplatesPath)/$($TemplateFileName).json"
    $item = $item.Replace("#SPARK_SESSION_NAME#", "$($NotebookName)_$($SparkPoolName)_1")

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/livyApi/versions/2019-11-01-preview/sparkPools/$($SparkPoolName)/sessions"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method POST -Body $item -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
    
    return $result
}

function Get-SparkNotebookSession {
    param(
    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SparkPoolName,

    [parameter(Mandatory=$true)]
    [int]
    $SessionId
    )

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/livyApi/versions/2019-11-01-preview/sparkPools/$($SparkPoolName)/sessions/$($SessionId)?detailed=true"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method GET -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
    
    return $result
}

function Wait-ForSparkNotebookSession {
    param(
    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SparkPoolName,

    [parameter(Mandatory=$true)]
    [int]
    $SessionId
    )

    Write-Information "Waiting for any pending operation to be properly triggered..."
    Start-Sleep -Seconds 20

    $result = Get-SparkNotebookSession -WorkspaceName $WorkspaceName -SparkPoolName $SparkPoolName -SessionId $SessionId

    while (($result.state -eq "not_started") -or ($result.state -eq "starting")) {
        Write-Information "Current status is $($result.state). Waiting for idle, busy, shutting_down, error, dead, or success."
        Start-Sleep -Seconds 10
        $result = Get-SparkNotebookSession -WorkspaceName $WorkspaceName -SparkPoolName $SparkPoolName -SessionId $SessionId
    }

    Write-Information "The Spark notebook session has now the $($result.state) status."
    return $result
}

function Delete-SparkNotebookSession {
    param(
    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SparkPoolName,

    [parameter(Mandatory=$true)]
    [int]
    $SessionId
    )

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/livyApi/versions/2019-11-01-preview/sparkPools/$($SparkPoolName)/sessions/$($SessionId)"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method DELETE -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
    
    return $result
}

function Start-SparkNotebookSessionStatement {

    param(
    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SparkPoolName,

    [parameter(Mandatory=$true)]
    [int]
    $SessionId,

    [parameter(Mandatory=$true)]
    [String]
    $Statement
    )

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/livyApi/versions/2019-11-01-preview/sparkPools/$($SparkPoolName)/sessions/$($SessionId)/statements"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method POST -Body $Statement -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
    
    return $result
}

function Get-SparkNotebookSessionStatement {

    param(
    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SparkPoolName,

    [parameter(Mandatory=$true)]
    [int]
    $SessionId,

    [parameter(Mandatory=$true)]
    [int]
    $StatementId
    )

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/livyApi/versions/2019-11-01-preview/sparkPools/$($SparkPoolName)/sessions/$($SessionId)/statements/$($StatementId)"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method GET -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
    
    return $result
}

function Wait-ForSparkNotebookSessionStatement {
    param(
    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $SparkPoolName,

    [parameter(Mandatory=$true)]
    [int]
    $SessionId,

    [parameter(Mandatory=$true)]
    [int]
    $StatementId
    )

    Write-Information "Waiting for any pending operation to be properly triggered..."
    Start-Sleep -Seconds 10

    $result = Get-SparkNotebookSessionStatement -WorkspaceName $WorkspaceName -SparkPoolName $SparkPoolName -SessionId $SessionId -StatementId $StatementId

    while (($result.state -eq "waiting") -or ($result.state -eq "running")) {
        Write-Information "Current status is $($result.state). Waiting for available, error, cancelling, or cancelled."
        Start-Sleep -Seconds 10
        $result = Get-SparkNotebookSessionStatement -WorkspaceName $WorkspaceName -SparkPoolName $SparkPoolName -SessionId $SessionId -StatementId $StatementId
    }

    Write-Information "The Spark notebook session statement has now the $($result.state) status."
    return $result
}

function Count-CosmosDbDocuments {

    param(
    [parameter(Mandatory=$true)]
    [String]
    $SubscriptionId,

    [parameter(Mandatory=$true)]
    [String]
    $ResourceGroupName,

    [parameter(Mandatory=$true)]
    [String]
    $CosmosDbAccountName,

    [parameter(Mandatory=$true)]
    [String]
    $CosmosDbDatabase,

    [parameter(Mandatory=$true)]
    [String]
    $CosmosDbContainer
    )
        
    $cosmosDbAccountKey = List-CosmosDBKeys -SubscriptionId $SubscriptionId -ResourceGroupName $ResourceGroupName -Name $CosmosDbAccountName
    Write-Information "Successfully retrieved Cosmos DB master key"

    $resourceLink = "dbs/$($CosmosDbDatabase)/colls/$($CosmosDbContainer)"
    $uri = "https://$($CosmosDbAccountName).documents.azure.com/$($resourceLink)/docs"
    $refTime = [DateTime]::UtcNow.ToString("r")
    $authHeader = Generate-CosmosDbMasterKeyAuthorizationSignature -verb POST -resourceLink $resourceLink -resourceType "docs" -key $cosmosDbAccountKey -keyType "master" -tokenVersion "1.0" -dateTime $refTime
    $headers = @{ 
            Authorization=$authHeader
            "Content-Type"="application/query+json"
            "x-ms-cosmos-allow-tentative-writes"="True"
            "x-ms-cosmos-is-query-plan-request"="True"
            "x-ms-cosmos-query-version"="1.4"
            "x-ms-cosmos-supported-query-features"="NonValueAggregate, Aggregate, Distinct, MultipleOrderBy, OffsetAndLimit, OrderBy, Top, CompositeAggregate, GroupBy, MultipleAggregates"
            "x-ms-date"=$refTime
            "x-ms-documentdb-populatequerymetrics"="True"
            "x-ms-documentdb-query-enable-scan"="True"
            "x-ms-documentdb-query-enablecrosspartition"="True"
            "x-ms-documentdb-query-parallelizecrosspartitionquery"="True"
            "x-ms-documentdb-responsecontinuationtokenlimitinkb"=1
            "x-ms-max-item-count"=100
            "x-ms-version"="2018-12-31"
    }
    $query = "{'query':'SELECT VALUE COUNT(1) FROM c'}"

    Write-Information "Requesting query plan from $($uri)"
    $result = Invoke-RestMethod -Uri $uri -Method POST -Body $query -Headers $headers

    Write-Information "Successfully retrieved query plan"

    $pkUri = "https://$($CosmosDbAccountName).documents.azure.com/$($resourceLink)/pkranges"
    $pkAuthHeader = Generate-CosmosDbMasterKeyAuthorizationSignature -verb GET -resourceLink $resourceLink -resourceType "pkranges" -key $cosmosDbAccountKey -keyType "master" -tokenVersion "1.0" -dateTime $refTime
    $pkHeaders = @{ 
            Authorization=$pkAuthHeader
            "x-ms-cosmos-allow-tentative-writes"="True"
            "x-ms-date"=$refTime
            "x-ms-documentdb-query-enablecrosspartition"="True"
            "x-ms-documentdb-responsecontinuationtokenlimitinkb"=1
            "x-ms-version"="2018-12-31"
    }

    Write-Information "Requesting PK ranges $($pkUri)"
    $pkResult = Invoke-RestMethod -Uri $pkUri -Method GET -Headers $pkHeaders

    Write-Information "Successfully retrieved PK ranges"

    $headers = @{ 
            Authorization=$authHeader
            "Content-Type"="application/query+json"
            "x-ms-cosmos-allow-tentative-writes"="True"
            "x-ms-cosmos-is-query"="True"
            "x-ms-date"=$refTime
            "x-ms-documentdb-populatequerymetrics"="True"
            "x-ms-documentdb-partitionkeyrangeid"=$pkResult.PartitionKeyRanges[0].id
            "x-ms-documentdb-query-enable-scan"="True"
            "x-ms-documentdb-query-enablecrosspartition"="True"
            "x-ms-documentdb-query-parallelizecrosspartitionquery"="True"
            "x-ms-documentdb-responsecontinuationtokenlimitinkb"=1
            "x-ms-max-item-count"=100
            "x-ms-version"="2018-12-31"
    }
    $query = "{""query"":$(ConvertTo-Json $result.queryInfo.rewrittenQuery)}"

    Write-Information "Executing query..."
    $queryResult = Invoke-RestMethod -Uri $uri -Method POST -Body $query -Headers $headers

    Write-Information "The collection contains $($queryResult.Documents[0][0].item) documents."
    return $queryResult.Documents[0][0].item
}

function Assign-SynapseRole {

    param(    
    [parameter(Mandatory=$true)]
    [String]
    $WorkspaceName,

    [parameter(Mandatory=$true)]
    [String]
    $RoleId,

    [parameter(Mandatory=$true)]
    [String]
    $PrincipalId
    )

    $uri = "https://$($WorkspaceName).dev.azuresynapse.net/rbac/roleAssignments?api-version=2020-02-01-preview"
    $method = "POST"

    $id = $RoleId + "-" + $PrincipalId
    $body = "{ id: ""$id"", roleId: ""$RoleId"", principalId: ""$PrincipalId"" }"

    Ensure-ValidTokens
    $result = Invoke-RestMethod  -Uri $uri -Method $method -Body $body -Headers @{ Authorization="Bearer $synapseToken" } -ContentType "application/json"
    return $result
}

function Refresh-Token {
    param(
    [parameter(Mandatory=$true)]
    [String]
    $TokenType
    )

    switch($TokenType) {
        "Synapse" {
            $tokenValue = ((az account get-access-token --resource https://dev.azuresynapse.net) | ConvertFrom-Json).accessToken
            $global:synapseToken = $tokenValue; 
            break;
        }
        "SynapseSQL" {
            $tokenValue = ((az account get-access-token --resource https://sql.azuresynapse.net) | ConvertFrom-Json).accessToken
            $global:synapseSQLToken = $tokenValue; 
            break;
        }
        "Management" {
            $tokenValue = ((az account get-access-token --resource https://management.azure.com) | ConvertFrom-Json).accessToken
            $global:managementToken = $tokenValue; 
            break;
        }
        default {throw "The token type $($TokenType) is not supported.";}
    }
    
}

function Ensure-ValidTokens {

    for ($i = 0; $i -lt $tokenTimes.Count; $i++) {
        Ensure-ValidToken $($tokenTimes.Keys)[$i]
    }
}

function Ensure-ValidToken {
    param(
        [parameter(Mandatory=$true)]
        [String]
        $TokenName
    )

    $refTime = Get-Date

    if (($refTime - $tokenTimes[$TokenName]).TotalMinutes -gt 30) {
        Write-Information "Refreshing $($TokenName) token."
        Refresh-Token $TokenName
        $tokenTimes[$TokenName] = $refTime
    }
}

Function Generate-CosmosDbMasterKeyAuthorizationSignature {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)][String]$verb,
        [Parameter(Mandatory=$true)][String]$resourceLink,
        [Parameter(Mandatory=$true)][String]$resourceType,
        [Parameter(Mandatory=$true)][String]$dateTime,
        [Parameter(Mandatory=$true)][String]$key,
        [Parameter(Mandatory=$true)][String]$keyType,
        [Parameter(Mandatory=$true)][String]$tokenVersion
    )
    $hmacSha256 = New-Object System.Security.Cryptography.HMACSHA256
    $hmacSha256.Key = [System.Convert]::FromBase64String($key)
 
    If ($resourceLink -eq $resourceType) {
        $resourceLink = ""
    }
 
    $payLoad = "$($verb.ToLowerInvariant())`n$($resourceType.ToLowerInvariant())`n$resourceLink`n$($dateTime.ToLowerInvariant())`n`n"
    $hashPayLoad = $hmacSha256.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($payLoad))
    $signature = [System.Convert]::ToBase64String($hashPayLoad)
 
    [System.Web.HttpUtility]::UrlEncode("type=$keyType&ver=$tokenVersion&sig=$signature")
}

Export-ModuleMember -Function List-StorageAccountKeys
Export-ModuleMember -Function List-CosmosDBKeys
Export-ModuleMember -Function Create-KeyVaultLinkedService
Export-ModuleMember -Function Create-BlobStorageLinkedService
Export-ModuleMember -Function Create-DataLakeLinkedService
Export-ModuleMember -Function Create-CosmosDBLinkedService
Export-ModuleMember -Function Create-SQLPoolKeyVaultLinkedService
Export-ModuleMember -Function Create-IntegrationRuntime
Export-ModuleMember -Function Get-IntegrationRuntime
Export-ModuleMember -Function Delete-IntegrationRuntime
Export-ModuleMember -Function Create-Dataset
Export-ModuleMember -Function Create-Pipeline
Export-ModuleMember -Function Run-Pipeline
Export-ModuleMember -Function Get-PipelineRun
Export-ModuleMember -Function Wait-ForPipelineRun
Export-ModuleMember -Function Get-OperationResult
Export-ModuleMember -Function Wait-ForOperation
Export-ModuleMember -Function Delete-ASAObject
Export-ModuleMember -Function Get-ASAObject
Export-ModuleMember -Function Control-SQLPool
Export-ModuleMember -Function Get-SQLPool
Export-ModuleMember -Function Wait-ForSQLPool
Export-ModuleMember -Function Execute-SQLQuery
Export-ModuleMember -Function Execute-SQLScriptFile
Export-ModuleMember -Function Execute-SQLScriptFile-SqlCmd
Export-ModuleMember -Function Wait-ForSQLQuery
Export-ModuleMember -Function Create-SQLScript
Export-ModuleMember -Function Get-SparkPool
Export-ModuleMember -Function Create-SparkNotebook
Export-ModuleMember -Function Start-SparkNotebookSession
Export-ModuleMember -Function Get-SparkNotebookSession
Export-ModuleMember -Function Wait-ForSparkNotebookSession
Export-ModuleMember -Function Delete-SparkNotebookSession
Export-ModuleMember -Function Start-SparkNotebookSessionStatement
Export-ModuleMember -Function Get-SparkNotebookSessionStatement
Export-ModuleMember -Function Wait-ForSparkNotebookSessionStatement
Export-ModuleMember -Function Assign-SynapseRole
Export-ModuleMember -Function Refresh-Token
Export-ModuleMember -Function Generate-CosmosDbMasterKeyAuthorizationSignature
Export-ModuleMember -Function Count-CosmosDbDocuments
Export-ModuleMember -Function Get-Workspace