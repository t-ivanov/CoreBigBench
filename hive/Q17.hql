
-- simple key value user function

use bigbenchv2;

SELECT wl_webpage_name, regexp_replace(wl_webpage_name, '\\#', '_') as new_name 
FROM web_logs 
	lateral view 
	json_tuple( 
		web_logs.line,
		'wl_webpage_name' 
	)logs as wl_webpage_name 
WHERE wl_webpage_name IS NOT NULL;


-- Time taken: 981.545 seconds, Fetched: 316450046 row(s)


-- limit 10;
