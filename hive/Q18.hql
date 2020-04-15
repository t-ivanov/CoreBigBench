
use bigbenchv2;


SELECT ss.ss_item_id AS ss_item_id,
ss.ss_quantity AS ss_quantity,
pr.pr_review_id AS pr_review_id
FROM store_sales_part_customer_id ss 
INNER JOIN product_reviews pr 
ON ss.ss_item_id = pr.pr_item_id
;

-- Time taken: 661.878 seconds