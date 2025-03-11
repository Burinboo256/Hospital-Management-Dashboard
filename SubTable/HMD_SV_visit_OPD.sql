USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_visit_OPD]    Script Date: 11/3/2025 16:19:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE view [da].[HMD_SV_visit_OPD]
as
	with OPD as
	(
	SELECT DISTINCT 
		CAST(FORMAT(DATEADD(YEAR,543,CAST([VISIT_DATE] as Date)),'yyyy-MM-01') as date) as [Actual_Date]
			,COUNT(DISTINCT VISIT_NUMBER) as [OPD]
			,COUNT(DISTINCT IIF(clinic_code IN ('1114','1115'),VISIT_NUMBER, null)) as [VC]
			,COUNT(DISTINCT IIF(clinic_code in ('4780','4781','4782','4783','4784','4785','4786','4787','4788','4789','4794','4795','4796','4797','4798','4799','4744','4746','47ac'),VISIT_NUMBER,null)) as [HSolution]
			,COUNT(DISTINCT IIF(clinic_code in ('4767','4779'),VISIT_NUMBER,null)) as [BOT]
			,COUNT(DISTINCT IIF(LEFT(clinic_code,2) = '64',VISIT_NUMBER,null)) as [SiSKN]
	FROM [dbo].[T_out_patient_visit_details_info] WITH (NOLOCK)
	WHERE visit_date >= '2020-10-01'
	GROUP BY CAST(FORMAT(DATEADD(YEAR,543,CAST([VISIT_DATE] as Date)),'yyyy-MM-01') as date)
	)

	SELECT 
		YEAR(DATEADD(MONTH, 3, [Actual_Date])) AS [Fiscal_Year],
		[Actual_Date],
		[Type],
		[Visit_Count] - IIF([BU]='OPD',[VC],0) AS [Result],
		[Visit_Count] - IIF([BU]='OPD',[VC],0) AS [ตัวตั้ง],
		1 AS [ตัวหาร],
		[BU]
	FROM 
	(
		SELECT 
			[Actual_Date],
			'จำนวน VISIT OPD' AS [Type],
			[OPD], [VC], [HSolution], [BOT], [SiSKN]
		FROM OPD
	) AS SourceTable
	UNPIVOT
	(
		[Visit_Count] FOR [BU] IN ([OPD], [BOT], [HSolution], [SiSKN])
	) AS Unpivoted
GO


