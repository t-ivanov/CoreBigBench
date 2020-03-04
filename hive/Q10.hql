
-- complex relational aggregation

use bigbenchv2;

select ss_customer_id,
count(*) as number_transactions,
COUNT(distinct ss_item_id) as Distinct_Items,
stddev_pop(ss_item_id) as STDDEV_Webpages,
-- corr(Column column1, Column column2) --> Aggregate function: returns the Pearson Correlation Coefficient for two columns.
corr(ss_item_id, ss_store_id) as PearsonCC_Item_Store,
min(ss_quantity) as Min_Quantity, 
max(ss_quantity) as Max_Quantity, 
avg(ss_quantity) as Avg_Quantity, 
corr(ss_item_id, ss_quantity) as PearsonCC_Item_Q,
min(to_date(ss_ts)) as Earliest,
max(to_date(ss_ts)) as Latest
from store_sales_part_customer_id
group by ss_customer_id;


-- Time taken: 75.747 seconds, Fetched: 104929 row(s)
