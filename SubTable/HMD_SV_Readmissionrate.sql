USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_Readmissionrate]    Script Date: 11/3/2025 16:14:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [da].[HMD_SV_Readmissionrate]
AS

WITH readmission_ตัวตั้ง AS
(
	SELECT	a.*
			,b.[before_an_icd10]
			,c.[icd_an_10]
			,[datediff_hour]
	FROM
	(
		SELECT [an]
				,LAG([an],1,0) OVER (PARTITION BY HN ORDER BY discharge_date ASC) as before_an
				,[admission_date]
				,[discharge_date]
				,DATEdiff(day,TRY_CAST(LAG(CAST(discharge_date as nvarchar),1,0) OVER (PARTITION BY HN ORDER BY discharge_date) as date),admission_date) as [readmission_day]
		FROM [SiIMC_MGHT].[dbo].[T_in_patient]  WITH (NOLOCK) 
	) AS a

	LEFT JOIN

	(
		SELECT [an]
				,[final_code] AS [before_an_icd10]
		FROM [SiIMC_MGHT].[dbo].[T_final_diag] WITH (NOLOCK)
		WHERE final_type = 'D' and final_grp = 'G1'
	) b
	ON A.before_an = b.an

	LEFT JOIN

	(
		SELECT [an]
				,[final_code] AS [icd_an_10]
		FROM [SiIMC_MGHT].[dbo].[T_final_diag] WITH (NOLOCK)
		WHERE final_type = 'D' and final_grp = 'G1'
	) c
	ON a.an = c.an

	LEFT JOIN 

	( 
		SELECT DISTINCT  [PATIENT_ID]
				,[ENCOUNTER_ID]
				,[ADMISSION_DATE_TIME]
				,[DISCHARGE_DATE_TIME]
				,CAST(DATEDIFF(SECOND, ADMISSION_DATE_TIME , DISCHARGE_DATE_TIME) / 3600.0  as float) as datediff_hour
		FROM [SiIMC_MGHT].[dbo].[EHIS_IP_ADT_TRN] WITH (NOLOCK) 
	) AS d
	ON a.an = d.ENCOUNTER_ID

	WHERE [before_an_icd10] = [icd_an_10]
	  AND [readmission_day] <= 28
	  AND [datediff_hour] >= 4
	  AND [icd_an_10] NOT IN ('Z511','Z512')
)
, readmission_ตัวหาร as
(
	SELECT distinct an
		  ,[hn]
		  ,[admission_date]
		  ,[discharge_date]
	FROM [SiIMC_MGHT].[dbo].[INTO_Financial_Information_of_IPD_5Year] WITH (NOLOCK) 
	WHERE ประเภทการจำหน่าย = '1-With Approval'
)
	
SELECT YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([admission_date] as Date)),'yyyy-MM-01') as date))) as [Fiscal_Year]
		,CAST(FORMAT(DATEADD(YEAR,543,CAST([admission_date] as Date)),'yyyy-MM-01') as date) as [Actual_Date]
		,'Readmission Rate' AS [Type]
		,(COUNT(an)/[ตัวหาร]) * 100 AS [Result]
		,COUNT(an) AS [ตัวตั้ง]
		,[ตัวหาร]
		,'IPD' AS BU
	  
FROM [readmission_ตัวตั้ง] AS A

LEFT JOIN
(
	SELECT YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(MONTH,1,DATEADD(YEAR,543,CAST([discharge_date] as Date))),'yyyy-MM-01') as date))) as [Fiscal_Year] --dateadd +1 month เพราะตัวหารเป็นเดือนก่อนหน้า
			,CAST(FORMAT(DATEADD(MONTH,1,DATEADD(YEAR,543,CAST([discharge_date] as Date))),'yyyy-MM-01')  as date) as [Actual_Date]
			,CAST(COUNT(AN) AS FLOAT) AS ตัวหาร
	FROM [readmission_ตัวหาร]
	GROUP BY YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(MONTH,1,DATEADD(YEAR,543,CAST([discharge_date] as Date))),'yyyy-MM-01') as date)))
				,CAST(FORMAT(DATEADD(MONTH,1,DATEADD(YEAR,543,CAST([discharge_date] as Date))),'yyyy-MM-01')  as date)
) AS B
ON CAST(FORMAT(DATEADD(YEAR,543,CAST([admission_date] as Date)),'yyyy-MM-01') as date) = B.Actual_Date

WHERE Actual_Date >= '2020-10-01'

GROUP BY 
	YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([admission_date] as Date)),'yyyy-MM-01') as date))) 
	,CAST(FORMAT(DATEADD(YEAR,543,CAST([admission_date] as Date)),'yyyy-MM-01') as date)
	,B.ตัวหาร

GO


