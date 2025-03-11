USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_an_IPD]    Script Date: 11/3/2025 16:02:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER view [da].[HMD_SV_an_IPD]
AS

WITH ori as 
(
	SELECT YEAR(DATEADD(MONTH,3,[discharge_date])) as [Fiscal_Year]
			,CAST(FORMAT(DATEADD(YEAR,543,CAST([discharge_date] as Date)),'yyyy-MM-01') as date) as [Actual_Date]
			,COUNT(DISTINCT an) as Result
	FROM [SiIMC_MGHT].[dbo].[T_in_patient] WITH (NOLOCK)
	WHERE discharge_date >= '2020-10-01'  -- ห้องคลอด '302','303','309'
			AND ( 
					discharge_date  <  '2024-10-01' AND  ward_number NOT IN ('230','146','147')
				) -- ภูมิแพ้, สูงอายุ 1+2
			OR (
					discharge_date >= '2020-10-01' and ward_number NOT IN ('801')
				) --วิจัย
	GROUP BY YEAR(DATEADD(MONTH,3,[discharge_date])),CAST(FORMAT(DATEADD(YEAR,543,CAST([discharge_date] as Date)),'yyyy-MM-01') as date)
)


,ori2 as 
(
	SELECT YEAR(DATEADD(MONTH,3,[discharge_date])) as [Fiscal_Year]
			,CAST(FORMAT(DATEADD(YEAR,543,CAST([discharge_date] as Date)),'yyyy-MM-01') as date) as [Actual_Date]
			,COUNT(DISTINCT an) as Result
	FROM [SiIMC_MGHT].[dbo].[T_in_patient] WITH (NOLOCK)
	WHERE [discharge_date] = '2024-01-01' AND ward_number in ('146','147')
	GROUP BY YEAR(DATEADD(MONTH,3,[discharge_date])),CAST(FORMAT(DATEADD(YEAR,543,CAST([discharge_date] as Date)),'yyyy-MM-01') as date)
)

	SELECT 
		[Fiscal_Year],
		[Actual_Date],
		'จำนวน AN' as [Type],
		[Result],
		Result as [ตัวตั้ง],
		1 AS [ตัวหาร],
		'IPD' as [BU]
	FROM ori

	UNION ALL

	SELECT 
		[Fiscal_Year],
		[Actual_Date],
		'จำนวน AN' as [Type],
		[Result],
		Result as [ตัวตั้ง],
		1 AS [ตัวหาร],
		'SiSKN' as [BU]
	FROM ori2

GO
