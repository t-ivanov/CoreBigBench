
use bigbenchv2;

DROP TABLE IF EXISTS product_reviews_part_pr_review_id;
CREATE EXTERNAL TABLE product_reviews_part_pr_review_id
  ( pr_item_id				 bigint	
  , pr_review_id			 bigint
  , pr_ts           		  string
  , pr_content			      string
    )
PARTITIONED by (pr_rating int)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
;

SET hive.mapred.mode = nonstrict;
SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;
set hive.exec.max.dynamic.partitions=105000; 
set hive.exec.max.dynamic.partitions.pernode=105000; 
SET hive.exec.max.created.files=105000;

INSERT OVERWRITE TABLE product_reviews_part_pr_review_id PARTITION(pr_rating)
SELECT pr_item_id,pr_ts,pr_rating,pr_content,pr_review_id
FROM product_reviews
DISTRIBUTE BY pr_rating;
