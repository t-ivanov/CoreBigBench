
use bigbenchv2;

DROP TABLE IF EXISTS product_reviews_part;
CREATE EXTERNAL TABLE product_reviews_part
  (pr_review_id              bigint              --not null
  , pr_ts           		  string
  , pr_rating				  int
  , pr_content			      string
    )
PARTITIONED by (pr_item_id bigint)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
;

SET hive.mapred.mode = nonstrict;
SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;
set hive.exec.max.dynamic.partitions=2320; 
set hive.exec.max.dynamic.partitions.pernode=2320; 

INSERT OVERWRITE TABLE product_reviews_part PARTITION(pr_item_id)
SELECT pr_review_id,pr_ts,pr_rating,pr_content,pr_item_id 
FROM product_reviews
DISTRIBUTE BY pr_item_id;
