INSERT INTO fly_tb.tb_dim_airlines
SELECT
      airlines.airlineid             AS airlineid
    , airlines.name                  AS name     
    , airlines.alias                 AS alias    
    , airlines.iata                  AS iata     
    , airlines.icao                  AS icao     
    , airlines.callsign              AS callsign 
    , airlines.country               AS country  
    , airlines.active                AS active   
    , countries.iso                  AS country_iso
    , countries.dafif                AS country_dafif
FROM             fly_vw.vw_src_airlines airlines
LEFT OUTER JOIN  fly_vw.vw_src_countries countries
ON               airlines.country = countries.name;




