
-- Declaro mi base de datos a usar
USE Test_DataAnalystMintData
GO

-- Declaro la primer CTE con el fin de obtener las diferencias de los minutos
WITH Differences AS (
	SELECT	dep_airport_iata	=	f.dep_airport_iata
			,arr_airport_iata	=	f.arr_airport_iata
			,[Route]			=	CONCAT(f.dep_airport_iata, '-',f.arr_airport_iata)
			,[Month]			=	MONTH(f.estimated_departure)
			,total_flights		=	COUNT(*)
			,flight_number		=	f.flight_number
			,times_problematic	=	DATEDIFF(MINUTE,f.estimated_departure,f.scheduled_departure)
			,avg_dep_delay_min	=	AVG(f.dep_delay_minutes)
			,Avg_arr_delay_min	=	AVG(f.arr_delay_minutes)
			,DateDiffArrival	=	DATEDIFF(MINUTE,f.estimated_arrival,f.scheduled_arrival)
	FROM Test_DataAnalystMintData.GoldData.flights_unified f
	WHERE DATEDIFF(MINUTE,f.estimated_departure,f.scheduled_departure) >= 30
		OR DATEDIFF(MINUTE,f.estimated_arrival,f.scheduled_arrival) >=	30
	GROUP BY f.dep_airport_iata
			,f.arr_airport_iata
			,f.flight_number
			,f.estimated_departure
			,f.scheduled_departure
			,f.estimated_arrival
			,f.scheduled_arrival
),

-- Declaro mi segunda CTE con el fin de obtener el ranking de los vuelos
Ranking AS (
	SELECT	d.dep_airport_iata
			,d.arr_airport_iata
			,d.[Route]
			,d.[Month]
			,d.total_flights
			,d.flight_number
			,d.times_problematic
			,d.avg_dep_delay_min
			,d.Avg_arr_delay_min
			,d.DateDiffArrival
			,rank_in_route_month	=	DENSE_RANK() OVER (PARTITION BY d.[Route] ORDER BY d.DateDiffArrival)
FROM Differences d
GROUP BY	d.dep_airport_iata
			,d.arr_airport_iata
			,d.[Route]
			,d.[Month]
			,d.total_flights
			,d.flight_number
			,d.times_problematic
			,d.avg_dep_delay_min
			,d.Avg_arr_delay_min
			,d.DateDiffArrival
)

-- Muestro los datos solicitados finalmente
SELECT	r.dep_airport_iata
		,r.arr_airport_iata
		,r.[Month]
		,r.total_flights
		,r.flight_number
		,r.times_problematic
		,r.avg_dep_delay_min
		,r.Avg_arr_delay_min
		,r.DateDiffArrival
		,r.rank_in_route_month	
FROM Ranking r
WHERE r.rank_in_route_month <= 3
ORDER BY r.dep_airport_iata
		,r.arr_airport_iata 
		,r.[Month]
		,r.rank_in_route_month
;
