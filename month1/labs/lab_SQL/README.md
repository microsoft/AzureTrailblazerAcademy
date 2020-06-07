# Hands-on lab to Migrate SQL database to Azure (step-by-step)
## Objective
In this hands-on lab, you will migrate 2012 SQL database to Azure PaaS SQL database. You will also apply data security for business critical applications.

### Task-1: Create Virutal Machine with 2012 SQL database
1. Navigate to the [Azure portal](https://portal.azure.com) and select **Resource groups** from the Azure services list.

<img src="./images/azure-services-resource-groups.png" alt="Resource groups is highlighted in the Azure services list" Width="700">

2. Create **Resource group** by selecting 'add'
- Enter 'ata-sql-lab-<name>' as the Resource group
- Select 'East US' as the Region
- Click on 'Review + Create' button
- Make sure the validation is passed before clicking on 'Create' button.

<img src="./images/resource-group-create.PNG" alt="Resource Group Create" Width="500">

3. Create Virutal Machine 
- Select 'goto resource' to go resource group
- Select 'add' and search for 'SQL Server 2012 SP4'
- Click on 'Create'

<img src="./images/sql-server-vm-create.PNG" alt="Create SQL server VM" Width="400">

4. Enter configuration
- Make sure you have selected the correct resource group
- Virtual machine name:'ata-sql-2012-your-initials'
- Region: 'East US'
- Size: Standard_DS12_V2-4 vcpus, 28 Gib Memory(DropDown Selection)
- Username: AzureUser (Keep the Default)
- Password: Atasql2012user (Use this to avoid password issues)
- Select inbound ports: RDP(3389) (We need this to access this VM remotely)

5. Enter SQL Server User Configuration
- Click on 'SQL Server settings' tab
- Enable SQL Authentication 
- Enter SQL Login name:'sqladmin'
- Enter password:'Atasql2012admin'

<img src="./images/SQL-VM-Admin-User.PNG" alt="SQL Server Admin Login" Width="500">

- Rest are default options
- Click on 'Review + create' button

<img src="./images/SQL-VM-Configuration-full.PNG" alt="SQL VM configuration setup" Width="600">

- Make sure you have green check for the **validation passed** and Click on **Create** button
- Wait till your deployment is complete and see 'Go To Resource' button

### Task-2: Restore a sample database, AdventureWorks from a backup
1. Access the Virtual Machine (VM) from your environment.
- Select 'Go to resource' to access Virtual Machine server config
- Select 'Connect' and 'RDP' 
- Click on 'Download RDP File'
- Click on 'Connect'

<img src="./images/SQL-VM-RDP-Connect.PNG" alt="Remote Desktop connect" Width="600">

- 'Enter your credentials popup'
- Select 'Use a different account'
- Enter user name as 'azureuser'
- Enter the password ('Atasql2012user')
2. Modify Internet Security to download the software
- Open 'Server Manager' if not open
- Select 'Local Server' 
- Find 'IE Enhanced Security Configuration' and Turn 'Off' 
- It is not recommended but to avoid internet issues. Please turn On after the download.

<img src="./images/SQL-VM-turn-off-IE.PNG" alt="Turn off IE browser Security" Width="800">

3. Download the AdventureWorks, a sample database for SQL 2012.
- Open Internet Explorer browser and access [SQL 2012 Backup](https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks)
- Select 'AdventureWorks2012.bak' under "AdventureWorks (OLTP) full database backups" section 

<img src="./images/SQL-2012-Backup-download.PNG" alt="SQL 2012 Database backup" Width="600">

- Save the backup file to local 'c:\Data' folder (Create a new folder)

4. Open SQL Server Management Studio and restore the database.
- Search for 'SQL Server Management Studio' on the desktop
- Connect to SQL Server with 'sqladmin' login
- Select 'database' folder and right click to select 'Restore database' option

<img src="./images/SQL-VM-SQL-Select-Restore.PNG" alt="select Restore database option" Width="300">

- Select 'Device', '...', 'File', 'C:\data Folder' and 'AdventureWorks2012.bak' file.

<img src="./images/SQL-DB-Restore-Backup.PNG" alt="select backup file" Width=500">

- Click 'OK' three times to start the backup process

<img src="./images/SQL-DB-Restore-backup-Done.PNG" alt="backup restore done" Width="400">

- Expand 'Database'|'AdventureWorks2012'|'Tables'|'HumanResources.employee' table |'Select Top 1000 Rows'

<img src="./images/SQL-DB-Select-table-rows.PNG" alt="Select 1000 rows from Employee table" Width="400">

- Execute the query
- You have restored the database successfully!

### Task-3: Create Azure SQL PaaS Database
1. Open Portal to create SQL PaaS Database.

- Select Database service from the search bar
- Select 'Add' to create a new database
- Select Resource Group
- Enter Database name: 'ata-sql-2012-migrate-<name>'
- Server: Click on 'Create new'
- Enter Server name: 'ata-sql-server-srini'
- Enter Server admin: login: 'azuresqladmin'
- Enter password: 'Atasql2012admin'
- Location: 'East US'
- Click on 'OK' button
- Click on 'Review + create' button
- Click on 'Create' button

<img src="./images/Azure-SQL-DB-Server=Create.PNG" alt="create Azure SQL DB Server" Width="500">

- You will see 'Deployment underway screen'

<img src="./images/AzureSQL-DB-Deployment.PNG" alt="SQL DB deployment underway" Width="400"> 

- You will see 'Deployment complete' after few minutes
- You are successfully created Azure SQL (PaaS) Database

### Task-4: Install Data Migration Assistant

- Now let us evaluate the SQL 2012 database to migrate to Azure SQL.
- Data Migration Assistant is available to assess the migration 
- This tool will provide a report about any feature parity and compatibility issues between the on-premises database and the Azure SQL DB service.
1. Access SQL 2012 VM and Download [Microsoft Data Migration Assistant](https://www.microsoft.com/en-us/download/details.aspx?id=53595)
- Run the install with the default options.

<img src="./images/SQL-VM-DMA-Install.PNG" alt="Download DMA install" Width="700">

- At the end check the box to launch the Data Migration Assistant (DMA)
2. In the DMA dialog, select + from the left-hand menu to create a new project.

<img src="./images/DMA-Select-new.PNG" alt="DMA Select new" Width="300">

3. Provide the following details and click on 'Create'
- **Project type**: Select **Assessment**.
- **Project name**: Enter `ata-sql2012db-azure-sql`
- **Assessment type**: Select **Database Engine**.
- **Source server type**: Select **SQL Server**.
- **Target server type**: Select **Azure SQL Database**.

<img src="./images/DMA-SQL-Migrate-Project.PNG" alt="SQL Migrate Project info" Width="400">

4. On the **Options** screen, ensure **Check database compatibility** and **Check feature parity** are both checked, and then select **Next**.

<img src="./images/DMA-Migration-project-options.PNG" alt="Project Migration Options" Width="700">

5. On the **Sources** screen, enter the following into the **Connect to a server** dialog that appears on the right-hand side:
- **Server name**: Select **SQLSERVER2008**.
- **Authentication type**: Select **SQL Server Authentication**.
- **Username**: Enter `ata-sql-2012-sr`
- **Password**: Enter `atasql2012admin`
- **Encrypt connection**: Uncheck this box.
- **Trust server certificate**: Uncheck this box.

<img src="./images/DMA-SQL-source-Info.PNG", alt="Source database access info" Width="300">

- Select Connect
6. On the Add sources dialog that appears next, check the box for 'AdventureWorks12' and select Add.

<img src="./images/DMA-Select-Data-Source.PNG" alt="Select Source Database" Height="300">

7. Select 'Start Assessment' 

<img src="./images/DMA-Migration-Start-Assessment.PNG" alt="Start Migration Assessment" Width="600">

8. Analyze the feature parity issues with the possible migration

<img src="./images/DMA-SQL-Migrate-feature-parity.PNG" alt="SQL Migrate feature parity isues" Width="800">

9. Analyze the compatibility issues with the possible migration.

<img src="./images/DMA-SQL-Migrate-Compatibility.PNG" alt="SQL Migrate Compatibility issues" Width="800">

10. Store the assessment to share with Development and Azure Teams.

### Task-5: Migrate SQL 2012 Schema to Azure SQL PaaS Database
1. Select new to create a migration project
2. Enter the following:
- **Project type**: Select **Migration**
- **Project name**: Enter 'Migrate-schema-sql2012-AzureSQL'
- **Source server type**:Select **SQL Server**
- **Target server type**:Select **Azure SQL Database**
- **Migration scope**:Select **Schema only**
- Click on **Create**

<img src="./images/DMA-Migreate-schema-select.PNG" alt="Migrate Schema project" Height="300">

3. Enter the source database info
- Server name: Enter Your Server Name
- Authentication type: Select **SQL Server Authentication**
- Username: Enter 'sqladmin'
- Password: Enter 'Atasql2012admin'
- Encrypt connection: Uncheck the box
- Trust server certificate: Uncheck the box
- Click on 'Connect'
<img src="./images/DMA-Migrate-schema-source-db.PNG" alt="Migrate SQL DB Schema Source info" Height="300">

- Select the 'AdventureWorks2012' database
- Click on 'Next' button
4. Provide the target datbase info
- Get the Azure SQL DB Server name from the Azure Portal 

<img src="./images/AzureSQLDB-Server-name.PNG" alt="Azure SQL DB Server name" Width="800">

- Allow client access to the Azure SQL Database
- Select Azure SQL DB server
- Select **Show firewall settings**
- Create a firewall rule to allow the 2012 SQL server client IP
- Get the SQL 2012 VM IP address from the portal

<img src="./images/Azure-SQL2012-VM-PublicIP.PNG" alt="SQL 2012 VM Public IP address" Width="900">

- Enter the SQL 2012 VM IP address as the Start and End IP Range. You are giving access to only one server.

<img src="./images/Azure-SQL-DB-Server-Firewall-ClientAccess.PNG" alt="Firewall rule to provide to access SQL 2012 DB client" Width="800">

- Enter the Azure SQL DB database info
- Server Name: Paste the name from the portal
- Authentication type: Select **SQL Server Authentication**
- Username: Enter 'azuresqladmin'
- Password: Enter 'Atasql2012admin'
- Encrypt connection: uncheck the box
- Trust server certificate: uncheck the box
- Click on 'Connect'
- Select the database and click on **Next**

<img src="./images/Azure-Migrate-Target-db-Info.PNG" alt="DMA Migrate Target DB" Width="800">

5. Select Objects for migration
- Check the following boxes for migration
- **Schemas**
- **Stored Procedures**
- **Tables**
- Click on **Generate SQL Script**

<img src="./images/Azure-Migrate-Schema-Select-Objects.PNG" alt="Azure Migrate select objects" Width="800">

6. Verify the tables and schema in Azure SQL DB.
- Search for SQL Databases and select the database.
- Select **Query editor**.

<img src="./images/Azure-SQL-DB-QueryEditor-Select.PNG" alt="Azure SQL DB Query Editor" Height="300">

- Enter the password
- Expand Tables & Schema and verify everything is empty

<img src="./images/Azure-SQL-DB-Tables-Empty.PNG" alt="Azure SQL DB Empty tables" Width="800">

7. Deploy Schema 
- Save the SQL script for reference
- Click on **Deploy schma**

<img src="./images/Azure-Migrate-Schema-Deploy-Schema.PNG" alt="DMA Migrate schema deploy" Width="800">

8. Wait till it complete its run. Verify errors.

<img src="./images/DMA-Schema-Migrate-Deploy-Complete.PNG" alt="DMA Schema migrate deploy complete" Width="800">

9. Verify the table creation in Azure SQL DB.
- Access the Azure SQL DB 
- Select the **Query editor**
- Expand the **Tables**
- Run a query to see if you have any data

<img src="./images/DMA-Migration-Schema-Complete.PNG" alt="Verify Schema Migration" Width="800">

9. You are successfully migrated the SQL 2012 DB schema to Azure SQL DB.

### Task-6: Migrate SQL2012 Table Data to Azure SQL DB using DMA

1. Create a new migration for migrating the data to Azure SQL DB.
2. Enter the following info:
- Project type: Select **Migration**
- Project name: Enter 'ata-sql2012-to-AzureSQLDB-Data'
- Source server type: **SQL Server**
- Targent server type: **Azure SQL Database**
- Migration scope: **Data only**
- Click on **Create**

<img src="./images/DMA-Migrate-Data-Project.PNG" alt="DMA Migrate Data Project" Width="200">

3. Provide the source and the target database info. Same info used in the Schema migrate task.

4. Select **Next** to reach 'Select Tables' section

5. Make sure all the tables were selected and click on **Start data migration**

<img src="./images/DMA-Data-Migrate-Select-All-Tables.PNG" alt="DMA Data Migration Select all Tables" Width="950">

6. Watch the data migration progress and monitor the warnings and errors list.

7. Make sure it successfully migrated the data to all tables.

<img src="./images/DMA-Data-Migration-Complete.PNG" alt="DMA Data Migration complete" Width="950">

8. Verify the data in Azure SQL DB
- Search for 'SQL Databases' and Access you Azure SQL DB.
- Select the 'Query Editor' and enter the username and password
- Select HumanResources.Employee table and select top 1000 row option. You will see all the data in the table. Verify few other tables.

<img src="./images/Azure-SQL-DB-Data-Migrate-Verify.PNG" alt="Azure SQL DB Data verification" Width="800">

9. You successfully migrated the SQL 2012 database to Azure SQL PaaS Database. Pat yourself on your back!! Great Job!!

10. You can migrate 1000's of databases using powershell scripts. Please reach us if you need help on this. 