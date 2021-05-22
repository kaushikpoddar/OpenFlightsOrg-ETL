CREATE VIEW fly_vw.vw_src_airports 
AS
SELECT
      CAST(airportid AS INTEGER)                         AS airportid
    , REPLACE(name,'\N','')                              AS name
    , city                                               AS city
    , country                                            AS country
    , REPLACE(iata,'\N','')                              AS iata
    , REPLACE(icao,'\N','')                              AS icao
    , CAST(latitude AS DECIMAL(20,15))                   AS latitude
    , CAST(longitude AS DECIMAL(20,15))                  AS longitude
    , CAST(altitude AS INTEGER)                          AS altitude
    , CAST(REPLACE(timezone,'\N',0) AS DECIMAL(6,3))     AS timezone
    , REPLACE(dst,'\N','')                               AS dst
    , REPLACE(tzdatabasetimezone,'\N','')                AS tzdatabasetimezone
    , loctype                                            AS loctype
    , datasource                                         AS datasource
FROM fly_tb.tb_src_airports;

-----
CREATE VIEW fly_vw.vw_src_airlines
AS
SELECT
      CAST(airlineid AS INTEGER)   AS airlineid
    , REPLACE(name,'\N','')        AS name
    , REPLACE(alias,'\N','')       AS alias
    , REPLACE(iata,'\N','')        AS iata
    , REPLACE(icao,'\N','')        AS icao
    , REPLACE(callsign,'\N','')    AS callsign
    , country                      AS country
    , CAST(active AS CHAR(1))      AS active
FROM fly_tb.tb_src_airlines;

-----
CREATE VIEW fly_vw.vw_src_routes
AS 
SELECT
      REPLACE(airline,'\N','')                                 AS airline
    , CAST(REPLACE(airlineid,'\N','') AS INTEGER)              AS airlineid
    , CAST(sourceairport AS VARCHAR(4))                        AS sourceairport
    , CAST(REPLACE(sourceairportid,'\N','') AS INTEGER)        AS sourceairportid
    , CAST(destinationairport AS VARCHAR(4))                   AS destinationairport
    , CAST(REPLACE(destinationairportid,'\N','') AS INTEGER)   AS destinationairportid
    , CAST(codeshare AS VARCHAR(1))                            AS codeshare
    , CAST(stops AS INTEGER)                                   AS stops
    , REPLACE(equipment,'\N','')                               AS equipment
FROM fly_tb.tb_src_routes;

-----
CREATE VIEW fly_vw.vw_src_planes
AS
SELECT
      name                     AS name
    , REPLACE(iata,'\N','')    AS iata
    , REPLACE(icao,'\N','')    AS icao
FROM fly_tb.tb_src_planes;

-----
CREATE VIEW fly_vw.vw_src_countries
AS
SELECT 
      name                     AS name 
    , REPLACE(iso,'\N','')     AS iso  
    , REPLACE(dafif,'\N','')   AS dafif
FROM fly_tb.tb_src_countries;

-----
CREATE VIEW fly_ext_vw.vw_src_airline_safety
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
FROM fly_ext_tb.tb_src_airline_safety;

