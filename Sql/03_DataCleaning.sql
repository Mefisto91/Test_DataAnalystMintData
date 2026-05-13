
USE Test_DataAnalystMintData
GO

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
        --CASE    WHEN UPPER(JSON_VALUE(statusMap, '$.status.S')) = 'SCHEDULED'  THEN 'SCHEDULED'
        --                                WHEN UPPER(JSON_VALUE(arrivalDeviation, '$.status.S')) = 'ARRIVED'  THEN 'ARRIVED'
        --                                WHEN UPPER(JSON_VALUE(departureDeviation, '$.deviationType.S')) = 'DELAY'   THEN 'DELAYED'  
        --                                ELSE 'UNKNOWN'
        --                        END,
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
INSERT INTO Test_DataAnalystMintData.Clean.y4_output (flight_id,airline_iata,airline_icao,flight_number,departure_date,dep_airport_iata,arr_airport_iata,scheduled_departure,estimated_departure,actual_departure,scheduled_arrival,estimated_arrival,
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








