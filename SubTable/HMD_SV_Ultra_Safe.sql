USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_Ultra_Safe]    Script Date: 11/3/2025 16:16:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [da].[HMD_SV_Ultra_Safe] 
AS
--ผ่าตัดผิดคน ผิดข้าง ผิดหัตถการ
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
    SELECT 'Ultra safe - ผ่าตัดผิดคนผิดข้างผิดหัตถการ' AS [Type]
    UNION ALL
    SELECT 'Ultra safe - ให้เลือดผิดคน ผิด Group'
    UNION ALL
    SELECT 'Ultra safe - จำหน่ายแม่ลูกผิดคน'
    UNION ALL
    SELECT 'Ultra safe - (แพ้ยาซ้ำ)'
)

SELECT 
	 Month2.[Fiscal_Year]
    ,Month2.[Actual_Date]
	,MONTH2.[Type]
	,ISNULL([ตัวตั้ง], 0) AS Result
	,ISNULL([ตัวตั้ง], 0) AS ตัวตั้ง
	,1 AS ตัวหาร
	,'IPD' AS [BU]
FROM
	(
		SELECT 
				Month2.[Fiscal_Year]
			,Month2.[Actual_Date]
			,Values_CTE_OPD.[Type]
				
		FROM 
			Month2
		CROSS JOIN 
			Values_CTE_OPD
		) AS MONTH2

LEFT JOIN
(
SELECT CASE WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
	   END AS [Fiscal_Year]
	  ,CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE) AS [Actual_Date]
	  ,'Ultra safe - ผ่าตัดผิดคนผิดข้างผิดหัตถการ' AS [Type]
	  ,COUNT(DISTINCT [ORF]) AS [Result]
	  ,COUNT(DISTINCT [ORF]) AS [ตัวตั้ง]
	  ,1 AS [ตัวหาร]
	  ,'IPD' AS [BU]
FROM [SiIMC_MGHT].[dbo].[T_IRMdata]
WHERE [เหตุการณ์หลัก] = 'การผ่าตัด วิสัญญี หัตถการ' AND [เหตุการณ์รอง] IN ('ผิดตำแหน่ง','ผิดคน','ผิดข้าง')
		AND (UPPER([ผู้ป่วยบาดเจ็บ]) NOT IN ('A','B') AND ([ผู้ป่วยบาดเจ็บ] != ' ' AND [ผู้ป่วยบาดเจ็บ] IS NOT NULL))
		AND UPPER([IPD-OPD]) = 'IPD'
GROUP BY CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE)
		,(CASE WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544 ELSE YEAR([วันที่])+543 END)

UNION ALL		
--ให้เลือดผิดคน ผิดหมู่
SELECT CASE
			WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
		END AS [Fiscal_Year]
	  ,CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE) AS [Actual_Date]
	  ,'Ultra safe - ให้เลือดผิดคน ผิด Group' AS [Type]
	  ,COUNT(DISTINCT [ORF]) AS [Result]
	  ,COUNT(DISTINCT [ORF]) AS [ตัวตั้ง]
	  ,1 AS [ตัวหาร]
	  ,'IPD' AS [BU]
  FROM [SiIMC_MGHT].[dbo].[T_IRMdata]
  WHERE [เหตุการณ์หลัก]= 'เลือดและส่วนประกอบของเลือด' AND [เหตุการณ์รอง] IN ('ความคลาดเคลื่อนในการสั่ง','ความคลาดเคลื่อนในการให้','ความคลาดเคลื่อนในการจ่าย')
		AND [เหตุการณ์ย่อย] IN ('ผิดคน','ผิดหมู่เลือด')
		AND (UPPER([ผู้ป่วยบาดเจ็บ]) NOT IN ('A','B') AND ([ผู้ป่วยบาดเจ็บ] != ' ' AND [ผู้ป่วยบาดเจ็บ] IS NOT NULL))
		AND UPPER([IPD-OPD]) = 'IPD'
  GROUP BY CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE),(CASE
			WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
		END)
UNION ALL

--ส่งทารกผิดพ่อ ผิดแม่ ภายหลังการจำหน่ายออกจางโรงพยาบาล
SELECT CASE
			WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
		END AS [Fiscal_Year]
	  ,CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE) AS [Actual_Date]
	  ,'Ultra safe - จำหน่ายแม่ลูกผิดคน' AS [Type]
	  ,COUNT(DISTINCT [ORF]) AS [Result]
	  ,COUNT(DISTINCT [ORF]) AS [ตัวตั้ง]
	  ,1 AS [ตัวหาร]
	  ,'IPD' AS [BU]
  FROM [SiIMC_MGHT].[dbo].[T_IRMdata]
  WHERE [เหตุการณ์หลัก] = 'การจำหน่าย' AND [เหตุการณ์รอง] = 'นำส่งบุตรให้บิดา-มารดาไม่ถูกต้อง'
		AND (UPPER([ผู้ป่วยบาดเจ็บ]) NOT IN ('A','B') AND ([ผู้ป่วยบาดเจ็บ] != ' ' AND [ผู้ป่วยบาดเจ็บ] IS NOT NULL))
		AND UPPER([IPD-OPD]) = 'IPD'
  GROUP BY CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE),(CASE
			WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
		END)
UNION ALL
--แพ้ยาชื่อสามัญที่เกิดอาการรุนแรง
SELECT CASE
			WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
		END AS [Fiscal_Year]
	  ,CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE) AS [Actual_Date]
	  ,'Ultra safe - (แพ้ยาซ้ำ)' AS [Type]
	  ,COUNT(DISTINCT [ORF]) AS [Result]
	  ,COUNT(DISTINCT [ORF]) AS [ตัวตั้ง]
	  ,1 AS [ตัวหาร]
	  ,'IPD' AS [BU]
  FROM [SiIMC_MGHT].[dbo].[T_IRMdata]
  WHERE [เหตุการณ์หลัก] = 'ยา สารน้ำ' AND [เหตุการณ์รอง] IN ('ความคลาดเคลื่อนในการสั่ง (Prescribing error)','ความคลาดเคลื่อนในการให้ (Administration error)','ความคลาดเคลื่อนในการจ่าย (Dispensing error)')
  AND [เหตุการณ์ย่อย] = 'การแพ้ยาซ้ำชื่อสามัญเดียวกันที่เกิดอาการรุนแรง'
  AND UPPER([IPD-OPD]) = 'IPD'
  GROUP BY CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE),(CASE
			WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
		END)
) AS IPD
 ON MONTH2.Actual_Date = IPD.Actual_Date AND Month2.[Type] = IPD.[Type]

 UNION ALL
 -- OPD
 SELECT 
	 Month2.[Fiscal_Year]
    ,Month2.[Actual_Date]
	,MONTH2.[Type]
	,ISNULL([ตัวตั้ง], 0) AS Result
	,ISNULL([ตัวตั้ง], 0) AS ตัวตั้ง
	,1 AS ตัวหาร
	,'OPD' AS [BU]
FROM
		(
				SELECT 
					 Month2.[Fiscal_Year]
				    ,Month2.[Actual_Date]
				    ,Values_CTE_OPD.[Type]
				
				FROM 
				    Month2
				CROSS JOIN 
				    Values_CTE_OPD
		) AS MONTH2
LEFT JOIN
--OPD
  --ผ่าตัดผิดคน ผิดข้าง ผิดหัตถการ
  (
SELECT CASE
			WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
		END AS [Fiscal_Year]
	  ,CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE) AS [Actual_Date]
	  ,'Ultra safe - ผ่าตัดผิดคนผิดข้างผิดหัตถการ' AS [Type]
	  ,COUNT(DISTINCT [ORF]) AS [Result]
	  ,COUNT(DISTINCT [ORF]) AS [ตัวตั้ง]
	  ,1 AS [ตัวหาร]
	  ,'OPD' AS [BU]
  FROM [SiIMC_MGHT].[dbo].[T_IRMdata]
  WHERE [เหตุการณ์หลัก] = 'การผ่าตัด วิสัญญี หัตถการ' AND [เหตุการณ์รอง] IN ('ผิดตำแหน่ง','ผิดคน','ผิดข้าง')
		AND (UPPER([ผู้ป่วยบาดเจ็บ]) NOT IN ('A','B') AND ([ผู้ป่วยบาดเจ็บ] != ' ' AND [ผู้ป่วยบาดเจ็บ] IS NOT NULL))
		AND UPPER([IPD-OPD]) = 'OPD'
  GROUP BY CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE),(CASE
			WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
		END)
UNION ALL		
--ให้เลือดผิดคน ผิดหมู่
SELECT CASE
			WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
		END AS [Fiscal_Year]
	  ,CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE) AS [Actual_Date]
	  ,'Ultra safe - ให้เลือดผิดคน ผิด Group' AS [Type]
	  ,COUNT(DISTINCT [ORF]) AS [Result]
	  ,COUNT(DISTINCT [ORF]) AS [ตัวตั้ง]
	  ,1 AS [ตัวหาร]
	  ,'OPD' AS [BU]
  FROM [SiIMC_MGHT].[dbo].[T_IRMdata]
  WHERE [เหตุการณ์หลัก]= 'เลือดและส่วนประกอบของเลือด' AND [เหตุการณ์รอง] IN ('ความคลาดเคลื่อนในการสั่ง','ความคลาดเคลื่อนในการให้','ความคลาดเคลื่อนในการจ่าย')
		AND [เหตุการณ์ย่อย] IN ('ผิดคน','ผิดหมู่เลือด')
		AND (UPPER([ผู้ป่วยบาดเจ็บ]) NOT IN ('A','B') AND ([ผู้ป่วยบาดเจ็บ] != ' ' AND [ผู้ป่วยบาดเจ็บ] IS NOT NULL))
		AND UPPER([IPD-OPD]) = 'OPD'
  GROUP BY CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE),(CASE
			WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
		END)
UNION ALL
--ส่งทารกผิดพ่อ ผิดแม่ ภายหลังการจำหน่ายออกจางโรงพยาบาล
SELECT CASE
			WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
		END AS [Fiscal_Year]
	  ,CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE) AS [Actual_Date]
	  ,'Ultra safe - จำหน่ายแม่ลูกผิดคน' AS [Type]
	  ,COUNT(DISTINCT [ORF]) AS [Result]
	  ,COUNT(DISTINCT [ORF]) AS [ตัวตั้ง]
	  ,1 AS [ตัวหาร]
	  ,'OPD' AS [BU]
  FROM [SiIMC_MGHT].[dbo].[T_IRMdata]
  WHERE [เหตุการณ์หลัก] = 'การจำหน่าย' AND [เหตุการณ์รอง] = 'นำส่งบุตรให้บิดา-มารดาไม่ถูกต้อง'
		AND (UPPER([ผู้ป่วยบาดเจ็บ]) NOT IN ('A','B') AND ([ผู้ป่วยบาดเจ็บ] != ' ' AND [ผู้ป่วยบาดเจ็บ] IS NOT NULL))
		AND UPPER([IPD-OPD]) = 'OPD'
  GROUP BY CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE),(CASE
			WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
		END)
UNION ALL
--แพ้ยาชื่อสามัญที่เกิดอาการรุนแรง
SELECT CASE
			WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
		END AS [Fiscal_Year]
	  ,CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE) AS [Actual_Date]
	  ,'Ultra safe - (แพ้ยาซ้ำ)' AS [Type]
	  ,COUNT(DISTINCT [ORF]) AS [Result]
	  ,COUNT(DISTINCT [ORF]) AS [ตัวตั้ง]
	  ,1 AS [ตัวหาร]
	  ,'OPD' AS [BU]
  FROM [SiIMC_MGHT].[dbo].[T_IRMdata]
  WHERE [เหตุการณ์หลัก] = 'ยา สารน้ำ' AND [เหตุการณ์รอง] IN ('ความคลาดเคลื่อนในการสั่ง (Prescribing error)','ความคลาดเคลื่อนในการให้ (Administration error)','ความคลาดเคลื่อนในการจ่าย (Dispensing error)')
  AND [เหตุการณ์ย่อย] = 'การแพ้ยาซ้ำชื่อสามัญเดียวกันที่เกิดอาการรุนแรง'
  AND UPPER([IPD-OPD]) = 'OPD'
  GROUP BY CAST(FORMAT(DATEADD(YEAR,543,CAST([วันที่] AS DATE)),'yyyy-MM-01') AS DATE),(CASE
			WHEN MONTH([วันที่]) IN ('10','11','12') THEN YEAR([วันที่])+544
			ELSE YEAR([วันที่])+543
		END)
		) AS OPD
 ON MONTH2.Actual_Date = OPD.Actual_Date AND Month2.[Type] = OPD.[Type]
GO


