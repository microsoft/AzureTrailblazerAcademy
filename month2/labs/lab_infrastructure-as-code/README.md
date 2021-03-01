# Azure Infrastructure-as-Code Lab

## Prerequisites

- Microsoft Azure subscription
- Resource Group to deploy Azure services
- Permissions to create the following resource 
    - Virtual Machines
    - Virtual Networks
    - Public IP addresses
    - Network security groups
    - Network load balancers
    - Availability sets


## Step 1: Create a Resource Group
1. In a new browser window, sign in to the [Azure portal](https://portal.azure.com).
2. In the Azure Portal, search for **Resource Groups**.
3. Click on the **Add** button.
4. Fill out the **Basics** tab as follows:
- **Subscription:** Choose your subscription
- **Resource group:** Provide the name of "ATA-Infrastructure-as-Code-RG"
- **Region:** East US

<img src="./images/lab01/01-rg-basics.jpg" alt="Resource Group Basics Tab"  Width="600">

4. Click the **Next: Review + Create** button
5. Click the **Create** button

## Step 2: Deploy an Azure Resource Manager (ARM) Quickstart Template
1. Visit [Quickstart Template Gallery](https://github.com/Azure/azure-quickstart-templates)
2. Browse some of the templates to see what is available
3. Visit [Virtual Network with two Subnets](https://github.com/Azure/azure-quickstart-templates/tree/master/101-vnet-two-subnets)
3. Fill out the **Basics** tab as follows:
- **Subscription:** Choose your subscription
- **Resource group:** Select the Resource Group you created for this lab
- **Account name:** Choose a unique name for the Cosmos DB Account
- **API:** Core (SQL)
- **Location:** (US) East US

<img src="./images/lab01/01-cosmosdb-account-create-basics.jpg" alt="Cosmos DB Account Create Basics Tab"  Width="600">

4. Leave the rest of the fields as default, and click the **Review + create** button.

<img src="./images/lab01/01-cosmosdb-account-create-review.jpg" alt="Cosmos DB Account Create Review"  Width="600">

5. Click the **Create** button.

## Step 3: Create a container
1. In the Azure Portal, search for the Cosmos DB Account that was created for the lab.
2. In the Azure Cosmos DB blade, locate and select the **Overview** link on the left side of the blade. At the top select the **Add Container** button.

<img src="./images/lab01/01-cosmosdb-overview-add-container.jpg" alt="Cosmos DB Overview Add Container"  Width="600">

3.	In the **Add Container** popup, fill out the following fields and click the **OK** button.
- **Database id:** Select the **Create new** option and enter the value **NutritionDatabase**.
- **Provision database throughput:** Do not check this option.
- **Container id:** FoodCollection
- **Partition key:** /foodGroup
- **My partition key is larger than 100 bytes:** Do not check this option.
- **Throughput (400 - 100,000 RU/s) More information:** Select **Manual** and enter the value 4000.

<img src="./images/lab01/01-cosmosdb-add-container.jpg" alt="Cosmos DB Add Container"  Width="600">

## Step 4: Import Lab Data Into Container
You will use **Azure Data Factory (ADF)** to import the JSON array stored in the **NutritionData.json** file from Azure Blob Storage.

You do not need to do Steps 1-4 in this section and can proceed to Step 5 by opening your Data Factory if you have created a Data Factory resource for the previous lab.

1. On the left side of the portal, select the **Resource groups** link.

    > To learn more about copying data to Cosmos DB with ADF, please read [ADF's documentation](https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-cosmos-db).

    ![Resource groups link is highlighted](./images/lab01/01-resource_groups.jpg "Select Resource Groups")

2. In the **Resource groups** blade, locate and select the resource group created for the lab.

3. If you see a Data Factory resource, you can skip to step 5, otherwise select **Add** to add a new resource

    ![A data factory resource is highlighted](./images/lab01/01-adf-instance.jpg "Review if you have data factory already")

    ![Select Add in the nav bar](./images/lab01/01-add_adf.jpg "Add a new resource")

   - Search for **Data Factory** and select it. 
   - Create a new **Data Factory**. You should give this data factory a unique name and select the relevant Azure subscription. You should ensure your existing resource group is selected as well as a Version **V2**. 
   - Select **East US** as the region. Do not select **Enable GIT** (this may be checked by default). 
   - Select **Create**.

        ![The new data factory dialog is displayed](./images/lab01/01-adf_selections.jpg "Add a new Data Factory resource")

4. After creation, open your newly created Data Factory. Select **Author & Monitor** and you will launch ADF.

    ![The overview blade is displayed for ADF](./images/lab01/01-adf_author&monitor.jpg "Select Author and Monitor link")

5. Select **Copy Data**.

   - We will be using ADF for a one-time copy of data from a source JSON file on Azure Blob Storage to a database in Cosmos DB�s SQL API. ADF can also be used for more frequent data transfers from Cosmos DB to other data stores.

    ![The main workspace page is displayed for ADF](./images/lab01/01-adf_copydata.jpg "Select the Copy Data activity")

6. Edit basic properties for this data copy. You should name the task **ImportNutrition** and select to **Run once now**, then select **Next**

   ![The copy data activity properties dialog is displayed](./images/lab01/01-adf_properties.jpg "Enter a task name and the schedule")

7. **Create a new connection** and select **Azure Blob Storage**. We will import data from a json file on Azure Blob Storage. In addition to Blob Storage, you can use ADF to migrate from a wide variety of sources. We will not cover migration from these sources in this tutorial.

    ![Create new connection link is highlighted](./images/lab01/01-adf_blob.jpg "Create a new connection")

    ![Azure Blog Storage is highlighted](./images/lab01/01-adf_blob2.jpg "Select the Azure Blob Storage connection type")

8. Name the source **NutritionJson** and select **SAS URI** as the Authentication method. Please use the following SAS URI for read-only access to this Blob Storage container:

    `https://cosmosdblabsv3.blob.core.windows.net/?sv=2018-03-28&ss=bfqt&srt=sco&sp=rlp&se=2022-01-01T04:55:28Z&st=2019-08-05T20:02:28Z&spr=https&sig=%2FVbismlTQ7INplqo6WfU8o266le72o2bFdZt1Y51PZo%3D`

    ![The New linked service dialog is displayed](./images/lab01/01-adf_connecttoblob.jpg "Enter the SAS url in the dialog")

9. Select **Create**
10. Select **Next**
11. Select **Browse**, then double-click to open the **nutritiondata** folder
12. Select **Choose**

    ![The nutritiiondata folder is displayed](./images/lab01/01-adf_choosenutrition.jpg "Select the nutritiondata folder")

13. Un-check **Copy file recursively** or **Binary Copy** if they are checked. Also ensure that other fields are empty.

    ![The input file or folder dialog is displayed](./images/lab01/01-adf_source_next.jpg "Ensure all other fields are empty, select next")

14. Select the file format as **JSON format**. Then select **Next**.

    !["The file format settings dialog is displayed"](./images/lab01/01-adf_source_dataset_format.jpg "Ensure JSON format is selected, then select Next")

15. You have now successfully connected the Blob Storage container with the nutrition.json file as the source.

16. For the **Destination data store** add the Cosmos DB target data store by selecting **Create new connection** and selecting **Azure Cosmos DB (SQL API)**.

    !["The New Linked Service dialog is displayed"](./images/lab01/01-adf_selecttarget.jpg "Select the Azure Cosmos DB service type")

17. Name the linked service **targetcosmosdb** and select your Azure subscription and Cosmos DB account. You should also select the Cosmos DB **NutritionDatabase** that you created earlier.

    !["The linked service configuration dialog is displayed"](./images/lab01/01-adf_selecttargetdb.jpg "Select the NutritionDatabase database")

18. Select your newly created **targetcosmosdb** connection as the Destination date store.

    !["The destination data source dialog is displayed"](./images/lab01/01-adf_destconnectionnext.jpg "Select your recently created data source")

19. Select your **FoodCollection** container from the drop-down menu. You will map your Blob storage file to the correct Cosmos DB container. Select **Next** to continue.

    !["The table mapping dialog is displayed"](./images/lab01/01-adf_correcttable.jpg "Select the FoodCollection container")

20. There is no need to change any `Settings`. Select **next**.

    !["The settings dialog is displayed"](./images/lab01/01-adf_settings.jpg "Review the dialog, select next")

21. Select **Next** to begin deployment After deployment is complete, select **Monitor**.

    !["The pipeline runs are displayed"](./images/lab01/01-adf_progress.jpg "Notice the pipeline is In progress")

22. After a few minutes, refresh the page and the status for the ImportNutrition pipeline should be listed as **Succeeded**.

    !["The pipeline runs are displayed"](./images/lab01/01-adf_progress_complete.jpg "The pipeline has succeeded")

23. Once the import process has completed, close the ADF. You will now proceed to validate your imported data.

## Validate Imported Data

The Azure Cosmos DB Data Explorer allows you to view documents and run queries directly within the Azure Portal. In this exercise, you will use the Data Explorer to view the data stored in our container.

You will validate that the data was successfully imported into your container using the **Items** view in the **Data Explorer**.

1. Return to the **Azure Portal** (<http://portal.azure.com>).

1. Select the **Resource groups** link, locate and select the resource group created for the lab.

    ![The Lab resource group is highlighted](./images/lab01/01-resource_groups.jpg "Select the resource group")

1. Inside the resource group, select the **Azure Cosmos DB** account you created for the lab.

    ![The Cosmos DB resource is highlighted](./images/lab01/01-cosmos_resource.jpg "Select the Cosmos DB resource")

1. In the **Azure Cosmos DB** blade, locate and select the **Data Explorer** link on the left side of the blade.

    ![The Data Explorer link was selected and is blade is displayed](./images/lab01/01-data_explorer_pane.jpg "Select Data Explorer")

1. In the **Data Explorer** section, expand the **NutritionDatabase** database node and then expand the **FoodCollection** container node.

    ![The Container node is displayed](./images/lab01/01-collection_node.jpg "Expand the NutritionDatabase node")

1. Within the **FoodCollection** node, select the **Items** link to view a subset of the various documents in the container. Select a few of the documents and observe the properties and structure of the documents.

    ![Items is highlighted](./images/lab01/01-documents.jpg "Select Items")

    ![An Example document is displayed](./images/lab01/01-example_document.jpg "Select a document")
