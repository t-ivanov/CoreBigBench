add file  /home/user1/CoreBench/Hive/regexp.py;

use bigbenchv2;

SELECT transform(wl_webpage_name) 
USING 'python regexp.py'
AS (wl_webpage_name string) 
FROM web_logs 
	lateral view 
	json_tuple( 
		web_logs.line,
		'wl_webpage_name' 
	)logs as wl_webpage_name
;

-- Time taken: 984.492 seconds, Fetched: 632900094 row(s)


-- LIMIT 10;