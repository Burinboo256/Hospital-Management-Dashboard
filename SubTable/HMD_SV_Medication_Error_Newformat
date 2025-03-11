USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_Medication_Error_Newformat]    Script Date: 11/3/2025 16:06:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [da].[HMD_SV_Medication_Error_Newformat]
AS

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
)

, Values_CTE_OPD AS (
    SELECT 'Medication Error - ความคลาดเคลื่อนในการให้ (Administration error) OPD' AS [Type]
    UNION ALL
    SELECT 'Medication Error - ความคลาดเคลื่อนในการจ่าย (Dispensing error) OPD'
    UNION ALL
    SELECT 'Medication Error - ความคลาดเคลื่อนในการสั่ง (Prescribing error) OPD'
)

, Values_CTE_IPD AS (
    SELECT 'Medication Error - ความคลาดเคลื่อนในการให้ (Administration error) IPD' AS [Type]
    UNION ALL
    SELECT 'Medication Error - ความคลาดเคลื่อนในการจ่าย (Dispensing error) IPD'
    UNION ALL
    SELECT 'Medication Error - ความคลาดเคลื่อนในการสั่ง (Prescribing error) IPD'
					)
SELECT Month2.[Fiscal_Year]
    ,Month2.[Actual_Date]
	,MONTH2.[Type]
		,( ISNULL(ตัวตั้ง,0) / จำนวนใบสั่งยา ) AS Result
	, ISNULL(ตัวตั้ง,0) AS ตัวตั้ง
		,จำนวนใบสั่งยา AS ตัวหาร
	,'OPD' AS [BU]
FROM
	(
		SELECT 
			Month2.[Fiscal_Year]
			,Month2.[Actual_Date]
			,Values_CTE_OPD.[Type]
		FROM Month2
		CROSS JOIN 
		Values_CTE_OPD
	) AS MONTH2

LEFT JOIN
(

SELECT CASE
		WHEN MONTH(m.[Actual_Date]) IN ('10','11','12') THEN YEAR(m.[Actual_Date])+1
		ELSE YEAR(m.[Actual_Date])
		END AS [Fiscal_Year]
	   ,m.[Actual_Date]
	  ,'Medication Error - ' + CASE
	   WHEN m.[เหตุการณ์รอง] = 'ความคลาดเคลื่อนในการจ่าย (Dispensing error)' THEN 'ความคลาดเคลื่อนในการจ่าย (Dispensing error) OPD'
	   WHEN m.[เหตุการณ์รอง] = 'ความคลาดเคลื่อนในการให้ (Administration error)' THEN 'ความคลาดเคลื่อนในการให้ (Administration error) OPD'
	   WHEN m.[เหตุการณ์รอง] = 'ความคลาดเคลื่อนในการสั่ง (Prescribing error)' THEN 'ความคลาดเคลื่อนในการสั่ง (Prescribing error) OPD'
	   ELSE m.[เหตุการณ์รอง] END AS [Type]
	--   ,( (m.[Result] *1000 ) / b.จำนวนใบสั่งยา ) AS Result
	   ,m.[Result] * 1000 AS [ตัวตั้ง]
	--   ,b.จำนวนใบสั่งยา AS [ตัวหาร]
	   ,'OPD' AS [BU]
FROM (SELECT CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE) AS [Actual_Date],
	   [เหตุการณ์รอง],
	   CAST(COUNT(DISTINCT [ORF]) AS FLOAT) AS [Result]
FROM [SiIMC_MGHT].[dbo].[T_IRMdata] WITH (NOLOCK)
WHERE  [เหตุการณ์หลัก] = 'ยา สารน้ำ' 
	   AND [เหตุการณ์รอง] IN ('ความคลาดเคลื่อนในการจ่าย (Dispensing error)','ความคลาดเคลื่อนในการให้ (Administration error)','ความคลาดเคลื่อนในการสั่ง (Prescribing error)')
       AND ([ประเภทเหตุการณ์] LIKE '%Med Error%' AND [ประเภทเหตุการณ์] LIKE '%opd%')
	   AND ([Med Error] IS NOT NULL AND UPPER([Med Error]) NOT IN('NULL','A','B','C','D'))
	   AND IIF(COALESCE([การรายงาน],IIF([รายละเอียด] = 'ใช้สำหรับ TEST : อบรมการปิดรายงานในระบบ SiIRM','ได้รับรายงานซ้ำ',NULL)) IS NULL,NULL,'ได้รับรายงานซ้ำ') IS NULL

GROUP BY CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE),[เหตุการณ์รอง] ) AS m
) as b

ON MONTH2.Actual_Date = b.Actual_Date AND Month2.[Type] = B.[Type]
LEFT JOIN (
			SELECT 
		
	COUNT(DISTINCT CONCAT([ref_pay],[running_no],[pharm_room],[p_r_type],[order_date])) as จำนวนใบสั่งยา
  ,CAST(FORMAT(DATEADD(YEAR, 543 , (CONVERT(Date,(CONVERT(  Date, CONVERT(nvarchar,[order_date]-5430000)))))), 'yyyy-MM-01') AS DATE) as Actual_date
   ,'OPD' AS BU
  FROM [SiIMC_MGHT].[dbo].[siod_phopd] WITH (NOLOCK)
  WHERE [order_date] >= 25620101 AND
  ([p_r_type] = 'O' ) AND
  adm_no <= 1 AND 
  [CANCEL_BY1] IS NULL AND
  [rec_status] = 'D' AND
  [pharm_room] IN ('103','ENT','ER','MS2','ONC','OON','OP7','PED','SCP','SKN','SM1','SRO','NM2','BOT','30B','ICS')

GROUP BY 	CAST(FORMAT(DATEADD(YEAR, 543 , (CONVERT(Date,(CONVERT(  Date, CONVERT(nvarchar,[order_date]-5430000)))))), 'yyyy-MM-01') AS DATE) 
		  ) AS  C
		ON   MONTH2.Actual_Date = C.Actual_Date

UNION ALL

SELECT 

		 Month2.[Fiscal_Year]
    ,Month2.[Actual_Date]
	,MONTH2.[Type]
	,( ISNULL(D.ตัวตั้ง,0) / F.ตัวตั้ง ) AS Result
	, ISNULL(D.ตัวตั้ง,0) AS ตัวตั้ง
		,F.ตัวตั้ง AS ตัวหาร
	,'IPD' AS [BU]
FROM
		(
				SELECT 
					 Month2.[Fiscal_Year]
				    ,Month2.[Actual_Date]
				    ,Values_CTE_IPD.[Type]
				
				FROM 
				    Month2
				CROSS JOIN 
				    Values_CTE_IPD
		) AS MONTH2

	LEFT JOIN
	(
SELECT CASE
		WHEN MONTH(m.[Actual_Date]) IN ('10','11','12') THEN YEAR(m.[Actual_Date])+1
		ELSE YEAR(m.[Actual_Date])
		END AS [Fiscal_Year]
	   ,m.[Actual_Date]
	   ,'Medication Error - ' + CASE
	   WHEN m.[เหตุการณ์รอง] = 'ความคลาดเคลื่อนในการจ่าย (Dispensing error)' THEN 'ความคลาดเคลื่อนในการจ่าย (Dispensing error) IPD'
	   WHEN m.[เหตุการณ์รอง] = 'ความคลาดเคลื่อนในการให้ (Administration error)' THEN 'ความคลาดเคลื่อนในการให้ (Administration error) IPD'
	   WHEN m.[เหตุการณ์รอง] = 'ความคลาดเคลื่อนในการสั่ง (Prescribing error)' THEN 'ความคลาดเคลื่อนในการสั่ง (Prescribing error) IPD'
	   ELSE m.[เหตุการณ์รอง] END AS [Type]
	 --  ,((m.[Result] * 1000 )/ [View_Demo_HMD_Source_LOS].ตัวตั้ง) AS Result
	   ,m.[Result] * 1000 AS [ตัวตั้ง]
	--   ,[View_Demo_HMD_Source_LOS].ตัวตั้ง AS ตัวหาร
	   ,'IPD' AS [BU]
FROM 

(
SELECT CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE) AS [Actual_Date],
	   [เหตุการณ์รอง],
	   COUNT(DISTINCT [ORF]) AS [Result]
FROM [SiIMC_MGHT].[dbo].[T_IRMdata] WITH (NOLOCK)
WHERE  [เหตุการณ์หลัก] = 'ยา สารน้ำ' 
	   AND [เหตุการณ์รอง] IN ('ความคลาดเคลื่อนในการจ่าย (Dispensing error)','ความคลาดเคลื่อนในการให้ (Administration error)','ความคลาดเคลื่อนในการสั่ง (Prescribing error)')
       AND ([ประเภทเหตุการณ์] LIKE '%Med Error%' AND [ประเภทเหตุการณ์] LIKE '%ipd%')
	   AND ([Med Error] IS NOT NULL AND UPPER([Med Error]) NOT IN('NULL','A','B','C','D'))
	   AND IIF(COALESCE([การรายงาน],IIF([รายละเอียด] = 'ใช้สำหรับ TEST : อบรมการปิดรายงานในระบบ SiIRM','ได้รับรายงานซ้ำ',NULL)) IS NULL,NULL,'ได้รับรายงานซ้ำ') IS NULL

GROUP BY CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE),[เหตุการณ์รอง]) AS m
	) AS D

ON MONTH2.Actual_Date = D.Actual_Date AND Month2.[Type] = D.[Type]

		LEFT JOIN [SiIMC_MGHT].[da].[View_Demo_HMD_Source_LOS] AS F WITH (NOLOCK) 
		ON MONTH2.Actual_date = F.Actual_date 
		WHERE F.BU = 'IPD'

GO


