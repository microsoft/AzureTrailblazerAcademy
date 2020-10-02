'use strict';

if (process.env.NODE_ENV !== 'production') {
  require('dotenv').config();
}

let results;
const mssql = require('mssql')

        
const config = {
    user: process.env.SQL_USERNAME,
    password: process.env.SQL_PASSWORD,
    server: process.env.SQL_SERVER, 
    database: process.env.SQL_DATABASE,
    encrypt: true // use this for Azure database encryption
}


module.exports={
 
    /*
    *  Execute a sql query and return response to the called
    */
   connect2SQLServer: function  (query,res) {
       
        
        console.log('Query:' + query);
        
        mssql.connect(config, function (err) {

            if (err) {console.log(err); res.send(err); return;}
            let sqlRequest = new mssql.Request();

            sqlRequest.query(query, function (err,data) {
                console.log(data);
                let results = JSON.stringify(data);
                mssql.close();
                res.send(results);
            });
        });
       
       
    }

};
