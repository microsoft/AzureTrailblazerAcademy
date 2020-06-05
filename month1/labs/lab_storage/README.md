# Azure Trailblazer Academy Azure Storage Lab
## Overview
### Store Data in Azure
Blob storage is optimized for storing massive amounts of unstructured data. Unstructured data is data that doesn't adhere to a particular data model or definition, such as text or binary data. Azure Data Lake Storage Gen2 (ADLSGen2) offers a hierarchical file system as well as the advantages of Blob storage for Big Data Hadoop needs.

### Sharing data between the organizations
Share structured and unstructured data from multiple Azure data stores with other organizations in just a few clicks. There’s no infrastructure to set up or manage, no SAS keys are required, and sharing is all code-free. You control data access and set terms of use aligned with your enterprise policies. Use snapshot-based sharing to copy data from the data provider, or use in-place sharing to refer to data in the provider’s account.

## How to load media files into Blob Storage? (Step-by-Step Lab)
### Step-1:Create Storage account
- Login to Azure Portal (https://portal.azure.com) 
    Select "create a resource".
    
<img src="./images/Create-storage-account.PNG" alt="Create Storage Account" width="400">

- select "Storage accounts" service. 
Hit 'create' button.

<img src="./images/Create-storage-account.PNG" alt="Create Storage Account" width="400">

- Create a new resource group.
    Select 'Create new' under 'Resource group' section. 
    Enter "ata-storage-lab-<Name>-rg"
    
    <img src="./images/CreateResourceGroup.PNG" alt="Create Resource Group" width="600">
- Enter Storage account name.
    Enter 'atastorageblob<yourname>' 
- Specify the location.
    Select 'East US' as the region
- Leave defaults for the rest
- Select 'Review + create' button.
    Make sure you have completed all the entries high lighted in the diagram. It completes the validation checks.
    
    <img src="./images/Storage-Review-Create.PNG" alt="Storage Review" width="600">
- Select 'Create' button. 
    Make sure you have the green check mark next to 'Validation Passed'. You are good to create the blob storage! Hit the 
    'Create' button. 
- Go to 'blob storage' from the deployment status screen.
    Wait till you see 'Your deployment is complete'.
    Select 'go to resource' button when you see it.

    <img src="./images/Deploy-complete-blob-storage.PNG" alt="blob storage Deploy complete" width="400">

### Step-2 Create container

- Select the 'containers' link from the available storage options in the middle of the page.

    <img src="./images/CreateBlobContainer.PNG" alt="Storage Review" width="400">
- Create a new container.
    Select the 'plus' sign next to container to add a new container
    'New container' window pops up and enter the name 'atablob<yourname>'

    <img src="./images/Complete-create-blob-container.PNG" alt="Storage Review" width="400">

### Step-3 Upload image to Blob container
- Access Storage Explorer.
    Select the 'Storage Explorer(preview)' from the left blade.
    Select the created blob container.
    Select upload button.
    Browse the local data and upload an image.

    <img src="./images/blob-upload-image.PNG" alt="blob-upload-image" width="200"> 

## How to load data into Data Lake Storage? (Step-by-Step Lab)

### Step-1:Create Azure Data Lake Storage Gen2
- Login to Azure Portal (https://portal.azure.com). 
    Select "create a resource" and select "Storage accounts" service. 
Hit 'create' button.

<img src="./images/Create-storage-account.PNG" alt="Create Storage Account" width="400">

- Select the resource group.
    Select the existing resource group "ata-storage-lab-<Name>-rg" from the dropdown menu. 
- Enter Storage account name.
    Use 'atastorageADLSGen2<yourname>' format.
- Specify the location.
    Select 'East US' as the region.
- Leave defaults for the rest.
- Select the 'Networking' button.
    Make sure you have completed all the entries high lighted in the diagram. All the above steps are similar to the blob storage creation but you need select 'Networking' to turn on the hierarchical feature.
    
    <img src="./images/ADLSGen2_Networking.PNG" alt="Storage Review" width="600">
- Networking Options: 
    Leave the defaults and select the 'Advanced' button 
- Advanced Options:
    Enable the 'hierarchical' option under ADLSGen2 option and select 'Review + Create' button.
    
    <img src="./images/ADLSGen2HierarchichalOption.PNG" alt="ADLSGen2 Hierarchichal Option" width="600">

- Select 'Create' button. 
    Make sure you have the green check mark next to 'Validation Passed'. You are good to create the Data Lake Storage! Hit the 'Create' button. 

- Go to 'Datalake storage' from the deployment status screen.
    Wait till you see 'Your deployment is complete'.
    Select 'go to resource' button when you see it.

    <img src="./images/ADLS-Deploy-Complete.PNG" alt="ADLSGen2 Hierarchichal Option" width="400">

### Step-2 Create container
- Select container
    Select the 'containers' link from the available storage options in the middle of the page.

    <img src="./images/CreateBlobContainer.PNG" alt="Storage Review" width="400">
- Create a new container.
    Select the 'plus' sign next to container to add a new container.
    'New container' window popsup and enter the name 'adlsgen2filesystem<yourname>'.

    <img src="./images/ADLSGen2-Container-Complete.PNG" alt="Storage Review" width="400">

### Step-3 Upload a folder to the Datalake
- Access Storage Explorer.
    Select the 'Storage Explorer(preview)' from the left blade.
    Select the created blob container.
    Select upload button.
    It will prompt you to download Storage Explorer.

- Install Storage Explorer.
    Install the Storage Explorer on your system.
    Access the Datalake Storage you just created.
<img src="./images/StorageExplorer_UploadFolder.PNG" alt="blob-upload-image" width="400">

- Upload the data files.
    Browse the local folder and upload all the files.

    <img src="./images/ADLSGen2UploadComplete.PNG" alt="blob-upload-image" width="400">

## How to share Data between the organizations? (Step-by-Step Lab)

### Architecture
<img src="./images/Data-Share-Lab-Architecture.PNG" alt="datashare lab architecture" Width="400">

### Prerequisites
- Azure Subscription
- Recipient's Azure login e-mail address
- Storage Account
- Permission to write to storage account for the Shared Service (Contributor Role)
- Permission to add role assignment to storage account for the Shared Service (Owner Role) 

### Step-1: Create data share service
- Login to Azure Portal (https://portal.azure.com). 
    Select "create a resource" and select "Data Share" service.
    Hit 'create' button.

<img src="./images/Create-Data_Share.PNG" alt="Create Data Share" Width="300">
- Create Data Share options:
- Resource Group: Select 'ata-storage-lab-<name>-rg" from the dropdown
- Location: Select "US East" region
- Name: ata-data-share-<name>
- Click on "Review+Create" button

<img src="./images/Review_Create_Data_Share.PNG" alt="Review And Create button" Width="400">
- Initiate Create Data Share process.
    Make sure you get a green check mark next to "Validation Passed". Click on "Create" button to initiate the creation process.
- Verify Deployment completion.
    Make sure you get a confirmation saying "Deployment is complete".
    You will see "Go to Resource" button when it is done.
    Click to "Go to Resource" to access the Data Share you just created.

<img src="./images/DataShare-Create-Deployment-complete.PNG" alt="Data Share Deployment complete" Width="300">

### Step-2: Add Storage Owner and Contributor roles to the Data Share
- Select the blob storage account (atastorageblob<yourname>).
    Select the storage accounts from the top left menu. Select your blob storage account.
- Select Create role.
    Select "Access Control (IAM)" from the left blade.
    Click on "Create role" button. It will pop up Add role window.
<img src="./images/Storage-Access-Mgmt.PNG" alt="Access Control" height="400">
- Add Owner role to the data share. 
    Select "Owner" role from the dropdown. Select the data share by typing "ata-data-share-<name>".
    Click on "Save" button.
<img src="./images/DataShare-Storage-Owner-save.PNG" alt="Create Owner Role" height="300">
- Add Contributor role to the data share.
    Select "Contributor" role from the dropdown. Select data sahre by typing "ata-data-share-<name>".
    Click on "Save" button.
### Step-3: Add Data Sets to the data share
- access the data share service
- Select 'Start Sharing your data' from the left blade
<img src="./images/Data-Share-Start_Sharing.PNG", alt="Start Sharing Data", Width="300">
- Select + sign next to 'Create' 
<img src="./images/Data-Share-Create-SentShare.PNG" alt="Create Sent Shares" Width="300">
- Enter Sent Share Details:
- Share name:"ata-sent-shipping-scans-<name>"
- Shape type: Snapshot (default)
- Description: "Sharing Shipping Scan images with partners"
- Terms of use" "Update hourly"
- Click on Continue
<img src="./images/DataShare-create-sent-shares-details.PNG" alt="create sent share details" Width="400">
- Datasets Tab:
- Click on "Add Datasets" button
- Select blob storage as the data type
- Click on "next"
<img src="./images/DataShare-Add-Blob-DataSet.PNG" alt="select blob data set" Width="300">
- Select the resource group
- Select the blob storage account
- Select the container
- Click on "next"
<img src="./images/DataShare-Select-Blob-Image_folder.PNG" alt="select blob container" Width="400">
- Enter Dataset Name as "ata-shipping-image-share"
- Click on "Add Dataset".
  Displays the created data set.
- Click on "Continue"
### Step-4: Add Recipient to the data share
- Recipients Tab:
- Click on "Add Recipient" 
- Enter your personal email address
- Click on Continue
<img src="./images/DataShare-SentShares-add-Recipient.PNG"> alt="add recipient" Width="400">
- Ignore Snapshot schedule and click on "Continue"
- Click on Create 
<img src="./images/DataShare-review-Sent-Share.PNG" alt="Review and create sent shares" Width="400">
- Creates sent share 
<img src="./images/DataShare-SentShare-Complete.PNG" alt="Create Sent Sharecomplete" Width="400">
- Your Azure Data Share has now been created and the recipient of your Data Share is now ready to accept your invitation.

