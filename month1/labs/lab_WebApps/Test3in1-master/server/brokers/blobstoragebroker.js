'use strict';

if (process.env.NODE_ENV !== 'production') {
  require('dotenv').config();
}

const path = require('path');
const storage = require('azure-storage');

const blobService = storage.createBlobService();

const listContainers = async () => {
    return new Promise((resolve, reject) => {
        blobService.listContainersSegmented(null, (err, data) => {
            if (err) {
                reject(err);
            } else {
                resolve({ message: `${data.entries.length} containers`, containers: data.entries });
            }
        });
    });
};


module.exports={
 
  
    /*
    *  Get a list of all my containers
    */
  
     connect2BS: function () {
              

        if (blobService == null) {
            return 'failed to connect';
        }
        else  return 'Success';
        
          
     },
  
  };
