-- count key value aggregation

use bigbenchv2;


SELECT count(wl_webpage_name) 
FROM web_logs
lateral view 
	json_tuple( 
		web_logs.line,
		'wl_webpage_name' 
	)logs as wl_webpage_name
WHERE wl_webpage_name IS NOT NULL;

-- 316450046
-- Time taken: 902.338 seconds, Fetched: 1 row(s)