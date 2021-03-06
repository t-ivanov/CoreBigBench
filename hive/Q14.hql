
-- key value Window function

use bigbenchv2;


SELECT wl_customer_id, to_date(wl_timestamp), wl_webpage_name, 
ROW_NUMBER() OVER (ORDER BY to_date(wl_timestamp))
FROM web_logs 
	lateral view 
	json_tuple( 
		web_logs.line,
		'wl_webpage_name',
		'wl_customer_id',
		'wl_timestamp'
	)logs as  wl_webpage_name, 
			  wl_customer_id,
			  wl_timestamp
WHERE wl_customer_id IS NOT NULL
  AND wl_timestamp IS NOT NULL
  AND wl_webpage_name IS NOT NULL;

-- Time taken: 1628.078 seconds, Fetched: 30910168 row(s)


--LIMIT 1000;
-- Time taken: 452.739 seconds, Fetched 1000 row(s)


-- explain

-- == Physical Plan ==
-- CollectLimit 1000
-- +- *(3) LocalLimit 1000
--   +- *(3) Project [wl_customer_id#4L, to_date(spark_logs.`wl_timestamp`)#109, wl_webpage_name#108, row_number() OVER (ORDER BY to_date(spark_logs.`wl_timestamp`) ASC NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)#110]
--      +- Window [row_number() windowspecdefinition(_w0#111 ASC NULLS FIRST, specifiedwindowframe(RowFrame, unboundedpreceding$(), currentrow$())) AS row_number() OVER (ORDER BY to_date(spark_logs.`wl_timestamp`) ASC NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)#110], [_w0#111 ASC NULLS FIRST]
--         +- *(2) Sort [_w0#111 ASC NULLS FIRST], false, 0
--            +- Exchange SinglePartition
--               +- *(1) Project [wl_customer_id#4L, cast(wl_timestamp#107 as date) AS to_date(spark_logs.`wl_timestamp`)#109, wl_webpage_name#108, cast(wl_timestamp#107 as date) AS _w0#111]
--                  +- *(1) Filter ((isnotnull(wl_customer_id#4L) && isnotnull(wl_timestamp#107)) && isnotnull(wl_webpage_name#108))
--                     +- *(1) FileScan json bigbenchv2.spark_logs[wl_customer_id#4L,wl_timestamp#107,wl_webpage_name#108] Batched: false, Format: JSON, Location: InMemoryFileIndex[hdfs://babar0:8020/user/user1/semibench/data/web_logs/clicks.json], PartitionFilters: [], PushedFilters: [IsNotNull(wl_customer_id), IsNotNull(wl_timestamp), IsNotNull(wl_webpage_name)], ReadSchema: struct<wl_customer_id:bigint,wl_timestamp:string,wl_webpage_name:string>
