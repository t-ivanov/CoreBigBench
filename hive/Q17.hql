
use bigbenchv2;


SELECT ss.ss_item_id AS ss_item_id,
ss.ss_quantity AS ss_quantity,
pr.pr_review_id AS pr_review_id
FROM store_sales_part ss 
INNER JOIN product_reviews_part pr 
ON ss.ss_item_id = pr.pr_item_id
;


-- Time taken: 448.05 seconds

