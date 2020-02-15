
use bigbenchv2;

DROP TABLE IF EXISTS store_sales_part;
CREATE EXTERNAL TABLE store_sales_part
  (ss_transaction_id           bigint              --not null
  , ss_store_id 			   bigint
  , ss_customer_id             bigint	     	   		   
  , ss_quantity				   int
  , ss_ts					   string
    )
PARTITIONED by (ss_item_id bigint)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
;

SET hive.mapred.mode = nonstrict;
SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;
set hive.exec.max.dynamic.partitions=2320; 
set hive.exec.max.dynamic.partitions.pernode=2320; 

INSERT OVERWRITE TABLE store_sales_part PARTITION(ss_item_id)
SELECT ss_transaction_id,ss_store_id,ss_customer_id,ss_quantity,ss_ts,ss_item_id 
FROM store_sales
DISTRIBUTE BY ss_item_id;
