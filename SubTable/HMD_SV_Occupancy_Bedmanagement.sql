USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_Occupancy_Bedmanagement]    Script Date: 11/3/2025 16:07:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE view [da].[HMD_SV_Occupancy_Bedmanagement]
AS

SELECT 
    YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([DATE] as Date)),'yyyy-MM-01') as date))) as [Fiscal_Year]
	,CAST(FORMAT(DATEADD(YEAR,543,CAST([Date] as Date)),'yyyy-MM-01') as date) as [Actual_Date]
	,'อัตราครองเตียง' as [Type]
	,SUM(SUM_Endofday + SUM_Oneday) / CAST( SUM(COUNT_BED - sum_blockbed) AS float ) * 100 AS Result
	,SUM(SUM_Endofday) + SUM(SUM_Oneday) AS ตัวตั้ง
	,SUM(COUNT_BED - sum_blockbed) AS ตัวหาร
	,'IPD' AS BU
FROM
(
   SELECT 
		[DATE]
		,Nursing_unit_code
		,SUM([End of Day]) AS SUM_Endofday
		,SUM(OneDayStay) AS SUM_Oneday
		,COUNT(DISTINCT Bed_no) AS COUNT_BED
		,SUM(Block_bed_condition) AS sum_blockbed
	--FROM [SiIMC_MGHT].[da].[hospitalbedmanagement_clean_joinmaster]
	FROM [SiIMC_MGHT].[da].[HMD_LT_AM_Bedmanagement] WITH (NOLOCK)
	WHERE Pseudo_bed_yn = 'N'
		AND [DATE] >= '2021-10-01'
	GROUP BY [DATE] ,Nursing_unit_code
) AS A
GROUP BY  CAST(FORMAT(DATEADD(YEAR,543,CAST([Date] as Date)),'yyyy-MM-01') as date) , YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([DATE] as Date)),'yyyy-MM-01') as date)))

UNION ALL

SELECT 
	YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([DATE] as Date)),'yyyy-MM-01') as date))) as [Fiscal_Year]
	,CAST(FORMAT(DATEADD(YEAR,543,CAST([Date] as Date)),'yyyy-MM-01') as date) as [Actual_Date]
	,'อัตราครองเตียง' as [Type]
	,SUM(SUM_Endofday + SUM_Oneday) / CAST( SUM(COUNT_BED - sum_blockbed) AS float ) * 100 AS Result
	,SUM(SUM_Endofday) + SUM(SUM_Oneday) AS ตัวตั้ง
	,SUM(COUNT_BED - sum_blockbed) AS ตัวหาร
	,'SiSKN' AS BU
FROM
(
   SELECT 
		[DATE]
		,Nursing_unit_code
		,SUM([End of Day]) AS SUM_Endofday
		,SUM(OneDayStay) AS SUM_Oneday
		,COUNT(DISTINCT Bed_no) AS COUNT_BED
		,SUM(Block_bed_condition) AS sum_blockbed
	--FROM [SiIMC_MGHT].[da].[hospitalbedmanagement_clean_joinmaster]
	FROM [SiIMC_MGHT].[da].[HMD_LT_AM_Bedmanagement] WITH (NOLOCK)
	WHERE Pseudo_bed_yn = 'N'
		AND NURSING_UNIT_CODE IN ('7000','7001')
		AND [DATE] >= '2021-10-01'
	GROUP BY [DATE] ,Nursing_unit_code
) AS A
GROUP BY CAST(FORMAT(DATEADD(YEAR,543,CAST([Date] as Date)),'yyyy-MM-01') as date) , YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([DATE] as Date)),'yyyy-MM-01') as date)))

GO


