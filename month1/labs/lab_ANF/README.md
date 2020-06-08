# Azure Trailblazer Academy Azure Net App Files Storage Lab
## Overview
## Access Data in Azure  with Azure NetApp Files
The Azure NetApp Files service is an enterprise-class, high-performance, file storage service. Azure NetApp Files supports any workload type and is highly available by default. You can select service and performance levels and set up snapshots through the service.
### Labs:
- [Lab-1: Register ANF Service](#lab-1-Register-ANF-service)
- [Lab-2: Provision a Pool and Volume to Contain Your Data](#lab-2-Provision-Capacity)



## Lab-1: Setup the Azure NetApp Files Service 
### Step-1: Register the ANF Service
- Login to Azure Portal (https://portal.azure.com) 

### Step-2: Create ANF Storage account
- In the Azure portal’s search box, enter Azure NetApp Files and then select Azure NetApp Files from the list that appears.
<img src="./images/Storage-Account.png" width="400">

### Step-3: Click **+ Add** to create a new NetApp account
<img src="./images/Add-Account.png" width="400">

### Step-4: Enter the Info Below
In the New NetApp Account window, provide the following information:

<img src="./images/Account-Info.png" alt="Enter Account Info" width="400">

Enter **myaccount1** for the account name.

Select your subscription.


Select Create new to create new resource group. 

<img src="./images/Resource-Group.png" alt="Create RG" width="400">

Enter **Ata-labname-username-RG** for the resource group name. Click OK.


Select your account location.
 then 
 
Hit **Create** button.



## Lab-2: Provision a Pool and Volume to Contain Your Data

### Step-1: Provision a Capacity Pool to Contain Your Volumes

From the Azure NetApp Files management blade, select your NetApp account (**myaccount1**)
<img src="./images/Myaccount1.png" alt="Select Account" width="400">

From the Azure NetApp Files management blade of your NetApp account, click **Capacity pools**
<img src="./images/Select-Capacity-Pool.png" alt="Select Capacity Pool" width="400">

Click **+ Add pools**
<img src="./images/Create-Capacity-Pool.png" alt="Create Capacity Pool" width="400">

Provide information for the capacity pool:

Enter **mypool1** as the pool name

Select **Premium** for the service level

Specify **4** (TiB) as the pool size

Click **OK**

###Step-2: Create a NFS Volume to Conatin Your Data

From the Azure NetApp Files management blade of your NetApp account, click **Volumes**
<img src="./images/Select-Volume.png" alt="Select Volume" width="400">

Click **+ Add volume**
<img src="./images/Add-Volume.png" alt="Add Volume" width="400">


In the Create a Volume window, provide information for the volume:


Enter **myvol1** as the volume name.

Select your capacity pool (**mypool1**)

Use the **default value** for quota.


Under **virtual network**, click **Create new** to create a new Azure virtual network (Vnet). 

<img src="./images/Create-VNet.png" alt="Create VNet" width="400">


Then fill in the following information:

Enter **myvnet1** as the Vnet name

Specify an address space for your setting, for example, **10.7.0.0/16**

Enter **myANFsubnet** as the subnet name

Specify the subnet address range, for example, **10.7.0.0/24**

Select **Microsoft.NetApp/volumes** for subnet delegation

Click **OK** to create the Vnet.


Click **Protocol**, from the Top Selection 
<img src="./images/Protocol.png" alt="Protocol" width="400">

Select **NFS** as the protocol type for the volume

Enter **myfilepath1** as the file path that will be used to create the export path for the volume

Select the NFS version **NFSv3**


Click the **Review + Create Buttom** at the bottom
<img src="./images/Review-Create.png" alt="Review+Create" width="400">


Finally Click the **Create Button**
<img src="./images/Create-Volume.png" alt="Create Volume" width="400">


