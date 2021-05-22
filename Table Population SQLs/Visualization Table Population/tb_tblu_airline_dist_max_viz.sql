INSERT INTO fly_tb.tb_tblu_airline_dist_max_viz
SELECT airlinename
     , CAST(ROUND(SUM(tripdistance),2) AS DECIMAL(15,2)) AS totaldistancecovered
     , CAST(ROUND(MAX(tripdistance),2) AS DECIMAL(15,2)) AS longesttrip 
FROM fly_tb.tb_tblu_src_dest_dist_viz
GROUP BY airlinename;