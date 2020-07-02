# Azure Trailblazer Academy Azure Data Factory (ADF) Lab
## Overview
Azure Data Factory is the PaaS cloud-based ETL & data integration tool allows you to create data driven workflows in the cloud for orchestrating and automating data movement and data transformation. 

Big data requires service that can orchestrate and operationalize processes to refine these enormous stores of raw data into actionable business insights.

## Lab Overview
This lab will help you gain the experience to ingest data from on-premises databases such as Oracle, SAP, Teradata, Hortonworks, DB2, SQL Server and Cloudera. It will showcase the steps to build a pipeline inside ADF to ingest the data into ADLS GEN2 storage and secure the PII data using data transformation functions inside the Data Flow activity and finally store the data in Synapse SQL Pool (Data warehouse) for building BI dashboard.  

## Pre-requisites:
### 1. Write Access to Azure Data Lake Storage Account (ADLS Gen2)
### 2. Read Access to Sample HR schema in Oracle Database
### 3. Write Access to Synapse SQL Pool Data warehouse   

- [Task-1: Create linked services](#task-1-create-linked-services)
- [Task-2: Create Data Sets](#task-2-create-date-sets) 
- [Task-3: Create Activity to move the data from the source to target](#task-3-create-activity-to-move-the-data-from-the-source-to-target)
- [Task-4: Create Data Transformation Flow](#task-4-create-data-transformation-flow)
- [Task-5: Build a pipeline to connect activities](#task-5-build-a-pipeline-to-connect-activities)
- [Task-6: Trigger the pipeline execution](#task-6-trigger-the-pipeline-execution) 

### Task-1: Create linked services

