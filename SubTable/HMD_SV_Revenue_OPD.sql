USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_Revenue_OPD]    Script Date: 11/3/2025 16:15:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [da].[HMD_SV_Revenue_OPD]
AS
 
WITH Main as 
(
/*	SELECT YEAR([SERVICE_DATE]) as [Year]
			,YEAR(DATEADD(MONTH,3,CAST(FORMAT([SERVICE_DATE],'yyyy-MM-01') as date))) as [Fiscal_Year]
			,FORMAT([SERVICE_DATE],'yyyy-MM-01') as [Actual_Date]
			,SUM([รายได้รวม]) as [รายได้รวม]
			,SUM([รายได้เงินสด]) as [รายได้เงินสด]
			,SUM([ตั้งหนี้]) as [ตั้งหนี้]
			,SUM([ต้นทุนรวม]) as [ต้นทุนรวม]
			,COUNT(DISTINCT VISIT_NUMBER) as [จำนวนVisit]
	FROM
	(	SELECT VISIT_NUMBER
				,CAST(DATEADD(YEAR,543,[SERVICE_DATE_DATE]) as date) as [SERVICE_DATE]
				,SUM([AMOUNT]) as [รายได้รวม]
				,SUM(IIF([CASH_STATUS]='C',[AMOUNT],null)) as [รายได้เงินสด]
				,MAX([Amount_จำนวนเงินตั้งหนี้]) as [ตั้งหนี้]
				,SUM([cost_amount]) as [ต้นทุนรวม]
		FROM [SiIMC_MGHT].[dbo].[INTO_Financial_Information_of_OPD] WITH (NOLOCK)
		WHERE [SERVICE_DATE_DATE] >= '2020-10-01' and [SERVICE_DATE_DATE] <= GETDATE()--and [Amount_จำนวนเงินตั้งหนี้] is not null --and VISIT_NUMBER in ('H53571143/6602958747','H54562406/6702084953')
		GROUP BY  VISIT_NUMBER
				,CAST(DATEADD(YEAR,543,[SERVICE_DATE_DATE]) as date)
	) a
	GROUP BY YEAR([SERVICE_DATE])
			,FORMAT([SERVICE_DATE],'yyyy-MM-01')
*/
SELECT [Year]
      ,[Fiscal_Year]
      ,[Actual_Date]
      ,[รายได้รวม]
      ,[รายได้เงินสด]
      ,[ตั้งหนี้]
      ,[ต้นทุนรวม]
      ,[จำนวนVisit]
FROM [SiIMC_MGHT].[da].[HMD_Financial_Information_of_OPD]
)

SELECT [Fiscal_Year]
,[Actual_Date]
,'Revenue per patient - OPD' as [Type]
,[รายได้รวม] / [จำนวนVisit] as [Result]
,[รายได้รวม] as [ตัวตั้ง]
,[จำนวนVisit] as [ตัวหาร]
,'OPD' as [BU]
FROM Main

UNION ALL

SELECT [Fiscal_Year]
,[Actual_Date]
,'Charge cost ratio - OPD' as [Type]
,[รายได้รวม] / [ต้นทุนรวม] as [Result]
,[รายได้รวม] as [ตัวตั้ง]
,[ต้นทุนรวม] as [ตัวหาร]
,'OPD' as [BU]
FROM Main

UNION ALL

SELECT [Fiscal_Year]
,[Actual_Date]
,'กำไรจากราคาขาย (amount)' as [Type]
,[รายได้รวม] - [ต้นทุนรวม] as [Result]
,[รายได้รวม] - [ต้นทุนรวม] as [ตัวตั้ง]
, 1 as [ตัวหาร]
,'OPD' as [BU]
FROM Main

UNION ALL

SELECT [Fiscal_Year]
,[Actual_Date]
,'กำไรจากราคาขาย (margin %)' as [Type]
,([รายได้รวม] - [ต้นทุนรวม]) / [ต้นทุนรวม] as [Result]
,([รายได้รวม] - [ต้นทุนรวม]) as [ตัวตั้ง]
,[ต้นทุนรวม] as [ตัวหาร]
,'OPD' as [BU]
FROM Main

UNION ALL

SELECT [Fiscal_Year]
,[Actual_Date]
,'Cost per patient OPD' as [Type]
,[ต้นทุนรวม] / [จำนวนVisit] as [Result]
,[ต้นทุนรวม] as [ตัวตั้ง]
,[จำนวนVisit] as [ตัวหาร]
,'OPD' as [BU]
FROM Main

GO


