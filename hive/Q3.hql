
-- complex relational scan
-- Select 90% of the records!

use bigbenchv2;

SELECT ss_item_id, ss_quantity 
FROM store_sales 
WHERE to_date(ss_ts) >= '2013-01-21' 
AND to_date(ss_ts) < '2014-11-10';

-- Time taken: 35.077 seconds, Fetched 4162795 row(s)

