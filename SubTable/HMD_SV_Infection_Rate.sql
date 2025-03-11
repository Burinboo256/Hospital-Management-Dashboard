USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_Infection_Rate]    Script Date: 11/3/2025 16:05:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [da].[HMD_SV_Infection_Rate] AS
--Infection Rate (VAP)
SELECT CASE WHEN MONTH(n.[Actual_Date]) IN ('10','11','12') THEN YEAR(n.[Actual_Date])+1 ELSE YEAR(n.[Actual_Date]) END AS [Fiscal_Year]
	   ,n.[Actual_Date]
	   ,'Infection Rate (VAP)' AS [Type]
	   ,n.[Result]
	   ,n.[ตัวตั้ง]
	   ,n.[ตัวหาร]
	   ,'IPD' AS [BU]
FROM (SELECT  DATEFROMPARTS(m.[year], m.[month], '01') AS [Actual_Date]
	   ,SUM(m.[VAP])*1000 AS [ตัวตั้ง]
	   ,SUM(m.[res_cath]) AS [ตัวหาร]
	   ,ROUND((SUM(m.[VAP])*1000)/SUM(m.[res_cath]),2) AS [Result]
FROM (SELECT [year]
	  ,CASE
		WHEN [month] = 'January'    THEN 1
		WHEN [month] = 'February'   THEN 2
		WHEN [month] = 'March'      THEN 3
		WHEN [month] = 'April'      THEN 4
		WHEN [month] = 'May'        THEN 5
		WHEN [month] = 'June'       THEN 6
		WHEN [month] = 'July'       THEN 7
		WHEN [month] = 'August'     THEN 8
		WHEN [month] = 'September'  THEN 9
		WHEN [month] = 'October'    THEN 10
		WHEN [month] = 'November'   THEN 11
		WHEN [month] = 'December'   THEN 12
		END AS [month]
	,CASE
		WHEN [year] = '2566' AND  ([site1] = '4. VAP'  OR [site2] = '4. VAP'  OR [site3] = '4. VAP'  OR [site4] = '4. VAP') THEN 1
		WHEN [year] = '2567' AND  ([site1] = '48. Early VAP'  OR [site2] = '48. Early VAP' OR [site3] = '48. Early VAP'  OR [site4] = '48. Early VAP'  OR [site1] = '49. Late VAP'  OR [site2] = '49. Late VAP'  OR [site3] = '49. Late VAP'  OR [site4] = '49. Late VAP') THEN 1
		WHEN [site1] ='29. early VAP'  OR [site1]='30. late VAP'  OR [site2]='29. early VAP'  OR  [site2]='30. late VAP'  OR [site3]='29. early VAP'  OR [site3]='30. late VAP'  OR [site4]='29. early VAP'   OR  [site4]='30. late VAP' THEN 1
		ELSE 0
		END AS [VAP]
	,CASE 
		WHEN [res_cath] IS NULL OR [res_cath] = ' ' THEN 0
		ELSE [res_cath]
		END AS [res_cath]
  FROM [SiIMC_MGHT].[dbo].[T_IC] WITH (NOLOCK)
  ) AS m
  WHERE DATEFROMPARTS(m.[year], m.[month], '01') IS NOT NULL
  GROUP BY DATEFROMPARTS(m.[year], m.[month], '01')) AS n



  UNION ALL

 --Infection Rate (CLABSI)
SELECT CASE WHEN MONTH(n.[Actual_Date]) IN ('10','11','12') THEN YEAR(n.[Actual_Date])+1 ELSE YEAR(n.[Actual_Date]) END AS [Fiscal_Year]
	   ,n.[Actual_Date]
	   ,'Infection Rate (CLABSI)' AS [Type]
	   ,n.[Result]
	   ,n.[ตัวตั้ง]
	   ,n.[ตัวหาร]
	   ,'IPD' AS [BU]
FROM (SELECT  DATEFROMPARTS(m.[year], m.[month], '01') AS [Actual_Date]
	   ,ROUND((SUM(m.[CLABSI])*1000)/SUM(m.[cent_cat]),2) AS [Result]
	   ,SUM(m.[CLABSI])*1000 AS [ตัวตั้ง]
	   ,SUM(m.[cent_cat]) AS [ตัวหาร]
FROM (SELECT [year]
	  ,CASE
		WHEN [month] = 'January'    THEN 1
		WHEN [month] = 'February'   THEN 2
		WHEN [month] = 'March'      THEN 3
		WHEN [month] = 'April'      THEN 4
		WHEN [month] = 'May'        THEN 5
		WHEN [month] = 'June'       THEN 6
		WHEN [month] = 'July'       THEN 7
		WHEN [month] = 'August'     THEN 8
		WHEN [month] = 'September'  THEN 9
		WHEN [month] = 'October'    THEN 10
		WHEN [month] = 'November'   THEN 11
		WHEN [month] = 'December'   THEN 12
		END AS [month]
	,CASE
    WHEN    [site1]='22. short trem-CLABSI' OR [site1]='23. long term-CLABSI' OR [site1]='24. Hemodialysis-CLABSI' OR 
            [site2]='22. short trem-CLABSI' OR [site2]='23. long term-CLABSI' OR [site2]='24. Hemodialysis-CLABSI' OR 
            [site3]='22. short trem-CLABSI' OR [site3]='23. long term-CLABSI' OR [site3]='24. Hemodialysis-CLABSI' OR 
            [site4]='22. short trem-CLABSI' OR [site4]='23. long term-CLABSI' OR [site4]='24. Hemodialysis-CLABSI' OR 
            [site1] = '8. CLABSI' OR [site2] = '8. CLABSI' OR [site3] = '8. CLABSI' OR [site4] = '8. CLABSI' 
        THEN 1 
        ELSE 0
   END AS [CLABSI]
	,CASE 
		WHEN [cent_cat] IS NULL OR [cent_cat] = ' ' THEN 0
		ELSE [cent_cat]
		END AS [cent_cat]
  FROM [SiIMC_MGHT].[dbo].[T_IC] WITH (NOLOCK)
  ) AS m
  WHERE DATEFROMPARTS(m.[year], m.[month], '01') IS NOT NULL
  GROUP BY DATEFROMPARTS(m.[year], m.[month], '01')) n


  UNION ALL
  --Infection Rate (CAUTI)
 SELECT CASE WHEN MONTH(n.[Actual_Date]) IN ('10','11','12') THEN YEAR(n.[Actual_Date])+1 ELSE YEAR(n.[Actual_Date]) END AS [Fiscal_Year]
	   ,n.[Actual_Date]
	   ,'Infection Rate (CAUTI)' AS [Type]
	   ,n.[Result]
	   ,n.[ตัวตั้ง]
	   ,n.[ตัวหาร]
	   ,'IPD' AS [BU]
FROM (SELECT  DATEFROMPARTS(m.[year], m.[month], '01') AS [Actual_Date]
	   ,ROUND((SUM(m.[CAUTI])*1000)/SUM(m.[uri_cath]),2) AS [Result]
	   ,SUM(m.[CAUTI])*1000 AS [ตัวตั้ง]
	   ,SUM(m.[uri_cath]) AS [ตัวหาร]
FROM (SELECT [year]
	  ,CASE
		WHEN [month] = 'January'    THEN 1
		WHEN [month] = 'February'   THEN 2
		WHEN [month] = 'March'      THEN 3
		WHEN [month] = 'April'      THEN 4
		WHEN [month] = 'May'        THEN 5
		WHEN [month] = 'June'       THEN 6
		WHEN [month] = 'July'       THEN 7
		WHEN [month] = 'August'     THEN 8
		WHEN [month] = 'September'  THEN 9
		WHEN [month] = 'October'    THEN 10
		WHEN [month] = 'November'   THEN 11
		WHEN [month] = 'December'   THEN 12
		END AS [month]
	,CASE
        WHEN  [site1]='25. CAUTI' OR [site1] = '2. CAUTI' OR [site2]='25. CAUTI' OR [site2] = '2. CAUTI' OR 
              [site3]='25. CAUTI' OR [site3] = '2. CAUTI' OR [site4]='25. CAUTI' OR [site4] = '2. CAUTI'
        THEN 1 
        ELSE 0
        END AS [CAUTI]
	,CASE 
		WHEN [uri_cath] IS NULL OR [uri_cath] = ' ' THEN 0
		ELSE [uri_cath]
		END AS [uri_cath]
  FROM [SiIMC_MGHT].[dbo].[T_IC] WITH (NOLOCK)
  ) AS m
  WHERE DATEFROMPARTS(m.[year], m.[month], '01') IS NOT NULL
  GROUP BY DATEFROMPARTS(m.[year], m.[month], '01')) n

GO


