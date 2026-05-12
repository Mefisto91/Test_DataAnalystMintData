
USE Test_DataAnalystMintData
GO

INSERT INTO Clean.ak_output
-- Se realiza la limpieza y transformacion de datos para poderlas insertar en la tabla final
    SELECT  flight_id           =   NEWID(),
            airline_iata        =   'AK',
            airline_icao        =   'AXM',
            flightNumber        =   REPLACE(REPLACE(REPLACE(TRIM(flightNumber), '"', ''),'AK', ''),' ', ''),
            departure_date      =   TRY_CAST(flightDate AS DATE),
            dep_airport_iata    =   UPPER(TRIM(flightDep)),
            arr_airport_iata    =   UPPER(TRIM(flightArr)),
            scheduled_departure =   TRY_CAST(flight_dep_scheduled_full AS DATETIME2),
            estimated_departure =   TRY_CAST(flight_dep_estimated_full AS DATETIME2),
            actual_departure    =   TRY_CAST(flight_dep_estimated_full AS DATETIME2),
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

--SELECT TOP(1) *
--FROM Test_DataAnalystMintData.RawData.ak_output;

