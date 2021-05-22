-- Report 1: Most Active Airline(How many unique routes)

SELECT
      airlines.country                                                       AS airlinecountry
    , airlines.name                                                          AS airlinename
    , COUNT(DISTINCT CONCAT(routes.sourceairport,routes.destinationairport)) AS totaluniqueroutes
FROM            (SELECT airlineid, sourceairport, destinationairport FROM fly_vw.vw_fact_routes WHERE airlineid <> 0) routes
LEFT OUTER JOIN (SELECT * FROM fly_vw.vw_dim_airlines WHERE active = 'Y') airlines
             ON routes.airlineid = airlines.airlineid
WHERE airlines.country IS NOT NULL OR  airlines.name IS NOT NULL
GROUP BY airlines.country, airlines.name
--ORDER BY totaluniqueroutes DESC


-- Report 2: Most Popular Plane Model

SELECT dim_planes.name                                                AS airplanename
     , COUNT(CONCAT(routes.sourceairport, routes.destinationairport)) AS numbersinoperation
FROM       (SELECT * FROM fly_vw.vw_fact_routes WHERE airlineid <> 0) routes
INNER JOIN fly_vw.vw_link_asso_planes link_planes 
        ON routes.equipment = link_planes.iata
LEFT OUTER JOIN fly_vw.vw_dim_planes dim_planes 
        ON link_planes.iata = dim_planes.iata
GROUP BY dim_planes.name
--ORDER BY numbersinoperation DESC


-- Report 3: Given Airline, get a report of all the routes

CREATE PROCEDURE fly_sp.usp_airline_rpt @airlinename VARCHAR(50)
AS
SELECT
      airlines.name               AS airlinename
    , srcairports.name			  AS sourceairport
    , srcairports.city			  AS sourcecity
    , destairports.name			  AS destinationairport
    , destairports.city			  AS destinationcity
FROM       (SELECT airlineid
                 , sourceairportid
				 , sourceairport
				 , destinationairportid
				 , destinationairport 
             FROM fly_vw.vw_fact_routes 
			WHERE airlineid <> 0) routes
INNER JOIN (SELECT * 
              FROM fly_vw.vw_dim_airlines 
			 WHERE active = 'Y' 
			   AND name = @airlinename) airlines
             ON routes.airlineid = airlines.airlineid
LEFT OUTER JOIN fly_vw.vw_dim_airports srcairports
             ON routes.sourceairportid = srcairports.airportid
LEFT OUTER JOIN fly_vw.vw_dim_airports destairports
             ON routes.destinationairportid = destairports.airportid;

EXEC fly_sp.usp_airline_rpt 'American Airlines'


-- Report 4: Given Country, get all the flights details

CREATE PROCEDURE fly_sp.usp_country_rpt @country VARCHAR(50)
AS
SELECT 
      country
    , airlinename
    , sourceairport
    , sourcecity
    , destinationairport
    , destinationcity
FROM	
(
SELECT
      srcairports.country         AS country
    , airlines.name               AS airlinename
    , srcairports.name			  AS sourceairport
    , srcairports.city			  AS sourcecity
    , destairports.name			  AS destinationairport
    , destairports.city			  AS destinationcity			 		 
FROM       (SELECT airlineid
                 , sourceairportid
				 , sourceairport
				 , destinationairportid
				 , destinationairport 
              FROM fly_vw.vw_fact_routes
			 WHERE airlineid <> 0) routes 
INNER JOIN (SELECT * FROM fly_vw.vw_dim_airports
            WHERE country = @country) srcairports
		ON routes.sourceairportid = srcairports.airportid
LEFT OUTER JOIN fly_vw.vw_dim_airports destairports
             ON routes.destinationairportid = destairports.airportid
INNER JOIN (SELECT * 
              FROM fly_vw.vw_dim_airlines 
			 WHERE active = 'Y' ) airlines
			 ON routes.airlineid = airlines.airlineid
UNION
SELECT
      destairports.country        AS country
    , airlines.name               AS airlinename
    , srcairports.name			  AS sourceairport
    , srcairports.city			  AS sourcecity
    , destairports.name			  AS destinationairport
    , destairports.city			  AS destinationcity			 		 
FROM       (SELECT airlineid
                 , sourceairportid
				 , sourceairport
				 , destinationairportid
				 , destinationairport 
             FROM fly_vw.vw_fact_routes
			 WHERE airlineid <> 0) routes 
INNER JOIN (SELECT * FROM fly_vw.vw_dim_airports
            WHERE country = @country) destairports
			ON routes.sourceairportid = destairports.airportid
LEFT OUTER JOIN fly_vw.vw_dim_airports srcairports
             ON routes.destinationairportid = srcairports.airportid
INNER JOIN (SELECT * 
              FROM fly_vw.vw_dim_airlines 
			 WHERE active = 'Y' ) airlines
			 ON routes.airlineid = airlines.airlineid)y;

EXEC fly_sp.usp_country_rpt 'Ireland'