'use strict';

if (process.env.NODE_ENV !== 'production') {
  require('dotenv').config();
}

var jsforce = require('jsforce');

const rq = require('request')
const crypto = require('crypto')
const util = require('util')

var conn = new jsforce.Connection({
  // you can change loginUrl to connect to sandbox or prerelease env.
  loginUrl : 'https://login.salesforce.com'
});



module.exports={
 
  
  /*
  *  Attempt to connect to sales force instance
  */

   connect2SF: function () {
            

      conn.login(process.env.SF_USERNAME, process.env.SF_PASSWORD, function(err, userInfo) {

          if (err) { 
            console.log(err); 
            return err;
          }

          // Now you can get the access token and instance URL information.
          // Save them to establish connection next time.
          console.log(conn.accessToken);              // Salesforce returns a token key
          console.log(conn.instanceUrl);
          // logged in user property
          console.log("User ID: " + userInfo.id);
          console.log("Org ID: " + userInfo.organizationId);
         
        });
        return 'Connected'
   },

};




