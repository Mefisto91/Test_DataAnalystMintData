
USE master
GO
------------------------------------------------------------------------------------
--Se crea la base de con la cual se va a trabajar
DROP DATABASE IF EXISTS Test_DataAnalystMintData
GO

CREATE DATABASE Test_DataAnalystMintData
GO

USE Test_DataAnalystMintData
GO

------------------------------------------------------------------------------------
--Se crean los diferentes esquemas con el fin de poder separar la data
CREATE SCHEMA RawData --Data Original
GO

CREATE SCHEMA Clean --Se realiza limpieza y transformacion de datos
GO

CREATE SCHEMA GoldData --Data final (Data de produccion)
GO

------------------------------------------------------------------------------------
--Se crean las diferentes tablas que se van a usar para traer la RawData
DROP TABLE IF EXISTS RawData.ak_output
GO 

CREATE TABLE RawData.ak_output (
	flight_id                  NVARCHAR(100),   
	ArrivalTerminal            NVARCHAR(100),    
	baggageID                  NVARCHAR(100),    
	boardGate                  NVARCHAR(100),    
	checkinTable               NVARCHAR(100),    
	DepartureTerminal          NVARCHAR(100),    
	flight_arr_actual_date     NVARCHAR(100),    
	flight_arr_actual_full     NVARCHAR(100),    
	flight_arr_actual_time     NVARCHAR(100),    
	flight_arr_actual_UTC      NVARCHAR(100),    
	flight_arr_estimated_date  NVARCHAR(100),    
	flight_arr_estimated_full  NVARCHAR(100),    
	flight_arr_estimated_time  NVARCHAR(100),    
	flight_arr_estimated_UTC   NVARCHAR(100),    
	flight_arr_scheduled_date  NVARCHAR(100),    
	flight_arr_scheduled_full  NVARCHAR(100),    
	flight_arr_scheduled_time  NVARCHAR(100),    
	flight_arr_scheduled_UTC   NVARCHAR(100),    
	flight_dep_actual_date     NVARCHAR(100),    
	flight_dep_actual_full     NVARCHAR(100),    
	flight_dep_actual_time     NVARCHAR(100),    
	flight_dep_actual_UTC      NVARCHAR(100),    
	flight_dep_estimated_date  NVARCHAR(100),    
	flight_dep_estimated_full  NVARCHAR(100),    
	flight_dep_estimated_time  NVARCHAR(100),    
	flight_dep_estimated_UTC   NVARCHAR(100),    
	flight_dep_scheduled_date  NVARCHAR(100),    
	flight_dep_scheduled_full  NVARCHAR(100),    
	flight_dep_scheduled_time  NVARCHAR(100),    
	flight_dep_scheduled_UTC   NVARCHAR(100),    
	flight_map_flag            NVARCHAR(100),   
	flightArr                  NVARCHAR(100),    
	flightCarrier              NVARCHAR(100),    
	flightDate                 NVARCHAR(100),    
	flightDep                  NVARCHAR(100),    
	flightNumber               NVARCHAR(100),    
	flightStatus               NVARCHAR(100),    
	flightTDOWN_full           NVARCHAR(100),
	flightTDOWN_time           NVARCHAR(100),
	flightTDOWN_date           NVARCHAR(100),
	flightTDOWN_UTC            NVARCHAR(100),
	flightTKOFF_date           NVARCHAR(100),
	flightTKOFF_full           NVARCHAR(100),
	flightTKOFF_time           NVARCHAR(100),
	flightTKOFF_UTC            NVARCHAR(100),
	prev_arrivalstation        NVARCHAR(100),    
	lastUpdatedCache           NVARCHAR(100),    
	prev_ata                   NVARCHAR(100),    
	prev_atd                   NVARCHAR(100),    
	prev_carrierCode           NVARCHAR(100),    
	prev_departurestation      NVARCHAR(100),    
	prev_eta                   NVARCHAR(100),    
	prev_etd                   NVARCHAR(100),    
	prev_flightnumber          NVARCHAR(100),    
	prev_legcode               NVARCHAR(100),    
	prev_sta                   NVARCHAR(100),    
	prev_std                   NVARCHAR(100),    
	recordLocator              NVARCHAR(100),
	rego                       NVARCHAR(100),    
	utcFlightArrival           NVARCHAR(100),    
	utcFlightDepart            NVARCHAR(100)
)


DROP TABLE IF EXISTS RawData.jt_output
GO 

CREATE TABLE RawData.jt_output(
	flight_id                 NVARCHAR(MAX),
	aircraftAge               NVARCHAR(MAX),
	aircraftType              NVARCHAR(MAX),
	airlineCode               NVARCHAR(MAX),
	airlineName               NVARCHAR(MAX),
	airlinePhone              NVARCHAR(MAX),
	arrivalAirportHelpline    NVARCHAR(MAX),
	arrivalDeviation          NVARCHAR(MAX),
	boardingStatus            NVARCHAR(MAX),
	[delay]                   NVARCHAR(MAX),
	departureAirportHelpline  NVARCHAR(MAX),
	departureDeviation        NVARCHAR(MAX),
	destAirport               NVARCHAR(MAX),
	distance                  NVARCHAR(MAX),
	duration                  NVARCHAR(MAX),
	durationStr               NVARCHAR(MAX),
	flightNumber              NVARCHAR(MAX),
	flightUniqueId            NVARCHAR(MAX),
	isArrivalDelayed          NVARCHAR(MAX),
	isDepartureDelayed        NVARCHAR(MAX),
	nextDayCount              NVARCHAR(MAX),
	onTimeAccuracy            NVARCHAR(MAX),
	originAirport             NVARCHAR(MAX),
	providerStatus            NVARCHAR(MAX),
	[status]                  NVARCHAR(MAX),
	statusMap                 NVARCHAR(MAX),
	technicalStop             NVARCHAR(MAX),
	terminalInfo              NVARCHAR(MAX),
	timings                   NVARCHAR(MAX)
)


DROP TABLE IF EXISTS RawData.y4_output
GO 

CREATE TABLE RawData.y4_output(
	flight_id           NVARCHAR(100),
	aircraftFamily      NVARCHAR(100),
	aircraftStatus      NVARCHAR(100),
	arrivalDate         NVARCHAR(100),
	arrivalTerminal     NVARCHAR(100),
	carrier             NVARCHAR(100),
	delayDuration       NVARCHAR(100),
	departure           NVARCHAR(100),
	departureDate       NVARCHAR(100),
	departureGate       NVARCHAR(100),
	departureTerminal   NVARCHAR(100),
	destination         NVARCHAR(100),
	duration            NVARCHAR(100),
	estimatedArrival    NVARCHAR(100),
	estimatedDeparture  NVARCHAR(100),
	flightNumber        NVARCHAR(100),
	flightStatus        NVARCHAR(100),
	irop                NVARCHAR(100),
	isBlacklisted       NVARCHAR(100),
	isCodeShare         NVARCHAR(100),
	operatedBy          NVARCHAR(100),
	scheduledArrival    NVARCHAR(100),
	scheduledDeparture  NVARCHAR(100),
	thruFlights         NVARCHAR(100)
)



------------------------------------------------------------------------------------
--Se crean las diferentes tablas que se van a usar para la limpieza y transformacion de datos
DROP TABLE IF EXISTS Clean.ak_output
GO 

CREATE TABLE Clean.ak_output (
	flight_id				NVARCHAR(100) PRIMARY KEY	,   
	airline_iata			VARCHAR(2)	NOT NULL	,    
	airline_icao			VARCHAR(3)	NOT NULL	,
	flight_number			VARCHAR(10)	NOT NULL	,
	departure_date			DATE					,
	dep_airport_iata		VARCHAR(3)				,
	arr_airport_iata		VARCHAR(3)				,
	scheduled_departure		DATETIME				,
	estimated_departure		DATETIME				,
	actual_departure		DATETIME				,
	scheduled_arrival		DATETIME				,
	estimated_arrival		DATETIME				,
	actual_arrival			DATETIME				,
	flight_status			VARCHAR(20)	NOT NULL	,
	dep_delay_minutes		INT						,
	arr_delay_minutes		INT						,
	aircraft_type			VARCHAR(10)
)


DROP TABLE IF EXISTS Clean.jt_output
GO 

CREATE TABLE Clean.jt_output(
	flight_id				NVARCHAR(100) PRIMARY KEY	,   
	airline_iata			VARCHAR(2)	NOT NULL	,    
	airline_icao			VARCHAR(3)	NOT NULL	,
	flight_number			VARCHAR(10)	NOT NULL	,
	departure_date			DATE					,
	dep_airport_iata		VARCHAR(3)				,
	arr_airport_iata		VARCHAR(3)				,
	scheduled_departure		DATETIME				,
	estimated_departure		DATETIME				,
	actual_departure		DATETIME				,
	scheduled_arrival		DATETIME				,
	estimated_arrival		DATETIME				,
	actual_arrival			DATETIME				,
	flight_status			VARCHAR(20)	NOT NULL	,
	dep_delay_minutes		INT						,
	arr_delay_minutes		INT						,
	aircraft_type			VARCHAR(10)
)


DROP TABLE IF EXISTS Clean.y4_output
GO 

CREATE TABLE Clean.y4_output(
	flight_id				NVARCHAR(100) PRIMARY KEY	,   
	airline_iata			VARCHAR(2)	NOT NULL	,    
	airline_icao			VARCHAR(3)	NOT NULL	,
	flight_number			VARCHAR(10)	NOT NULL	,
	departure_date			DATE					,
	dep_airport_iata		VARCHAR(3)				,
	arr_airport_iata		VARCHAR(3)				,
	scheduled_departure		DATETIME				,
	estimated_departure		DATETIME				,
	actual_departure		DATETIME				,
	scheduled_arrival		DATETIME				,
	estimated_arrival		DATETIME				,
	actual_arrival			DATETIME				,
	flight_status			VARCHAR(20)	NOT NULL	,
	dep_delay_minutes		INT						,
	arr_delay_minutes		INT						,
	aircraft_type			VARCHAR(10)
)

------------------------------------------------------------------------------------
--Se crean las diferentes tablas que se van a usar para traer la data final (Gold Layer)
DROP TABLE IF EXISTS GoldData.flights_unified
GO 

CREATE TABLE GoldData.flights_unified(
	flight_id				NVARCHAR(100) PRIMARY KEY	,   
	airline_iata			VARCHAR(2)	NOT NULL	,    
	airline_icao			VARCHAR(3)	NOT NULL	,
	flight_number			VARCHAR(10)	NOT NULL	,
	departure_date			DATE					,
	dep_airport_iata		VARCHAR(3)				,
	arr_airport_iata		VARCHAR(3)				,
	scheduled_departure		DATETIME				,
	estimated_departure		DATETIME				,
	actual_departure		DATETIME				,
	scheduled_arrival		DATETIME				,
	estimated_arrival		DATETIME				,
	actual_arrival			DATETIME				,
	flight_status			VARCHAR(20)	NOT NULL	,
	dep_delay_minutes		INT						,
	arr_delay_minutes		INT						,
	aircraft_type			VARCHAR(10)
)