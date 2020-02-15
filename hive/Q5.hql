
-- Scan with High Number of Keys

use bigbenchv2;

SELECT wl_webpage_name, wl_customer_id, wl_item_id, wl_timestamp, 
        wl_key1, wl_key10, wl_key20, wl_key30, wl_key40, wl_key50,
        wl_key60, wl_key70, wl_key80, wl_key90, wl_key99
FROM 
	web_logs 
		lateral view 
		json_tuple( 
			web_logs.line,
			'wl_webpage_name','wl_customer_id',
			'wl_item_id','wl_timestamp',
			'wl_key1','wl_key10',
			'wl_key20', 'wl_key30', 
			'wl_key40', 'wl_key50',
			'wl_key60', 'wl_key70', 	
			'wl_key80', 'wl_key90', 
			'wl_key99'
		)logs as wl_webpage_name,
		 wl_customer_id, wl_item_id, wl_timestamp, 
        wl_key1, wl_key10, wl_key20, wl_key30, wl_key40, wl_key50,
        wl_key60, wl_key70, wl_key80, wl_key90, wl_key99
WHERE wl_webpage_name IS NOT NULL
AND wl_customer_id IS NOT NULL
AND wl_item_id IS NOT NULL
AND wl_timestamp IS NOT NULL
AND wl_key1 IS NOT NULL
AND wl_key10 IS NOT NULL
AND wl_key20 IS NOT NULL
AND wl_key30 IS NOT NULL
AND wl_key40 IS NOT NULL
AND wl_key50 IS NOT NULL
AND wl_key60 IS NOT NULL
AND wl_key70 IS NOT NULL
AND wl_key80 IS NOT NULL
AND wl_key90 IS NOT NULL
AND wl_key99 IS NOT NULL
;

-- Time taken: 951.287 seconds, Fetched: 13204 row(s)
