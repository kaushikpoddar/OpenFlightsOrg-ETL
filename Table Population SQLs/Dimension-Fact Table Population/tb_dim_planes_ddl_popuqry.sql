INSERT INTO fly_tb.tb_dim_planes
SELECT
      name   AS name
    , iata   AS iata
    , icao   AS icao
FROM fly_vw.vw_src_planes;