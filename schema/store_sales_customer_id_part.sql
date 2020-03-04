
use bigbenchv2;

DROP TABLE IF EXISTS store_sales_part_customer_id;
CREATE EXTERNAL TABLE store_sales_part_customer_id
  (ss_transaction_id          bigint              --not null
  , ss_store_id               bigint	   
  , ss_item_id     	   		   bigint
  , ss_quantity				   int
  , ss_ts					   string
    )
PARTITIONED by (ss_customer_id bigint)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
;

SET hive.mapred.mode = nonstrict;
SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;
set hive.exec.max.dynamic.partitions=105000; 
set hive.exec.max.dynamic.partitions.pernode=105000; 
SET hive.exec.max.created.files=105000;


INSERT OVERWRITE TABLE store_sales_part_customer_id PARTITION(ss_customer_id)
SELECT ss_transaction_id,ss_store_id,ss_item_id,ss_quantity,ss_ts,ss_customer_id
FROM store_sales 
DISTRIBUTE BY ss_customer_id;
