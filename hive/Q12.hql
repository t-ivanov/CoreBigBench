-- simple relational aggregation

use bigbenchv2;

SELECT ss_item_id , COLLECT_SET(ss_customer_id)
FROM store_sales_part_customer_id
GROUP BY ss_item_id;