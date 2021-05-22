CREATE VIEW fly_vw.vw_dim_airports
AS
SELECT
      airportid            AS airportid         
    , name                 AS name              
    , city                 AS city              
    , country              AS country           
    , iata                 AS iata              
    , icao                 AS icao              
    , latitude             AS latitude          
    , longitude            AS longitude         
    , altitude             AS altitude          
    , timezone             AS timezone          
    , dst                  AS dst               
    , tzdatabasetimezone   AS tzdatabasetimezone
    , loctype              AS loctype           
    , datasource           AS datasource        
    , country_iso          AS country_iso       
    , country_dafif        AS country_dafif     
FROM fly_tb.tb_dim_airports;
-----

CREATE VIEW fly_vw.vw_dim_airlines
AS
SELECT
      airlineid        AS airlineid    
    , name             AS name         
    , alias            AS alias        
    , iata             AS iata         
    , icao             AS icao         
    , callsign         AS callsign     
    , country          AS country      
    , active           AS active       
    , country_iso      AS country_iso  
    , country_dafif    AS country_dafif
FROM fly_tb.tb_dim_airlines;
-----

CREATE VIEW fly_vw.vw_fact_routes
AS
SELECT
      airline                AS airline             
    , airlineid              AS airlineid           
    , sourceairport          AS sourceairport       
    , sourceairportid        AS sourceairportid     
    , destinationairport     AS destinationairport  
    , destinationairportid   AS destinationairportid
    , codeshare              AS codeshare           
    , stops                  AS stops               
    , equipment              AS equipment           
FROM fly_tb.tb_fact_routes
WHERE active_ind = 'AC';
-----

CREATE VIEW fly_vw.vw_link_asso_planes
AS
SELECT
    iata    AS iata
FROM fly_tb.tb_link_asso_planes;
-----

CREATE VIEW fly_vw.vw_dim_planes
AS
SELECT
      name    AS name
    , iata    AS iata
    , icao    AS icao
FROM fly_tb.tb_dim_planes;
-----

CREATE VIEW fly_ext_vw.vw_dim_airline_safety
AS
SELECT 
      airline                   AS airline               
    , avail_seat_km_per_week    AS avail_seat_km_per_week
    , incidents_85_99           AS incidents_85_99       
    , fatal_accidents_85_99     AS fatal_accidents_85_99 
    , fatalities_85_99          AS fatalities_85_99      
    , incidents_00_14           AS incidents_00_14       
    , fatal_accidents_00_14     AS fatal_accidents_00_14 
    , fatalities_00_14          AS fatalities_00_14      
FROM fly_ext_tb.tb_dim_airline_safety;