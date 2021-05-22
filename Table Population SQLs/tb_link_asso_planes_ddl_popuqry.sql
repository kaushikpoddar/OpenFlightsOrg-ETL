INSERT INTO fly_tb.tb_link_asso_planes
SELECT
      iata   AS iata
FROM fly_vw.vw_src_planes
GROUP BY iata;
