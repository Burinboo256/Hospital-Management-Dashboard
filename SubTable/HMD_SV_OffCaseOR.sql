USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_OffCaseOR]    Script Date: 11/3/2025 16:07:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [da].[HMD_SV_OffCaseOR] AS

WITH Month1 AS (
    SELECT DATEFROMPARTS(2019, 1, 1) AS [Date]
    UNION ALL
    SELECT DATEADD(MONTH, 1, [Date])
    FROM Month1
    WHERE [Date] < FORMAT(GETDATE(), 'yyyy-MM-01')
)
, Month2 AS (

    SELECT 
        YEAR(DATEADD(MONTH, 3, CAST(DATEADD(YEAR, 543, CAST([Date] AS Date)) AS Date))) AS [Fiscal_Year],
        CAST(DATEADD(YEAR, 543, CAST([Date] AS Date)) AS Date) AS [Actual_Date]
    FROM Month1
),
Month3 AS (
	SELECT 'preventable' AS [Type]
	UNION ALL
	SELECT 'unpreventable' AS [Type]
	UNION ALL
	SELECT 'other' AS [Type]
),
Month5 AS (
	SELECT 'IPD' AS [BU]
	UNION ALL
	SELECT 'OPD' AS [BU]
),
Month6 AS (
	SELECT Month2.*,Month3.*
	FROM Month2
	CROSS JOIN Month3
),
Month4 AS (
	SELECT Month6.*,Month5.*
	FROM Month6
	CROSS JOIN Month5
),
MAIN AS (
		SELECT l.[Actual_Date],l.[Type],(CAST(l.[ตัวตั้ง] AS FLOAT)/CAST(r.[ตัวหาร] AS FLOAT)) AS [Result],l.[ตัวตั้ง],r.[ตัวหาร],l.[BU]
		FROM (SELECT FORMAT(DATEADD(YEAR,543,[วันที่]),'yyyy-MM-01') AS [Actual_Date],[preventable/ unpreventable] AS [Type],[OPD/IPD] AS [BU],COUNT(DISTINCT CONCAT(FORMAT([วันที่],'yyyyMMdd'),'|',[HN],'|',[ORF])) AS [ตัวตั้ง]
			  FROM [SiIMC_MGHT].[da].[T_RM_OffCaseOR_Excel1]
			  GROUP BY FORMAT(DATEADD(YEAR,543,[วันที่]),'yyyy-MM-01'),[preventable/ unpreventable],[OPD/IPD]) AS l
		LEFT JOIN (SELECT FORMAT(CASE WHEN DATEDIFF(YEAR ,GETDATE(),CAST([Date_Operation] AS DATETIME2)) < 490 THEN DATEADD(YEAR,543,CAST([Date_Operation] AS DATETIME2))
									  ELSE CAST([Date_Operation] AS DATETIME2)
									  END,'yyyy-MM-01') AS [Actual_Date],
							COUNT(DISTINCT [ORSetID]) AS [ตัวหาร]
					FROM [SiIMC_MGHT].[dbo].[OSS_SetCase]
					GROUP BY FORMAT(CASE WHEN DATEDIFF(YEAR ,GETDATE(),CAST([Date_Operation] AS DATETIME2)) < 490 THEN DATEADD(YEAR,543,CAST([Date_Operation] AS DATETIME2))
										 ELSE CAST([Date_Operation] AS DATETIME2)
										 END,'yyyy-MM-01')) AS r
	    ON l.[Actual_Date] = r.[Actual_Date]
		),
 DF AS (
    SELECT [Actual_Date],[Type],SUM([ตัวตั้ง]) AS [ตัวตั้ง],[ตัวหาร]
	FROM MAIN 
	GROUP BY [Actual_Date],[Type],[ตัวหาร]
 ),
 QT AS(
	SELECT DISTINCT m.*
	FROM (SELECT FORMAT(CASE WHEN DATEDIFF(YEAR ,GETDATE(),CAST([Date_Operation] AS DATETIME2)) < 490 THEN DATEADD(YEAR,543,CAST([Date_Operation] AS DATETIME2))
									  ELSE CAST([Date_Operation] AS DATETIME2)
									  END,'yyyy-MM-01') AS [Actual_Date],
							COUNT(DISTINCT [ORSetID]) AS [ตัวหาร]
					FROM [SiIMC_MGHT].[dbo].[OSS_SetCase]
					GROUP BY FORMAT(CASE WHEN DATEDIFF(YEAR ,GETDATE(),CAST([Date_Operation] AS DATETIME2)) < 490 THEN DATEADD(YEAR,543,CAST([Date_Operation] AS DATETIME2))
										 ELSE CAST([Date_Operation] AS DATETIME2)
										 END,'yyyy-MM-01')) AS m
	WHERE (m.[Actual_Date] IS NOT NULL)
 )
 SELECT DISTINCT Month4.[Fiscal_Year],Month4.[Actual_Date],Month4.[Type],ISNULL(MAIN.[Result],0) AS [Result],ISNULL(MAIN.[ตัวตั้ง],0) AS [ตัวตั้ง],ISNULL(QT.[ตัวหาร],0) AS [ตัวหาร], Month4.[BU]
 FROM Month4
 LEFT JOIN MAIN
 ON (Month4.[Actual_Date] = MAIN.[Actual_Date]) AND (Month4.[Type]=MAIN.[Type]) AND (Month4.[BU] = MAIN.[BU])
 LEFT JOIN QT
 ON (Month4.[Actual_Date] = QT.[Actual_Date])
 WHERE [Fiscal_Year] >= YEAR(DATEADD(YEAR,538,GETDATE()))

 UNION ALL

 SELECT DISTINCT Month4.[Fiscal_Year], Month4.[Actual_Date],Month4.[Type],CAST(ISNULL(DF.[ตัวตั้ง],0)AS FLOAT)/CAST(ISNULL(QT.[ตัวหาร],1) AS FLOAT) AS [Result], ISNULL(DF.[ตัวตั้ง],0) AS [ตัวตั้ง],ISNULL(QT.[ตัวหาร],0) AS [ตัวหาร], 'All' AS [BU]
 FROM Month4
 LEFT JOIN DF
 ON (Month4.[Actual_Date] = DF.[Actual_Date]) AND (Month4.[Type]=DF.[Type])
 LEFT JOIN QT
 ON (Month4.[Actual_Date] = QT.[Actual_Date])
 WHERE [Fiscal_Year] >= YEAR(DATEADD(YEAR,538,GETDATE()))
GO


