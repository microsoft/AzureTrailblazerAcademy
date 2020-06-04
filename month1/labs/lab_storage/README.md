# Azure Trailblazer Academy Azure Storage Lab
## Overview
### Store Data in Azure
Blob storage is optimized for storing massive amounts of unstructured data. Unstructured data is data that doesn't adhere to a particular data model or definition, such as text or binary data. Azure Data Lake Storage Gen2 (ADLSGen2) offers a hierarchical file system as well as the advantages of Blob storage for Big Data Hadoop needs.

### Sharing data between the organizations
Share structured and unstructured data from multiple Azure data stores with other organizations in just a few clicks. There’s no infrastructure to set up or manage, no SAS keys are required, and sharing is all code-free. You control data access and set terms of use aligned with your enterprise policies. Use snapshot-based sharing to copy data from the data provider, or use in-place sharing to refer to data in the provider’s account.

## How to load data into Blob Storage? (Step-by-Step Lab)
### Step-1:Create Storage account
- Login to Azure Portal (https://portal.azure.com) 
    Select "create a resource" and select "Storage accounts" service. 
Hit 'create' button.

<img src="./images/Create-storage-account.PNG" alt="Create Storage Account" width="400">

- Create a new resource group
    Select 'Create new' under 'Resource group' section. 
    Enter "ata-storage-lab-<Name>-rg"
    
    <img src="./images/CreateResourceGroup.PNG" alt="Create Resource Group" width="600">
- Enter Storage account name
    Enter 'atastorageblob<yourname>' 
- Select the location
    Select 'East US' as the region
- Leave defaults for the rest
- Select 'Review + create' button
    Make sure you have completed all the entries high lighted in the diagram. It completes the validation checks.
    
    <img src="./images/Storage-Review-Create.PNG" alt="Storage Review" width="600">
- Select 'Create' button 
    Make sure you have the green check mark next to 'Validation Passed'. You are good to create the blob storage! Hit the 
    'Create' button. 
- Go to 'blob storage' from the deployment status screen
    Wait till you see 'Your deployment is complete'.
    Select 'go to resource' button when you see it.
    <img src="./images/Deploy-complete-blob-storage.PNG" alt="blob storage Deploy complete" width="600">

### Step-2 Create container

- Select container
    Select the 'containers' link from the available storage options in the middle of the page.
    <img src="./images/CreateBlobContainer.PNG" alt="Storage Review" width="400">
- Create a new container
    Select the 'plus' sign next to container to add a new container
    'New container' window popsup and enter the name 'atablob<yourname>'
    <img src="./images/Complete-create-blob-container.PNG" alt="Storage Review" width="400">

### Step-3 Upload image to Blob container
- Access Storage Explorer
    Select the 'Storage Explorer(preview)' from the left blade
    Select the created blob container 
    Select upload button 
    Browse the local data and upload an imapge

    <img src="./images/blob-upload-image.PNG" alt="blob-upload-image" width="200"> 

## How to load data into Data Lake Storage? (Step-by-Step Lab)
### Step-1:Create Azure Data Lake Storage Gen2
- Login to Azure Portal (https://portal.azure.com) 
    Select "create a resource" and select "Storage accounts" service. 
Hit 'create' button.

<img src="./images/Create-storage-account.PNG" alt="Create Storage Account" width="400">

- Select the resource group
    Select the existing resource group "ata-storage-lab-<Name>-rg" from the dropdown menu 
- Enter Storage account name
    Enter 'atastorageADLSGen2<yourname>' 
- Select the location
    Select 'East US' as the region
- Leave defaults for the rest
- Select the 'Networking' button
    Make sure you have completed all the entries high lighted in the diagram. All the above steps are similar to the blob storage creation but you need select 'Networking' to turn the hierarchical feature.
    
    <img src="./images/ADLSGen2_Networking.PNG" alt="Storage Review" width="600">
- Networking 
    Leave the defaults and select the 'Advanced' button 
- Advanced
    Enable the 'hierarchical' option under ADLSGen2 option and select 'Review + Create' button
    <img src="./images/ADLSGen2HierarchichalOption.PNG" alt="ADLSGen2 Hierarchichal Option" width="600">

- Select 'Create' button 
    Make sure you have the green check mark next to 'Validation Passed'. You are good to create the Data Lake Storage! Hit the 'Create' button. 

- Go to 'Datalake storage' from the deployment status screen
    Wait till you see 'Your deployment is complete'.
    Select 'go to resource' button when you see it.
    <img src="./images/ADLS-Deploy-Complete.PNG" alt="ADLSGen2 Hierarchichal Option" width="600">

### Step-2 Create container
- Select container
    Select the 'containers' link from the available storage options in the middle of the page.

    <img src="./images/CreateBlobContainer.PNG" alt="Storage Review" width="400">
- Create a new container
    Select the 'plus' sign next to container to add a new container
    'New container' window popsup and enter the name 'adlsgen2filesystem<yourname>'

    <img src="./images/ADLSGen2-Container-Complete.PNG" alt="Storage Review" width="400">

### Step-3 Upload a folder to the Datalake
- Access Storage Explorer
    Select the 'Storage Explorer(preview)' from the left blade
    Select the created blob container 
    Select upload button
    It will prompt you to download Storage Explorer

- Install Storage Explorer
    Install the Storage Explorer on your system
    Access the Datalake Storage you just created
<img src="./images/StorageExplorer_UploadFolder.PNG" alt="blob-upload-image" width="400">

- Upload the data files
    Browse the local folder and upload all the files

    <img src="./images/ADLSGen2UploadComplete.PNG" alt="blob-upload-image" width="400">

## How to share Data between the organizations? (Step-by-Step Lab)