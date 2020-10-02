var express = require('express');
var brokerSF = require('./server/brokers/salesforcebroker');
var brokerBS = require('./server/brokers/blobstoragebroker');
var brokerDS = require('./server/brokers/sqlserverbroker');


var sf,bs,ds = '';

var app = express();

app.get('/', async function (req, res) {
   console.log(req.query.sql);
   res.send('Salesforce: ' + sf + ',Blob Storage: ' + bs + ',SQL-Server:' +  'To test SQL use /run?sql=select * from table');
});

app.get('/run', async function (req, res) {
   console.log('Query=' + req.query.sql);
   brokerDS.connect2SQLServer(req.query.sql,res);
})

var port = process.env.PORT || 3000;

var server = app.listen(port, function () {
   var host = server.address().address
   var port = server.address().port

   console.log('Setting up listener now on port ', port);
   
   console.log("Example app listening at http://%s:%s", host, port)

   
   bs = brokerBS.connect2BS();
   
   sf = brokerSF.connect2SF();

   //ds = brokerDS.connect2SQLServer();

})
