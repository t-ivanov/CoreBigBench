
-- relational Window function

use bigbenchv2;


SELECT ss_customer_id, ss_transaction_id, ss_ts, ss_item_id, 
ROW_NUMBER() OVER (PARTITION BY ss_customer_id, ss_transaction_id ORDER BY ss_item_id)
FROM store_sales;

-- Time taken: 41.607 seconds, Fetched: 4617860 row(s)


-- LIMIT 1000;
-- Time taken: 12.397 seconds, Fetched 1000 row(s)


-- explain
-- == Physical Plan ==
-- CollectLimit 1000
-- +- *(2) LocalLimit 1000
--   +- Window [row_number() windowspecdefinition(ss_customer_id#4L, ss_transaction_id#3L, ss_item_id#6L ASC NULLS FIRST, specifiedwindowframe(RowFrame, unboundedpreceding$(), currentrow$())) AS row_number() OVER (PARTITION BY ss_customer_id, ss_transaction_id ORDER BY ss_item_id ASC NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)#9], [ss_customer_id#4L, ss_transaction_id#3L], [ss_item_id#6L ASC NULLS FIRST]
--      +- *(1) Sort [ss_customer_id#4L ASC NULLS FIRST, ss_transaction_id#3L ASC NULLS FIRST, ss_item_id#6L ASC NULLS FIRST], false, 0
--         +- Exchange hashpartitioning(ss_customer_id#4L, ss_transaction_id#3L, 200)
--            +- HiveTableScan [ss_customer_id#4L, ss_transaction_id#3L, ss_ts#8, ss_item_id#6L], HiveTableRelation `bigbenchv2`.`store_sales`, org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe, [ss_transaction_id#3L, ss_customer_id#4L, ss_store_id#5L, ss_item_id#6L, ss_quantity#7, ss_ts#8]
