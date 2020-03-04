

--Cluster customers into book buddies/club groups based on their in
--store book purchasing histories.

-- set the database
use BigBenchV2;

set TEMP_RESULT_TABLE=q22_prep_data;
set cluster_centers=8;
set clustering_iterations=20;

-- Resources
-- https://github.com/brndnmtthws/facebook-hive-udfs/blob/master/src/main/java/com/facebook/hive/udf/UDFKmeans.java
ADD JAR facebook-udfs-1.0.4-SNAPSHOT.jar;

CREATE TEMPORARY FUNCTION kmeans AS 'com.facebook.hive.udf.UDFKmeans';



SELECT kmeans(collect_list(array(id1, id3, id5, id7, id9, id11, id13, 
id15, id2, id4, id6, id8, id10, id14, id16)), 
${hiveconf:cluster_centers}, 
${hiveconf:clustering_iterations}) as out 
FROM ${hiveconf:TEMP_RESULT_TABLE};

-- Time taken: 21.505 seconds, Fetched: 1 row(s)
-- Time taken: 23.544 seconds, Fetched: 1 row(s)
-- Time taken: 22.42 seconds, Fetched: 1 row(s)
