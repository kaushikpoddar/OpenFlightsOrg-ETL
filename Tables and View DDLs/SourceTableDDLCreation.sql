drop table fly_tb.tb_src_airports;

CREATE TABLE fly_tb.tb_src_airports
(
airportid            VARCHAR(50) NOT NULL,
name                 VARCHAR(100) NOT NULL,
city                 VARCHAR(50),
country              VARCHAR(50) NOT NULL,
iata                 CHAR(3),
icao                 CHAR(4),
latitude             VARCHAR(50) NOT NULL,
longitude            VARCHAR(50) NOT NULL,
altitude             VARCHAR(50) NOT NULL,
timezone             VARCHAR(50) NOT NULL,
dst                  CHAR(2) NOT NULL CHECK (dst IN ('E', 'A', 'S', 'O', 'Z', 'N', 'U')),
tzdatabasetimezone   VARCHAR(50) NOT NULL,
loctype              VARCHAR(10) NOT NULL CHECK (loctype IN ('airport', 'station', 'port', 'unknown')),
datasource           VARCHAR(20) NOT NULL CHECK (datasource IN ('OurAirports', 'Legacy', 'User'))
CONSTRAINT pk_tb_src_airports PRIMARY KEY (airportid)
);

-----
drop table fly_tb.tb_src_airlines;

CREATE TABLE fly_tb.tb_src_airlines
(
airlineid    VARCHAR(50) NOT NULL,
name         VARCHAR(100) NOT NULL,
alias        VARCHAR(50),
iata         CHAR(3),
icao         CHAR(4),
callsign     VARCHAR(50),
country      VARCHAR(50),
active       VARCHAR(50) NOT NULL CHECK (active IN ('Y','N'))
CONSTRAINT pk_tb_src_airlines PRIMARY KEY (airlineid)
);

-----
drop table fly_tb.tb_src_routes;

CREATE TABLE fly_tb.tb_src_routes
(
airline                 VARCHAR(3) NOT NULL,
airlineid               VARCHAR(50) NOT NULL,
sourceairport           VARCHAR(50),
sourceairportid         VARCHAR(50),
destinationairport      VARCHAR(50),
destinationairportid    VARCHAR(50),
codeshare               VARCHAR(50),
stops                   VARCHAR(10),
equipment               VARCHAR(50)
--CONSTRAINT pk_tb_src_routes PRIMARY KEY (airlineid, sourceairportid, destinationairportid)
);

-----
drop table fly_tb.tb_src_planes;

CREATE TABLE fly_tb.tb_src_planes
(
name    VARCHAR(100) NOT NULL,
iata    CHAR(3),
icao    CHAR(4)
CONSTRAINT pk_tb_src_planes PRIMARY KEY (name)
);

-----
drop table fly_tb.tb_src_countries;

CREATE TABLE fly_tb.tb_src_countries
(
name          VARCHAR(100) NOT NULL,
iso           VARCHAR(2),
dafif         VARCHAR(10)
CONSTRAINT pk_tb_src_countries PRIMARY KEY (dafif)
);

-----
drop table fly_tb.tb_src_airline_safety;

CREATE TABLE fly_ext_tb.tb_src_airline_safety
(
airline                   VARCHAR(100) NOT NULL,
avail_seat_km_per_week    BIGINT NOT NULL,
incidents_85_99           INTEGER NOT NULL,
fatal_accidents_85_99     INTEGER NOT NULL,
fatalities_85_99          INTEGER NOT NULL,
incidents_00_14           INTEGER NOT NULL,
fatal_accidents_00_14     INTEGER NOT NULL,
fatalities_00_14          INTEGER NOT NULL
CONSTRAINT pk_tb_src_airline_safety PRIMARY KEY (airline)
);