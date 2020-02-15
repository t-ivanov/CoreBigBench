
-- simple key value aggregation

use bigbenchv2;

SELECT wl_item_id , COLLECT_SET(wl_webpage_name)
FROM web_logs 
	lateral view 
	json_tuple( 
		web_logs.line,
		'wl_item_id',
		'wl_webpage_name'
	)logs as wl_item_id, wl_webpage_name
GROUP BY wl_item_id;

--- Time taken: 1544.218 seconds, Fetched: 2316 row(s)
