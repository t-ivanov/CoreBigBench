

--Cluster customers into book buddies/club groups based on their in
--store book purchasing histories.

-- set the database
use BigBenchV2;

set TEMP_RESULT_TABLE=q26_results;

-- Resources
-- https://github.com/brndnmtthws/facebook-hive-udfs/blob/master/src/main/java/com/facebook/hive/udf/UDFKmeans.java
ADD JAR facebook-udfs-1.0.4-SNAPSHOT.jar;

CREATE TEMPORARY FUNCTION kmeans AS 'com.facebook.hive.udf.UDFKmeans';

--   cluster_centers=8
--   clustering_iterations=20

SELECT kmeans(collect_list(array(id1, id3, id5, id7, id9, id11, id13, id15, id2, id4, id6, id8, id10, id14, id16)),8,20) as out from ${hiveconf:TEMP_RESULT_TABLE};

-- Time taken: 21.505 seconds, Fetched: 1 row(s)
-- Time taken: 23.544 seconds, Fetched: 1 row(s)
-- Time taken: 22.42 seconds, Fetched: 1 row(s)
