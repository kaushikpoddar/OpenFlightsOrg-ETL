INSERT INTO fly_tb.tb_tblu_src_dest_dist_viz
SELECT
      airlines.name                                                               AS airlinename           
    , srcdetl.name                                                                AS sourceairportname     
    , srcdetl.city                                                                AS sourcecity            
    , srcdetl.country                                                             AS sourcecountry         
    , srcdetl.latitude                                                            AS sourcelatitude        
    , srcdetl.longitude                                                           AS sourcelongitude       
    , destdetl.name                                                               AS destinationairportname
    , destdetl.city                                                               AS destinationcity       
    , destdetl.country                                                            AS destinationcountry    
    , destdetl.latitude                                                           AS destinationlatitude   
    , destdetl.longitude                                                          AS destinationlongitude  
    , 2*3958.756*ASIN(SQRT(POWER(SIN((RADIANS(srcdetl.latitude)-
	    RADIANS(destdetl.latitude))/2),2)+COS(RADIANS(srcdetl.latitude))*
	    COS(RADIANS(destdetl.latitude))*POWER(SIN((RADIANS(srcdetl.longitude)-
	    RADIANS(destdetl.longitude))/2),2)))                                      AS tripdistance
		-- Using Haversine's Formula
FROM            (SELECT airlineid, sourceairportid, destinationairportid FROM fly_vw.vw_fact_routes WHERE airlineid <> 0) routes
LEFT OUTER JOIN (SELECT airlineid, name FROM fly_vw.vw_dim_airlines) airlines 
             ON routes.airlineid = airlines.airlineid 
LEFT OUTER JOIN fly_vw.vw_dim_airports srcdetl 
             ON routes.sourceairportid = srcdetl.airportid 
LEFT OUTER JOIN fly_vw.vw_dim_airports destdetl 
             ON routes.destinationairportid = destdetl.airportid 
WHERE airlines.name IS NOT NULL
  AND srcdetl.name IS NOT NULL
  AND srcdetl.city IS NOT NULL
  AND srcdetl.country IS NOT NULL
  AND srcdetl.latitude IS NOT NULL
  AND srcdetl.longitude IS NOT NULL
  AND destdetl.name IS NOT NULL
  AND destdetl.city IS NOT NULL
  AND destdetl.country IS NOT NULL
  AND destdetl.latitude IS NOT NULL
  AND destdetl.longitude IS NOT NULL