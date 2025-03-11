USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_Bedturn_Bedmanagement]    Script Date: 11/3/2025 16:04:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [da].[HMD_SV_Bedturn_Bedmanagement]
AS

SELECT [Fiscal_Year]
		,[Actual_Date]
		,[Type]
		,SUM(ตัวตั้ง) / SUM(ตัวหาร) AS Result
		,SUM(ตัวตั้ง) AS ตัวตั้ง
		,SUM(ตัวหาร) AS ตัวหาร
		,BU
FROM
(
	SELECT 
		YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([DATE] as Date)),'yyyy-MM-01') as date))) as [Fiscal_Year]
		,CAST(FORMAT(DATEADD(YEAR,543,CAST([Date] as Date)),'yyyy-MM-01') as date) as [Actual_Date]
		,[Nursing_unit_code]
		,'อัตราหมุนเวียนเตียง' as [Type]
		,SUM(sum_discharge)  AS [ตัวตั้ง]
		,AVG(CAST( BED_MONTH AS float )) AS [ตัวหาร]
		,'IPD' AS [BU]
	FROM
	(
		SELECT 
			[DATE]
			,Nursing_unit_code
			,SUM(Discharge) AS SUM_Discharge
			,COUNT(DISTINCT Bed_no) -  SUM(Block_bed_condition) AS BED_MONTH
		--FROM [SiIMC_MGHT].[da].[hospitalbedmanagement_clean_joinmaster]
		FROM [SiIMC_MGHT].[da].[HMD_LT_AM_Bedmanagement] WITH (NOLOCK)
		WHERE Pseudo_bed_yn = 'N'
			AND  [Date] >= '2021-10-01'
		GROUP BY   [DATE] ,Nursing_unit_code
	) AS A
	GROUP BY  CAST(FORMAT(DATEADD(YEAR,543,CAST([Date] as Date)),'yyyy-MM-01') as date) , YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([DATE] as Date)),'yyyy-MM-01') as date))),Nursing_unit_code
) AS B

GROUP BY  [Fiscal_Year]
			,[Actual_Date]
			,[Type]
			,[BU]

UNION ALL

SELECT	[Fiscal_Year]
		,[Actual_Date]
		,[Type]
		,SUM(ตัวตั้ง) / SUM(ตัวหาร) AS [Result]
		,SUM(ตัวตั้ง) AS [ตัวตั้ง]
		,SUM(ตัวหาร) AS [ตัวหาร]
		,[BU]
FROM
(
	SELECT YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([DATE] as Date)),'yyyy-MM-01') as date))) as [Fiscal_Year]
			,CAST(FORMAT(DATEADD(YEAR,543,CAST([Date] as Date)),'yyyy-MM-01') as date) as [Actual_Date]
			,[Nursing_unit_code]
			,'อัตราหมุนเวียนเตียง' as [Type]
			,SUM(sum_discharge)  AS [ตัวตั้ง]
			,AVG(CAST( BED_MONTH AS float )) AS [ตัวหาร]
			,'SiSKN' AS [BU]
	FROM
	  (
		SELECT	[DATE]
				,[Nursing_unit_code]
				,SUM(Discharge) AS SUM_Discharge
				,COUNT(DISTINCT Bed_no) -  SUM(Block_bed_condition) AS BED_MONTH
		--FROM [SiIMC_MGHT].[da].[hospitalbedmanagement_clean_joinmaster]
		FROM [SiIMC_MGHT].[da].[HMD_LT_AM_Bedmanagement] WITH (NOLOCK)
		WHERE Pseudo_bed_yn = 'N'
			AND NURSING_UNIT_CODE IN ('7000','7001')
			AND  [Date] >= '2021-10-01'
		GROUP BY   [DATE],[Nursing_unit_code]
	  ) AS A
	GROUP BY	CAST(FORMAT(DATEADD(YEAR,543,CAST([Date] as Date)),'yyyy-MM-01') as date) , YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([DATE] as Date)),'yyyy-MM-01') as date))),Nursing_unit_code
) AS B
GROUP BY  [Fiscal_Year]
			,[Actual_Date]
			,[Type]
			,[BU]
GO


