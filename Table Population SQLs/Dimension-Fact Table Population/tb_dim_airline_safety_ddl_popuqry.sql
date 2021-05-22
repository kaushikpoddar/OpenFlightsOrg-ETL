INSERT INTO fly_ext_tb.tb_dim_airline_safety
SELECT
      airline                   AS airline               
    , avail_seat_km_per_week    AS avail_seat_km_per_week
    , incidents_85_99           AS incidents_85_99       
    , fatal_accidents_85_99     AS fatal_accidents_85_99 
    , fatalities_85_99          AS fatalities_85_99      
    , incidents_00_14           AS incidents_00_14       
    , fatal_accidents_00_14     AS fatal_accidents_00_14 
    , fatalities_00_14          AS fatalities_00_14      
FROM fly_ext_vw.vw_src_airline_safety;