
-- complex relational scan
-- Select 10% of the records!

use bigbenchv2;


SELECT ss_item_id, ss_quantity 
FROM store_sales 
WHERE to_date(ss_ts) >= '2013-04-21' 
  AND to_date(ss_ts) < '2013-07-03';


--Time taken: 15.922 seconds, Fetched 460051 row(s)

