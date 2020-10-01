![Microsoft Cloud Workshop](https://github.com/Microsoft/MCW-Template-Cloud-Workshop/raw/master/Media/ms-cloud-workshop.png "Microsoft Cloud Workshops")

<div class="MCWHeader1">
Azure Synapse Analytics and AI
</div>

<div class="MCWHeader2">
Hands-on lab step-by-step
</div>

<div class="MCWHeader3">
July 2020
</div>


Information in this document, including URL and other Internet Web site references, is subject to change without notice. Unless otherwise noted, the example companies, organizations, products, domain names, e-mail addresses, logos, people, places, and events depicted herein are fictitious, and no association with any real company, organization, product, domain name, e-mail address, logo, person, place or event is intended or should be inferred. Complying with all applicable copyright laws is the responsibility of the user. Without limiting the rights under copyright, no part of this document may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means (electronic, mechanical, photocopying, recording, or otherwise), or for any purpose, without the express written permission of Microsoft Corporation.

Microsoft may have patents, patent applications, trademarks, copyrights, or other intellectual property rights covering subject matter in this document. Except as expressly provided in any written license agreement from Microsoft, the furnishing of this document does not give you any license to these patents, trademarks, copyrights, or other intellectual property.

The names of manufacturers, products, or URLs are provided for informational purposes only and Microsoft makes no representations and warranties, either expressed, implied, or statutory, regarding these manufacturers or the use of the products with any Microsoft technologies. The inclusion of a manufacturer or product does not imply endorsement of Microsoft of the manufacturer or product. Links may be provided to third party sites. Such sites are not under the control of Microsoft and Microsoft is not responsible for the contents of any linked site or any link contained in a linked site, or any changes or updates to such sites. Microsoft is not responsible for webcasting or any other form of transmission received from any linked site. Microsoft is providing these links to you only as a convenience, and the inclusion of any link does not imply endorsement of Microsoft of the site or the products contained therein.

© 2020 Microsoft Corporation. All rights reserved.

Microsoft and the trademarks listed at <https://www.microsoft.com/en-us/legal/intellectualproperty/Trademarks/Usage/General.aspx> are trademarks of the Microsoft group of companies. All other trademarks are property of their respective owners.

**Contents** 

<!-- TOC -->
- [Azure Synapse Analytics and AI hands-on lab step-by-step](#azure-synapse-analytics-and-ai-hands-on-lab-step-by-step)
  - [Abstract and learning objectives](#abstract-and-learning-objectives)
  - [Overview](#overview)
  - [Solution architecture](#solution-architecture)
  - [Requirements](#requirements)
  - [Before the hands-on lab](#before-the-hands-on-lab)
  - [Resource naming throughout this lab](#resource-naming-throughout-this-lab)
  - [Exercise 1: Accessing the Azure Synapse Analytics workspace](#exercise-1-accessing-the-azure-synapse-analytics-workspace)
    - [Task 1: Launching Synapse Studio](#task-1-launching-synapse-studio)
  - [Exercise 2: Create and populate the supporting tables in the SQL Pool](#exercise-2-create-and-populate-the-supporting-tables-in-the-sql-pool)
    - [Task 1: Create the sale table](#task-1-create-the-sale-table)
    - [Task 2: Populate the sale table](#task-2-populate-the-sale-table)
    - [Task 3: Create the customer information table](#task-3-create-the-customer-information-table)
    - [Task 4: Populate the customer information table](#task-4-populate-the-customer-information-table)
    - [Task 5: Create the campaign analytics table](#task-5-create-the-campaign-analytics-table)
    - [Task 6: Populate the campaign analytics table](#task-6-populate-the-campaign-analytics-table)
    - [Task 7: Populate the product table](#task-7-populate-the-product-table)
  - [Exercise 3: Exploring raw parquet](#exercise-3-exploring-raw-parquet)
    - [Task 1: Query sales Parquet data with Synapse SQL Serverless](#task-1-query-sales-parquet-data-with-synapse-sql-serverless)
    - [Task 2: Query sales Parquet data with Azure Synapse Spark](#task-2-query-sales-parquet-data-with-azure-synapse-spark)
  - [Exercise 4: Exploring raw text based data with Azure Synapse SQL Serverless](#exercise-4-exploring-raw-text-based-data-with-azure-synapse-sql-serverless)
    - [Task 1: Query CSV data](#task-1-query-csv-data)
    - [Task 2: Query JSON data](#task-2-query-json-data)
  - [Exercise 5: Synapse Pipelines and Cognitive Search](#exercise-5-synapse-pipelines-and-cognitive-search)
    - [Task 1: Create the invoice storage container](#task-1-create-the-invoice-storage-container)
    - [Task 2: Create and train an Azure Forms Recognizer model and setup Cognitive Search](#task-2-create-and-train-an-azure-forms-recognizer-model-and-setup-cognitive-search)
    - [Task 3: Configure a skillset with Form Recognizer](#task-3-configure-a-skillset-with-form-recognizer)
    - [Task 4: Create the Synapse Pipeline](#task-4-create-the-synapse-pipeline)
  - [Exercise 6: Security](#exercise-6-security)
    - [Task 1: Column level security](#task-1-column-level-security)
    - [Task 2: Row level security](#task-2-row-level-security)
    - [Task 3: Dynamic data masking](#task-3-dynamic-data-masking)
  - [Exercise 7: Machine Learning](#exercise-7-machine-learning)
    - [Task 1: Training, consuming, and deploying models](#task-1-training-consuming-and-deploying-models)
  - [Exercise 8: Monitoring](#exercise-8-monitoring)
    - [Task 1: Workload importance](#task-1-workload-importance)
    - [Task 2: Workload isolation](#task-2-workload-isolation)
    - [Task 3: Monitoring with Dynamic Management Views](#task-3-monitoring-with-dynamic-management-views)
    - [Task 4: Orchestration Monitoring with the Monitor Hub](#task-4-orchestration-monitoring-with-the-monitor-hub)
    - [Task 5: Monitoring SQL Requests with the Monitor Hub](#task-5-monitoring-sql-requests-with-the-monitor-hub)
  - [After the hands-on lab](#after-the-hands-on-lab)
    - [Task 1: Delete the resource group](#task-1-delete-the-resource-group)
<!-- /TOC -->

# Azure Synapse Analytics and AI hands-on lab step-by-step

## Abstract and learning objectives

In this hands-on-lab, you will build an end-to-end data analytics with machine learning solution using Azure Synapse Analytics. The information will be presented in the context of a retail scenario. We will be heavily leveraging Azure Synapse Studio, a tool that conveniently unifies the most common data operations from ingestion, transformation, querying, and visualization.

## Overview

In this lab various features of Azure Synapse Analytics will be explored. Azure Synapse Analytics Studio is a single tool that every team member can use collaboratively. Synapse Studio will be the only tool used throughout this lab through data ingestion, cleaning, and transforming raw files to using Notebooks to train, register, and consume a Machine learning model. The lab will also provide hands-on-experience monitoring and prioritizing data related workloads.

## Solution architecture

![Architecture diagram explained in the next paragraph.](media/archdiagram.png "Architecture Diagram")

This lab explores the cold data scenario of ingesting various types of raw data files. These files can exist anywhere. The file types used in this lab are CSV, parquet, and JSON. This data will be ingested into Synapse Analytics via Pipelines. From there, the data can be transformed and enriched using various tools such as data flows, Synapse Spark, and Synapse SQL (both provisioned and serverless). Once processed, data can be queried using Synapse SQL tooling. Azure Synapse Studio also provides the ability to author notebooks to further process data, create datasets, train, and create machine learning models. These models can then be stored in a storage account or even in a SQL table. These models can then be consumed via various methods, including T-SQL. The foundational component supporting all aspects of Azure Synapse Analytics is the ADLS Gen 2 Data Lake.

## Requirements

1. Microsoft Azure subscription

2. Azure Synapse Workspace / Studio

## Before the hands-on lab

Refer to the Before the hands-on lab setup guide manual before continuing to the lab exercises.

## Resource naming throughout this lab

For the remainder of this lab, the following terms will be used for various ASA (Azure Synapse Analytics) related resources (make sure you replace them with actual names and values from your environment):

| Azure Synapse Analytics Resource  | To be referred to                                                                  |
|-----------------------------------|------------------------------------------------------------------------------------|
| Azure Subscription                | `WorkspaceSubscription`                                                            |
| Azure Region                      | `WorkspaceRegion`                                                                  |
| Workspace resource group          | `WorkspaceResourceGroup`                                                           |
| Workspace / workspace name        | `asaworkspace{suffix}`                                                             |
| Primary Storage Account           | `asadatalake{suffix}`                                                              |
| Default file system container     | `DefaultFileSystem`                                                                |
| SQL Pool                          | `SqlPool01`                                                                        |
| SQL Serverless Endpoint           | `SqlServerless01`                                                                  |
| Azure Key Vault                   | `asakeyvault{suffix}`                                                              |

## Exercise 1: Accessing the Azure Synapse Analytics workspace

**Duration**: 5 minutes

All exercises in this lab utilize the workspace Synapse Studio user interface. This exercise will outline the steps to launch Synapse Studio. Unless otherwise specified, all instruction including menu navigation will occur in Synapse Studio.

### Task 1: Launching Synapse Studio

1. Log into the [Azure Portal](https://portal.azure.com).

2. Expand the left menu, and select the **Resource groups** item.
  
    ![The Azure Portal left menu is expanded with the Resource groups item highlighted.](media/azureportal_leftmenu_resourcegroups.png "Azure Portal Resource Groups menu item")

3. From the list of resource groups, select `WorkspaceResourceGroup`.
  
4. From the list of resources, select the **Synapse Workspace** resource, `asaworkspace{suffix}`.
  
    ![In the resource list, the Synapse Workspace item is selected.](media/resourcelist_synapseworkspace.png "The resource group listing")

5. On the **Overview** tab of the Synapse Workspace page, select the **Launch Synapse Studio** item from the top toolbar. Alternatively you can select the Workspace web URL link.

    ![On the Synapse workspace resource screen, the Overview pane is shown with the Launch Synapse Studio button highlighted in the top toolbar. The Workspace web URL value is also highlighted.](media/workspaceresource_launchsynapsestudio.png "Launching Synapse Studio")

## Exercise 2: Create and populate the supporting tables in the SQL Pool

**Duration**: 120 minutes

The first step in querying meaningful data is to create tables to house the data. In this case, we will create four different tables: SaleSmall, CustomerInfo, CampaignAnalytics, and Sales. When designing tables in Azure Synapse Analytics, we need to take into account the expected amount of data in each table, as well as how each table will be used. Utilize the following guidance when designing your tables to ensure the best experience and performance.

Table design performance considerations

| Table Indexing | Recommended use |
|--------------|-------------|
| Clustered Columnstore | Recommended for tables with greater than 100 million rows, offers the highest data compression with best overall query performance. |
| Heap Tables | Smaller tables with less than 100 million rows, commonly used as a staging table prior to transformation. |
| Clustered Index | Large lookup tables (> 100 million rows) where querying will only result in a single row returned. |
| Clustered Index + non-clustered secondary index | Large tables (> 100 million rows) when single (or very few) records are being returned in queries. |

| Table Distribution/Partition Type | Recommended use |
|--------------------|-------------|
| Hash distribution | Tables that are larger than 2 GBs with infrequent insert/update/delete operations, works well for large fact tables in a star schema. |
| Round robin distribution | Default distribution, when little is known about the data or how it will be used. Use this distribution for staging tables. |
| Replicated tables | Smaller lookup tables, less than 1.5 GB in size. |

### Task 1: Create the sale table

Over the past 5 years, Wide World Importers has amassed over 3 billion rows of sales data. With this quantity of data, the storage consumed would be greater than 2 GB. While we will be using only a subset of this data for the lab, we will design the table for the production environment. Using the guidance outlined in the current Exercise description, we can ascertain that we will need a **Clustered Columnstore** table with a **Hash** table distribution based on the **CustomerId** field which will be used in most queries. For further performance gains, the table will be partitioned by transaction date to ensure queries that include dates or date arithmetic are returned in a favorable amount of time.

1. Expand the left menu and select the **Develop** item. From the **Develop** blade, expand the **+** button and select the **SQL script** item.

    ![The left menu is expanded with the Develop item selected. The Develop blade has the + button expanded with the SQL script item highlighted.](media/develop_newsqlscript_menu.png "The Develop Hub")

2. In the query tab toolbar menu, ensure you connect to your SQL Pool, `SQLPool01`.

    ![The query tab toolbar menu is displayed with the Connect to set to the SQL Pool.](media/querytoolbar_connecttosqlpool.png "Connecting to the SQL Pool")

3. In the query window, copy and paste the following query to create the customer information table. Then select the **Run** button in the query tab toolbar.

    ```sql
      CREATE TABLE [wwi_mcw].[SaleSmall]
      (
        [TransactionId] [uniqueidentifier]  NOT NULL,
        [CustomerId] [int]  NOT NULL,
        [ProductId] [smallint]  NOT NULL,
        [Quantity] [tinyint]  NOT NULL,
        [Price] [decimal](9,2)  NOT NULL,
        [TotalAmount] [decimal](9,2)  NOT NULL,
        [TransactionDateId] [int]  NOT NULL,
        [ProfitAmount] [decimal](9,2)  NOT NULL,
        [Hour] [tinyint]  NOT NULL,
        [Minute] [tinyint]  NOT NULL,
        [StoreId] [smallint]  NOT NULL
      )
      WITH
      (
        DISTRIBUTION = HASH ( [CustomerId] ),
        CLUSTERED COLUMNSTORE INDEX,
        PARTITION
        (
          [TransactionDateId] RANGE RIGHT FOR VALUES (
            20180101, 20180201, 20180301, 20180401, 20180501, 20180601, 20180701, 20180801, 20180901, 20181001, 20181101, 20181201,
            20190101, 20190201, 20190301, 20190401, 20190501, 20190601, 20190701, 20190801, 20190901, 20191001, 20191101, 20191201)
        )
      );
    ```

4. From the top toolbar, select the **Discard all** button as we will not be saving this query. When prompted, choose to **Discard changes**.

   ![The top toolbar menu is displayed with the Discard all button highlighted.](media/toptoolbar_discardall.png "Discarding all changes")
  
### Task 2: Populate the sale table

The data that we will be retrieving to populate the sale table is currently stored as a series of parquet files in the **asadatalake{SUFFIX}** data lake (Azure Data Lake Storage Gen 2). This storage account has already been added as a linked service in Azure Synapse Analytics when the environment was provisioned. Linked Services are synonymous with connection strings in Azure Synapse Analytics. Azure Synapse Analytics linked services provides the ability to connect to nearly 100 different types of external services ranging from Azure Storage Accounts to Amazon S3 and more.

1. Review the presence of the **asadatalake{SUFFIX}** linked service, by selecting **Manage** from the left menu, and selecting **Linked services** from the blade menu. Filter the linked services by the term **asadatalake** to find the **asadatalake{SUFFIX}** item. Further investigating this item will unveil that it makes a connection to the storage account using a storage account key.
  
   ![The Manage item is selected from the left menu. The Linked services menu item is selected on the blade. On the Linked services screen the term asadatalake{SUFFIX} is entered in the search box and the asadatalake{SUFFIX} Azure Blob Storage item is selected from the filtered results list.](media/manage_linkedservices_solliancepublicdata.png "Searching for a linked service")

2. The sale data for each day is stored in a separate parquet file which is placed in storage following a known convention. In this lab, we are interested in populating the Sale table with only 2018 and 2019 data. Investigate the structure of the data by selecting the **Data** tab, and in the **Data** pane, select the **Linked** tab, and expanding the `asadatalake{SUFFIX}` Storage account.

    > **Note**: The current folder structure for daily sales data is as follows: 
    /wwi-02/sale-small/Year=`YYYY`/Quarter=`Q#`/Month=`M`/Day=`YYYYMMDD`, where `YYYY` is the 4 digit year (eg. 2019), `Q#` represents the quarter (eg. Q1), `M` represents the numerical month (eg. 1 for January) and finally `YYYYMMDD` represents a numeric date format representation (eg. `20190516` for May 16, 2019).
    > A single parquet file is stored each day folder with the name **sale-small-YYYYMMDD-snappy.parquet** (replacing `YYYYMMDD` with the numeric date representation).

    ```text
    Sample path to the parquet folder for January 1, 2019:
    /wwi-02/sale-small/Year=2019/Quarter=Q1/Month=1/Day=20190101/sale-small-20190101-snappy.parquet
    ```

3. Create a new Dataset by selecting **Data** from the left menu, expanding the **+** button on the Data blade and selecting **Dataset**. We will be creating a dataset that will point to the root folder of the sales data in the data lake.

4. In the **New dataset** blade, with the **All** tab selected, choose the **Azure Data Lake Storage Gen2** item. Select **Continue**.

    ![The New dataset blade is displayed with the All tab selected, the Azure Data Lake Storage Gen2 item is selected from the list.](media/new_dataset_type_selection.png "Defining a new Dataset")

5. In the **Select format** screen, choose the **Parquet** item. Select **Continue**.

    ![In the Select format screen, the Parquet item is highlighted.](media/dataset_format_parquet.png "Selecting Parquet")

6. In the **Set properties** blade, populate the form as follows then select **OK**.
  
   | Field | Value |
   |-------|-------|
   | Name  | Enter **asamcw_sales_parquet**. |
   | Linked service | **asadatalake{SUFFIX}** |
   | File path - Container | Enter **wwi-02**. |  
   | File path - Folder | Enter **sale-small**. |
   | Import schema | **From connection/store** |

    ![The Set properties blade is displayed with fields populated with the values from the preceding table.](media/dataset_salesparquet_propertiesform.png "Dataset form")

7. Now we will need to define the destination dataset for our data. In this case we will be storing sale data in our SQL Pool. Create a new dataset by expanding the **+** button on the **Data** blade and selecting **Dataset**.

8. On the **New dataset** blade, with the **Azure** tab selected, enter **synapse** as a search term and select the **Azure Synapse Analytics (formerly SQL DW)** item. Select **Continue**.
  
9. On the **Set properties** blade, set the field values to the following, then select **OK**.

   | Field | Value |
   |-------|-------|
   | Name  | Enter **asamcw_sale_asa**. |
   | Linked service | **SQLPool01** |
   | Table name | **wwi_mcw.SaleSmall** |  
   | Import schema | **From connection/store** |

    ![The Set properties blade is populated with the values specified in the preceding table.](media/dataset_saleasaform.png "Dataset form")
  
10. In the top toolbar, select **Publish all** to publish the new dataset definitions. When prompted, select the **Publish** button to deploy the changes to the workspace.

    ![The top toolbar is displayed with the Publish all button highlighted.](media/publishall_toolbarmenu.png "Publish changes")

11. Since we want to filter on multiple sale year folders (Year=2018 and Year=2019) and copy only the 2018 and 2019 sales data, we will need to create a data flow to define the specific data that we wish to retrieve from our source dataset. To create a new data flow, start by selecting **Develop** from the left menu, and in the **Develop** blade, expand the **+** button and select **Data flow**.

    ![From the left menu, the Develop item is selected. From the Develop blade the + button is expanded with the Data flow item highlighted.](media/develop_newdataflow_menu.png "Creating a data flow")

12. In the side pane on the **General** tab, name the data flow by entering **ASAMCW_Exercise_2_2018_and_2019_Sales** in the **Name** field.

    ![The General tab is displayed with ASAMCW_Exercise_2_2018_and_2019_Sales entered as the name of the data flow.](media/dataflow_generaltab_name.png "Naming the data flow")

13. In the data flow designer window, select the **Add Source** box.

    ![The Add source box is highlighted in the data flow designer window.](media/dataflow_addsourcebox.png "Adding a data flow source")

14. With the added source selected in the designer, in the lower pane with the **Source settings** tab selected, set the following field values:
  
    | Field | Value |
    |-------|-------|
    | Output stream name  | Enter **salesdata**. |
    | Source type | **Dataset** |
    | Dataset | **asamcw_sales_parquet** |

    ![The Source settings tab is selected displaying the Output stream name set to salesdata and the selected dataset being asamcw_sales_parquet.](media/dataflow_source_sourcesettings.png "Defining the source")

15. Select the **Source options** tab, and add the following as **Wildcard paths**, this will ensure that we only pull data from the parquet files for the sales years of 2018 and 2019:

    1. sale-small/Year=2018/\*/\*/\*/\*

    2. sale-small/Year=2019/\*/\*/\*/\*

      ![The Source options tab is selected with the above wildcard paths highlighted.](media/dataflow_source_sourceoptions.png "Setting wildcard paths on the source")

16. At the bottom right of the **salesdata** source, expand the **+** button and select the **Sink** item located in the **Destination** section of the menu.

      ![The + button is highlighted toward the bottom right of the source element on the data flow designer.](media/dataflow_source_additem.png "Adding another data flow activity")

17. In the designer, select the newly added **Sink** element and in the bottom pane with the **Sink** tab selected, fill the form as follows:

    | Field | Value |
    |-------|-------|
    | Output stream name  | Enter **sale**. |
    | Incoming stream | **salesdata** |
    | Sink type | **Dataset** |
    | Dataset | **asamcw_sale_asa** |

    ![The Sink tab is displayed with the form populated with the values from the preceding table.](media/dataflow_sink_sinktab.png "Defining the data flow sink")

18. Select the **Mapping** tab and toggle the **Auto mapping** setting to the off position. You will need to select Input columns for the following:
  
    | Input column | Output column |
    |-------|-------|
    | Quantity | Quantity |
    | TransactionDate  | TransactionDateId |
    | Hour | Hour |
    | Minute | Minute |

    ![The Mapping tab is selected with the Auto mapping toggle set to the off position. The + Add mapping button is highlighted along with the mapping entries specified in the preceding table.](media/dataflow_sink_mapping.png "Mapping columns")

19. In the top toolbar, select **Publish all** to publish the new dataset definitions. When prompted, select the **Publish** button to deploy the new data flow to the workspace.

    ![The top toolbar is displayed with the Publish all button highlighted.](media/publishall_toolbarmenu.png "Publishing changes")

20. We can now use this data flow as an activity in a pipeline. Create a new pipeline by selecting **Orchestrate** from the left menu, and in the **Orchestrate** blade, expand the **+** button and select **Pipeline**.

21. On the **Properties** blade, Enter **ASAMCW - Exercise 2 - Copy Sale Data** as the Name of the pipeline.

22. From the **Activities** menu, expand the **Move & transform** section and drag an instance of **Data flow** to the design surface of the pipeline.
  
    ![The Activities menu of the pipeline is displayed with the Move and transform section expanded. An arrow indicating a drag operation shows adding a Data flow activity to the design surface of the pipeline.](media/pipeline_sales_dataflowactivitymenu.png "Drag and drop of the data flow activity")

23. In the **Adding data flow** blade, ensure **Use existing data flow** is selected, and choose **ASAMCW_Exercise_2_2018_and_2019_Sales** from the select list and select **Finish**.

    ![The Adding data flow blade is displayed populated with the appropriate values.](media/pipeline_dataflowactivity_addingblade.png "Configuring the data flow activity")

24. Select the **Settings** tab and set the form fields to the following values:

    | Field | Value |
    |-------|-------|
    | Data flow  | **ASAMCW_Exercise_2_2018_and_2019_Sales** |
    | Staging linked service | `asadatalake{SUFFIX}` |
    | Staging storage folder - Container | Enter **staging**. |
    | Staging storage folder - Folder | Enter **mcwsales**. |

    ![The data flow activity Settings tab is displayed with the fields specified in the preceding table highlighted.](media/pipeline_sales_dataflowsettings.png "Data flow activity settings")

25. In the top toolbar, select **Publish all** to publish the new dataset definitions. When prompted, select the **Publish** button to commit the changes.

    ![The top toolbar is displayed with the Publish all button highlighted.](media/publishall_toolbarmenu.png "Publishing changes")

26. Once published, expand the **Add trigger** item on the pipeline designer toolbar, and select **Trigger now**. In the **Pipeline run** blade, select **OK** to proceed with the latest published configuration. You will see notification toast windows indicating the pipeline is running and when it has completed.

27. View the status of the pipeline run by locating the **ASAMCW - Exercise 2 - Copy Sale Data** pipeline in the Orchestrate blade. Expand the actions menu, and select the **Monitor** item.

    ![In the Orchestrate blade, the Action menu is displayed with the Monitor item selected on the ASAMCW - Exercise 2 - Copy Sale Data pipeline.](media/orchestrate_pipeline_monitor_copysaledata.png "Monitoring a pipeline")
  
28. You should see a run of the pipeline we created in the **Pipeline runs** table showing as in progress. It will take approximately 45 minutes for this pipeline operation to complete. You will need to refresh this table from time to time to see updated progress. Once it has completed. You should see the pipeline run displayed with a Status of **Succeeded**. _Feel free to proceed to the following tasks in this exercise while this pipeline runs_.
  
    ![On the pipeline runs screen, a successful pipeline run is highlighted in the table.](media/pipeline_run_sales_successful.png "Successful pipeline indicator")

29. Verify the table has populated by creating a new query. Select the **Develop** item from the left menu, and in the **Develop** blade, expand the **+** button, and select **SQL script**. In the query window, be sure to connect to the SQL Pool database (`SQLPool01`), then paste and run the following query. When complete, select the **Discard all** button from the top toolbar.

  ```sql
    select count(TransactionId) from wwi_mcw.SaleSmall;
  ```

### Task 3: Create the customer information table

Over the past 5 years, Wide World Importers has amassed over 3 billion rows of sales data. With this quantity of data, the customer information lookup table is estimated to have over 100 million rows but will consume less than 1.5 GB of storage. While we will be using only a subset of this data for the lab, we will design the table for the production environment. Using the guidance outlined in the Exercising description, we can ascertain that we will need a **Clustered Columnstore** table with a **Replicated** table distribution to hold customer data.

1. Expand the left menu and select the **Develop** item. From the **Develop** blade, expand the **+** button and select the **SQL script** item.

    ![The left menu is expanded with the Develop item selected. The Develop blade has the + button expanded with the SQL script item highlighted.](media/develop_newsqlscript_menu.png "Adding a SQL script")

2. In the query tab toolbar menu, ensure you connect to your SQL Pool, `SQLPool01`.

    ![The query tab toolbar menu is displayed with the Connect to set to the SQL Pool.](media/querytoolbar_connecttosqlpool.png "Connecting to the SQL Pool")

3. In the query window, copy and paste the following query to create the customer information table. Then select the **Run** button in the query tab toolbar.
  
   ```sql
    CREATE TABLE [wwi_mcw].[CustomerInfo]
    (
      [UserName] [nvarchar](100)  NULL,
      [Gender] [nvarchar](10)  NULL,
      [Phone] [nvarchar](50)  NULL,
      [Email] [nvarchar](150)  NULL,
      [CreditCard] [nvarchar](21)  NULL
    )
    WITH
    (
      DISTRIBUTION = REPLICATE,
      CLUSTERED COLUMNSTORE INDEX
    )
    GO
   ```

   ![The query tab toolbar is displayed with the Run button selected.](media/querytoolbar_run.png "Running the query")

4. From the top toolbar, select the **Discard all** button as we will not be saving this query. When prompted, choose to **Discard changes**.

   ![The top toolbar menu is displayed with the Discard all button highlighted.](media/toptoolbar_discardall.png "Discard all changes")

### Task 4: Populate the customer information table

1. The data that we will be retrieving to populate the customer information table is currently stored in CSV format in the data lake (Azure Data Lake Storage Gen2 account). The storage account that possesses this data has already been added as a linked service in Azure Synapse Analytics when the environment was provisioned. 

2. Similar to the previous step, the destination for our data has also been added as a linked service. In this case, the destination for our data is our SQL Pool, `SQLPool01`. Repeat the previous step, this time filtering with the term **sqlpool** to verify the existence of the linked service.

3. The next thing that we will need to do is define a source dataset that will represent the information that we are copying over. This dataset will reference the CSV file containing customer information. From the left menu, select **Data**. From the **Data** blade, expand the **+** button and select **Dataset**.

    ![The Data item is selected from the left menu. On the Data blade, the + button is expanded with the Dataset item highlighted.](media/data_newdatasetmenu.png "Creating a new Dataset")

4. On the **New dataset** blade, with the **Azure** tab selected, choose the **Azure Data Lake Gen2** item. Select **Continue**.  
  
    ![On the New dataset blade, the All tab is selected and the Azure Data Lake Gen2 item is highlighted.](media/newdataset_azuredatalakegen2.png "Selecting Azure Data Lake Gen2 as the dataset type")

5. On the **Select format** blade, select **CSV Delimited Text**. Select **Continue**.

    ![On the Select format blade the CSV Delimited Text item is highlighted.](media/newdataset_selectfileformat_csv.png "Defining the dataset format to be CSV")

6. On the **Set properties** blade, set the fields to the following values, then select **OK**.

   | Field | Value |
   |-------|-------|
   | Name  | Enter **asamcw_customerinfo_csv**. |
   | Linked service | **asadatalake{SUFFIX}**|
   | File Path - Container | Enter **wwi-02**. |
   | File Path - Directory | Enter **customer-info**. |
   | File Path - File | Enter **customerinfo.csv**. |
   | First row as header | Checked |
   | Import schema | Select **From connection/store**. |

    ![The Set properties form is displayed with the values specified in the previous table.](media/customerinfodatasetpropertiesform.png "Configuring the dataset")

7. Now we will need to define the destination dataset for our data. In this case we will be storing customer information data in our SQL Pool. On the **Data** blade, expand the **+** button just as you did in **Step 3**.

8. On the **New dataset** blade, with the **Azure** tab selected, enter **synapse** as a search term and select the **Azure Synapse Analytics (formerly SQL DW)** item. Select **Continue**.

    ![On the New dataset blade, synapse is entered as the search term and Azure Synapse Analytics (formerly SQL DW) is selected from the filtered results.](media/newdataset_synapseitem.png "Selecting Azure Synapse Analytics as the dataset type")
  
9. On the **Set properties** blade, set the field values to the following, then select **OK**.

   | Field | Value |
   |-------|-------|
   | Name  | Enter **asamcw_customerinfo_asa**. |
   | Linked service | **SQLPool01** |
   | Table name | **wwi_mcw.CustomerInfo** |  
   | Import schema | **From connection/store** |

    ![The Set properties blade is populated with the values specified in the preceding table.](media/dataset_customerinfoasaform.png "Configuration form for the dataset")

10. In the top toolbar, select **Publish all** to publish the new dataset definitions. When prompted, select the **Publish** button to commit the changes.

    ![The top toolbar is displayed with the Publish all button highlighted.](media/publishall_toolbarmenu.png "Publishing changes")

11. Next, we will define a pipeline to populate data into the CustomerInfo table. From the left menu, select **Orchestrate**. From the Orchestrate blade, select the **+** button and select the **Pipeline** item.

    ![The Orchestrate menu item is selected from the left menu. On the Orchestrate blade, the + button is expanded with the Pipeline item highlighted.](media/orchestrate_newpipelinemenu.png "The Orchestrate Hub")

12. In the **Properties** blade, enter **ASAMCW - Exercise 2 - Copy Customer Information** in the **Name** field.

    ![The General tab is shown with the name field populated as described above.](media/pipeline_customerinfo_generaltab.png "Naming the pipeline")

13. In the **Activities** menu, expand the **Move & transform** item. Drag an instance of the **Copy data** activity to the design surface of the pipeline.

    ![In the Activities menu, the Move and transform section is expanded. An arrow denotes an instance of the Copy data activity being dragged over to the design surface of the pipeline.](media/pipeline_addcopydataactivity.png "Adding a copy activity to the pipeline")

14. Select the **Copy data** activity on the pipeline design surface. In the bottom pane, on the **General** tab, enter **Copy Customer Information Data** in the **Name** field.

    ![The General tab is selected with the Name field set to Copy Customer Information Data.](media/pipeline_copycustomerinformation_general.png "Naming the Copy data activity")

15. Select the **Source** tab in the bottom pane. In the **Source dataset** field, select **asamcw_customerinfo_csv**.

    ![The Source tab is selected with the Source dataset field set to asamcw_customerinfo_csv.](media/pipeline_copycustomerinformation_source.png "Selecting a source dataset")
  
16. Select the **Sink** tab in the bottom pane. In the **Sink dataset** field, select **asamcw_customerinfo_asa**, for the **Copy method** field, select **Bulk insert**, and for **Pre-copy script** enter:

    ```sql
      truncate table wwi_mcw.CustomerInfo
    ```

    ![The Sink tab is selected with the Sink dataset field set to asamcw_customerinfo_asa, the Copy method set to Bulk insert, and the Pre-copy script field set to the previous query.](media/pipeline_copycustomerinformation_sink.png "Selecting the sink dataset")
  
17. Select the **Mapping** tab in the bottom pane. Select the **Import schemas** button. You will notice that Azure Synapse Analytics automated the mapping for us since the field names and types match.

    ![The Mapping tab is selected in the bottom pane. The source to destination field mapping is shown.](media/pipeline_copycustomerinformation_mapping.png "Source to destination field mapping")

18. In the top toolbar, select **Publish all** to publish the new dataset definitions. When prompted, select the **Publish** button to commit the changes.

    ![The top toolbar is displayed with the Publish all button highlighted.](media/publishall_toolbarmenu.png "Publishing changes")

19. Once published, expand the **Add trigger** item on the pipeline designer toolbar, and select **Trigger now**. In the **Pipeline run** blade, select **OK** to proceed with the latest published configuration. You will see notification toast windows indicating the pipeline is running and when it has completed.

20. View the status of the completed run by locating the **ASAMCW - Exercise 2 - Copy Customer Information** pipeline in the Orchestrate blade. Expand the actions menu, and select the **Monitor** item.

    ![In the Orchestrate blade, the Action menu is displayed with the Monitor item selected on the ASAMCW - Exercise 2 - Copy Customer Information pipeline.](media/pipeline_copycustomerinformation_monitormenu.png "Monitoring the pipeline")
  
21. You should see a successful run of the pipeline we created in the **Pipeline runs** table.
  
    ![On the pipeline runs screen, a successful pipeline run is highlighted in the table.](media/pipeline_run_customerinfo_successful.png "Successful pipeline run indicator")

22. Verify the table has populated by creating a new query. Remember from **Task 1**, select the **Develop** item from the left menu, and in the **Develop** blade, expand the **+** button, and select **SQL script**. In the query window, be sure to connect to the SQL Pool database (`SQLPool01`), then paste and run the following query. When complete, select the **Discard all** button from the top toolbar.

  ```sql
    select * from wwi_mcw.CustomerInfo;
  ```
  
### Task 5: Create the campaign analytics table

The campaign analytics table will be queried primarily for dashboard and KPI purposes. Performance is a large factor in the design of this table, and as such  we can ascertain that we will need a **Clustered Columnstore** table with a **Hash** table distribution based on the **Region** field which will fairly evenly distribute the data.

1. Expand the left menu and select the **Develop** item. From the **Develop** blade, expand the **+** button and select the **SQL script** item.

    ![The left menu is expanded with the Develop item selected. The Develop blade has the + button expanded with the SQL script item highlighted.](media/develop_newsqlscript_menu.png "Creating a new SQL script")

2. In the query tab toolbar menu, ensure you connect to your SQL Pool, `SQLPool01`.

    ![The query tab toolbar menu is displayed with the Connect to set to the SQL Pool.](media/querytoolbar_connecttosqlpool.png "Connecting to the SQL Pool")

3. In the query window, copy and paste the following query to create the campaign analytics table. Then select the **Run** button in the query tab toolbar.

    ```sql
    CREATE TABLE [wwi_mcw].[CampaignAnalytics]
    (
        [Region] [nvarchar](50)  NULL,
        [Country] [nvarchar](30)  NOT NULL,
        [ProductCategory] [nvarchar](50)  NOT NULL,
        [CampaignName] [nvarchar](500)  NOT NULL,
        [Analyst] [nvarchar](25) NULL,
        [Revenue] [decimal](10,2)  NULL,
        [RevenueTarget] [decimal](10,2)  NULL,
        [City] [nvarchar](50)  NULL,
        [State] [nvarchar](25)  NULL
    )
    WITH
    (
        DISTRIBUTION = HASH ( [Region] ),
        CLUSTERED COLUMNSTORE INDEX
    );  
    ```

    ![The query tab toolbar is displayed with the Run button selected.](media/querytoolbar_run.png "Running the query")

4. From the top toolbar, select the **Discard all** button as we will not be saving this query. When prompted, choose to **Discard changes**.

   ![The top toolbar menu is displayed with the Discard all button highlighted.](media/toptoolbar_discardall.png "Discard all changes")

### Task 6: Populate the campaign analytics table

Similar to the customer information table, we will also be populating the campaign analytics table via a CSV file located in the data lake. This will require source and sink datasets to point to the CSV file in storage and the campaign analytics table that you just created in the SQL Pool. The source CSV file that was received is poorly formatted - we will need to add data transformations to make adjustments to this data before it is imported into the data warehouse.

1. The source dataset will reference the CSV file containing campaign analytics information. From the left menu, select **Data**. From the **Data** blade, expand the **+** button and select **Dataset**.

    ![The Data item is selected from the left menu. On the Data blade, the + button is expanded with the Dataset item highlighted.](media/data_newdatasetmenu.png "Creating a new dataset")

2. On the **New dataset** blade, with the **All** tab selected, choose the **Azure Data Lake Storage Gen2** item. Select **Continue**.  
  
    ![The New dataset blade is displayed with the All tab selected, the Azure Data Lake Storage Gen2 item is selected from the list.](media/new_dataset_type_selection.png "Selecting the dataset type")

3. On the **Select format** blade, select **CSV Delimited Text**. Select **Continue**.

    ![On the Select format blade the CSV Delimited Text item is highlighted.](media/newdataset_selectfileformat_csv.png "Selecting the dataset format")

4. On the **Set properties** blade, set the fields to the following values, then select **OK**. You may choose to preview the data which will show a sample of the CSV file. Notice that since we are not setting the first row as the header, the header columns appear as the first row. Also, notice that the city and state values do not appear. This is because of the mismatch in the number of columns in the header row compared to the rest of the file. Soon, we will exclude the first row as we transform the data.

   | Field | Value |
   |-------|-------|
   | Name  | Enter **asamcw_campaignanalytics_csv** |
   | Linked service | Select **asadatalake{SUFFIX}**.|
   | File Path - Container | Enter **wwi-02** |
   | File Path - Directory | Enter **campaign-analytics** |
   | File Path - File | Enter **campaignanalytics.csv** |
   | First row as header | Unchecked |
   | Import schema | Select **From connection/store** |

    ![The Set properties form is displayed with the values specified in the previous table.](media/campaignanalyticsdatasetpropertiesform.png)

5. In the center pane, on the **Connection** tab of **asamcw_campainganalytics_csv** dataset, ensure the following field values are set:

   | Field | Value |
   |-------|-------|
   | Escape Character  | **Backslash (\\\)** |
   | Quote Character | **Double quote (")** |  

6. Now we will need to define the destination dataset for our data. In this case we will be storing campaign analytics data in our SQL Pool. On the **Data** blade, expand the **+** button and select **Dataset**.

7. On the **New dataset** blade, with the **Azure** tab selected, enter **synapse** as a search term and select the **Azure Synapse Analytics (formerly SQL DW)** item. Select **Continue**.

    ![On the New dataset blade, synapse is entered as the search term and Azure Synapse Analytics (formerly SQL DW) is selected from the filtered results.](media/newdataset_synapseitem.png "Selecting the dataset type")
  
8. On the **Set properties** blade, set the field values to the following, then select **OK**.

   | Field | Value |
   |-------|-------|
   | Name  | Enter **asamcw_campaignanalytics_asa**. |
   | Linked service | **SQLPool01** |
   | Table name | **wwi_mcw.CampaignAnalytics** |  
   | Import schema | Select **From connection/store**. |

    ![The Set properties blade is populated with the values specified in the preceding table.](media/dataset_campaignanalyticsasaform.png "The dataset configuration form")

9. In the top toolbar, select **Publish all** to publish the new dataset definitions. When prompted, select the **Publish** button to commit the changes.

    ![The top toolbar is displayed with the Publish all button highlighted.](media/publishall_toolbarmenu.png "Publish changes")

10. Since our source data is malformed and does not contain an Analyst column, we will need to create a data flow to transform the source data. A data flow allows you to graphically define dataset filters and transformations without writing code. These data flows can be leveraged as an activity in an orchestration pipeline. Create a new data flow, start by selecting **Develop** from the left menu, and in the **Develop** blade, expand the **+** button and select **Data flow**.

    ![From the left menu, the Develop item is selected. From the Develop blade the + button is expanded with the Data flow item highlighted.](media/develop_newdataflow_menu.png "Create a new data flow")

11. In the **Properties** blade name the data flow by entering **ASAMCW_Exercise_2_Campaign_Analytics_Data** in the **Name** field.

    ![The Properties blade is displayed with ASAMCW_Exercise_2_Campaign_Analytics_Data entered as the name of the data flow.](media/dataflow_campaignanalytics_propertiesblade.png "Naming the data flow")

12. In the data flow designer window, select the **Add Source** box.

    ![The Add source box is highlighted in the data flow designer window.](media/dataflow_addsourcebox.png "Adding a data flow source")

13. Under **Source settings**, configure the following:

    | Field | Value |
    |-------|-------|
    | Output stream name  | Enter **campaignanalyticscsv**. |
    | Source type | **Dataset** |
    | Dataset | **asamcw_campaignanalytics_csv** |
    | Skip line count | Enter **1**. |  

    ![The Source settings tab is displayed with a form populated with the values defined in the preceding table.](media/dataflow_campaignanalytics_sourcesettings.png "The data flow configuration form")

14. When you create data flows, certain features are enabled by turning on debug, such as previewing data and importing a schema (projection). Due to the amount of time it takes to enable this option, as well as environmental constraints of the lab environment, we will bypass these features. The data source has a schema we need to set. To do this, select **Script** from the right side of the dataflow designer toolbar menu.

    ![A portion of the dataflow designer toolbar is shown with the Script icon highlighted.](media/dataflow_toolbarscriptmenu.png "The data flow script icon")

15. Replace the script with the following to provide the column mappings (`output`), then select **OK**:

    ```json
        source(output(
            {_col0_} as string,
            {_col1_} as string,
            {_col2_} as string,
            {_col3_} as string,
            {_col4_} as string,
            {_col5_} as double,
            {_col6_} as string,
            {_col7_} as double,
            {_col8_} as string,
            {_col9_} as string
        ),
        allowSchemaDrift: true,
        validateSchema: false,
        skipLines: 1) ~> campaignanalyticscsv
    ```

    > **Note**: We are changing the mappings as the source file was corrupted with the wrong headers.

16. Select the **campaignanalyticscsv** data source, then select **Projection**. The projection should display the following schema:

    ![The Projection tab is displayed with columns defined as described in the column mapping script.](media/dataflow_campaignanalytics_projectiontab.png "The column mappings of the source")

17. Select the **+** to the bottom right of the **campaignanalyticscsv** source, then select the **Select** schema modifier from the context menu.

    ![The + button on the bottom right of the campaignanalyticscsv source is highlighted.](media/dataflow_campaignanalytics_addstep.png "Adding a Select schema modifier")

18. In the bottom pane, under **Select settings**, configure the following:

    | Field | Value |
    |-------|-------|
    | Output stream name  | Enter **mapcampaignanalytics**. |

    For **Input Columns**, under the **Name as** column, enter the following list values in order:
      - Region
      - Country
      - ProductCategory
      - CampaignName
      - RevenuePart1
      - Revenue
      - RevenueTargetPart1
      - RevenueTarget
      - City
      - State

    ![The Select settings tab is displayed with the form filled as described in the preceding table.](media/dataflow_mapcampaignanalytics_selectsettings.png "Configuring the Select schema modifier")

19. Select the **+** to the right of the **mapCampaignAnalytics** source, then select the **Derived Column** schema modifier from the context menu.

20. Under **Derived column's settings**, configure the following:

    | Field | Value |
    |-------|-------|
    | Output stream name  | Enter **convertandaddcolumns**. |

    For **Columns**, add the following (Note you will need to type in the **Analyst** column):

    | Column | Expression | Description |
    | --- | --- | --- |
    | Revenue | **toDecimal(replace(concat(toString(RevenuePart1), toString(Revenue)), '\\\\', ''), 10, 2, '$###,###.##')** | Concatenate the **RevenuePart1** and **Revenue** fields, replace the invalid `\` character, then convert and format the data to a decimal type. |
    | RevenueTarget | **toDecimal(replace(concat(toString(RevenueTargetPart1), toString(RevenueTarget)), '\\\\', ''), 10, 2, '$###,###.##')** | Concatenate the **RevenueTargetPart1** and **RevenueTarget** fields, replace the invalid `\` character, then convert and format the data to a decimal type. |
    | Analyst | **iif(isNull(City), '',  replace('DataAnalyst'+ City,' ',''))** | If the city field is null, assign an empty string to the Analyst field, otherwise concatenate DataAnalyst to the City value, removing all spaces. |

    ![The derived column's settings are displayed as described.](media/dataflow_campaignanalytics_derivedcolumns.png "Deriving columns based on expressions")

21. Select the **+** to the right of the **convertandaddcolumns** step, then select the **Select** schema modifier from the context menu.

22. Under **Select settings**, configure the following:

    | Field | Value |
    |-------|-------|
    | Output stream name  | Enter **selectcampaignanalyticscolumns**. |
    | Input columns | Delete the **RevenuePart1** and **RevenueTargetPart1** columns. |

    ![The Select settings are displayed showing the updated column mappings.](media/dataflow_campaignanalytics_select2.png "Configuring the Select schema modifier")

23. Select the **+** to the right of the **selectcampaignanalyticscolumns** step, then select the **Sink** destination from the context menu.

24. In the bottom pane, on the **Sink** tab, configure it as follows:

    | Field | Value |
    |-------|-------|
    | Output stream name  | Enter **campaignanlyticsasa**. |
    | Dataset | **asamcw_campaignanalytics_asa** |

    ![The Sink settings form is displayed populated with the values defined in the previous table.](media/dataflow_campaignanalytics_sink.png "Configuring the data flow sink")

25. Select **Settings** tab, and for **Table action** select **Truncate table**.

    ![The sink Settings tab is displayed with the Table action set to Truncate table.](media/dataflow_campaignanalytics_sinksettings.png "Truncate table action")

26. Your completed data flow should look similar to the following:

    ![The completed data flow is displayed.](media/dataflow_campaignanalytics_complete.png "The completed data flow")
  
27. Select **Publish all** to save your new data flow.

    ![Publish all is highlighted.](media/publishall_toolbarmenu.png "Publish all")

28. Now that the data flow is published, we can use it in a pipeline. Create a new pipeline by selecting **Orchestrate** from the left menu, then in the **Orchestrate** blade, expand the **+** button and select **Pipeline**.

29. In the **Properties** pane on the right side of the pipeline designer. Enter **ASAMCW - Exercise 2 - Copy Campaign Analytics Data** in the **Name** field.

    ![The pipeline properties blade is displayed with the Name field populated with ASAMCW - Exercise 2 - Copy Campaign Analytics Data.](media/pipeline_properties_blade.png "Naming the pipeline")

30. From the **Activities** menu, expand the **Move & transform** section and drag an instance of **Data flow** to the design surface of the pipeline.
  
    ![The Activities menu of the pipeline is displayed with the Move and transform section expanded. An arrow indicating a drag operation shows adding a Data flow activity to the design surface of the pipeline.](media/pipeline_sales_dataflowactivitymenu.png "Adding a data flow activity to the pipeline")

31. In the **Adding data flow** blade, select the data flow **ASAMCW_Exercise_2_Campaign_Analytics_Data**, then **Finish**. Select the Mapping Data Flow activity on the design surface.

32. In the bottom pane, select the **Settings** tab and set the form fields to the following values:

    | Field | Value |
    |-------|-------|
    | Data flow  | **ASAMCW_Exercise_2_Campaign_Analytics_Data** |
    | Staging linked service | **asadatalake{SUFFIX}** |
    | Staging storage folder - Container | Enter **staging**. |
    | Staging storage folder - Directory | Enter **mcwcampaignanalytics**. |

    ![The data flow activity Settings tab is displayed with the fields specified in the preceding table highlighted.](media/pipeline_campaigndata_dataflowsettings.png "Configuring the data flow activity")

33. In the top toolbar, select **Publish all** to publish the new pipeline. When prompted, select the **Publish** button to commit the changes.

    ![The top toolbar is displayed with the Publish all button highlighted.](media/publishall_toolbarmenu.png "Publish changes")

34. Once published, expand the **Add trigger** item on the pipeline designer toolbar, and select **Trigger now**. In the **Pipeline run** blade, select **OK** to proceed with the latest published configuration. You will see notification toast window indicating the pipeline is running and when it has completed.

35. View the status of the pipeline run by locating the **ASAMCW - Exercise 2 - Copy Campaign Analytics Data** pipeline in the Orchestrate blade. Expand the actions menu, and select the **Monitor** item.

    ![In the Orchestrate blade, the Action menu is displayed with the Monitor item selected on the ASAMCW - Exercise 2 - Copy Campaign Analytics Data pipeline.](media/orchestrate_pipeline_monitor_copycampaigndata.png "Monitoring the pipeline run")

36. You should see a run of the pipeline we created in the **Pipeline runs** table showing as in progress. You will need to refresh this table from time to time to see updated progress. Once it has completed. You should see the pipeline run displayed with a Status of **Succeeded**.

37. Verify the table has populated by creating a new query. Select the **Develop** item from the left menu, and in the **Develop** blade, expand the **+** button, and select **SQL script**. In the query window, be sure to connect to the SQL Pool database (`SQLPool01`), then paste and run the following query. When complete, select the **Discard all** button from the top toolbar.

  ```sql
    select count(Region) from wwi_mcw.CampaignAnalytics;
  ```

### Task 7: Populate the product table

When the lab environment was provisioned, the **wwi_mcw.Product** table and datasets required for its population were created. Throughout this exercise, you have gained experience creating datasets, data flows, and pipelines. The population of the product table would be repetitive, so we will simply trigger an existing pipeline to populate this table.

1. From the left menu, select **Orchestrate**. From the **Orchestrate** blade, expand the **Pipelines** section and locate and select the **ASAMCW - Exercise 2 - Copy Product Information** pipeline.

2. Expand the **Add trigger** item on the pipeline designer toolbar, and select **Trigger now**. In the **Pipeline run** blade, select **OK** to proceed with the latest published configuration. You will see notification toast windows indicating the pipeline is running and when it has completed.

3. View the status of the pipeline run by locating the **ASAMCW - Exercise 2 - Copy Product Information** pipeline in the Orchestrate blade. Expand the actions menu, and select the **Monitor** item.

4. You should see a run of the pipeline we created in the **Pipeline runs** table showing as in progress (or succeeded). Once it has completed. You should see the pipeline run displayed with a Status of **Succeeded**.

5. Verify the table has populated by creating a new query. Select the **Develop** item from the left menu, and in the **Develop** blade, expand the **+** button, and select **SQL script**. In the query window, be sure to connect to the SQL Pool database (`SQLPool01`), then paste and run the following query. When complete, select the **Discard all** button from the top toolbar.

  ```sql
    select * from wwi_mcw.Product;
  ```

## Exercise 3: Exploring raw parquet

**Duration**: 30 minutes

Understanding data through data exploration is one of the core challenges faced today by data engineers and data scientists. Depending on the underlying structure of the data as well as the specific requirements of the exploration process, different data processing engines will offer varying degrees of performance, complexity, and flexibility.

In Azure Synapse Analytics, you have the possibility of using either the Synapse SQL Serverless engine, the big-data Spark engine, or both.

In this exercise, you will explore the data lake using both options.

### Task 1: Query sales Parquet data with Synapse SQL Serverless

When you query Parquet files using Synapse SQL Serverless, you can explore the data with T-SQL syntax.

1. From the left menu, select **Data**.

2. From the **Data** blade, select the **Linked** tab.

3. Expand **Storage accounts**. Expand the `asadatalake{SUFFIX}` ADLS Gen2 account and select **wwi-02**.

4. Navigate to the **wwi-02/sale-small/Year=2010/Quarter=Q4/Month=12/Day=20101231** folder. Right-click on the **sale-small-20101231-snappy.parquet** file, select **New SQL script**, then **Select TOP 100 rows**.

    ![The Storage accounts section is expanded with the context menu visible on the asadatalake{SUFFIX} account with the Select TOP 100 rows option highlighted.](media/data-hub-parquet-select-rows.png "Querying parquet data in SQL Serverless")

5. Ensure **SQL on-demand** is selected in the **Connect to** dropdown list above the query window, then run the query. Data is loaded by the Synapse SQL Serverless endpoint and processed as if was coming from any regular relational database.

    ![The SQL on-demand connection is highlighted on the query window toolbar.](media/sql-on-demand-selected.png "SQL on-demand")

6. Modify the SQL query to perform aggregates and grouping operations to better understand the data. Replace the query with the following, making sure that the file path in **OPENROWSET** matches your current file path, be sure to substitute `asadatalake{SUFFIX}` for the appropriate value in your environment:

    ```sql
    SELECT
        TransactionDate, ProductId,
        CAST(SUM(ProfitAmount) AS decimal(18,2)) AS [(sum) Profit],
        CAST(AVG(ProfitAmount) AS decimal(18,2)) AS [(avg) Profit],
        SUM(Quantity) AS [(sum) Quantity]
    FROM
        OPENROWSET(
            BULK 'https://asadatalake{SUFFIX}.dfs.core.windows.net/wwi-02/sale-small/Year=2010/Quarter=Q4/Month=12/Day=20101231/sale-small-20101231-snappy.parquet',
            FORMAT='PARQUET'
        ) AS [r] GROUP BY r.TransactionDate, r.ProductId;
    ```

    ![The T-SQL query above is displayed within the query window.](media/sql-serverless-aggregates.png "Query window")

7. Now let's figure out how many records are contained within the Parquet files for 2019 data. This information is important for planning how we optimize for importing the data into Azure Synapse Analytics. To do this, replace your query with the following (be sure to update the name of your data lake in BULK statement, by replacing `asadatalake{SUFFIX}`):

    ```sql
    SELECT
        COUNT_BIG(*)
    FROM
        OPENROWSET(
            BULK 'https://asadatalake{SUFFIX}.dfs.core.windows.net/wwi-02/sale-small/Year=2019/*/*/*/*',
            FORMAT='PARQUET'
        ) AS [r];
    ```

    > Notice how we updated the path to include all Parquet files in all subfolders of `sale-small/Year=2019`.

    The output should be **339507246** records.

### Task 2: Query sales Parquet data with Azure Synapse Spark

1. Select **Data** from the left menu, select the **Linked** tab, then browse to the data lake storage account `asadatalake{SUFFIX}` to  **wwi-02/sale-small/Year=2010/Quarter=Q4/Month=12/Day=20101231**, then right-click the Parquet file and select New notebook.

    ![The Parquet file is displayed with the New notebook menu item highlighted.](media/new-spark-notebook-sales.png "New notebook")

2. This will generate a notebook with PySpark code to load the data in a dataframe and display 100 rows with the header.

3. Attach the notebook to a Spark pool.

    ![The Spark pool list is displayed.](media/attach-spark-pool.png "Attach to Spark pool")

4. Select **Run all** on the notebook toolbar to execute the notebook.

    > **Note:** The first time you run a notebook in a Spark pool, Synapse creates a new session. This can take approximately 5 minutes.
    
    > **Note:** To run just the cell, either hover over the cell and select the _Run cell_ icon to the left of the cell, or select the cell then type **Ctrl+Enter** on your keyboard.

5. Create a new cell underneath by selecting **{} Add code** when hovering over the blank space at the bottom of the notebook.

    ![The Add Code menu option is highlighted.](media/new-cell.png "Add code")

6. The Spark engine can analyze the Parquet files and infer the schema. To do this, enter the following in the new cell:

    ```python
    data_path.printSchema()
    ```

    Your output should look like the following:

    ```text
    root
        |-- TransactionId: string (nullable = true)
        |-- CustomerId: integer (nullable = true)
        |-- ProductId: short (nullable = true)
        |-- Quantity: short (nullable = true)
        |-- Price: decimal(29,2) (nullable = true)
        |-- TotalAmount: decimal(29,2) (nullable = true)
        |-- TransactionDate: integer (nullable = true)
        |-- ProfitAmount: decimal(29,2) (nullable = true)
        |-- Hour: byte (nullable = true)
        |-- Minute: byte (nullable = true)
        |-- StoreId: short (nullable = true)
    ```

7. Now let's use the dataframe to perform the same grouping and aggregate query we performed with the SQL Serverless pool. Create a new cell and enter the following:

    ```python
    from pyspark.sql import SparkSession
    from pyspark.sql.types import *
    from pyspark.sql.functions import *

    profitByDateProduct = (data_path.groupBy("TransactionDate", "ProductId")
    .agg(
    round(sum("ProfitAmount"),2).alias("(sum)Profit"),
    round(avg("ProfitAmount"),2).alias("(avg)Profit"),
    sum("Quantity").alias("(sum)Quantity")
    ).orderBy("TransactionDate", "ProductId")
    )
    profitByDateProduct.show(100)
    ```

 > We import required Python libraries to use aggregation functions and types defined in the schema to successfully execute the query.

## Exercise 4: Exploring raw text based data with Azure Synapse SQL Serverless

**Duration**: 15 minutes

A common format for exporting and storing data is with text based files. These can delimited text files such as CSV as well as JSON structured data files. Azure Synapse Analytics also provides ways of querying into these types of raw files to gain valuable insights into the data without having to wait for them to be processed.

### Task 1: Query CSV data

1. Create a new SQL script by selecting **Develop** from the left menu, then in the **Develop** blade, expanding the **+** button and selecting **SQL script**.

2. Ensure **SQL on-demand** is selected in the **Connect to** dropdown list above the query window.

    ![The SQL on-demand connection is highlighted on the query window toolbar.](media/sql-on-demand-selected.png "SQL on-demand")

3. In this scenario, we will be querying into the CSV file that was used to populate the product table. This file is located in the `asadatalake{SUFFIX}` account at: **wwi-02/data-generators/generator-product.csv**. We will select all data from this file. Copy and paste the following query into the query window and select **Run** from the query window toolbar menu. Remember to replace `asadatalake{SUFFIX}` with your storage account name.

    ```sql
    SELECT
       csv.*
    FROM
        OPENROWSET(
            BULK 'https://asadatalake{SUFFIX}.dfs.core.windows.net/wwi-02/data-generators/generator-product/generator-product.csv',
            FORMAT='CSV',
            FIRSTROW = 1
        ) WITH (
            ProductID INT,
            Seasonality INT,
            Price DECIMAL(10,2),
            Profit DECIMAL(10,2)
        ) as csv
    ```

    > **Note**: In this query we are querying only a single file. Azure Synapse Analytics allows you to query across a series of CSV files (structured identically) by using wildcards in the path to the file(s).

4. You are also able to perform aggregations on this data. Replace the query with the following, and select **Run** from the toolbar menu. Remember to replace `asadatalake{SUFFIX}` with your storage account name.

    ```sql
    SELECT
        Seasonality,
        SUM(Price) as TotalSalesPrice,
        SUM(Profit) as TotalProfit
    FROM
        OPENROWSET(
            BULK 'https://asadatalake{SUFFIX}.dfs.core.windows.net/wwi-02/data-generators/generator-product/generator-product.csv',
            FORMAT='CSV',
            FIRSTROW = 1
        ) WITH (
            ProductID INT,
            Seasonality INT,
            Price DECIMAL(10,2),
            Profit DECIMAL(10,2)
        ) as csv
    GROUP BY
        csv.Seasonality
    ```

5. After you have run the previous query, switch the view on the **Results** tab to **Chart** to see a visualization of the aggregation of this data. Feel free to experiment with the chart settings to obtain the best visualization!

    ![The result of the previous aggregation query is displayed as a chart in the Results pane.](media/querycsv_serverless_chart.png "Aggregation query results")

6. From the top toolbar, select the **Discard all** button as we will not be saving this query. When prompted, choose to **Discard changes**.

   ![The top toolbar menu is displayed with the Discard all button highlighted.](media/toptoolbar_discardall.png "Discard changes")

### Task 2: Query JSON data

1. Create a new SQL script by selecting **Develop** from the left menu, then in the **Develop** blade, expanding the **+** button and selecting **SQL script**.

2. Ensure **SQL on-demand** is selected in the **Connect to** dropdown list above the query window.

    ![The SQL on-demand connection is highlighted on the query window toolbar.](media/sql-on-demand-selected.png "SQL on-demand")

3. Replace the query with the following, remember to replace `asadatalake{SUFFIX}` with the name of your storage account:

    ```sql
    SELECT
        products.*
    FROM
        OPENROWSET(
            BULK 'https://asadatalake{SUFFIX}.dfs.core.windows.net/wwi-02/product-json/json-data/*.json',
            FORMAT='CSV',
            FIELDTERMINATOR ='0x0b',
            FIELDQUOTE = '0x0b',
            ROWTERMINATOR = '0x0b'
        )
        WITH (
            jsonContent NVARCHAR(200)
        ) AS [raw]
    CROSS APPLY OPENJSON(jsonContent)
    WITH (
        ProductId INT,
        Seasonality INT,
        Price DECIMAL(10,2),
        Profit DECIMAL(10,2)
    ) AS products
    ```

4. From the top toolbar, select the **Discard all** button as we will not be saving this query. When prompted, choose to **Discard changes**.

   ![The top toolbar menu is displayed with the Discard all button highlighted.](media/toptoolbar_discardall.png "Discard changes")

## Exercise 5: Synapse Pipelines and Cognitive Search

**Duration**: 45 minutes

In this exercise you will create a Synapse Pipeline that will orchestrate updating the part prices from a supplier invoice. You will accomplish this by a combination of a Synapse Pipeline with an Azure Cognitive Search Skillset that invokes the Form Recognizer service as a custom skill. The pipeline will work as follows:

- Invoice is uploaded to Azure Storage.
- An Azure Cognitive Search index is started
- The index of any new or updated invoices invokes an Azure Cognitive Search skillset.
- The first skill in the skillset invokes an Azure Function, passing it the URL to the PDF invoice.
- The Azure Function invokes the Form Recognizer service, passing it the URL and SAS token to the PDF invoice. Forms recognizer returns the OCR results to the function.
- The Azure Function returns the results to skillset. The skillset then extracts only the product names and costs and sends that to a configure knowledge store that writes the extracted data to JSON files in Azure Blob Storage.
- The Synapse pipeline reads these JSON files from Azure Storage in a Data Flow activity and performs an upsert against the product catalog table in the Synapse SQL Pool.

### Task 1: Create the invoice storage container

1. In the Azure Portal, navigate to the lab resource group and select the **asastore{suffix}** storage account.

    ![The lab resources list is shown with the asastore storage account highlighted.](media/ex5-task1a-000.png "Lab resource group listing")
  
2. From the left menu, beneath **Blob service**, select **Containers**. From the top toolbar menu of the **Containers** screen, select **+ Container**.
  
    ![The Containers screen is displayed with Containers selected from the left menu, and + Container selected from the toolbar.](media/ex5-task1a-001.png "Azure Storage Container screen")

3. On the **New container** blade, name the container **invoices**, and select **Create**, we will keep the default values for the remaining fields.

4. Repeat steps 2 and 3, and create two additional containers named **invoices-json** and **invoices-staging**.

5. From the left menu, select **Storage Explorer (preview)**. Then, in the hierarchical menu, expand the **BLOB CONTAINERS** item.

6. Beneath **BLOB CONTAINERS**, select the **invoices** container, then from the taskbar menu, select **+ New Folder**

    ![The Storage Explorer (preview) screen is shown with Storage Explorer selected from the left menu. In the hierarchical menu, the BLOB CONTAINERS item expanded with the invoices item selected. The + New Folder button is highlighted in the taskbar menu.](media/storageexplorer_invoicesnewfolder.png "Azure Storage Explorer")

7. In the **Create New Virtual Directory** blade, name the directory **Test**, then select **OK**. This will automatically move you into the new **Test** folder.

    ![The Create New Virtual Directory form is displayed with Test entered in the name field.](media/storageexplorer_createnewvirtualdirectoryblade.png "Create New Virtual Directory form")

8. From the taskbar, select **Upload**. Upload all invoices located in **Hands-on lab/artifacts/sample_invoices/Test**. These files are Invoice_6.pdf and Invoice_7.pdf.

9. Return to the root **invoices** folder by selecting the **invoices** breadcrumb from the location textbox found beneath the taskbar.

    ![A portion of the Storage Explorer window is displayed with the invoices breadcrumb selected from the location textbox.](media/storageexplorer_breadcrumbnav.png "Storage Explorer breadcrumb navigation")

10. From the taskbar, select **+ New Folder** once again. This time creating a folder named **Train**. This will automatically move you into the new **Train** folder.

11. From the taskbar, select **Upload**. Upload all invoices located in **Hands-on lab/artifacts/sample_invoices/Train**. These files are Invoice_1.pdf, Invoice_2.pdf, Invoice_3.pdf, Invoice_4.pdf and Invoice_5.pdf.

12. From the left menu, select **Access keys**.

    ![The left menu is displayed with the Access keys link highlighted.](media/ex5-task1a-003.png "The Access keys menu item")

13. Copy the Connection string under **key1**. Save it to notepad, Visual Studio Code, or another text file. We'll use this several times

    ![The copy button is selected next to the key1 connection string.](media/ex5-task1a-004.png "Copying the key1 connection string value")

14. From the left menu, beneath **Settings**, select **Shared access signature**.

15. Make sure all the checkboxes are selected and choose **Generate SAS and connection string**.

    ![The configuration form is displayed for SAS generation.](media/ex5-task1a-012.png "SAS Configuration form")

16. Copy the generated **Blob service SAS URL** to the same text file as above.

    ![The SAS form is shown with the shared access signature blob service SAS URL highlighted.](media/ex5-task1a-013.png "The SAS URL")

17. Modify the SAS URL that you just copied and add the **invoices** container name just before the **?** character.

    >**Example**: https://asastore{{suffix}.blob.core.windows.net/**invoices**?sv=2019-12-12&ss=bfqt&srt ...

### Task 2: Create and train an Azure Forms Recognizer model and setup Cognitive Search

1. Browse to your Azure Portal homepage, select **+ Create a resource**, then search for and select **Form Recognizer** from the search results.

    ![The New resource screen is shown with Form Recognizer entered into the search text boxes and selected from the search results.](media/ex5-task2a-01.png "New resource search form")

2. Select **Create**.

    ![The Form Recognizer overview screen is displayed with the Create button highlighted.](media/ex5-task2a-02.png "The Form Recognizer overview form")

3. Enter the following configuration settings, then select **Create**:

    | Field | Value |
    |-------|-------|
    | Name  | Enter a unique name (denoted by the green checkmark indicator) for the form recognition service. |
    | Subscription | Select the lab subscription. |
    | Location | Select  the lab region. |
    | Pricing | Select **Free F0**. |
    | Confirmation checkbox | Checked. |
  
    ![The Form Recognizer configuration screen is displayed populated with the preceding values.](media/ex5-task2a-03.png "Form Recognizer configuration screen")

4. Wait for the service to provision then navigate to the resource.

5. From the left menu, select **Keys and Endpoint**.

    ![The left side navigation is shown with the Keys and Endpoint item highlighted.](media/ex5-task2a-04.png "Left menu navigation")

6. Copy and Paste both KEY 1 and the ENDPOINT values. Put these in the same location as the storage connection string you copied earlier

    ![The Keys and Endpoint screen is shown with KEY 1 and ENDPOINT values highlighted.](media/ex5-task2a-05.png "The Keys and Endpoint screen")

7. Browse to your Azure Portal homepage, select **+ Create a new resource**, then search for and create a new instance of **Azure Cognitive Search**.

    ![The Azure Cognitive Search overview screen is displayed.](media/ex5-task1-006.png "Azure Cognititve Search Overview screen")

8. Choose the subscription and the resource group you've been using for this lab. Set the URL of the Cognitive Search Service to a unique value, relating to search. Then, switch the pricing tier to **Free**.

    ![The configuration screen for Cognitive Search is displayed populated as described above.](media/ex5-task1-007.png "Cognitive Search service configuration")

9. Select **Review + create**.

    ![displaying the review + create button](media/ex5-task1-008.png "The review and create button")

10. Select **Create**.

11. Wait for the Search service to be provisioned then navigate to the resource.

12. From the left menu, select **Keys**, copy the **Primary admin key** and paste it into your text document. Also make note of the name of your search service resource.

    ![They Keys page of the Search service resource is shown with the Primary admin key value highlighted.](media/ex5-task3-010.png "Cognitive search keys")

13. Also make note of the name of your search service in the text document.

    ![The Search Service name is highlighted on the Keys screen.](media/ex5-task3-011.png "Search service name")

14. Open Visual Studio Code.

15. From the **File** menu, select **Open file** then choose to open **Hands-on lab/artifacts/pocformreader.py**.

16. Update Lines 7, 9, and 17 with the appropriate values indicated below:

    - Line 7: The endpoint of Azure Cognitive Services.

    - Line 9: The Blob Service SAS URL storage account with your Train and Test invoice folders.

    - Line 17: The key for your Azure Cognitive Service endpoint.

    ![The source code listing of pocformreader.py is displayed with the lines mentioned above highlighted.](media/ex5-task2a-06.png "The source listing of pocofrmreader.py")

17. Save the file.

18. Select Run, then Start Debugging.

    ![The VS Code File menu is shown with Run selected and Start Debugging highlighted.](media/ex5-task2a-07.png "The VS Code File menu")

19. In the **Debug Configuration**, select to debug the **Python File - Debug the currently active Python File** value.

    ![The Debug Configuration selection is shown with Python File - Debug the currently active Python File highlighted.](media/ex5-task2a-08.png "Debug Configuration selection")

20. When it completes, you should see an output similar to what is seen in the screenshot below. The output should also contain a modelID. Copy and paste this into your text file to use later

    ![A sample output of the python script is shown with a modelID value highlighted.](media/ex5-task2a-09.png "Visual Studio Code output window")

    >**Note**: If you receive an error stating the **requests** module is not found, from the terminal window in Visual Studio code, execute: **pip install requests**

### Task 3: Configure a skillset with Form Recognizer

1. Open a new instance of Visual Studio Code.

2. In Visual Studio Code open the folder **Hands-on lab/environment-setup/functions**.

   ![The file structure of the /environment-setup/functions folder is shown.](media/ex5-task1-001.png "The file structure of the functions folder")

3. In the **GetInvoiceData/\_\_init\_\_.py** file, update lines 66, 68, 70, and 73 with the appropriate values for your environment, the values that need replacing are located between **\<\<** and **\>\>** values.

   ![The __init__.py code listing is displayed.](media/ex5-task1-step2.png "The __init__.py code listing")

4. Use the Azure Functions extension to publish to a new Azure function. If you don't see the Azure Functions panel, go to the **View** menu, select **Open View...** and choose **Azure**. If the panel shows the **Sign-in to Azure** link, select it and log into Azure. Select the **Publish** button at the top of the panel.

   ![The Azure Functions extension panel in VS Code is displayed highlighting the button to publish the function.](media/ex5-task1-002.png "The Azure Function panel")

    - Select the same subscription as your Synapse workspace.

    - Choose to **Create new Function App in Azure...**.

    - Give this function a unique name, relative to form recognition.

        ![The Create new function App in Azure dialog is shown with the name populated.](media/ex5-task1-003.png "The Create new function App in Azure dialog")

    - For the runtime select Python 3.7.

        ![The python runtime version selection dialog is shown with Python 3.7 highlighted.](media/ex5-task1-004.png "Setting the Python runtime version")

    - Deploy the function to the same region as your Synapse workspace.

        ![The Region selection dialog is shown.](media/ex5-task1-005.png "The region selection dialog")

5. Once publishing has completed, return to the Azure Portal and search for a resource group that was created with the same name as the Azure Function App.

6. Within this resource group, open the **App Service** resource with the same name.

   ![A resource listing is shown with the App Service highlighted.](media/formrecognizerresourcelist.png "Resource group listing")

7. From the left menu, beneath the **Functions** heading, select **Functions**.

8. From the Functions listing, select **GetInvoiceData**.

9. From the toolbar menu of the **GetInvoiceData** screen, select the **Get Function Url** item, then copy this value to your text document for later reference.

    ![The GetInvoiceData function screen is shown with the Get Function Url button highlighted in the taskbar and the URL displayed in a textbox.](media/azurefunctionurlvalue.png "GetInvoiceData function screen")

10. Now that we have the function published and all our resources created, we can create the skillset. This will be accomplished using **Postman**. Open Postman.

11. From the **File** menu, select **Import** and choose to import the postman collection from **Hands-on lab/environment-setup/skillset**.

    ![The Postman File menu is expanded with the Import option selected.](media/ex5-task3-004.png "Postman File menu")

    ![The Postman file import screen is displayed with the Upload files button highlighted.](media/ex5-task3-005.png "The Postman Import Screen")

    ![The file selection dialog is shown with the file located in the skillset folder highlighted.](media/ex5-task3-006.png "File selection dialog")

12. Select Import.

13. In Postman, the Collection that was imported will give you 4 items in the **Create a KnowledgeStore** collection. These are: Create Index, Create Datasource, Create the skillset, and Create the Indexer.

    ![The Collections pane is shown with the Create a KnowledgeStore collection expanded with the four items indicated above.](media/ex5-task3-007.png "The Postman Collections Pane")

14. The first thing we need to do, is edit some properties that will affect each of the calls in the collection. Hover over the **Create a KnowledgeStore** collection, and select the ellipsis button **...**, and then select **Edit**.

    ![In Postman, the ellipsis is expanded next to the Create a KnowledgeStore collection with the edit menu option selected.](media/ex5-task3-008.png "Editing the Postman Collection")

15. In the Edit Collection screen, select the **Variables** tab.

    ![In the Edit Collection screen, the Variables tab is selected.](media/ex5-task3-009.png "Edit Collection variables screen")

16. We are going to need to edit each one of these variables to match the following:

    | Variable | Value |
    |-------|-------|
    | admin-key  | The key from the search service you created. |
    | search-service-name | The name of the search service. |
    | storage-account-name | asastore{{suffix}} |
    | storage-connection-string | The connection string from the asastore{{suffix}} storage account. |
    | datasourcename | Enter **invoices** |
    | indexer-name | Enter **invoice-indexer** |
    | index-name | Enter **invoice-index** |
    | skillset-name | Enter **invoice-skillset** |
    | storage-container-name | Enter **invoices** |
    | skillset-function | Enter function URL from the function you published.|

17. Select **Update** to update the collection with the modified values.

    ![The Edit Collection Variables screen is shown with a sampling of modified values.](media/ex5-task3-014.png "The Edit Collection Values screen")

18. Select the **Create Index** call from the collection, then select the **Body** tab and review the content.

    ![The Create Index call is selected from the collection, and the Body tab is highlighted.](media/ex5-task3-015.png "The Create Index Call")

19. Select "Send".

    ![The Postman send button is selected.](media/ex5-task3-016.png "Send button")

20. You should get a response that the index was created.

    ![The Create Index response is displayed in Postman with the Status of 201 Created highlighted.](media/ex5-task3-017.png "The Create Index call response")

21. Do the same steps for the **Create Datasource, Create the Skillset, and Create the indexer** calls.

22. After you Send the Indexer request, if you navigate to your search service you should see your indexer running, indicated by the in-progress indicator. It will take a couple of minutes to run.

    ![The invoice-indexer is shown with a status of in-progress.](media/ex5-task3-018.png "The invoice-indexer status")

23. Once the indexer has run, it will show two successful documents. If you go to your Blob storage account, **asastore{suffix}** and look in the **invoices-json** container you will see two folders with .json documents in them.

    ![The execution history of the invoice-indexer is shown as successful.](media/ex5-task3-019.png "The execution history of the invoice-indexer")

    ![The invoices-json container is shown with two folders. A JSON file is shown in the blob window.](media/ex5-task3-020.png "Contents of the invoices-json container")

### Task 4: Create the Synapse Pipeline

1. Open your Synapse workspace.

    ![The Azure Synapse Workspace resource screen is shown with the Launch Synapse Studio button highlighted.](media/ex5-task4-001.png)

2. Expand the left menu and select the **Develop** item. From the **Develop** blade, expand the **+** button and select the **SQL script** item.

    ![The left menu is expanded with the Develop item selected. The Develop blade has the + button expanded with the SQL script item highlighted.](media/develop_newsqlscript_menu.png "Creating a new SQL script")

3. In the query tab toolbar menu, ensure you connect to your SQL Pool, `SQLPool01`.

    ![The query tab toolbar menu is displayed with the Connect to set to the SQL Pool.](media/querytoolbar_connecttosqlpool.png "Connecting to the SQL Pool")

4. In the query window, copy and paste the following query to create the invoice information table. Then select the **Run** button in the query tab toolbar.

    ```sql
      CREATE TABLE [wwi_mcw].[Invoices]
      (
        [TransactionId] [uniqueidentifier]  NOT NULL,
        [CustomerId] [int]  NOT NULL,
        [ProductId] [smallint]  NOT NULL,
        [Quantity] [tinyint]  NOT NULL,
        [Price] [decimal](9,2)  NOT NULL,
        [TotalAmount] [decimal](9,2)  NOT NULL
      );
    ```

5. From the top toolbar, select the **Discard all** button as we will not be saving this query. When prompted, choose to **Discard changes**.

   ![The top toolbar menu is displayed with the Discard all button highlighted.](media/toptoolbar_discardall.png "Discard changes")

6. Select the **Orchestrate** hub from the left navigation.

    ![The Orchestrate hub is selected from the left navigation.](media/ex5-task4-012.png "The Orchestrate hub")

7. In the Orchestrate blade, expand the **+** button and then select **Pipeline** to create a new pipeline.

    ![The + button is expanded with the pipeline option selected.](media/ex5-task4-013.png "Create a new pipeline")

8. Name your pipeline **InvoiceProcessing**.

    ![The new pipeline properties are shown with InvoiceProcessing entered as the name of the pipeline.](media/ex5-task4-014.png "Naming the pipeline")

9. On the pipeline taskbar, select **Add trigger** then choose **New/Edit** to create an event to start the pipeline.

    ![The Add trigger button is expanded with the New/Edit option selected.](media/ex5-task4-015.png "New Trigger menu item")

10. On the Add triggers form, select  **+New** from the **Choose trigger** dropdown.

    ![The Add triggers form is displayed with the Choose trigger dropdown expanded and the +New item is selected.](media/ex5-task4-016.png "Choosing to create a new trigger")

11. For this exercise, we're going to do a schedule. However, in the future you'll also be able to use an event-based trigger that would fire off new JSON files being added to blob storage. Set the trigger to start every 5 minutes, then select **OK**.

    ![The new trigger form is displayed with the trigger set to start every 5 minutes.](media/ex5-task4-017.png "New trigger form")

12. Select **OK** on the Run Parameters form, nothing needs to be done here.

13. Next we need to add a Data Flow to the pipeline. Under Activities, expand **Move & transform** then drag and drop a **Data flow** onto the designer canvas.

    ![The pipeline designer is shown with an indicator of a drag and drop operation of the data flow activity.](media/ex5-task4-018.png "The Data flow activity")

14. On the **Adding data flow** form, select **Create new data flow** and name it **NewInvoicesProcessing**.

    ![The Adding data flow form is displayed populated with the preceding values.](media/ex5-task4-019.png)

15. On the **NewInvoicesProcessing** data flow design canvas. Select the **Add source** box.

    ![The NewInvoicesProcessing designer is shown with the Add source box selected.](media/ex5-task4-020.png "The NewInvoicesProcessing designer")

16. In the bottom pane, name the output stream **jsonInvoice**, leave the source type as **Dataset**, and keep all the remaining options set to their defaults. Select **+New** next to the Dataset field.

    ![The Source settings tab is displayed populated with the name of jsonInvoice and the +New button next to the Dataset field is selected.](media/ex5-task4-021.png "Source Settings")

17. In the **New dataset blade**, select **Azure Blob Storage** then select **Continue**.

    ![The New dataset blade is displayed with Azure Blob Storage selected.](media/ex5-task4-022.png "Azure Blob Storage dataset")

18. On the **Select format** blade, select **Json** then select **Continue**.

    ![The select format screen is displayed with Json selected as the type.](media/ex5-task4-023.png "Select format form")

19. On the **Set properties** screen, name the dataset **InvoicesJson** then for the linked service field, choose the Azure Storage linked service **asastore{suffix}**.

    ![A portion of the Set properties form is displayed populated with the above values.](media/ex5-task4-024.png "Dataset Set properties form")

20. For the file path field, enter **invoices-json** and set the import schema field to **From sample file**.

    ![The set properties form is displayed with the file path and import schema fields populated as described.](media/ex5-task4-025.png "Data set properties form")

21. Select **Browse** and select the file located at **Hands-on lab/environment-setup/synapse/sampleformrecognizer.json** and select **OK**.

    ![The Set properties form is displayed with the sampleformrecognizer.json selected as the selected file.](media/ex5-task4-026.png "Data set properties form")

22. Select the **Source options** tab on the bottom pane. Add \*/\* to the Wildcard paths field.

    ![The Source options tab is shown with the Wildcard paths field populated as specified.](media/ex5-task4-048.png "Source options tab")

23. On the Data flow designer surface, select **+** to the lower right of the source activity to add another step in your data flow.

    ![The + button is highlighted to the lower right of the source activity.](media/ex5-task4-028.png "Adding a data flow step")

24. From the list of options, select **Derived column** from beneath the **Schema modifier** section.

    ![With the + button expanded, Derived column is selected from the list of options.](media/ex5-task4-029.png "Adding a derived column activity")

25. On the **Derived column's settings** tab, provide the output stream name of **RemoveCharFromStrings**. Then for the Columns field, add 3 columns and configure them as follows:

    | Column | Expression |
    |--------|------------|
    | productprice | toDecimal(replace(productprice,'$','')) |
    | totalcharges | toDecimal(replace(replace(totalcharges,'$',''),',','')) |
    | quantity | toInteger(replace(quantity,',','')) |

     ![The Derived column's settings tab is shown with the fields populated as described.](media/ex5-task4-030.png "The derived column's settings tab")

26. Return to the Data flow designer, select the **+** next to the derived column activity to add another step to your data flow.

27. This time select the **Alter Row** from beneath the **Row modifier** section.

    ![In the Row modifier section, the Alter Row option is selected.](media/ex5-task4-031.png "The Alter row activity")

28. On the **Alter row settings** tab on the bottom pane, Name the Output stream **AlterTransactionID**, and leave the incoming stream set to the default value. Change **Alter row conditions** field to **Upsert If** and then set the expression to **notEquals(transactionid,"")**

    ![The Alter row settings tab is shown populated with the values described above.](media/ex5-task4-032.png "The Alter row settings tab")

29. Return to the Data flow designer, select the **+** to the lower right of the **Alter Row** activity to add another step into your data flow.

30. Within the **Destination** section, select **Sink**.

    ![In the activity listing, the sink option is selected from within the Destination section.](media/ex5-task4-033.png "The Sink Activity")

31. On the bottom pane, with the **Sink** tab selected, name the Output stream name **SQLDatabase** and leave everything else set to the default values. Next to the **Dataset** field, select **+New** to add a new Dataset.

    ![The sink tab is shown with the output stream name set to SQLDatabase and the +New button selected next to the Dataset field.](media/ex5-task4-034.png "The Sink tab")

32. On the **New dataset** blade, select the **Azure** tab. Select **Azure Synapse Analytics (formerly SQL DW)** and select **Continue**.

    ![Azure Synapse Analytics is selected in a list of dataset types.](media/ex5-task4-035.png "Selecting the Azure Synapse Analytics dataset type")

33. Set the name of the Dataset to **InvoiceTable** and choose the **sqlpool01** Linked service. Choose **Select from existing table** and choose the **wwi_mcw.Invoices** table. If you don't see it in the list of your table names, select the **Refresh** button and it should show up. Select **OK**.

    ![The Dataset Set properties form is displayed populated as described.](media/ex5-task4-036.png "Set properties form")

34. In the bottom pane, with the Sink activity selected on the data flow designer, select the **Settings** tab and check the box to **Allow upsert**. Set the **Key columns** field to **transactionid**.

    ![The Settings tab of the Sink activity is shown and is populated as described.](media/ex5-task4-037.png "Sink Settings tab")

35. Select the **Mapping** tab, disable the **Auto mapping** setting and configure the mappings between the json file and the database. Select **+ Add mapping** then choose **Fixed mapping** to add the following mappings:

    | Input column | Output column |
    |--------------|---------------|
    | transactionid | TransactionId |
    | productid | ProductId |
    | customerid | CustomerId |
    | productprice | Price |
    | quantity  | Quantity |
    | totalcharges | TotalAmount |

    ![The Mapping tab is displayed with Auto Mapping disabled and the column mappings from the table above are defined.](media/ex5-task4-038.png "The Mapping tab")

36. Return to the **InvoiceProcessing** pipeline by selecting its tab at the top of the workspace.

    ![The InvoiceProcessing tab is selected at the top of the workspace.](media/ex5-task4-039.png "The InvoiceProcessing pipeline tab")

37. Select the data flow activity on the pipeline designer surface, then in the bottom pane, select the **Settings** tab.

    ![The data flow activity Settings tab is displayed.](media/ex5-task4-040.png "The Settings tab")

38. Under the **PolyBase** settings, set the **Staging linked service** to the **asastore{suffix}** linked service. Enter **invoices-staging** as the **Storage staging folder**.

    ![The data flow activity Settings tab is displayed with its form populated as indicated above.](media/ex5-task4-041.png "The Settings tab")

39. Select **Publish All** from the top toolbar.

    ![The Publish All button is selected from the top toolbar.](media/ex5-task4-042.png "The Publish all button")

40. Select **Publish**.

41. Within a few moments, you should see a notification that Publishing completed.

    ![The Publishing completed notification is shown.](media/ex5-task4-043.png "The Publishing Completed notification")

42. From the left menu, select the **Monitor** hub, then ensure the **Pipeline runs** option is selected from the hub menu.

    ![The Monitor hub is selected from the left menu.](media/ex5-task4-044.png "The Monitor Hub menu option")

43. In approximately 5 minutes, you should see the **InvoiceProcessing** pipeline begin processing. You may need to refresh this list to see it appear, a refresh button is located in the toolbar.

    ![On the Pipeline runs list, the InvoiceProcessing pipeline is shown as in-progress.](media/ex5-task4-045.png "The Pipeline runs list")

44. After about 3 or 4 minutes it will complete. You may need to refresh the list to see the completed pipeline.

    ![The Pipeline runs list is displayed with the InvoiceProcessing pipeline shown as succeeded.](media/ex5-task4-046.png "The pipeline runs list")

45. From the left menu, select the **Develop** hub, then expand the **+** button an choose **SQL Script**. Ensure the proper database is selected, then run the following query to verify the data from the two test invoices.

    ```SQL
    SELECT * FROM wwi_mcw.Invoices
    ```

    ![show the data in the databases](media/ex5-task4-047.png)

## Exercise 6: Security

**Duration**: 30 minutes

### Task 1: Column level security

It is important to identify data columns of that hold sensitive information. Types of sensitive information could be social security numbers, email addresses, credit card numbers, financial totals, and more. Azure Synapse Analytics allows you define permissions that prevent users or roles select privileges on specific columns.

1. Create a new SQL script by selecting **Develop** from the left menu, then in the **Develop** blade, expanding the **+** button and selecting **SQL script**.

2. Copy and paste the following query into the query window. Then, step through each statement group by highlighting all queries between each comment block in the query window, and selecting **Run** from the query window toolbar menu. The query is documented inline. Ensure you are connected to **SQLPool01** when running the queries.

    ```sql
        /*  Column-level security feature in Azure Synapse simplifies the design and coding of security in applications.
        It ensures column level security by restricting column access to protect sensitive data. */

    /* Scenario: In this scenario we will be working with two users. The first one is the CEO, he has access to all
        data. The second one is DataAnalystMiami, this user doesn't have access to the confidential Revenue column
        in the CampaignAnalytics table. Follow this lab, one step at a time to see how Column-level security removes access to the
        Revenue column to DataAnalystMiami */

    --Step 1: Let us see how this feature in Azure Synapse works. Before that let us have a look at the Campaign Analytics table.
    select  Top 100 * from wwi_mcw.CampaignAnalytics
    where City is not null and state is not null

    /*  Consider a scenario where there are two users.
        A CEO, who is an authorized  personnel with access to all the information in the database
        and a Data Analyst, to whom only required information should be presented.*/

    -- Step:2 Verify the existence of the “CEO” and “DataAnalystMiami” users in the Datawarehouse.
    SELECT Name as [User1] FROM sys.sysusers WHERE name = N'CEO';
    SELECT Name as [User2] FROM sys.sysusers WHERE name = N'DataAnalystMiami';


    -- Step:3 Now let us enforcing column level security for the DataAnalystMiami.
    /*  The CampaignAnalytics table in the warehouse has information like ProductID, Analyst, CampaignName, Quantity, Region, State, City, RevenueTarget and Revenue.
        The Revenue generated from every campaign is classified and should be hidden from DataAnalystMiami.
    */

    REVOKE SELECT ON wwi_mcw.CampaignAnalytics FROM DataAnalystMiami;
    GRANT SELECT ON wwi_mcw.CampaignAnalytics([Analyst], [CampaignName], [Region], [State], [City], [RevenueTarget]) TO DataAnalystMiami;
    -- This provides DataAnalystMiami access to all the columns of the Sale table but Revenue.

    -- Step:4 Then, to check if the security has been enforced, we execute the following query with current User As 'DataAnalystMiami', this will result in an error
    --  since DataAnalystMiami doesn't have select access to the Revenue column
    EXECUTE AS USER ='DataAnalystMiami';
    select TOP 100 * from wwi_mcw.CampaignAnalytics;
    ---
    -- The following query will succeed since we are not including the Revenue column in the query.
    EXECUTE AS USER ='DataAnalystMiami';
    select [Analyst],[CampaignName], [Region], [State], [City], [RevenueTarget] from wwi_mcw.CampaignAnalytics;

    -- Step:5 Whereas, the CEO of the company should be authorized with all the information present in the warehouse.To do so, we execute the following query.
    Revert;
    GRANT SELECT ON wwi_mcw.CampaignAnalytics TO CEO;  --Full access to all columns.

    -- Step:6 Let us check if our CEO user can see all the information that is present. Assign Current User As 'CEO' and the execute the query
    EXECUTE AS USER ='CEO'
    select * from wwi_mcw.CampaignAnalytics
    Revert;
    ```

    ![The query tab toolbar is displayed with the Run button selected.](media/querytoolbar_run.png "Running a SQL Query")

3. From the top toolbar, select the **Discard all** button as we will not be saving this query. When prompted, choose to **Discard changes**.

   ![The top toolbar menu is displayed with the Discard all button highlighted.](media/toptoolbar_discardall.png "Discard changes")

### Task 2: Row level security

In many organizations it is important to filter certain rows of data by user. In the case of WWI, they wish to have data analysts only see their data. In the campaign analytics table, there is an Analyst column that indicates to which analyst that row of data belongs. In the past, organizations would create views for each analyst - this was a lot of work and unnecessary overhead. Using Azure Synapse Analytics, you can define row level security that compares the user executing the query to the Analyst column, filtering the data so they only see the data destined for them.

1. Create a new SQL script by selecting **Develop** from the left menu, then in the **Develop** blade, expanding the **+** button and selecting **SQL script**.

2. Copy and paste the following query into the query window. Then, step through each statement group by highlighting all queries between each comment block in the query window, and selecting **Run** from the query window toolbar menu. The query is documented inline.

    ```sql
    /* Row level Security (RLS) in Azure Synapse enables us to use group membership to control access to rows in a table.
    Azure Synapse applies the access restriction every time the data access is attempted from any user.
    Let see how we can implement row level security in Azure Synapse.*/

    -- Row-Level Security (RLS), 1: Filter predicates
    -- Step:1 The Sale table has two Analyst values: DataAnalystMiami and DataAnalystSanDiego.
    --     Each analyst has jurisdiction across a specific Region. DataAnalystMiami on the South East Region
    --      and DataAnalystSanDiego on the Far West region.
    SELECT DISTINCT Analyst, Region FROM wwi_mcw.CampaignAnalytics order by Analyst ;

    /* Scenario: WWI requires that an Analyst only see the data for their own data from their own region. The CEO should see ALL data.
        In the Sale table, there is an Analyst column that we can use to filter data to a specific Analyst value. */

    /* We will define this filter using what is called a Security Predicate. This is an inline table-valued function that allows
        us to evaluate additional logic, in this case determining if the Analyst executing the query is the same as the Analyst
        specified in the Analyst column in the row. The function returns 1 (will return the row) when a row in the Analyst column is the same as the user executing the query (@Analyst = USER_NAME()) or if the user executing the query is the CEO user (USER_NAME() = 'CEO')
        whom has access to all data.
    */

    -- Review any existing security predicates in the database
    SELECT * FROM sys.security_predicates

    --Step:2 Create a new Schema to hold the security predicate, then define the predicate function. It returns 1 (or True) when
    --  a row should be returned in the parent query.
    GO
    CREATE SCHEMA Security
    GO
    CREATE FUNCTION Security.fn_securitypredicate(@Analyst AS sysname)  
        RETURNS TABLE  
    WITH SCHEMABINDING  
    AS  
        RETURN SELECT 1 AS fn_securitypredicate_result
        WHERE @Analyst = USER_NAME() OR USER_NAME() = 'CEO'
    GO
    -- Now we define security policy that adds the filter predicate to the Sale table. This will filter rows based on their login name.
    CREATE SECURITY POLICY SalesFilter  
    ADD FILTER PREDICATE Security.fn_securitypredicate(Analyst)
    ON wwi_mcw.CampaignAnalytics
    WITH (STATE = ON);

    ------ Allow SELECT permissions to the Sale Table.------
    GRANT SELECT ON wwi_mcw.CampaignAnalytics TO CEO, DataAnalystMiami, DataAnalystSanDiego;

    -- Step:3 Let us now test the filtering predicate, by selecting data from the Sale table as 'DataAnalystMiami' user.
    EXECUTE AS USER = 'DataAnalystMiami'
    SELECT * FROM wwi_mcw.CampaignAnalytics;
    revert;
    -- As we can see, the query has returned rows here Login name is DataAnalystMiami

    -- Step:4 Let us test the same for  'DataAnalystSanDiego' user.
    EXECUTE AS USER = 'DataAnalystSanDiego';
    SELECT * FROM wwi_mcw.CampaignAnalytics;
    revert;
    -- RLS is working indeed.

    -- Step:5 The CEO should be able to see all rows in the table.
    EXECUTE AS USER = 'CEO';  
    SELECT * FROM wwi_mcw.CampaignAnalytics;
    revert;
    -- And he can.

    --Step:6 To disable the security policy we just created above, we execute the following.
    ALTER SECURITY POLICY SalesFilter  
    WITH (STATE = OFF);

    DROP SECURITY POLICY SalesFilter;
    DROP FUNCTION Security.fn_securitypredicate;
    DROP SCHEMA Security;
    ```

    ![The query tab toolbar is displayed with the Run button selected.](media/querytoolbar_run.png "Running a query")

3. From the top toolbar, select the **Discard all** button as we will not be saving this query. When prompted, choose to **Discard changes**.

   ![The top toolbar menu is displayed with the Discard all button highlighted.](media/toptoolbar_discardall.png "Discard changes")

### Task 3: Dynamic data masking

As an alternative to column level security, SQL Administrators also have the option of masking sensitive data. This will result in data being obfuscated when returned in queries. The data is still stored in a pristine state in the table itself. SQL Administrators can grant unmask privileges to users that have permissions to see this data.

1. Create a new SQL script by selecting **Develop** from the left menu, then in the **Develop** blade, expanding the **+** button and selecting **SQL script**.

2. Copy and paste the following query into the query window. Then, step through each statement group by highlighting all queries between each comment block in the query window, and selecting **Run** from the query window toolbar menu. The query is documented inline.

    ```sql
    ----- Dynamic Data Masking (DDM) ---------
    /*  Dynamic data masking helps prevent unauthorized access to sensitive data by enabling customers
        to designate how much of the sensitive data to reveal with minimal impact on the application layer.
        Let see how */

    /* Scenario: WWI has identified sensitive information in the CustomerInfo table. They would like us to
        obfuscate the CreditCard and Email columns of the CustomerInfo table to DataAnalysts */

    -- Step:1 Let's first get a view of CustomerInfo table.
    SELECT TOP (100) * FROM wwi_mcw.CustomerInfo;

    -- Step:2 Let's confirm that there are no Dynamic Data Masking (DDM) applied on columns.
    SELECT c.name, tbl.name as table_name, c.is_masked, c.masking_function  
    FROM sys.masked_columns AS c  
    JOIN sys.tables AS tbl
        ON c.[object_id] = tbl.[object_id]  
    WHERE is_masked = 1
        AND tbl.name = 'CustomerInfo';
    -- No results returned verify that no data masking has been done yet.

    -- Step:3 Now let's mask 'CreditCard' and 'Email' Column of 'CustomerInfo' table.
    ALTER TABLE wwi_mcw.CustomerInfo  
    ALTER COLUMN [CreditCard] ADD MASKED WITH (FUNCTION = 'partial(0,"XXXX-XXXX-XXXX-",4)');
    GO
    ALTER TABLE wwi_mcw.CustomerInfo
    ALTER COLUMN Email ADD MASKED WITH (FUNCTION = 'email()');
    GO
    -- The columns are successfully masked.

    -- Step:4 Let's see Dynamic Data Masking (DDM) applied on the two columns.
    SELECT c.name, tbl.name as table_name, c.is_masked, c.masking_function  
    FROM sys.masked_columns AS c  
    JOIN sys.tables AS tbl
        ON c.[object_id] = tbl.[object_id]  
    WHERE is_masked = 1
        AND tbl.name ='CustomerInfo';

    -- Step:5 Now, let's grant SELECT permission to 'DataAnalystMiami' on the 'CustomerInfo' table.
   GRANT SELECT ON wwi_mcw.CustomerInfo TO DataAnalystMiami;  

    -- Step:6 Logged in as  'DataAnalystMiami' let's execute the select query and view the result.
    EXECUTE AS USER = 'DataAnalystMiami';  
    SELECT * FROM wwi_mcw.CustomerInfo;

    -- Step:7 Let's remove the data masking using UNMASK permission
    GRANT UNMASK TO DataAnalystMiami;
    EXECUTE AS USER = 'DataAnalystMiami';  
    SELECT *
    FROM wwi_mcw.CustomerInfo;
    revert;
    REVOKE UNMASK TO DataAnalystMiami;  

    ----step:8 Reverting all the changes back to as it was.
    ALTER TABLE wwi_mcw.CustomerInfo
    ALTER COLUMN CreditCard DROP MASKED;
    GO
    ALTER TABLE wwi_mcw.CustomerInfo
    ALTER COLUMN Email DROP MASKED;
    GO
    ```

    ![The query tab toolbar is displayed with the Run button selected.](media/querytoolbar_run.png "Running a query")

3. From the top toolbar, select the **Discard all** button as we will not be saving this query. When prompted, choose to **Discard changes**.

   ![The top toolbar menu is displayed with the Discard all button highlighted.](media/toptoolbar_discardall.png "Discard changes")

## Exercise 7: Machine Learning

**Duration**: 60 minutes

Using Azure Synapse Analytics, data scientists are no longer required to use separate tooling to create and deploy machine learning models.

In this exercise, you will create multiple machine learning models. You will learn how to consume these models in your notebook. You will also deploy a model as a web service to Azure Container Instances and consume the service - without ever having to leave the Azure Synapse Analytics workspace.

### Task 1: Training, consuming, and deploying models

1. Open the **ASAMCW - Exercise 7 - Machine Learning** notebook (select **Develop** from the left menu, from the **Develop** menu, expand the **Notebooks** section and select the notebook)

2. Run the notebook step by step (DO NOT `RUN ALL`) to complete this exercise. Some of the most important tasks you will perform are:

- Exploratory data analysis (basic stats)
- Use PCA for dimensionality reduction
- Train ensemble of trees classifier (using XGBoost)
- Train classifier using Auto ML
- Register the best run model
- Deploy the model as a web service to Azure Container Instances
- Consume the web service to make predictions on sample data
  
> **Note**: Please note that each of these tasks will be addressed through several cells in the notebook.

## Exercise 8: Monitoring

**Duration**: 45 minutes

Azure Synapse Analytics provides a rich monitoring experience within the Azure portal to surface insights regarding your data warehouse workload.

You can monitor active SQL requests using the SQL requests area of the Monitor Hub. This includes details like the pool, submitter, duration, queued duration, workload group assigned, importance, and the request content.

Pipeline runs can be monitored using the Monitor Hub and selecting Pipeline runs. Here you can filter pipeline runs and drill in to view the activity runs associated with the pipeline run and monitor the running of in-progress pipelines.

### Task 1: Workload importance

Running mixed workloads can pose resource challenges on busy systems. Solution architects seek ways to separate classic data warehousing activities (such as loading, transforming, and querying data) to ensure that enough resources exist to hit SLAs.

Synapse SQL pool workload management in Azure Synapse consists of three high-level concepts: workload classification, workload importance and workload isolation. These capabilities give you more control over how your workload utilizes system resources.

Workload importance influences the order in which a request gets access to resources. On a busy system, a request with higher importance has first access to resources. Importance can also ensure ordered access to locks.

Setting importance in Synapse SQL for Azure Synapse allows you to influence the scheduling of queries. Queries with higher importance will be scheduled to run before queries with lower importance. To assign importance to queries, you need to create a workload classifier.

1. Navigate to the **Develop** hub.

    ![The Develop menu item is highlighted.](media/develop-hub.png "Develop hub")

2. From the **Develop** menu, select the + button and choose **SQL Script** from the context menu.

    ![The SQL script context menu item is highlighted.](media/synapse-studio-new-sql-script.png "New SQL script")

3. In the toolbar menu, connect to the **SQL Pool** database to execute the query.

    ![The connect to option is highlighted in the query toolbar.](media/synapse-studio-query-toolbar-connect.png "Query toolbar")

4. In the query window, replace the script with the following to confirm that there are no queries currently being run by users logged in as `asa.sql.workload01`, representing the CEO of the organization or `asa.sql.workload02` representing the data analyst working on the project:

    ```sql
    --First, let's confirm that there are no queries currently being run by users logged in as CEONYC or AnalystNYC.

    SELECT s.login_name, r.[Status], r.Importance, submit_time,
    start_time ,s.session_id FROM sys.dm_pdw_exec_sessions s
    JOIN sys.dm_pdw_exec_requests r ON s.session_id = r.session_id
    WHERE s.login_name IN ('asa.sql.workload01','asa.sql.workload02') and Importance
    is not NULL AND r.[status] in ('Running','Suspended')
    --and submit_time>dateadd(minute,-2,getdate())
    ORDER BY submit_time ,s.login_name
    ```

5. Select **Run** from the toolbar menu to execute the SQL command.

    ![The run button is highlighted in the query toolbar.](media/synapse-studio-query-toolbar-run.png "Run")

6. Next, you will flood the system with queries and see what happens for `asa.sql.workload01` and `asa.sql.workload02`. To do this, we'll run a Azure Synapse Pipeline that executes a large number of queries.

7. Select the `Orchestrate` Tab.

8. **Run** the **Exercise 8 - Execute Data Analyst and CEO Queries** Pipeline, which will run the `asa.sql.workload01` and `asa.sql.workload02` queries. You can run the pipeline with the Debug option if you have an instance of the Integration Runtime running.

9. Select **Add trigger**, then **Trigger now**. In the dialog that appears, select **OK**. **Let this pipeline run for 30 seconds to 1 minute, then proceed to the next step**.

    ![The add trigger and trigger now menu items are highlighted.](media/trigger-data-analyst-and-ceo-queries-pipeline.png "Add trigger")

10. From the left menu, select the **Monitor** hub. Hover over the link of the in-progress pipeline, and select the **Cancel recursive** icon that displays.

    ![The Monitor Hub icon is selected from the left menu, and the Cancel recursive button is selected on the in progress pipeline.](media/cancel_running_pipeline_monitor_hub.png)

11. From the left menu, select the **Develop** hub and return to your SQL script. Let's see what happened to all the queries that flooded the system. In the query window, replace the script with the following:

    ```sql
    SELECT s.login_name, r.[Status], r.Importance, submit_time, start_time ,s.session_id FROM sys.dm_pdw_exec_sessions s
    JOIN sys.dm_pdw_exec_requests r ON s.session_id = r.session_id
    WHERE s.login_name IN ('asa.sql.workload01','asa.sql.workload02') and Importance
    is not NULL AND r.[status] in ('Running','Suspended') and submit_time>dateadd(minute,-4,getdate())
    ORDER BY submit_time ,status
    ```

12. Select **Run** from the toolbar menu to execute the SQL command. You should see an output similar to the following:

    ![SQL query results.](media/sql-query-2-results.png "SQL script")

13. Intermittently perform the preceding query until all queries have been run and no results are returned.

14. We will give our `asa.sql.workload01` user queries priority by implementing the **workload importance** feature. In the query window, replace the script with the following:

    ```sql
    IF EXISTS (SELECT * FROM sys.workload_management_workload_classifiers WHERE name = 'CEO')
    BEGIN
        DROP WORKLOAD CLASSIFIER CEO;
    END
    CREATE WORKLOAD CLASSIFIER CEO
      WITH (WORKLOAD_GROUP = 'largerc'
      ,MEMBERNAME = 'asa.sql.workload01',IMPORTANCE = High);
    ```

15. Select **Run** from the toolbar menu to execute the SQL command.

16. Let's flood the system again with queries and see what happens this time for `asa.sql.workload01` and `asa.sql.workload02` queries. To do this, we'll run an Azure Synapse Pipeline that runs a large number queries. **Similar to before, run this pipeline for about 30 seconds to 1 minute**.

    - **Select** the `Orchestrate` Tab.

    - **Run** the **Exercise 8 - Execute Data Analyst and CEO Queries** Pipeline, which will run the `asa.sql.workload01` and `asa.sql.workload02` queries.

17. In the query window, replace the script with the following to see what happens to the `asa.sql.workload01` queries this time:

    ```sql
    SELECT s.login_name, r.[Status], r.Importance, submit_time, start_time ,s.session_id FROM sys.dm_pdw_exec_sessions s
    JOIN sys.dm_pdw_exec_requests r ON s.session_id = r.session_id
    WHERE s.login_name IN ('asa.sql.workload01','asa.sql.workload02') and Importance
    is not NULL AND r.[status] in ('Running','Suspended') and submit_time>dateadd(minute,-2,getdate())
    ORDER BY submit_time ,status desc
    ```

18. Select **Run** from the toolbar menu to execute the SQL command. You should see an output similar to the following that shows query executions for the `asa.sql.workload01` user having a **high** importance. Also note that the 'asa.sql.workload02' queries are in **Suspended** status while the high priority queries are being run.

    ![SQL query results showing asa.sql.workload01 queries with a higher importance than those queries from asa.sql.workload02.](media/sql-query-4-results.png "SQL script")

### Task 2: Workload isolation

Workload isolation means resources are reserved, exclusively, for a workload group. Workload groups are containers for a set of requests and are the basis for how workload management, including workload isolation, is configured on a system. A simple workload management configuration can manage data loads and user queries.

In the absence of workload isolation, requests operate in the shared pool of resources. Access to resources in the shared pool is not guaranteed and is assigned on an importance basis.

Configuring workload isolation should be done with caution as the resources are allocated to the workload group even if there are no active requests in the workload group. Over-configuring isolation can lead to diminished overall system utilization.

Users should avoid a workload management solution that configures 100% workload isolation: 100% isolation is achieved when the sum of `min_percentage_resource` configured across all workload groups equals 100%. This type of configuration is overly restrictive and rigid, leaving little room for resource requests that are accidentally misclassified. There is a provision to allow one request to execute from workload groups not configured for isolation.

1. Navigate to the **Develop** hub.

    ![The Develop menu item is highlighted.](media/develop-hub.png "Develop hub")

2. From the **Develop** menu, select the + button and choose **SQL Script** from the context menu.

    ![The SQL script context menu item is highlighted.](media/synapse-studio-new-sql-script.png "New SQL script")

3. In the toolbar menu, connect to the **SQL Pool** database to execute the query.

    ![The connect to option is highlighted in the query toolbar.](media/synapse-studio-query-toolbar-connect.png "Query toolbar")

4. In the query window, replace the script with the following:

    ```sql
    IF NOT EXISTS (SELECT * FROM sys.workload_management_workload_groups where name = 'CEODemo')
    BEGIN
        Create WORKLOAD GROUP CEODemo WITH  
        ( MIN_PERCENTAGE_RESOURCE = 50        -- integer value
        ,REQUEST_MIN_RESOURCE_GRANT_PERCENT = 25 --  
        ,CAP_PERCENTAGE_RESOURCE = 100
        )
    END
    ```

    The code creates a workload group called `CEODemo` that reserves resources exclusively for the workload group. In this example, a workload group with a `MIN_PERCENTAGE_RESOURCE` set to 50% and `REQUEST_MIN_RESOURCE_GRANT_PERCENT` set to 25% is guaranteed 2 concurrent queries.

5. Select **Run** from the toolbar menu to execute the SQL command.

6. In the query window, replace the script with the following to create a workload Classifier called `CEODreamDemo` that assigns a workload group and importance to incoming requests:

    ```sql
    IF NOT EXISTS (SELECT * FROM sys.workload_management_workload_classifiers where  name = 'CEODreamDemo')
    BEGIN
        Create Workload Classifier CEODreamDemo with
        ( Workload_Group ='CEODemo',MemberName='asa.sql.workload02',IMPORTANCE = BELOW_NORMAL);
    END
    ```

7. Select **Run** from the toolbar menu to execute the SQL command.

8. In the query window, replace the script with the following to confirm that there are no active queries being run by `asa.sql.workload02`:

    ```sql
    SELECT s.login_name, r.[Status], r.Importance, submit_time,
    start_time ,s.session_id FROM sys.dm_pdw_exec_sessions s
    JOIN sys.dm_pdw_exec_requests r ON s.session_id = r.session_id
    WHERE s.login_name IN ('asa.sql.workload02') and Importance
    is not NULL AND r.[status] in ('Running','Suspended')
    ORDER BY submit_time, status
    ```

9. Let's flood the system with queries and see what happens for `asa.sql.workload02`. To do this, we will run an Azure Synapse Pipeline that runs a large number of queries. Select the `Orchestrate` Tab. **Run** the **Exercise 8 - Execute Business Analyst Queries** Pipeline, which will run the  `asa.sql.workload02` queries. **Let this pipeline run for 30 seconds to 1 minute, then cancel the run recursively**.

10. In the query window, replace the script with the following to see what happened to all the `asa.sql.workload02` queries that were flooded into the system:

    ```sql
    SELECT s.login_name, r.[Status], r.Importance, submit_time,
    start_time ,s.session_id FROM sys.dm_pdw_exec_sessions s
    JOIN sys.dm_pdw_exec_requests r ON s.session_id = r.session_id
    WHERE s.login_name IN ('asa.sql.workload02') and Importance
    is not NULL AND r.[status] in ('Running','Suspended')
    ORDER BY submit_time, status
    ```

11. Select **Run** from the toolbar menu to execute the SQL command. You should see an output similar to the following that shows the importance for each session set to `below_normal` and two queries being run in parallel:

    ![The script results show that each session was executed with below normal importance with two queries being run in parallel.](media/sql-result-below-normal.png "SQL script")

12. In the query window, replace the script with the following to set 3.25% minimum resources per request:

    ```sql
    IF  EXISTS (SELECT * FROM sys.workload_management_workload_classifiers where group_name = 'CEODemo')
    BEGIN
        Drop Workload Classifier CEODreamDemo
        DROP WORKLOAD GROUP CEODemo
        --- Creates a workload group 'CEODemo'.
            Create  WORKLOAD GROUP CEODemo WITH  
        (MIN_PERCENTAGE_RESOURCE = 26 -- integer value
            ,REQUEST_MIN_RESOURCE_GRANT_PERCENT = 3.25 -- factor of 26 (guaranteed more than 4 concurrencies)
        ,CAP_PERCENTAGE_RESOURCE = 100
        )
        --- Creates a workload Classifier 'CEODreamDemo'.
        Create Workload Classifier CEODreamDemo with
        (Workload_Group ='CEODemo',MemberName='asa.sql.workload02',IMPORTANCE = BELOW_NORMAL);
    END
    ```

    > **Note**: Configuring workload containment implicitly defines a maximum level of concurrency. With a CAP_PERCENTAGE_RESOURCE set to 60% and a REQUEST_MIN_RESOURCE_GRANT_PERCENT set to 1%, up to a 60-concurrency level is allowed for the workload group. Consider the method included below for determining the maximum concurrency:
    >
    > [Max Concurrency] = [CAP_PERCENTAGE_RESOURCE] / [REQUEST_MIN_RESOURCE_GRANT_PERCENT]

13. Let's flood the system again and see what happens for `asa.sql.workload02`. To do this, we will run an Azure Synapse Pipeline that runs a large number of queries. Select the `Orchestrate` Tab. **Run** the **Exercise 8 - Execute Business Analyst Queries** Pipeline, which will run the `asa.sql.workload02` queries.

14. In the query window, replace the script with the following to see what happened to all of the `asa.sql.workload02` queries that flooded the system, note that many more queries are now being performed in parallel for asa.sql.workload02:

    ```sql
    SELECT s.login_name, r.[Status], r.Importance, submit_time,
    start_time ,s.session_id FROM sys.dm_pdw_exec_sessions s
    JOIN sys.dm_pdw_exec_requests r ON s.session_id = r.session_id
    WHERE s.login_name IN ('asa.sql.workload02') and Importance
    is  not NULL AND r.[status] in ('Running','Suspended')
    ORDER BY submit_time, status
    ```

15. Select **Run** from the toolbar menu to execute the SQL command.

  ![The SQL results pane is shown with multiple queries being run in parallel.](media/multiple_parallel_queries_workload02.png "More than 2 queries being run in parallel")

### Task 3: Monitoring with Dynamic Management Views

For a programmatic experience when monitoring SQL Analytics via T-SQL, the service provides a set of Dynamic Management Views (DMVs). These views are useful when actively troubleshooting and identifying performance bottlenecks with your workload.

All logins to your data warehouse are logged to `sys.dm_pdw_exec_sessions`. This DMV contains the last 10,000 logins. The `session_id` is the primary key and is assigned sequentially for each new logon.

1. Navigate to the **Develop** hub.

    ![The Develop menu item is highlighted.](media/develop-hub.png "Develop hub")

2. From the **Develop** menu, select the + button and choose **SQL Script** from the context menu.

    ![The SQL script context menu item is highlighted.](media/synapse-studio-new-sql-script.png "New SQL script")

3. In the toolbar menu, connect to the **SQL Pool** database to execute the query.

    ![The connect to option is highlighted in the query toolbar.](media/synapse-studio-query-toolbar-connect.png "Query toolbar")

4. In the query window, replace the script with the following:

    ```sql
    SELECT * FROM sys.dm_pdw_exec_sessions where status <> 'Closed' and session_id <> session_id();
    ```

    All queries executed on SQL pool are logged to `sys.dm_pdw_exec_requests`. This DMV contains the last 10,000 queries executed. The `request_id` uniquely identifies each query and is the primary key for this DMV. The `request_id` is assigned sequentially for each new query and is prefixed with `QID`, which stands for query ID. Querying this DMV for a given `session_id` shows all queries for a given logon.

5. Select **Run** from the toolbar menu to execute the SQL command.

6. Let's flood the system with queries to create operations to monitor. To do this, we will run a Azure Synapse Pipeline which triggers queries. Select the `Orchestrate` Tab. **Run** the **Exercise 8 - Execute Business Analyst Queries** Pipeline, which will run / trigger  `asa.sql.workload02` queries. **Let this pipeline run for 30 seconds to 1 minute, then cancel the run recursively**.

7. In the query window, replace the script with the following:

    ```sql
    SELECT *
    FROM sys.dm_pdw_exec_requests
    WHERE status not in ('Completed','Failed','Cancelled')
      AND session_id <> session_id()
    ORDER BY submit_time DESC;
    ```

8. Select **Run** from the toolbar menu to execute the SQL command. You should see a list of sessions in the query results similar to the following. **Note the `Request_ID` of a query** in the results that you would like to investigate (*keep this value in a text editor for a later step*):

    ![Active query results.](media/query-active-requests-results.png "Query results")

9. As an alternative, you can execute the following SQL command to find the top 10 longest running queries.

    ```sql
    SELECT TOP 10 *
    FROM sys.dm_pdw_exec_requests
    ORDER BY total_elapsed_time DESC;
    ```

10. To simplify the lookup of a query in the `sys.dm_pdw_exec_requests` table, use `LABEL` to assign a comment to your query, which can be looked up in the `sys.dm_pdw_exec_requests` view. To test using the labels, replace the script in the query window with the following:

    ```sql
    SELECT *
    FROM sys.tables
    OPTION (LABEL = 'My Query');
    ```

11. Select **Run** from the toolbar menu to execute the SQL command.

12. In the query window, replace the script with the following to filter the results with the label, `My Query`.

    ```sql
    -- Find a query with the Label 'My Query'
    -- Use brackets when querying the label column, as it is a key word
    SELECT  *
    FROM sys.dm_pdw_exec_requests
    WHERE [label] = 'My Query';
    ```

13. Select **Run** from the toolbar menu to execute the SQL command. You should see the previously run query in the results view.

14. In the query window, replace the script with the following to retrieve the query's distributed SQL (DSQL) plan from `sys.dm_pdw_request_steps`. **Be sure to replace** the `QID#####` with the `Request_ID` you noted in Step 8:

    ```sql
    SELECT * FROM sys.dm_pdw_request_steps
    WHERE request_id = 'QID####'
    ORDER BY step_index;
    ```

15. Select **Run** from the toolbar menu to execute the SQL command. You should see results showing the distributed query plan steps for the specified request:

    ![The query results are displayed.](media/sql-dsql-plan-results.png "Query results")

    > When a DSQL plan is taking longer than expected, the cause can be a complex plan with many DSQL steps or just one step taking a long time. If the plan is many steps with several move operations, consider optimizing your table distributions to reduce data movement.

### Task 4: Orchestration Monitoring with the Monitor Hub

1. Let's run a pipeline to monitor its execution in the next step. To do this, select the `Orchestrate` Tab. **Run** the **Exercise 8 - Execute Business Analyst Queries** Pipeline.

    ![The add trigger and trigger now menu items are highlighted.](media/ex7-task4-01.png "Add trigger")

2. Navigate to the `Monitor` hub. Then select **Pipeline runs** to get a list of pipelines that ran during the last 24 hours. Observe the Pipeline status.

    ![The pipeline runs blade is displayed within the Monitor hub.](media/ex7-task4-02.png "Monitor - Pipeline runs")

3. Hover over the running pipeline and select **Cancel** to cancel the execution of the current instance of the pipeline.

    ![The Cancel option is highlighted.](media/ex7-task4-03.png "Cancel")

### Task 5: Monitoring SQL Requests with the Monitor Hub

1. Let's run a pipeline to monitor its execution in the next step. To do this, select the `Orchestrate` Tab. **Run** the **Exercise 8 - Execute Business Analyst Queries** Pipeline.

    ![The add trigger and trigger now menu items are highlighted.](media/ex7-task5-01.png "Add trigger")

2. Navigate to the `Monitor` hub. Then select **SQL requests** to get a list of SQL requests that ran during the last 24 hours.

3. Select the **Pool** filter and select your SQL Pool. Observe the `Request Submitter`, `Submit Time`, `Duration`, and `Queued Duration` values.

    ![The SQL requests blade is displayed within the Monitor hub.](media/ex7-task5-02.png "Monitor - SQL requests")

4. Hover onto a SQL Request log and select `Request Content` to access the actual T-SQL command executed as part of the SQL Request.

    ![The request content link is displayed over a SQL request.](media/ex7-task5-03.png "SQL requests")

5. You may now return to the **Monitor** hub and cancel the in-progress pipeline run.
  
## After the hands-on lab

**Duration**: 5 minutes

### Task 1: Delete the resource group

1. In the Azure Portal, open the resource group for this lab. Select **Delete** from the top toolbar menu.

2. In the Azure Portal, open the resource group with the same name as your Function App. Select **Delete** from the top toolbar menu.

3. Open the Cloud Shell and issue the following command to remove the lab files:

   ```PowerShell
   Remove-Item -Path .\Synapse-MCW -recurse -force  
   ```

You should follow all steps provided *after* attending the Hands-on lab.
