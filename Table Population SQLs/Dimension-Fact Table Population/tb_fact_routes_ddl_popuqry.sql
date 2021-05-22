MERGE fly_tb.tb_fact_routes tgt
USING fly_vw.vw_src_routes src
ON    tgt.airlineid            = src.airlineid
AND   tgt.destinationairportid = src.destinationairportid
AND   tgt.sourceairportid      = src.sourceairportid
AND   tgt.equipment            = LTRIM(RTRIM(src.equipment))
WHEN MATCHED
THEN UPDATE SET etl_end_dt = CAST(GETDATE() AS DATE) , active_ind = 'IN';

INSERT INTO fly_tb.tb_fact_routes
SELECT
      airline             	                     AS airline             
    , airlineid           	                     AS airlineid           
    , sourceairport       	                     AS sourceairport       
    , sourceairportid     	                     AS sourceairportid     
    , destinationairport  	                     AS destinationairport  
    , destinationairportid	                     AS destinationairportid
    , codeshare           	                     AS codeshare           
    , stops               	                     AS stops               
    , CAST(RTRIM(LTRIM(equipment)) AS CHAR(50))  AS equipment 
	, CAST(GETDATE() AS DATE)                    AS etl_start_dt
    , '9999-12-31'                               AS etl_end_dt
    , 'AC'                                       AS active_ind
FROM  fly_vw.vw_src_routes
WHERE equipment IS NOT NULL
AND   sourceairportid <> 0 
AND   destinationairportid <> 0;


