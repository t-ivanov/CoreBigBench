
use bigbenchv2;


DROP TABLE IF EXISTS JOIN_RESULT;
CREATE TABLE JOIN_RESULT
  ( ss_item_id           	  bigint              --not null
  ,ss_quantity                int
  ,pr_review_id               bigint	     	   		   
    )
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

INSERT INTO TABLE JOIN_RESULT 
SELECT ss.ss_item_id AS ss_item_id,
ss.ss_quantity AS ss_quantity,
pr.pr_review_id AS pr_review_id
FROM store_sales ss 
INNER JOIN product_reviews_part pr 
ON ss.ss_item_id = pr.pr_item_id
;

-- Time taken: 356.016 seconds

-- Explain

-- == Physical Plan ==
-- Execute InsertIntoHiveTable InsertIntoHiveTable `bigbenchv2`.`join_result`, org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe, false, false, [ss_item_id#22L, ss_quantity#23, pr_review_id#25L]
-- +- *(4) Project [ss_item_id#22L, ss_quantity#23, pr_review_id#25L]
--   +- *(4) SortMergeJoin [ss_item_id#22L], [pr_item_id#29L], Inner
--      :- *(2) Sort [ss_item_id#22L ASC NULLS FIRST], false, 0
--      :  +- Exchange hashpartitioning(ss_item_id#22L, 200)
--      :     +- *(1) Filter isnotnull(ss_item_id#22L)
--      :        +- HiveTableScan [ss_item_id#22L, ss_quantity#23], HiveTableRelation `bigbenchv2`.`store_sales`, org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe, [ss_transaction_id#19L, ss_customer_id#20L, ss_store_id#21L, ss_item_id#22L, ss_quantity#23, ss_ts#24]
--      +- *(3) Sort [pr_item_id#29L ASC NULLS FIRST], false, 0
--         +- Exchange hashpartitioning(pr_item_id#29L, 200)
--            +- HiveTableScan [pr_review_id#25L, pr_item_id#29L], HiveTableRelation `bigbenchv2`.`product_reviews_part`, org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe, [pr_review_id#25L, pr_ts#26, pr_rating#27, pr_content#28], [pr_item_id#29L], [isnotnull(pr_item_id#29L)]
-- Time taken: 0.399 seconds, Fetched 1 row(s)
