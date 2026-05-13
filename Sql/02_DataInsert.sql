
USE Test_DataAnalystMintData
GO

-- IMPORTANTE: Se tiene que establecer la ruta en donde se encuentran los archivos
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









