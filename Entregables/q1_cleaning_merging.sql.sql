
-- IMPORTANTE: SE TIENE QUE ESTABLECER LA RUTA EN DONDE SE ENCUENTRAN LOS ARCHIVOS

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


/********************************************************************************************************************/

-- Se inserta la data de todos los archivos 
BULK INSERT Test_DataAnalystMintData.RawData.ak_output
FROM 'C:\Test_DataAnalystMintData\RawData\ak_output_jun_aug_2025.csv'
WITH (
    FIELDTERMINATOR = ',',   -- separador de columnas
    ROWTERMINATOR = '\n',    -- salto de línea
    FIRSTROW = 2             -- si tienes encabezados
);


BULK INSERT Test_DataAnalystMintData.RawData.jt_output
FROM 'C:\Test_DataAnalystMintData\RawData\jt_output_jun_aug_2025.csv'
WITH (
    FIELDTERMINATOR = ',',   -- separador de columnas
    ROWTERMINATOR = '\n',    -- salto de línea
    FIRSTROW = 2             -- si tienes encabezados
);


BULK INSERT Test_DataAnalystMintData.RawData.y4_output
FROM 'C:\Test_DataAnalystMintData\RawData\y4_output_jun_aug_2025.csv'
WITH (
    FIELDTERMINATOR = ',',   -- separador de columnas
    ROWTERMINATOR = '\n',    -- salto de línea
    FIRSTROW = 2             -- si tienes encabezados
);

-- Se valida que la data se inserto correctamente
SELECT COUNT(*) AS Conteo 
FROM Test_DataAnalystMintData.RawData.ak_output;

SELECT TOP(5) *
FROM Test_DataAnalystMintData.RawData.ak_output;


SELECT COUNT(*) AS Conteo 
FROM Test_DataAnalystMintData.RawData.jt_output;

SELECT TOP(5) *
FROM Test_DataAnalystMintData.RawData.jt_output;


SELECT COUNT(*) AS Conteo 
FROM Test_DataAnalystMintData.RawData.y4_output;

SELECT TOP(5) *
FROM Test_DataAnalystMintData.RawData.y4_output;

/********************************************************************************************************************/

-- Se realiza la limpieza y transformacion de datos para poderlas insertar en la tabla ak_output del esquema Clean
INSERT INTO Test_DataAnalystMintData.Clean.ak_output (flight_id,airline_iata,airline_icao,flight_number,departure_date,dep_airport_iata,arr_airport_iata,scheduled_departure,estimated_departure,actual_departure,scheduled_arrival,estimated_arrival,
            actual_arrival,flight_status,dep_delay_minutes,arr_delay_minutes,aircraft_type)
    SELECT  flight_id           =   NEWID(),
            airline_iata        =   'AK',
            airline_icao        =   'AXM',
            flightNumber        =   SUBSTRING(flight_id,3,CHARINDEX('_', flight_id) - 3),
            departure_date      =   TRY_CAST(flightDate AS DATE),
            dep_airport_iata    =   CASE WHEN UPPER(TRIM(flightDep)) LIKE '[A-Z][A-Z][A-Z]' THEN UPPER(TRIM(flightDep))
                                        ELSE NULL
                                    END,
            arr_airport_iata    =   CASE WHEN UPPER(TRIM(flightArr)) LIKE '[A-Z][A-Z][A-Z]' THEN UPPER(TRIM(flightArr))
                                        ELSE NULL
                                    END,
            scheduled_departure =   TRY_CAST(flight_dep_scheduled_full AS DATETIME2),
            estimated_departure =   TRY_CAST(flight_dep_estimated_full AS DATETIME2),
            actual_departure    =   TRY_CAST(flight_dep_actual_full AS DATETIME2),
            scheduled_arrival   =   TRY_CAST(flight_arr_scheduled_full AS DATETIME2),
            estimated_arrival   =   TRY_CAST(flight_arr_estimated_full AS DATETIME2),
            actual_arrival      =   TRY_CAST(flight_arr_actual_full AS DATETIME2),
            flight_status       =   CASE    WHEN UPPER(flightStatus) IN ('LANDED') THEN 'ARRIVED'
                                            WHEN UPPER(flightStatus) IN ('DELAYED') THEN 'DELAYED'
                                            WHEN UPPER(flightStatus) IN ('CANCELLED') THEN 'CANCELLED'
                                            WHEN UPPER(flightStatus) IN ('ON TIME', 'ONTIME') THEN 'ON_TIME'
                                        ELSE 'UNKNOWN'
                                    END,
            dep_delay_minutes   =   DATEDIFF(MINUTE,TRY_CAST(flight_dep_scheduled_full AS DATETIME2),TRY_CAST(flight_dep_actual_full AS DATETIME2)),
            arr_delay_minutes   =   DATEDIFF(MINUTE,TRY_CAST(flight_arr_scheduled_full AS DATETIME2),TRY_CAST(flight_arr_actual_full AS DATETIME2)),
            aircraft_type       =   NULLIF(REPLACE(REPLACE(rego,'"',''),'null',''), '')
    FROM Test_DataAnalystMintData.RawData.ak_output;


-- Se realiza la limpieza y transformacion de datos para poderlas insertar en la tabla jt_output del esquema Clean
INSERT INTO Test_DataAnalystMintData.Clean.jt_output (flight_id,airline_iata,airline_icao,flight_number,departure_date,dep_airport_iata,arr_airport_iata,scheduled_departure,estimated_departure,actual_departure,scheduled_arrival,estimated_arrival,
            actual_arrival,flight_status,dep_delay_minutes,arr_delay_minutes,aircraft_type)
SELECT  flight_uid          =   NEWID(),
        airline_iata        =   'JT',
        airline_icao        =   'LNI',
        flightNumber        =   SUBSTRING(flight_id,1,CHARINDEX('_', flight_id)-1),
        departure_date      =   TRY_CAST(SUBSTRING(flight_id,CHARINDEX('_', flight_id) + 1,10)AS DATE),
        dep_airport_iata    =   CASE WHEN ISJSON(CONCAT(REPLACE(REPLACE(originAirport,'""','"'),'"{','{'),'}')) = 1 THEN JSON_VALUE(CONCAT(REPLACE(REPLACE(originAirport,'""','"'),'"{','{'),'}'), '$.code.S')
                                    ELSE NULL
                                END,
        arr_airport_iata    =   CASE WHEN ISJSON(CONCAT(REPLACE(REPLACE(destAirport,'""','"'),'"{','{'),'}')) = 1 THEN JSON_VALUE(CONCAT(REPLACE(REPLACE(destAirport,'""','"'),'"{','{'),'}'), '$.code.S')
                                    ELSE NULL
                                END,
        scheduled_departure =   CASE WHEN ISJSON(CONCAT(REPLACE(REPLACE(timings,'""','"'),'"{','{'),'}')) = 1 THEN JSON_VALUE(CONCAT(REPLACE(REPLACE(REPLACE(timings,'"{','{'),'""','"'),'}"','}'),'}}','}'), '$.scheduledDepTime.N')
                                    ELSE NULL
                                END,
        estimated_departure =   CASE WHEN ISJSON(CONCAT(REPLACE(REPLACE(timings,'""','"'),'"{','{'),'}')) = 1 THEN JSON_VALUE(CONCAT(REPLACE(REPLACE(REPLACE(timings,'"{','{'),'""','"'),'}"','}'),'}}','}'), '$.scheduledDepTime.N')
                                    ELSE NULL
                                END,
        actual_departure    =   CASE WHEN ISJSON(CONCAT(REPLACE(REPLACE(timings,'""','"'),'"{','{'),'}')) = 1 THEN JSON_VALUE(CONCAT(REPLACE(REPLACE(REPLACE(timings,'"{','{'),'""','"'),'}"','}'),'}}','}'), '$.actualDepTime.N')
                                    ELSE NULL
                                END,
        scheduled_arrival   =   CASE WHEN ISJSON(CONCAT(REPLACE(REPLACE(timings,'""','"'),'"{','{'),'}')) = 1 THEN JSON_VALUE(CONCAT(REPLACE(REPLACE(REPLACE(timings,'"{','{'),'""','"'),'}"','}'),'}}','}'), '$.scheduledArrTime.N')
                                    ELSE NULL
                                END,
        estimated_arrival   =   CASE WHEN ISJSON(CONCAT(REPLACE(REPLACE(timings,'""','"'),'"{','{'),'}')) = 1 THEN JSON_VALUE(CONCAT(REPLACE(REPLACE(REPLACE(timings,'"{','{'),'""','"'),'}"','}'),'}}','}'), '$.estimatedArrTime.N')
                                    ELSE NULL
                                END,
        actual_arrival      =   CASE WHEN ISJSON(CONCAT(REPLACE(REPLACE(timings,'""','"'),'"{','{'),'}')) = 1 THEN JSON_VALUE(CONCAT(REPLACE(REPLACE(REPLACE(timings,'"{','{'),'""','"'),'}"','}'),'}}','}'), '$.actualArrTime.N')
                                    ELSE NULL
                                END,
        flight_status      =    'UNKNOWN',
        dep_delay_minutes   =   0,
        arr_delay_minutes   =   0,
        aircraftType        =   CASE  WHEN aircraftType LIKE '[A-Z][0-9][0-9][0-9]%'   THEN LEFT(aircraftType, 4)
                                    WHEN aircraftType LIKE '[A-Z][0-9][0-9][A-Z]%'   THEN LEFT(aircraftType, 4)
                                    WHEN aircraftType LIKE '[A-Z][A-Z][A-Z]'         THEN LEFT(aircraftType, 4)
                                    WHEN aircraftType LIKE '%737%' THEN 'B737'
                                    ELSE NULL
                                END
FROM Test_DataAnalystMintData.RawData.jt_output;      


-- Se realiza la limpieza y transformacion de datos para poderlas insertar en la tabla y4_output del esquema Clean
INSERT INTO Test_DataAnalystMintData.Clean.y4_output (flight_id,airline_iata,airline_icao,flight_number,departure_date,dep_airport_iata,arr_airport_iata,
			scheduled_departure,estimated_departure,actual_departure,scheduled_arrival,estimated_arrival,
            actual_arrival,flight_status,dep_delay_minutes,arr_delay_minutes,aircraft_type)
SELECT  flight_uid          =   NEWID(),
        airline_iata        =   'Y4',
        airline_icao        =   'VOI',
        flight_number       =   CASE WHEN flight_id LIKE 'Y4%_%' THEN SUBSTRING(flight_id,3,CHARINDEX('_', flight_id) - 3)
                                    ELSE NULL
                                END,
        departure_date      =   TRY_CAST(departureDate AS DATE),
        dep_airport_iata    =   UPPER(TRIM(departure)),
        arr_airport_iata    =   UPPER(TRIM(destination)),
        scheduled_departure =   TRY_CAST(CONCAT(departureDate, ' ', scheduledDeparture) AS DATETIME2),
        estimated_departure =   TRY_CAST(CONCAT(departureDate, ' ', estimatedDeparture) AS DATETIME2),
        actual_departure    =   NULL,
        scheduled_arrival   =   TRY_CAST(CONCAT(arrivalDate, ' ', scheduledArrival) AS DATETIME2),
        estimated_arrival   =   TRY_CAST(CONCAT(arrivalDate, ' ', estimatedArrival)AS DATETIME2),
        actual_arrival      =   NULL,
        flight_status       =   CASE    WHEN UPPER(flightStatus) = 'ON TIME'    THEN 'ON_TIME'
                                        WHEN UPPER(flightStatus) = 'DELAYED'    THEN 'DELAYED'
                                        WHEN UPPER(flightStatus) = 'CANCELLED'  THEN 'CANCELLED'
                                        WHEN UPPER(flightStatus) = 'LANDED'     THEN 'ARRIVED'
                                        ELSE 'UNKNOWN'
                                END,
        dep_delay_minutes   =   NULL,
        arr_delay_minutes   =   NULL,
        aircraft_type       =   NULLIF(TRIM(aircraftFamily),'')
FROM Test_DataAnalystMintData.RawData.y4_output;


/********************************************************************************************************************/
-- Se realiza la union de toda la informacion en la tabla Test_DataAnalystMintData.GoldData.flights_unified;

WITH AllInfo AS (
	SELECT *
	FROM Test_DataAnalystMintData.Clean.ak_output ak
	UNION ALL 
	SELECT *
	FROM Test_DataAnalystMintData.Clean.jt_output jt
	UNION ALL 
	SELECT *
	FROM Test_DataAnalystMintData.Clean.y4_output y4
)
INSERT INTO Test_DataAnalystMintData.GoldData.flights_unified (flight_id,airline_iata,airline_icao,flight_number,departure_date,dep_airport_iata,arr_airport_iata,scheduled_departure,estimated_departure,actual_departure,scheduled_arrival,estimated_arrival,
            actual_arrival,flight_status,dep_delay_minutes,arr_delay_minutes,aircraft_type)
SELECT *
FROM AllInfo;

SELECT *
FROM Test_DataAnalystMintData.GoldData.flights_unified;




