USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_OSS]    Script Date: 11/3/2025 16:08:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [da].[HMD_SV_OSS]
AS

(
	SELECT YEAR(DATEADD(MONTH,3,InOR)) as [Fiscal_Year]
		,CAST(FORMAT(DATEADD(YEAR,543,CAST(InOR as Date)),'yyyy-MM-01') as date) as [Actual_Date]
		,'จำนวนรายผ่าตัด' AS [Type]
		,COUNT(DISTINCT ORSetID) AS [Result]
		,COUNT(DISTINCT ORSetID) AS [ตัวตั้ง]
		,1 AS [ตัวหาร]
		,'IPD' as [BU]
	FROM dbo.OSS_T_Orutilize_ORAdmission WITH (NOLOCK)
	WHERE CaseStatus IN ('1','5') --OPD
		AND InOR >= '2020-10-01'
		AND CheckOut IS NOT NULL
	GROUP BY YEAR(DATEADD(MONTH,3,InOR))
		,CAST(FORMAT(DATEADD(YEAR,543,CAST(InOR as Date)),'yyyy-MM-01') as date)
)

UNION ALL

(
	SELECT YEAR(DATEADD(MONTH,3,InOR)) as [Fiscal_Year]
		,CAST(FORMAT(DATEADD(YEAR,543,CAST(InOR as Date)),'yyyy-MM-01') as date) as [Actual_Date]
		,'จำนวนรายผ่าตัด' AS [Type]
		,COUNT(DISTINCT ORSetID) AS [Result]
		,COUNT(DISTINCT ORSetID) AS [ตัวตั้ง]
		,1 AS [ตัวหาร]
		,'OPD' as [BU]
	FROM dbo.OSS_T_Orutilize_ORAdmission WITH (NOLOCK)
	WHERE CaseStatus IN ('2','3','4') --IPD
		AND InOR >= '2020-10-01'
		AND CheckOut IS NOT NULL
	GROUP BY YEAR(DATEADD(MONTH,3,InOR))
		,CAST(FORMAT(DATEADD(YEAR,543,CAST(InOR as Date)),'yyyy-MM-01') as date)
)

GO


