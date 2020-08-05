# Oracle Migration To Azure Database for PostgreSQL (Lab)
## Overview
- Azure Database for PostgreSQL is a relational database service based on the open-source Postgres database engine. It's a fully managed database-as-a-service offering that can handle mission-critical workloads with predictable performance, security, high availability, and dynamic scalability. It offers two deployment options Single Server and Hyperscale (Citus). Please access <a href="https://docs.microsoft.com/en-us/azure/postgresql/overview"> this link </a> for more details. 

- This lab provides the steps to migrate Oracle 12c database to Azure PostgreSQL version 11. This labs assumes that you have completed the assessment step using <a href="https://datamigration.microsoft.com/scenario/oracle-to-azurepostgresql"> Ora2Pg </a> free tool.

## Pre-requisites
- Read Access to Sample HR schema in Oracle Database

## Task List
- [Task-1: Create Azure Database for PostgreSQL Service](#task-1-create-azure-database-for-postgresql-service)
- [Task-2: Create Azure Database Migration Service](#task-2-create-azure-database-migration-service)
- [Task-3: Create a project to Migrate Oracle HR schema](#task-3-create-a-project-to-migrate-oracle-hr-schema)
- [Task-4: Execute the initial load](#task-4-execute-the-initial-load)
- [Task-5: Perform the data sync and Prepare for the cutover](#task-5-perform-the-data-sync-and-prepare-for-the-cutover)
- [Task-6: Perform the cutover and go live](#task-6-perform-the-cutover-and-go-live)

### Task-1: Create Azure Database for PostgreSQL Service
### We will provision Azure PostgreSQL service in this task.
- Type 'postgresql' on the search bar to select Azure database for postgreSQL service

<img src="./images/ATA_PostgreSQL_Select_Single_Server.PNG" alt="Select PostgreSQL Single Server Service" width="400">

- Enter the following details
- Resource group: Select 'Create new' and enter 'ata-ora2pg-\<yourname\>-rg'.
- Server name: enter 'pg11\<yourname\>'.
- Location: select 'East US'
- Version: 11
- Admin username: enter 'pgadmin'
- Password: enter 'atapg123!'

<img src="./images/ata-pg-create-single-server.PNG" alt="create single server postgreSQL" width="600">

- Click on 'Review + create'.
- Click on 'Create' after the successful validation.


