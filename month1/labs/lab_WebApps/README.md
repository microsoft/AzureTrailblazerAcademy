# Azure WebApp Lab  (UNDER CONSTRUCTION. DO NOT WORK HERE --ROBIN GHOSH-- )

## Prerequisites

- Microsoft Azure subscription
- 
- Resource Group to deploy Azure services
- Permissions to create the following resource  
    - App Service Plan
    - Blob Storage


## Step 1: Create a Resource Group
1. In the Azure Portal, search for **Resource Groups**
2. Click on the **Add** button
3. Fill out the **Basics** tab as follows:
- **Subscription:** Choose your subscription
- **Resource group:** Provide a unique name like **<initial>-ata-rg
- **Region:** EastUS

![RG Basic Tab](images/rg-basics.jpg)  

4. Click the **Next: Review + Create** button
5. Click the **Create** button

## Step 2: Create a App Service Plan
1. In the Azure Portal, search for **App Service Plan**
2. Click on the **Create** button
3. Fill out the **Basics** tab as follows:
- **Subscription:** Choose your subscription
- **Resource group:** Select the Resource Group you created for this lab
- **Region:** East US
- **App Servie Name:** Choose a unique name for the App Service
- **Pricing tier:** Premium V2

![App Service Basic Tab](images/app-service-create.JPG)

4. Click the **Review + create** button

![App Service Basic Tab](images/app-service-create-final.JPG)

5. Click the **Create** button


## Step 3: Add a Web App using your App Service Plan
1. In the Azure Portal, search for **App Services**
2. From the left menu, click on **App Services** under **Explorers**, then click **+ Add**

3. Fill out the **Basics** tab as follows:
- **Subscription:** Choose your subscription
- **Resource group:** Select the Resource Group you created for this lab
- **Region:** East US
- **Name:** Choose a unique name for the Web App
- **Publish** Code
- **Runtime Stack:** Select the Resource Group you created for this lab
- **Operating System:** East US
- **App Service Plan:** Select the App Service Plan created earlier

![Web Service Basic Tab](images/webapp-create.JPG)

4. Click the **Review + create** button

![Web Service Basic Tab](images/webapp-create-final.JPG)

5. Click the **Create** button

You should see a progress bar and underway screen

![Web Service Basic Tab](images/webapp-underway.JPG)

This screen will transition to deployed 

## Step 4: Go to your newly created Web App
1. In the Azure Portal, search for **App Services**
2. From the left menu, click on **App Services** under **Explorers**, find your webapp and then click ** on your new web app**
   OR
   You have an option to go through the top Notifications and select **Deployment Succeeded** message and click on **Go to resource**
   
3. You should be on the new web app:

![Web Service Basic Tab](images/webapp-goto.JPG)

![Web Service Basic Tab](images/webapp-happy.JPG)
   Make sure you see a Happy Page by clicking on the **url link of the web app**



  YEAH
