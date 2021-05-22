DROP TABLE fly_tb.tb_tblu_airline_dist_max_viz;

CREATE TABLE fly_tb.tb_tblu_airline_dist_max_viz
(
airlinename               VARCHAR(100),
totaldistancecovered      DECIMAL(15,2),            
longesttrip               DECIMAL(15,2)
);

-----
DROP TABLE fly_ext_tb.tb_tblu_airline_safety_viz;

CREATE TABLE fly_ext_tb.tb_tblu_airline_safety_viz
(
airline                   VARCHAR(100) NOT NULL,
category                  VARCHAR(50) NOT NULL,
duration1985to1999        INTEGER NOT NULL,
duration2000to2014        INTEGER NOT NULL
);

-----
DROP TABLE fly_tb.tb_tblu_airport_inouttraffic_viz;

CREATE TABLE fly_tb.tb_tblu_airport_inouttraffic_viz
(
airportname             VARCHAR(200),
outgoing                INTEGER,            
incoming                INTEGER,
totaltraffic            INTEGER
);

-----
DROP TABLE fly_tb.tb_tblu_src_dest_dist_viz;

CREATE TABLE fly_tb.tb_tblu_src_dest_dist_viz
(
airlinename                VARCHAR(100),
sourceairportname          VARCHAR(100),
sourcecity                 VARCHAR(50),
sourcecountry              VARCHAR(50),
sourcelatitude             DECIMAL(20,15),
sourcelongitude            DECIMAL(20,15),
destinationairportname     VARCHAR(100),
destinationcity            VARCHAR(50),
destinationcountry         VARCHAR(50),
destinationlatitude        DECIMAL(20,15),
destinationlongitude       DECIMAL(20,15),
tripdistance               DECIMAL(20,15)
);
