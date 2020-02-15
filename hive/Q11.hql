
-- complex key value aggregation

use bigbenchv2;

SELECT wl_customer_id, 
COUNT(*) as all_customers,
COUNT(distinct wl_customer_id) as dist_customers,
AVG(wl_item_id) as AVG_Items,
stddev_pop(wl_item_id) as STDDEV_Webpages,
-- corr(Column column1, Column column2) --> Aggregate function: returns the Pearson Correlation Coefficient for two columns.
corr(cast(wl_item_id as bigint), cast(wl_customer_id as bigint)) as PearsonCC_Item_Customer,
MIN(wl_item_id) as Min_Item_ID, 
MAX(wl_item_id) as Max_Item_ID,
-- VARIANCE mathematical property that signifies how far the values spread apart from the mean.
VARIANCE(wl_item_id) as Var_Item_IDs,
-- corr(Column column1, Column column2) --> Aggregate function: returns the Pearson Correlation Coefficient for two columns.
MIN(to_date(wl_timestamp)) as Earliest,
MAX(to_date(wl_timestamp)) as Latest
FROM web_logs 
	lateral view 
	json_tuple( 
		web_logs.line,
		'wl_webpage_name',
		'wl_item_id',
		'wl_customer_id',
		'wl_timestamp'
	)logs as  wl_webpage_name, 
			  wl_item_id, 
			  wl_customer_id,
			  wl_timestamp
WHERE wl_customer_id IS NOT NULL 
AND wl_item_id IS NOT NULL 
AND wl_webpage_name IS NOT NULL
AND wl_timestamp IS NOT NULL
GROUP BY wl_customer_id, wl_item_id
LIMIT 10;

-- Time taken: 1690.478 seconds, Fetched: 10 row(s)