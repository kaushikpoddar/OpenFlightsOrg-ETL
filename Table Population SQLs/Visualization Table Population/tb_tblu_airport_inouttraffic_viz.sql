INSERT INTO fly_tb.tb_tblu_airport_inouttraffic_viz
SELECT sourceairportname                                        AS airportname
     , count(sourceairportname)                                 AS outgoing
	 , count(destinationairportname)                            AS incoming
	 , count(sourceairportname) + count(destinationairportname) AS totaltraffic
FROM fly_tb.tb_tblu_src_dest_dist_viz 
WHERE sourceairportname IS NOT NULL
GROUP BY sourceairportname