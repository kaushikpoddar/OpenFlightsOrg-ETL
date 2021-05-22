INSERT INTO fly_tb.tb_dim_airports
SELECT
      airport.airportid              AS airportid
    , airport.name                   AS name
    , airport.city                   AS city
    , airport.country                AS country
    , airport.iata                   AS iata
    , airport.icao                   AS icao
    , airport.latitude               AS latitude
    , airport.longitude              AS longitude
    , airport.altitude               AS altitude
    , airport.timezone               AS timezone
    , airport.dst                    AS dst
    , airport.tzdatabasetimezone     AS tzdatabasetimezone
    , airport.loctype                AS loctype
    , airport.datasource             AS datasource
    , countries.iso                  AS country_iso
    , countries.dafif                AS country_dafif
FROM             fly_vw.vw_src_airports airport
LEFT OUTER JOIN  fly_vw.vw_src_countries countries
ON               airport.country = countries.name;




