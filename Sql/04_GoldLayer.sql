
USE Test_DataAnalystMintData
GO


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
FROM AllInfo
	