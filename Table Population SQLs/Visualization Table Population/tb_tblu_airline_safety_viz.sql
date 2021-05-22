INSERT INTO fly_ext_tb.tb_tblu_airline_safety_viz
SELECT airline
     , category
	 , max(duration1) as duration1985to1999
	 , max(duration2) as duration2000to2014
FROM (
    SELECT airline
         , category
    	 , MAX(COALESCE(CASE WHEN YearBand = '1985s1999' THEN Counts END,0)) as duration1
    	 , MAX(COALESCE(CASE WHEN YearBand = '2000s2014' THEN Counts END,0)) as duration2								
    FROM (
        SELECT airline 
        	 , CASE WHEN category LIKE '%_85_99%' THEN '1985s1999'
                    WHEN category LIKE '%_00_14%' THEN '2000s2014'
               END AS YearBand
             , CASE WHEN category LIKE '%incident%' THEN 'Incidents'
                    WHEN category LIKE '%fatal_acci%' THEN 'Fatal Accidents'
             		WHEN category LIKE '%fatalities%' THEN 'Fatalities'
               END AS category
             , Counts
        FROM   
           (SELECT airline, incidents_85_99, fatal_accidents_85_99, fatalities_85_99, 
                            incidents_00_14, fatal_accidents_00_14, fatalities_00_14
           FROM fly_ext_vw.vw_dim_airline_safety) p  
        UNPIVOT
           (Counts FOR category IN (incidents_85_99, fatal_accidents_85_99, fatalities_85_99, 
                                    incidents_00_14, fatal_accidents_00_14, fatalities_00_14)) AS unpvt) k
    GROUP BY airline, Category, YearBand, Counts)y
GROUP BY airline, Category