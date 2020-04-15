
-- simple relational user function

use bigbenchv2;

SELECT w_web_page_name, regexp_replace(w_web_page_name, '\\#', '_')
FROM web_pages;

-- Time taken: 15.15 seconds, Fetched: 26 row(s)

--limit 10;
