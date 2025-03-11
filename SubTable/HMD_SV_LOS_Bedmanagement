USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_LOS_Bedmanagement]    Script Date: 11/3/2025 16:06:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [da].[HMD_SV_LOS_Bedmanagement]
AS

SELECT YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([DATE] as Date)),'yyyy-MM-01') as date))) as [Fiscal_Year]
		,CAST(FORMAT(DATEADD(YEAR,543,CAST([Date] as Date)),'yyyy-MM-01') as date) as [Actual_Date]
		,'จำนวนวันนอนเฉลี่ย' as [Type]
		,SUM([SUM_LOS])/SUM(CAST([count_an] as float))  AS [Result]
		,SUM([SUM_LOS])  AS [ตัวตั้ง]
		,SUM([count_an]) AS [ตัวหาร]
		,'IPD' AS [BU]
FROM
(
   SELECT [DATE]
			,[Nursing_unit_code]
			,SUM([d/c_LOS]) AS SUM_LOS
			,COUNT(DISTINCT [d/c_encounter_id])  AS count_an
FROM 
	(
		SELECT DISTINCT [Date]
			,[yyyymm]
			,[Nursing_unit_code]
			,[LONG_DESC]
			,[SHORT_DESC]
			,[Bed_class_code]
			,[Pseudo_bed_yn]
			,[ENCOUNTER_ID]
			,[Bed_no]
			,[TRN_TYPE]
			,[d/c_encounter_id]
			,[d/c_icd_10]
			,[d/c_disease_name]
			,[d/c_ADJUSTED_RELATIVE_WEIGHT]
			,[d/c_LOS]
		--FROM [SiIMC_MGHT].[da].[hospitalbedmanagement_clean_joinmaster]
		FROM [SiIMC_MGHT].[da].[HMD_LT_AM_Bedmanagement] WITH (NOLOCK)
		WHERE Pseudo_bed_yn = 'N'
			AND [Date] >= '2021-10-01'
  ) AS C
  GROUP BY [DATE],[Nursing_unit_code]
) AS A
GROUP BY CAST(FORMAT(DATEADD(YEAR,543,CAST([Date] as Date)),'yyyy-MM-01') as date) , YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([DATE] as Date)),'yyyy-MM-01') as date)))

UNION ALL

SELECT YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([DATE] as Date)),'yyyy-MM-01') as date))) as [Fiscal_Year]
		,CAST(FORMAT(DATEADD(YEAR,543,CAST([Date] as Date)),'yyyy-MM-01') as date) as [Actual_Date]
		,'จำนวนวันนอนเฉลี่ย' as [Type]
		,SUM([SUM_LOS])/SUM(CAST([count_an] as float))  AS [Result]
		,SUM([SUM_LOS]) AS [ตัวตั้ง]
		,SUM([count_an]) AS [ตัวหาร]
		,'SiSKN' AS BU
FROM
(
	SELECT [DATE]
			,[Nursing_unit_code]
			,SUM([d/c_LOS]) AS SUM_LOS
			,COUNT(DISTINCT [d/c_encounter_id])  AS count_an
	FROM 
	(
		SELECT DISTINCT [Date]
			,[yyyymm]
			,[Nursing_unit_code]
			,[LONG_DESC]
			,[SHORT_DESC]
			,[Bed_class_code]
			,[Pseudo_bed_yn]
			,[ENCOUNTER_ID]
			,[Bed_no]
			,[TRN_TYPE]
			,[d/c_encounter_id]
			,[d/c_icd_10]
			,[d/c_disease_name]
			,[d/c_ADJUSTED_RELATIVE_WEIGHT]
			,[d/c_LOS]
		--FROM [SiIMC_MGHT].[da].[hospitalbedmanagement_clean_joinmaster]
		FROM [SiIMC_MGHT].[da].[HMD_LT_AM_Bedmanagement] WITH (NOLOCK)
		WHERE Pseudo_bed_yn = 'N'
			AND NURSING_UNIT_CODE IN ('7000','7001')
			AND [Date] >= '2021-10-01'
	) AS C
	GROUP BY [DATE],[Nursing_unit_code]
) AS A
GROUP BY CAST(FORMAT(DATEADD(YEAR,543,CAST([Date] as Date)),'yyyy-MM-01') as date) , YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([DATE] as Date)),'yyyy-MM-01') as date)))

GO


