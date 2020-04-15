
use bigbenchv2;


DROP TABLE IF EXISTS JOIN_RESULT;
CREATE TABLE JOIN_RESULT
  ( ss_item_id           	  bigint              --not null
  ,ss_quantity                int
  ,pr_review_id               bigint	     	   		   
    )
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

INSERT INTO TABLE JOIN_RESULT 
SELECT ss.ss_item_id AS ss_item_id,
ss.ss_quantity AS ss_quantity,
pr.pr_review_id AS pr_review_id
FROM store_sales_part_customer_id ss 
INNER JOIN product_reviews pr 
ON ss.ss_item_id = pr.pr_item_id
;

-- Time taken: 661.878 seconds
