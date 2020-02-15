
-- execution: login as hdfs user
-- sudo su
-- su hdfs


-- set the table format
-- supported are TEXTFILE, RCFILE, ORC, SEQUENCEFILE, PARQUET, AVRO
--set tableFormat=ORC;

-- set additional variables
--set temporaryTableSuffix=_temporary;
--set hdfsDataPath=/bigbenchv2/data;
--set fieldDelimiter=|;


--set store_salesTableName=store_sales_orc;


use bigbenchv2;

-- create table store_sales
DROP TABLE IF EXISTS store_sales_temporary;
CREATE EXTERNAL TABLE store_sales_temporary
  ( ss_transaction_id          bigint              --not null
  , ss_customer_id             bigint
  , ss_store_id				   bigint
  , ss_item_id     	   		   bigint
  , ss_quantity				   int
  , ss_ts					   string
  )
  ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
  STORED AS TEXTFILE LOCATION '/user/user1/semibench/data/store_sales'
;

!echo Load text data into ORC table:store_sales_orc;
DROP TABLE IF EXISTS store_sales_orc;
CREATE TABLE IF NOT EXISTS store_sales_orc
STORED AS ORC TBLPROPERTIES ("orc.compress"="NONE")
AS
SELECT * FROM store_sales_temporary
;

!echo Drop temporary table: store_sales_temporary;
DROP TABLE IF EXISTS store_sales_temporary;