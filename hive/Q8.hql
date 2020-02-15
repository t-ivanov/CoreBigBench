
-- simple relational aggregation

use bigbenchv2;

SELECT ss_item_id , COLLECT_SET(ss_customer_id)
FROM store_sales
GROUP BY ss_item_id;


-- Time taken: 27.89 seconds, Fetched: 2315 row(s)
