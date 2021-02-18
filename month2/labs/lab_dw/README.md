**Contents**

<!-- TOC -->

- [Azure Synapse Analytics and AI before the hands-on lab setup guide](#azure-synapse-analytics-and-ai-before-the-hands-on-lab-setup-guide)
  - [Requirements](#requirements)
  - [Before the hands-on lab](#before-the-hands-on-lab)
    - [Task 1: Download the current lab assets](#task-1-download-the-current-lab-assets)
    - [Task 1: Create a resource group in Azure](#task-1-create-a-resource-group-in-azure)
    - [Task 2: Create the Azure Synapse Analytics workspace](#task-2-create-the-azure-synapse-analytics-workspace)
    - [Task 3: Download lab artifacts](#task-3-download-lab-artifacts)
    - [Task 4: Establish a user context](#task-4-establish-a-user-context)
    - [Task 5: Run environment setup PowerShell script](#task-5-run-environment-setup-powershell-script)

<!-- /TOC -->

# Azure Synapse Analytics and AI before the hands-on lab setup guide

## Requirements

1. An Azure Account with the ability to create an Azure Synapse Workspace.

2. [Python v.3.7 or newer](https://www.python.org/downloads/)

3. [PIP](https://pip.pypa.io/en/stable/installing/#do-i-need-to-install-pip)

4. [Visual Studio Code](https://code.visualstudio.com/)

5. [Python Extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-python.python)

6. [Azure Function Core Tools v.3](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=windows%2Ccsharp%2Cbash#v2)

7. [Azure Functions Extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions)

8. [Postman](https://www.postman.com/downloads/)

9. [Ensure the Microsoft.Sql resource provider is registered in your Azure Subscription](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-providers-and-types).

## Before the hands-on lab

**Duration**: 20 minutes

### Task 1: Download the current lab assets

1. Access the [GitHub repository page](https://github.com/microsoft/MCW-Azure-Synapse-Analytics-and-AI).

2. Toward the right side of the screen, expand the **Code** button menu.

    ![On the GitHub repository page the Code button is highlighted.](media/githubcodebutton.png "GitHub repository Code button")

3. From the expanded menu, select **Download ZIP**.

    ![The Download ZIP option is selected from the expanded Code menu](media/githubdownloadzip.png "Github Code Menu")

4. Download the ZIP file and extract it to a location of your choosing on your local machine.

### Task 1: Create a resource group in Azure

1. Log into the [Azure Portal](https://portal.azure.com) using your Azure credentials.

2. On the Azure Portal home screen, select the **+ Create a resource** tile.

    ![A portion of the Azure Portal home screen is displayed with the + Create a resource tile highlighted.](media/bhol_createaresource.png "Create a resource")

3. In the **Search the Marketplace** text box, type **Resource group** and press the **Enter** key.

    ![On the new resource screen Resource group is entered as a search term.](media/bhol_searchmarketplaceresourcegroup.png "Searching for resource group")

4. Select the **Create** button on the **Resource group** overview page.

5. On the **Create a resource group** screen, select your desired Subscription and Region. For Resource group, enter **Synapse-MCW**, then select the **Review + Create** button.

    ![The Create a resource group form is displayed populated with Synapse-MCW as the resource group name.](media/bhol_resourcegroupform.png "Naming the resource group")

6. Select the **Create** button once validation has passed.

### Task 2: Create the Azure Synapse Analytics workspace

1. Deploy the workspace through the following Azure ARM template (press the button below):

    <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2FMCW-Azure-Synapse-Analytics-and-AI%2Fmaster%2FHands-on%2520lab%2Fenvironment-setup%2Fautomation%2F00-asa-workspace-core.json" target="_blank"><img src="http://azuredeploy.net/deploybutton.png" /></a>

2. On the **Custom deployment** form, select your desired subscription and select **Synapse-MCW** for the **Resource group**. Also provide a **Unique Suffix** such as your initials followed by birth year. Finally, provide a strong **SQL Administrator Login Password**. Remember this password value, you'll need it later!

    ![The Custom deployment form is displayed with example data populated.](media/bhol_customdeploymentform.png "Configuring the custom deployment")

    >**Note**: Password requirements are as follows:
    >
    >   1. Your password must be between 8 and 128 characters long.
    >   2. Your password must contain characters from three of the following categories: English uppercase letters, English lowercase letters, numbers (0-9), and non-alphanumeric characters (!, $, #, %, etc.).
    >   3. Your password cannot contain all or part of the login name. Part of a login name is defined as three or more consecutive alphanumeric characters.
  
3. Check the **I agree to the terms and conditions stated above**, then select the **Purchase** button.

    > **Note**: You may experience a deployment step failing in regard to Role Assignment. This error may safely be ignored.

### Task 3: Download lab artifacts

1. In the Azure Portal, open the Azure Cloud Shell by selecting its icon from the right side of the top toolbar. Be sure to select **Powershell** as the shell type.

    ![A portion of the Azure Portal taskbar is displayed with the Cloud Shell icon highlighted.](media/bhol_azurecloudshellmenu.png "Opening the Cloud Shell")

    > **Note**: If you are prompted to create a storage account for the Cloud Shell, agree to have it created.

2. In the Cloud Shell window, enter the following command to clone the repository files.

    ```PowerShell
    git clone https://github.com/microsoft/MCW-Azure-Synapse-Analytics-and-AI.git Synapse-MCW
    ```

3. Keep the Cloud Shell open.

### Task 4: Establish a user context

1. In the Cloud Shell, execute the following command:

    ```cli
    az login
    ```

2. A message will be displayed asking you to open a new tab in your web browser, navigate to [https://microsoft.com/devicelogin](https://microsoft.com/devicelogin) and to enter a code for authentication.

   ![A message is displayed indicating to enter an authentication code on the device login page.](media/bhol_devicelogin.png "Authentication message")

   ![A dialog is shown requesting the entry of a code.](media/bhol_clicodescreen.png "Authentication dialog")

3. Once complete, you may close the tab from the previous step and return to the Cloud Shell.

### Task 5: Run environment setup PowerShell script

When executing the script below, it is important to let the scripts run to completion. Some tasks may take longer than others to run. When a script completes execution, you will be returned to a command prompt.

1. In the Cloud Shell, change the current directory to the **automation** folder of the cloned repository by executing the following:

    ```PowerShell
    cd './Synapse-MCW/Hands-on lab/environment-setup/automation'
    ```

2. Execute the **01-environment-setup.ps1** script by executing the following command:

    ```PowerShell
    ./01-environment-setup.ps1
    ```

    You will be prompted to enter the name of your desired Azure Subscription. You can copy and paste the value from the list to select one. You will also be prompted for the following information for this script:

    | Prompt |
    |--------|
    | Enter the desired Azure Subscription for this lab [you will be able to copy and paste from a listing] |
    | Enter the name of the resource group containing the Azure Synapse Analytics Workspace |
    | Enter the SQL Administrator password you used in the deployment |
    | Enter the unique suffix you used in the deployment |

    ![The Azure Cloud Shell window is displayed with a sample of the output from the preceding command.](media/bhol_sampleshelloutput.png "The Azure Cloud Shell output")

3. At the end of the script, you should see a message indicating **Environment validation has succeeded**.

You should follow all steps provided *before* performing the Hands-on lab.