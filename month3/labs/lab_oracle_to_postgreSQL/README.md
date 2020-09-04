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
1. Select Azure Database for PostgreSQL service
- Type 'postgresql' on the search bar to select Azure database for postgreSQL service

<img src="./images/ATA_PostgreSQL_Select_Single_Server.PNG" alt="Select PostgreSQL Single Server Service" width="600">

2. Enter the following details
- Resource group: Select 'Create new' and enter 'ata-ora2pg-\<yourname\>-rg'.
- Server name: enter 'pg11\<yourname\>'.
- Location: select 'East US'
- Version: 11
- Admin username: enter 'pgadmin'
- Password: enter 'atapg123!'

<img src="./images/ata-pg-create-single-server.PNG" alt="create single server postgreSQL" width="800">

- Click on 'Review + create'.
- Click on 'Create' after the successful validation.
3. Install pgadmin tool
- Download PostgreSQL Admin tool using <a href="https://www.pgadmin.org/download/pgadmin-4-windows/">thislink</a>


4. Create a 'HR' database
- Download pgadmin tool to access PostgreSQL.
- Add the IP address of the client
- Connect to the Azure PostgreSQL from PgAdmin Tool
Enter the following:
- Host Name: copy host name from the Azure Portal
- User name:pgadmin@hostname
- Password:atapg123!
<img src="./src/images/ata-pg-connect-pg-service.PNG" alt="Create PG server connection" width="500">
- Select 'Databases' and create a new Database
- Enter HR as the new database
<img src="./src/images/ata-pg-create-hr-database.PNG" alt="Create PG server connection" width="500">

## Task-2: Create Azure Database Migration Service
1. Select Azure Database Migration Service
Enter 'Database Migration' in the search bar to select the service.
2. Enter the following information
- Resource Group: Select the resource group you have created in the Task-1.
- Migration service name: Enter 'ata-dms-\<youname\>'
- Pricing tier: Click on 'Configure tier' and select Premium service.
- Click on 'Networking' button
<img src="./src/images/ata-pg-create-dms.PNG" alt="Create Azure Database Migration Service" width="800">
- Enter 'ata-ora2pg-\<youname\>-vnet' name to create a new Virtual network name
<img src="./src/images/ata-pg-create-dms-vnet.PNG" alt="Create a new Virutal Network" Width="800">
- Click on 'Review + create'.
- Click on 'Create' after the successful validation.
- Click on 'Goto Resource' after it is done.
3. Create a migration project 
- Select '+' next to 'New Migration Project' 
Enter the following information
- Project name: ora12cToPg11
- Source server type: select 'Oracle' from the dropdown list
- Target server type: select 'Azure Database for PostgreSQL' 
- Click on 'Create and Run Activity' button
- It opens up 6 step configuration
4. Add Source Details
Enter the following Oracle 12c HR database details
- Source Server name: Enter the Instructor provided Oracle Server IP address.
- Server port: Enter the default port number 1521.
- Oracle SID: Enter 'nonpdb' 
- User Name: Enter 'system'
- Password: Enter 'OraPasswd1'
Click on Save button.
<img src="./src/images/ata-pg-dms-add-source.PNG" alt="Enter source oracle database access details" width="800">
5. Driver Install Detail
Enter the following location details to access the driver file
OCI driver path: Enter \\WindowsVMDBeave\Oracle\instantclient-basiclite-windows.x64-12.2.0.1.0.zip
User Name: Enter 'azure\azureuser'
Password: Enter 'Password123!'
Click on Save button


  




