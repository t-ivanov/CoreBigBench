
-- simple key-value scan

use bigbenchv2;

SELECT wl_webpage_name
FROM	
	web_logs 
	lateral view 
	json_tuple( 
		web_logs.line,
		'wl_webpage_name' 
	)logs as wl_webpage_name
WHERE wl_webpage_name IS NOT NULL
;

---Time taken: 931.704 seconds, Fetched: 316450046 row(s)