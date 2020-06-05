Tutorial: Build a Node.js and MongoDB app in Azure
05/04/2017
15 minutes to read
     +3
 Note

This article deploys an app to App Service on Windows. To deploy to App Service on Linux, see Build a Node.js and MongoDB app in Azure App Service on Linux.

Azure App Service provides a highly scalable, self-patching web hosting service. This tutorial shows how to create a Node.js app in App Service and connect it to a MongoDB database. When you're done, you'll have a MEAN application (MongoDB, Express, AngularJS, and Node.js) running in Azure App Service. For simplicity, the sample application uses the MEAN.js web framework.

MEAN.js app running in Azure App Service

What you'll learn:

Create a MongoDB database in Azure
Connect a Node.js app to MongoDB
Deploy the app to Azure
Update the data model and redeploy the app
Stream diagnostic logs from Azure
Manage the app in the Azure portal
If you don't have an Azure subscription, create a free account before you begin.

Prerequisites
To complete this tutorial:

Install Git
Install Node.js and NPM
Install Bower (required by MEAN.js)
Install Gulp.js (required by MEAN.js)
Install and run MongoDB Community Edition
Test local MongoDB
Open the terminal window and cd to the bin directory of your MongoDB installation. You can use this terminal window to run all the commands in this tutorial.

Run mongo in the terminal to connect to your local MongoDB server.

Bash

Copy
mongo
If your connection is successful, then your MongoDB database is already running. If not, make sure that your local MongoDB database is started by following the steps at Install MongoDB Community Edition. Often, MongoDB is installed, but you still need to start it by running mongod.

When you're done testing your MongoDB database, type Ctrl+C in the terminal.

Create local Node.js app
In this step, you set up the local Node.js project.

Clone the sample application
In the terminal window, cd to a working directory.

Run the following command to clone the sample repository.

Bash

Copy
git clone https://github.com/Azure-Samples/meanjs.git
This sample repository contains a copy of the MEAN.js repository. It is modified to run on App Service (for more information, see the MEAN.js repository README file).

Run the application
Run the following commands to install the required packages and start the application.

Bash

Copy
cd meanjs
npm install
npm start
When the app is fully loaded, you see something similar to the following message:

--
MEAN.JS - Development Environment

Environment:     development
Server:          http://0.0.0.0:3000
Database:        mongodb://localhost/mean-dev
App version:     0.5.0
MEAN.JS version: 0.5.0
--
Navigate to http://localhost:3000 in a browser. Click Sign Up in the top menu and create a test user.

The MEAN.js sample application stores user data in the database. If you are successful at creating a user and signing in, then your app is writing data to the local MongoDB database.

MEAN.js connects successfully to MongoDB

Select Admin > Manage Articles to add some articles.
