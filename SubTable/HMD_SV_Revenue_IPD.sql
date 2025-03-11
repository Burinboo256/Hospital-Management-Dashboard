USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_Revenue_IPD]    Script Date: 11/3/2025 16:14:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [da].[HMD_SV_Revenue_IPD]
AS
 
WITH Main as
(
	SELECT *
	FROM [SiIMC_MGHT].[dbo].[INTO_Financial_Information_of_IPD_5Year] WITH (NOLOCK)
	WHERE [discharge_date] >= '2020-10-01'
),
Revenue_Cost as
(
	SELECT YEAR([discharge_date])+543 as [Year]
			,CAST(FORMAT(DATEADD(YEAR,543,[discharge_date]),'yyyy-MM-01') as date) as [Actual_Date]
			,SUM([รายได้รวม]) as [รายได้รวม]
			,SUM([รายได้สุทธิ]) as [รายได้สุทธิ]
			,SUM([ค่ายา]/[CTCR_ค่ายา] + [บริการผ่าตัด]/[CTCR_บริการผ่าตัด]  + [ห้องปฏิบัติการ]/[CTCR_ห้องปฏิบัติการ] + [ค่าบริการรังสี]/[CTCR_ค่าบริการรังสี] + [ค่าบริการหอผู้ป่วย/หน่วยตรวจ/เครื่องมือแพทย์]/[CTCR_ค่าบริการหอผู้ป่วย/หน่วยตรวจ/เครื่องมือแพทย์] + [ค่าบริการทางการแพทย์]/[CTCR_ค่าบริการทางแพทย์] + [บริการวิสัญญี]/[CTCR_บริการวิสัญญี] + [บริการหัตถการ]/[CTCR_บริการหัตถการ] + [วินิจฉัยโดยวิธีพิเศษ]/[CTCR_วินิจฉัยโดยวิธีพิเศษ] + [บริการโลหิต]/[CTCR_บริการโลหิต] + [ค่าอุปกรณ์-เวชภัณฑ์]/[CTCR_ค่าอุปกรณ์-เวชภัณฑ์] + [ยา-เวชภัณฑ์นอกห้องยา]/[CTCR_ยา-เวชภัณฑ์นอกห้องยา] + [กายภาพบำบัด+ฟื้นฟู]/[CTCR_กายภาพบำบัด+ฟื้นฟู] + [ค่าธรรมเนียม]/[CTCR_ค่าธรรมเนียม] + [บริการทันตกรรม]/[CTCR_บริการทันตกรรม] +[บริการฝังเข็มและบริการบำบัดของผู้ประกอบโรคศิลป์อื่น]/[CTCR_บริการฝังเข็มและบริการบำบัดของผู้ประกอบโรคศิลป์อื่น] + [บริการทางจิตประสาท]/[CTCR_บริการทางจิตประสาท]  + [บริการอื่นๆ]/[CTCR_บริการอื่นๆ] + [ค่า DF]/isnull([CTCR_ค่า DF],1) + [ซื้อบริการหน่วยงานภายนอก]/isnull([CTCR_ซื้อบริการหน่วยงานภายนอก],1) + [นอกเหนืองานบริการ]/isnull([CTCR_นอกเหนืองานบริการ],1)) as [ต้นทุนรวม]
			,COUNT(DISTINCT [an]) as [จำนวนAN]
	FROM Main a

	LEFT JOIN [SiIMC_MGHT].[dbo].[View_Financial_Information_of_IPD_Cost_Ratio] f  WITH (NOLOCK)
	ON CONCAT(YEAR(CASE WHEN MONTH([discharge_date]) > 9 THEN DATEADD(year,1,a.[discharge_date]) ELSE [discharge_date] END),CASE MONTH([discharge_date]) WHEN '10' THEN '01'
		WHEN '11' THEN '02'
		WHEN '12' THEN '03'
		WHEN '1' THEN '04'
		WHEN '2' THEN '05'
		WHEN '3' THEN '06'
		WHEN '4' THEN '07'
		WHEN '5' THEN '08'
		WHEN '6' THEN '09'
		WHEN '7' THEN '10'
		WHEN '8' THEN '11'
		WHEN '9' THEN '12'
		END) = f.[FY_Period]
	GROUP BY YEAR([discharge_date])
			,CAST(FORMAT(DATEADD(YEAR,543,[discharge_date]),'yyyy-MM-01') as date) 
)

SELECT [Year] as [Fiscal_Year]
,[Actual_Date]
,'Revenue per bed' as [Type]
,[รายได้รวม] / ([CntBed] * [DayOfMonth]) as [Result]
,[รายได้รวม] as [ตัวตั้ง]
,([CntBed] * [DayOfMonth]) as [ตัวหาร]
,'IPD' as [BU]
FROM
(
	SELECT YEAR([discharge_date])+543 as [Year]
		  ,CAST(FORMAT(DATEADD(YEAR,543,[discharge_date]),'yyyy-MM-01') as date) as [Actual_Date]
		  ,FORMAT([discharge_date],'yyyyMM') as [yyyyMM]
		  ,COUNT(DISTINCT CAST([discharge_date] as date)) as [DayOfMonth]
		  ,SUM([รายได้รวม]) as [รายได้รวม]
		  ,SUM([รายได้สุทธิ]) as [รายได้สุทธิ]
	FROM Main
	GROUP BY YEAR([discharge_date])
		  ,CAST(FORMAT(DATEADD(YEAR,543,[discharge_date]),'yyyy-MM-01') as date) 
		  ,FORMAT([discharge_date],'yyyyMM')
) Revenue
INNER JOIN
(
SELECT format([Date],'yyyyMM') as [yyyyMM] 
	,ROUND(SUM((Beds * DayOfMonth) -  IIF([Blocked_days] IS NULL,0, TRY_CAST(replace(replace(Blocked_days,',',''),'-','') AS float))) / SUM(DISTINCT DayOfMonth ), 0) as [CntBed]
	FROM [SiIMC_MGHT].[dbo].[T_Occupancy_Bed]
	WHERE WardName not in  ('Phrasri 4 Labor', 'Phrasri 4Septic', 'Phrasri8/2Labor')
--	and YEAR([Date]) >= '2023'
	GROUP BY format([Date],'yyyyMM')
) Bed
ON Revenue.yyyyMM = Bed.yyyyMM

UNION ALL

SELECT [Year] as [Fiscal_Year]
		  ,[Actual_Date]
		  ,'Revenue per patient - IPD' as [Type]
		  ,[รายได้รวม]/[จำนวนAN]as [Result]
		  ,[รายได้รวม] as [ตัวตั้ง]
		  ,[จำนวนAN] as [ตัวหาร]
		  ,'IPD' as [BU]
FROM Revenue_Cost
UNION ALL

SELECT [Year] as [Fiscal_Year]
		  ,[Actual_Date]
		  ,'Revenue IPD' as [Type]
		  ,[รายได้รวม] as [Result]
		  ,[รายได้รวม] as [ตัวตั้ง]
		  ,1 as [ตัวหาร]
		  ,'IPD' as [BU]
FROM Revenue_Cost


UNION ALL

SELECT [Year] as [Fiscal_Year]
	,[Actual_Date]
	,'Charge cost ratio - IPD' as [Type]
	,[รายได้รวม] / [ต้นทุนรวม] as [Result]
	,[รายได้รวม] as [ตัวตั้ง]
	,[ต้นทุนรวม] as [ตัวหาร]
	,'IPD' as [BU]
FROM Revenue_Cost

UNION ALL

SELECT [Year] as [Fiscal_Year]
	,[Actual_Date]
	,'กำไรจากราคาขาย (amount)' as [Type]
	,[รายได้รวม] - [ต้นทุนรวม] as [Result]
	,[รายได้รวม] - [ต้นทุนรวม] as [ตัวตั้ง]
	,1 as [ตัวหาร]
	,'IPD' as [BU]
FROM Revenue_Cost

UNION ALL

SELECT [Year] as [Fiscal_Year]
	,[Actual_Date]
	,'กำไรจากราคาขาย (margin %)' as [Type]
	,([รายได้รวม] - [ต้นทุนรวม]) / [ต้นทุนรวม]  as [Result]
	,([รายได้รวม] - [ต้นทุนรวม]) as [ตัวตั้ง]
	,[รายได้รวม] as [ตัวหาร]
	,'IPD' as [BU]
FROM Revenue_Cost

UNION ALL

SELECT [Year] as [Fiscal_Year]
	,[Actual_Date]
	,'Cost per patient IPD' as [Type]
	,[ต้นทุนรวม] / [จำนวนAN]  as [Result]
	,[ต้นทุนรวม] as [ตัวตั้ง]
	,[จำนวนAN] as [ตัวหาร]
	,'IPD' as [BU]
FROM Revenue_Cost

UNION ALL

SELECT [Year] as [Fiscal_Year]
	,[Actual_Date]
	,'Cost IPD' as [Type]
	,[ต้นทุนรวม]   as [Result]
	,[ต้นทุนรวม] as [ตัวตั้ง]
	,1 as [ตัวหาร]
	,'IPD' as [BU]
FROM Revenue_Cost



UNION ALL

SELECT [Year] as [Fiscal_Year]
	,[Actual_Date]
	,'Reimbursement Ratio IPD' as [Type]
	,[รายได้สุทธิ] / [รายได้รวม]  as [Result]
	,[รายได้สุทธิ] as [ตัวตั้ง]
	,[รายได้รวม] as [ตัวหาร]
	,'IPD' as [BU]
FROM Revenue_Cost

GO


