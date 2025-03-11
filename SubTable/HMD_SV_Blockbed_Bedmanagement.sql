USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_Blockbed_Bedmanagement]    Script Date: 11/3/2025 16:04:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [da].[HMD_SV_Blockbed_Bedmanagement]
AS

SELECT YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([DATE] as Date)),'yyyy-MM-01') as date))) as [Fiscal_Year]
		,CAST(FORMAT(DATEADD(YEAR,543,CAST([Date] as Date)),'yyyy-MM-01') as date) as [Actual_Date]
		,'อัตราการปิดเตียง' as [Type]
		,(SUM([sum_blockbed]) / SUM([COUNT_BED])) * 100 AS Result
		,SUM([sum_blockbed]) AS ตัวตั้ง
		,SUM([COUNT_BED]) AS ตัวหาร
		,'IPD' AS BU
FROM
(
	SELECT [DATE]
			,[Nursing_unit_code]
			,CAST(COUNT(DISTINCT [Bed_no]) AS FLOAT) AS [COUNT_BED]
			,CAST(SUM(Block_bed_condition) AS FLOAT) AS sum_blockbed
	--FROM [SiIMC_MGHT].[da].[hospitalbedmanagement_clean_joinmaster] WITH (NOLOCK)
	FROM [SiIMC_MGHT].[da].[HMD_LT_AM_Bedmanagement] WITH (NOLOCK)
	WHERE Pseudo_bed_yn = 'N'
		AND [Date] >= '2021-10-01'
	GROUP BY [DATE],[Nursing_unit_code]
) AS A

GROUP BY  CAST(FORMAT(DATEADD(YEAR,543,CAST([Date] as Date)),'yyyy-MM-01') as date)
			,YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([DATE] as Date)),'yyyy-MM-01') as date)))


GO


