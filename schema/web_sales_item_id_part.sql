
use bigbenchv2;

DROP TABLE IF EXISTS web_sales_part;
CREATE EXTERNAL TABLE web_sales_part
  (ws_transaction_id           bigint              --not null
  , ws_customer_id             bigint
  , ws_quantity				   int
  , ws_ts					   string
    )
PARTITIONED by (ws_item_id bigint)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
;

SET hive.mapred.mode = nonstrict;
SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;
set hive.exec.max.dynamic.partitions=2320; 
set hive.exec.max.dynamic.partitions.pernode=2320; 

INSERT OVERWRITE TABLE web_sales_part PARTITION(ws_item_id)
SELECT ws_transaction_id,ws_customer_id,ws_quantity,ws_ts,ws_item_id 
FROM web_sales
DISTRIBUTE BY ws_item_id;
