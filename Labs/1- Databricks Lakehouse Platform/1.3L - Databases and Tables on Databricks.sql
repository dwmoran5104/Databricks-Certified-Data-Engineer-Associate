-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## Lab: Databases and Tables on Databricks

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Q1 - Creating managed table
-- MAGIC
-- MAGIC In the default database, create a managed table named **movies_managed** that has the following schema:
-- MAGIC
-- MAGIC
-- MAGIC | Column Name | Column Type |
-- MAGIC | --- | --- |
-- MAGIC | title | STRING |
-- MAGIC | category | STRING |
-- MAGIC | length | FLOAT |
-- MAGIC | release_date | DATE |

-- COMMAND ----------

create table movies_managed
  (title STRING, category string, length float, release_date date)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Review the extended metadata information of the table, and verify that:
-- MAGIC 1. The table type is Managed
-- MAGIC 1. The table is located under the default hive directory

-- COMMAND ----------

DESCRIBE EXTENDED movies_managed

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Q2 - Creating external table
-- MAGIC
-- MAGIC In the default database, create an external Delta table named **actors_external**, and located under the directory:
-- MAGIC **dbfs:/mnt/demo/actors_external**
-- MAGIC
-- MAGIC The schema for the table:
-- MAGIC
-- MAGIC | Column Name | Column Type |
-- MAGIC | --- | --- |
-- MAGIC | actor_id | INT |
-- MAGIC | name | STRING |
-- MAGIC | nationality | STRING |

-- COMMAND ----------

create external table actors_external 
(actor_id int, name string, nationality string)
location 'dbfs:/mnt/demo/actors_external'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Q4- Checking table metadata
-- MAGIC
-- MAGIC Review the extended metadata information of the table, and verify that:
-- MAGIC 1. The table type is External
-- MAGIC 1. The table is located under the directory: **dbfs:/mnt/demo/actors_external**

-- COMMAND ----------

DESCRIBE EXTENDED actors_external

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Q3- Dropping manged table
-- MAGIC
-- MAGIC Drop the manged table **movies_managed** 

-- COMMAND ----------

drop table movies_managed

-- COMMAND ----------

-- MAGIC %fs ls 'dbfs:/user/hive/warehouse/movies_managed'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Check that the directory of the managed table has been deleted
-- MAGIC

-- COMMAND ----------

-- MAGIC %fs ls 'dbfs:/user/hive/warehouse/actors_external'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Q4- Drop external table
-- MAGIC
-- MAGIC Drop the external table **actors_external** 

-- COMMAND ----------

DROP TABLE actors_external

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Check that the directory of the external table has **Not** been deleted

-- COMMAND ----------

-- MAGIC %fs help

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.fs.rm('dbfs:/mnt/demo/actors_external/', True)

-- COMMAND ----------



-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Q5- Creating new schema
-- MAGIC
-- MAGIC Create a new schema named **db_cinema**

-- COMMAND ----------

create schema db_cinema

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC Review the extended metadata information of the database, and verify that the database is located under the default hive directory.
-- MAGIC
-- MAGIC Note that the database folder has the extenstion **.db**

-- COMMAND ----------

DESCRIBE schema EXTENDED db_cinema

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC Use the new schema to create the below **movies** table

-- COMMAND ----------

use db_cinema;


CREATE TABLE movies
  (title STRING, category STRING, length INT, release_date DATE);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Q6- Creating new schema in custom location
-- MAGIC
-- MAGIC Create a new schema named **cinema_custom** in the directory: **dbfs:/Shared/schemas/cinema_custom.db**

-- COMMAND ----------

create schema cinema_custom
location 'dbfs:/Shared/schemas/cinema_custom.db'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Use the new schema to create the below **movies** table

-- COMMAND ----------

USE cinema_custom;

CREATE TABLE movies
  (title STRING, category STRING, length INT, release_date DATE);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Finally, review the extended metadata information of the table **movies**, and verify that:
-- MAGIC
-- MAGIC 1. The table type is Managed
-- MAGIC 1. The table is located in the new database defined under the custom location

-- COMMAND ----------

DESCRIBE EXTENDED movies
