USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_SirirajConnect]    Script Date: 11/3/2025 16:16:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [da].[HMD_SV_SirirajConnect]
AS

SELECT  IIF(MONTH(added_date) <= 9, YEAR(added_date) + 543, YEAR(added_date) + 544) AS [Fiscal_Year]
    ,CAST(DATEADD(YEAR, 543, DATEADD(MONTH, DATEDIFF(MONTH, 0, added_date), 0)) AS DATE) AS [Actual_Date]
	,'จำนวนผู้ลงทะเบียน Siriraj Connect (HN)' AS Type
	,COUNT (DISTINCT [hn]) AS Result
	,COUNT (DISTINCT [hn]) AS ตัวตั้ง
	,1 AS ตัวหาร
	,'All' AS [BU]
FROM [SiIMC_MGHT].[dbo].[T_smart_user] WITH (NOLOCK)
where eff_status='E'
GROUP BY IIF(MONTH(added_date) <= 9, YEAR(added_date) + 543, YEAR(added_date) + 544) 
    ,CAST(DATEADD(YEAR, 543, DATEADD(MONTH, DATEDIFF(MONTH, 0, added_date), 0)) AS DATE)

GO


