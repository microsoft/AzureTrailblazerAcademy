# Hands-on lab to Migrate SQL database to Azure (step-by-step)
##Objective
In this hands-on lab, you will migrate 2012 SQL database to Azure PaaS SQL database. You will also apply data security for business critical applications.
### Task-1: Create Virutal Machine with 2012 SQL database
- 1. Navigate to the [Azure portal](https://portal.azure.com) and select **Resource groups** from the Azure services list.

<img src="./images/azure-services-resource-groups.png " alt="Resource groups is highlighted in the Azure services list" Width="300">

- 2. Create Resource group by selecting 'add'
- Enter 'ata-sql-lab-<name>' as the Resource group
- Select 'East US' as the Region
- Click on 'Review + Create' button
- Make sure the validation is passed before clicking on 'Create' button.

<img src="./images/resource-group-create.PNG" alt="Resource Group Create" Width="300">

-3. Create Virutal Machine 
- Select 'goto resource' to go resource group
- Select 'add' and search for 'SQL Server 2012 SP4'
- Click on 'Create'
<img src="./images/sql-server-vm-create.PNG" alt="Create SQL server VM" Width="300">
-4. Enter configuration
- Make sure you have the correct resource group selected
- Virtual machine name:'ata-sql-2012-<two letter initial>
- Region: 'East US'
- Size: Standard_DS12_V2-4 vcpus, 28 Gib Memory(DropDown Selection)
- Username: AzureUser (Keep the Default)
- Password: Atasql2012user (Use this to avoid password issues)
- Select inbound ports: RDP(3389) (We need this to access this VM remotely)
- Click on 'SQL Server settings' tab
- Enable SQL Authentication 
- Enter SQL Login name:'sqladmin'
- Enter password:'Atasql2012admin'
<img src="./images/SQL-VM-Admin-User.PNG" alt="SQL Server Admin Login" Width="300">
- Rest are default options
- Click on 'Review + create' button
<img src="./images/SQL-VM-Configuration-full.PNG" alt="SQL VM configuration setup" Width="700">
### Task-2: Resort AdventureWorks database from a backup
- Select 'Go to resource' to go to Virtual Machine server config
- Select 'Connect' and 'RDP' 
- Click on 'Download RDP File'
- Click on 'Connect'
<img src="./images/SQL-VM-RDP-Connect.PNG" alt="Remote Desktop connect" Width="300">
- 'Enter your credentials popup'
- Select 'Use a different account'
- Enter user name as 'azureuser'
- Enter the password ('Atasql2012user')
- Open 'Server Manager' if not open
- Select 'Local Server' 
- Find 'IE Enhanced Security Configuration' and Turn 'Off' 
- It is not recommended but to avoid internet issues. Please turn On after the download.
<img src="./images/SQL-VM-turn-off-IE.PNG" alt="Turn off IE browser Security" Width="600">

- Open Internet Explorer browser and access [SQL 2012 Backup](https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks)
- Select 'AdventureWorks2012.bak' under "AdventureWorks (OLTP) full database backups" section

<img src="./images/SQL-2012-Backup-download.PNG" alt="SQL 2012 Database backup" Width="300">
- Download the backup file to local "c:\Data" folder

### Task-3: Install Data Migration Assistant
### Task-4: 