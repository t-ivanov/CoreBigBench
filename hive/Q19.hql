
-- set the database
use BigBenchV2;


SELECT
	  uid, 
      tstamp,
	  CONCAT(sessionize.uid, 
        CONCAT('_', 
        SUM(new_session) OVER (PARTITION BY sessionize.uid ORDER BY sessionize.tstamp)
       )
      ) AS session_id
  FROM (
    SELECT
      logs.wl_customer_id 			AS uid,
      unix_timestamp(logs.wl_ts)	AS tstamp
	  ,CASE
        WHEN (unix_timestamp(logs.wl_ts) - LAG (unix_timestamp(logs.wl_ts))
             OVER (PARTITION BY logs.wl_customer_id ORDER BY logs.wl_ts)) >= 600
         THEN 1
         ELSE 0
        END AS new_session 
    FROM 
	 (
	   SELECT
		   js.wl_customer_id,
		   js.wl_item_id,
		   js.wl_ts
	   FROM web_logs
			lateral view 
			json_tuple(
			web_logs.line,
			'wl_customer_id',
			'wl_item_id',
			'wl_timestamp'
		) js AS
			wl_customer_id,
			wl_item_id,
			wl_ts
	    WHERE 
		  js.wl_customer_id IS NOT NULL
		  AND js.wl_item_id IS NOT NULL
	 ) logs	
    CLUSTER BY uid
  ) sessionize
  CLUSTER BY uid, session_id
;

-- Time taken: 1938.764 seconds, Fetched: 27047928 row(s)

