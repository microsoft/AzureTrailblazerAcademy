# Program demonstrates connecting to Sales Force, Azure Bob Storage and Azure SQL Server


Here are some configuration variables that is required for this program to run. First 3 variables are important. The SQL variables are not mandatory, but would be required if you want to test SQL using **website/run?query=select * from table**
    
<BR>
SF_USERNAME=<Sales Force User ID><BR>
SF_PASSWORD=<Sales Force password><BR>
AZURE_STORAGE_CONNECTION_STRING=<KEY FROM YOUR BLOB STORAGE>
SQL_USERNAME=<your username>
SQL_PASSWORD=<your password>
SQL_DATABASE=<your db>
SQL_SERVER=<your server name>.database.windows.net
    

To test locally, you need the set the above variables in a .env file, then use
    
    npm install
    npm start OR node server.js

To deploy to Azure, create a App Service Plan, crank up a blank Web App using Windows/NodeJS LTS 12settings of the App Service.
Make sure your website renders with a Microsoft Developer page.
Go to the App Settings and add these 7 variables. Then go to the Deployment Center and pull this repository using the 4 steps of CI/CD. Make sure you go via External option. You also have a choice to pull the code to your local workbench and then use the Publish option from VSC or AZ CLI to push this application onto the newly created App Service.

When you access the website, if everything is good it should display
SAlesforce: Connected, Blob Storage: Success, SQL Server: To test SQL use /run?SQL=select * from yourtable

To test SQL, Run <website.azurewebsites.net/run?sql=select * from yourtable

**To pull the latest code into your existing web app. Follow these steps** 

Go to **Deployment Center** and then use the **Sync** button on your right to repull the code again.
    This should download the latest code and republish your app.

Give it 30 seconds. Go back to the website. Verify it shows **To test SQL user /run?sql=select * from table** This is a must.

To test SQL, Run <website.azurewebsites.net/run?sql=select * from yourtable 

Hope this works!

