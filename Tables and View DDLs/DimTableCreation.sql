drop table fly_ext_tb.tb_dim_airline_safety;

CREATE TABLE fly_ext_tb.tb_dim_airline_safety
(
airline                   VARCHAR(100) NOT NULL,
avail_seat_km_per_week    BIGINT NOT NULL,
incidents_85_99           INTEGER NOT NULL,
fatal_accidents_85_99     INTEGER NOT NULL,
fatalities_85_99          INTEGER NOT NULL,
incidents_00_14           INTEGER NOT NULL,
fatal_accidents_00_14     INTEGER NOT NULL,
fatalities_00_14          INTEGER NOT NULL
CONSTRAINT pk_tb_dim_airline_safety PRIMARY KEY (airline)
);

-----
drop table fly_tb.tb_dim_airlines;

CREATE TABLE fly_tb.tb_dim_airlines
(
airlineid        INTEGER NOT NULL,
name             VARCHAR(100) NOT NULL,
alias            VARCHAR(50),
iata             CHAR(3),
icao             CHAR(4),
callsign         VARCHAR(50),
country          VARCHAR(50),
active           CHAR(1),
country_iso      VARCHAR(2),
country_dafif    VARCHAR(10)
CONSTRAINT pk_tb_dim_airlines PRIMARY KEY (airlineid)
);

-----
drop table fly_tb.tb_dim_airports;

CREATE TABLE fly_tb.tb_dim_airports
(
airportid            INTEGER NOT NULL,
name                 VARCHAR(100) NOT NULL,
city                 VARCHAR(50),
country              VARCHAR(50) NOT NULL,
iata                 CHAR(3),
icao                 CHAR(4),
latitude             DECIMAL(20,15) NOT NULL,
longitude            DECIMAL(20,15) NOT NULL,
altitude             INTEGER NOT NULL,
timezone             DECIMAL(6,3) NOT NULL,
dst                  CHAR(2) NOT NULL,
tzdatabasetimezone   VARCHAR(50) NOT NULL,
loctype              VARCHAR(10) NOT NULL,
datasource           VARCHAR(20) NOT NULL,
country_iso          VARCHAR(2),
country_dafif        VARCHAR(10)
CONSTRAINT pk_tb_dim_airports PRIMARY KEY (airportid)
);

-----
drop table fly_tb.tb_dim_planes;

CREATE TABLE fly_tb.tb_dim_planes
(
name    VARCHAR(100) NOT NULL,
iata    CHAR(50),
icao    CHAR(4)
CONSTRAINT pk_tb_dim_planes PRIMARY KEY (name)
CONSTRAINT fk_tb_link_asso_planes FOREIGN KEY (iata) REFERENCES fly_tb.tb_link_asso_planes(iata)
);

-----
DROP TABLE fly_tb.tb_link_asso_planes;

CREATE TABLE fly_tb.tb_link_asso_planes
(
iata    CHAR(50),
CONSTRAINT pk_tb_link_asso_planes PRIMARY KEY (iata),
);

-----
drop table fly_tb.tb_fact_routes;

CREATE TABLE fly_tb.tb_fact_routes
(
airline                 VARCHAR(3) NOT NULL,
airlineid               INTEGER,
sourceairport           VARCHAR(4),
sourceairportid         INTEGER,
destinationairport      VARCHAR(4),
destinationairportid    INTEGER,
codeshare               VARCHAR(1),
stops                   INTEGER,
equipment               CHAR(50),
etl_start_dt            DATE NOT NULL,
etl_end_dt              DATE NOT NULL,
active_ind              CHAR(2),
CONSTRAINT fk_tb_dim_airlines_fct FOREIGN KEY (airlineid) REFERENCES fly_tb.tb_dim_airlines(airlineid),
CONSTRAINT fk_tb_dim_srcairports_fct FOREIGN KEY (sourceairportid) REFERENCES fly_tb.tb_dim_airports(airportid),
CONSTRAINT fk_tb_dim_desairports_fct FOREIGN KEY (destinationairportid) REFERENCES fly_tb.tb_dim_airports(airportid),
CONSTRAINT fk_tb_link_asso_planes_fct FOREIGN KEY (equipment) REFERENCES fly_tb.tb_link_asso_planes(iata)
);

-----