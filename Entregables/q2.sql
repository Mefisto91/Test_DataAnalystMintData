
-- Declaro mi base de datos a usar
USE Test_DataAnalystMintData
GO

-- Genero la consulta que me va a entregar el conteo de vuelos por dia
SELECT	flight_date		=	DAY(f.scheduled_departure) 
		,airline_iata	=	f.airline_iata
		,flight_count	=	COUNT(*)
FROM Test_DataAnalystMintData.GoldData.flights_unified f
GROUP BY	f.airline_iata
			,DAY(f.scheduled_departure) 
HAVING DAY(f.scheduled_departure)  IS NOT NULL -- Espercifico que no se tomen en cuenta los dias que tienen Null
ORDER BY	flight_date		ASC
			,airline_iata	ASC
;

-- Muestro los primeros 20 resultados
/*

flight_date	airline_iata	flight_count
1			AK				412
1			Y4				528
2			AK				252
2			Y4				292
3			AK				104
3			Y4				152
4			AK				33
4			Y4				53
5			AK				9
5			Y4				14
6			AK				2
6			Y4				9
7			AK				1
7			Y4				3
8			Y4				3
9			Y4				3
10			Y4				3
11			Y4				3
12			Y4				3
13			Y4				3


*/
