
add file  /home/user1/CoreBench/Hive/regexp.py;

use bigbenchv2;

SELECT transform(w_web_page_name) 
USING 'python regexp.py'
AS (w_web_page string) 
FROM web_pages;

-- Time taken: 15.059 seconds, Fetched: 52 row(s)

--LIMIT 10;