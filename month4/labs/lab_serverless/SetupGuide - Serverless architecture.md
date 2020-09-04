# Azure Serverless Lab Setup Guide
## Task List:
    - [Task 1: Create a new Azure Resource group](#task-1-create-a-new-azure-resource-group)
    - [Task 2: Set up a development environment](#task-2-set-up-a-development-environment)
    - [Task 3: Disable IE Enhanced Security](#task-3-disable-ie-enhanced-security)
    - [Task 4: Install Microsoft Edge](#task-4-install-microsoft-edge)
    - [Task 5: Validate connectivity to Azure](#task-5-validate-connectivity-to-azure)
    - [Task 6: Download and explore the TollBooth starter solution](#task-6-download-and-explore-the-tollbooth-starter-solution)


### Task 1: Create a new Azure Resource group

1. Open the [Azure Portal](https://portal.azure.com).

2. Within the Azure Management Portal, open the **Resource groups** tile and select **Add**.

   ![In the menu of the Azure Portal, Resource groups is selected. In the Resource Groups blade, the Add button is selected.](images/Setup/image9.png 'Azure Portal')

3. Specify the name of the resource group as **ServerlessArchitecture**, and choose the Azure region to which you want to deploy the lab. This resource group will be used throughout the rest of the lab. Select **Review + Create**. This will show you a summary of changes. Select **Create** to create the resource group.

   ![In the Create a resource group blade, the Resource group field displays ServerlessArchitecture.](images/Setup/image10.png 'Resource group blade')

### Task 2: Set up a development environment

1. Create a virtual machine (VM) in Azure using the Visual Studio Community 2019 on Windows Server 2019 (x64) image. A Windows 10 image will work as well. **Note:** Your Azure subscription must include MSDN offers to create a VM with Visual Studio pre-loaded.

   ![In Azure Portal, in the search field, Visual Studio Community 2019 (latest release) on Windows Server 2019 (x64) is selected.](media/select-vs2019-image.png 'Azure Portal')

   - Select **+ Create a resource**.

   - Type **Visual Studio 2019 Latest**.

   - Select the **Visual Studio Community 2019 (latest) on Windows Server 2019 (x64)**.

   - Select **Create**.

   - Select your subscription and recently created resource group.

   - For Virtual machine name, type **MainVM**, or a different name that is unique.

   - Leave availability option as **No infrastructure redundancy required**.

   - Ensure the image is **Visual Studio Community 2019 (latest) on Windows Server 2019 (x64)**.

   - Select your VM size.

   > **Note**: It is highly recommended to use a D4s or DS2_v2 instance size for this VM.

   - For username, type **demouser**

   - For password, type **Password.1!!**

   - Select **Allow selected ports**.

   - For the inbound ports, select **RDP (3389)**.

   - Select **Review + create**.

   - Select **Create**.

### Task 3: Disable IE Enhanced Security

> **Note**: Sometimes this image has IE ESC disabled. Sometimes it does not.

1. Login to the newly created VM using RDP and the username and password you supplied earlier.

2. After the VM loads, the Server Manager should open.

3. Select **Local Server**.

   ![Local Server is selected from the Server Manager menu.](images/Setup/image5.png 'Server Manager menu')

4. On the side of the pane, for **IE Enhanced Security Configuration**, if it displays **On**, select it.

   ![The IE Enhanced Security Configuration setting is set to On. The On item is selected.](images/Setup/image6.png 'IE Enhanced Security Configuration')

   - Change to **Off** for Administrators and select **OK**.

   ![In the Internet Explorer Enhanced Security Configuration dialog box, under Administrators, the Off button is selected.](images/Setup/image7.png 'Internet Explorer Enhanced Security Configuration dialog box')

### Task 4: Install Microsoft Edge

> **Note**: Some aspects of this lab require the use of the new Microsoft Edge (Chromium edition) browser. You may find yourself blocked if using Internet Explorer later in the lab.

1. Launch Internet Explorer and download [Microsoft Edge](https://www.microsoft.com/edge).

2. Follow the setup instructions and make sure you can run Edge to navigate to any webpage.

> **Note**: Edge is needed for one of the labs as Internet Explorer is not supported for some specific activities.

### Task 5: Validate connectivity to Azure

1. From within the virtual machine, launch Visual Studio (select **Continue without code** link) and validate that you can log in with your Microsoft Account when prompted.

2. To validate connectivity to your Azure subscription, open **Cloud Explorer** from the **View** menu, and ensure that you can connect to your Azure subscription.

   ![In Cloud Explorer, the list of Azure subscriptions is shown. A single subscription is highlighted and expanded in the list.](media/vs-cloud-explorer.png 'Cloud Explorer')

### Task 6: Download and explore the TollBooth starter solution

1. From your LabVM, download the starter files by downloading a .zip copy of the Cosmos DB real-time advanced analytics GitHub repo.

2. In a web browser, navigate to the [MCW Serverless architecture repo](https://github.com/Microsoft/MCW-Serverless-architecture).

3. On the repo page, select **Clone or download**, then select **Download ZIP**.

   ![On the GitHub Repository web page, the Clone or Download drop down is expanded with the Download ZIP button selected.](images/Setup/github-download-repo.png)

4. Unzip the contents to the folder **C:\\ServerlessMCW\\**

   ![On the Extract Compressed (Zipped) Folders dialog window, the extraction path is highlighted in the Files will be extracted to this folder field.](media/zip-extract.png 'Extract Compressed Folders')

5. Navigate to `C:\ServerlessMCW\MCW-Serverless-architecture-master\Hands-on lab\starter`

6. From the **TollBooth** folder, open the Visual Studio Solution file: **TollBooth.sln**. Notice the solution contains the following projects:

   - TollBooth
   - UploadImages
   
   > **Note**: The UploadImages project is used for uploading a handful of car photos for testing scalability of the serverless architecture.

7. Switch to windows explorer, navigate back to the **starter** subfolder and open the **license plates** subfolder. It contains sample license plate photos used for testing out the solution. One of the photos is guaranteed to fail OCR processing, which is meant to show how the workload is designed to handle such failures. The **copyfrom** folder is used by the UploadImages project as a basis for the 1,000 photo upload option for testing scalability.

You should follow all steps provided _before_ performing the Hands-on lab.
