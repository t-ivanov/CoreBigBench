
-- simple relational scan

use bigbenchv2;

SELECT ss_item_id, ss_quantity FROM store_sales_orc;

-- Time taken: 0.662 seconds, Fetched: 4617860 row(s)

--ZLIB - Time taken: 33.544 seconds, Fetched 4617860 row(s)
--No Compression - Time taken: 36.728 seconds, Fetched 4617860 row(s)
