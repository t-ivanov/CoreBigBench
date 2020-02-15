
use bigbenchv2;

DROP TABLE IF EXISTS JOIN_RESULT_CoLocated;
CREATE TABLE JOIN_RESULT_CoLocated
  ( ss_item_id           	  bigint              --not null
  ,ss_quantity                int
  ,pr_review_id               bigint	     	   		   
    )
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

INSERT INTO TABLE JOIN_RESULT_CoLocated 
SELECT ss.ss_item_id AS ss_item_id,
ss.ss_quantity AS ss_quantity,
pr.pr_review_id AS pr_review_id
FROM store_sales_part ss 
INNER JOIN product_reviews_part pr 
ON ss.ss_item_id = pr.pr_item_id
;


-- Time taken: 448.05 seconds


-- Explain
-- == Physical Plan ==
-- Execute InsertIntoHiveTable InsertIntoHiveTable `bigbenchv2`.`join_result_colocated`, org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe, false, false, [ss_item_id#18L, ss_quantity#16, pr_review_id#19L]
-- +- *(3) Project [ss_item_id#18L, ss_quantity#16, pr_review_id#19L]
--   +- *(3) SortMergeJoin [ss_item_id#18L], [pr_item_id#23L], Inner
--      :- *(1) Sort [ss_item_id#18L ASC NULLS FIRST], false, 0
--      :  +- Exchange hashpartitioning(ss_item_id#18L, 200)
--      :     +- HiveTableScan [ss_quantity#16, ss_item_id#18L], HiveTableRelation `bigbenchv2`.`store_sales_part`, org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe, [ss_transaction_id#13L, ss_store_id#14L, ss_customer_id#15L, ss_quantity#16, ss_ts#17], [ss_item_id#18L], [isnotnull(ss_item_id#18L)]
--      +- *(2) Sort [pr_item_id#23L ASC NULLS FIRST], false, 0
--         +- Exchange hashpartitioning(pr_item_id#23L, 200)
--            +- HiveTableScan [pr_review_id#19L, pr_item_id#23L], HiveTableRelation `bigbenchv2`.`product_reviews_part`, org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe, [pr_review_id#19L, pr_ts#20, pr_rating#21, pr_content#22], [pr_item_id#23L], [isnotnull(pr_item_id#23L)]
-- Time taken: 0.523 seconds, Fetched 1 row(s)
