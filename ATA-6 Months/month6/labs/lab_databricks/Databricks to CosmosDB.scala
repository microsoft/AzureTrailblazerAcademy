// Databricks notebook source
// Configure the connection to your collection in Cosmos DB.
// Spark connector does not support Spark 3 runtime yet, use Spark 2 runtime for the cluster
// Download Cosmos DB Spark Jar to your local drive then install it as a library for the cluster: https://github.com/Azure/azure-cosmosdb-spark
// Example notebook can be found here: https://docs.databricks.com/data/data-sources/azure/cosmosdb-connector.html
// Please refer to https://github.com/Azure/azure-cosmosdb-spark/wiki/Configuration-references for configuration details

import org.joda.time._
import org.joda.time.format._

import com.microsoft.azure.cosmosdb.spark.schema._
import com.microsoft.azure.cosmosdb.spark.CosmosDBSpark
import com.microsoft.azure.cosmosdb.spark.config.Config

import org.apache.spark.sql.functions._

// COMMAND ----------

// Create an Azure key vault backed secret scope
// https://docs.microsoft.com/en-us/azure/databricks/security/secrets/secret-scopes#azure-key-vault-backed-scopes
// https://<databricks-instance>#secrets/createScope. This URL is case sensitive; scope in createScope must be uppercase.

val secret_Scope = "demodbkeyvault1"  // This is the name of the Secret Scope (not necessarily the same as the Key Vault name)
val secret_CosmosKey = "awhotelcosmosdbkey" // This is the secret name that represents the Cosmos DB master key

val configMap = Map(
  "Endpoint" -> "https://awhotelcosmosdbcj.documents.azure.com:443/",
  "Masterkey" -> dbutils.secrets.get(scope = secret_Scope, key = secret_CosmosKey), 
  "Database" -> "awhotels",
  "Collection" -> "messagestore",
  "preferredRegions" -> "eastus2")
val config = Config(configMap)

// COMMAND ----------

// Read the data from Cosmos DB into a data frame
val dataInCosmosDb = spark.sqlContext.read.cosmosDB(config)
display(dataInCosmosDb.orderBy(col("createDate")))

// COMMAND ----------

// CreateOrReplaceTempView will create a temporary view on memory, it is not presistant at this moment but you can run sql query against it.
dataInCosmosDb.createOrReplaceTempView("messagestore")

// COMMAND ----------

// MAGIC %sql
// MAGIC select  createDate, username, messageType, message, score, sessionid from messagestore where messageType <>'join' and username <> 'HotelLobby' order by createDate 

// COMMAND ----------

// MAGIC %sql
// MAGIC select  createDate, username, messageType, message, score, sessionid from messagestore where messageType <>'join' and username <> 'HotelLobby' and score > -1 and instr(message,'weather')>0 order by createDate 

// COMMAND ----------

// Generate a few new messages from the existing messages
val dataOutCosmosDb = spark.sql("select message, '2020-11-10' as createDate, username, sessionid, messageId, 'UpdatedChat' as messageType, score, EventProcessedUtcTime, PartitionId, EventEnqueuedUtcTime from messagestore where messageType <>'join' and username <> 'HotelLobby' and score > -1 and instr(message,'weather')>0")

// COMMAND ----------

display(dataOutCosmosDb)

// COMMAND ----------

// Write data back to Cosmos DB
val configMap = Map(
  "Endpoint" -> "https://awhotelcosmosdbcj.documents.azure.com:443/",
  "Masterkey" -> dbutils.secrets.get(scope = secret_Scope, key = secret_CosmosKey), 
  "Database" -> "awhotels",
  "Collection" -> "messagestore",
  "preferredRegions" -> "eastus2")
val config = Config(configMap)
CosmosDBSpark.save(dataOutCosmosDb, config)
