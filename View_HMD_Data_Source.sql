USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[View_HMD_Data_Source]    Script Date: 11/3/2025 15:03:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [da].[View_HMD_Data_Source]
AS

SELECT [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_Infection_Rate]
FROM [SiIMC_MGHT].[da].[HMD_SV_Infection_Rate]

UNION ALL

SELECT  [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[dbo].[View_Demo_HMD_Source_SirirajConnect] WITH (NOLOCK)
FROM [da].[HMD_SV_SirirajConnect]

UNION ALL

SELECT  [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_Telemed] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_Telemed]

UNION ALL
    
SELECT  [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_visit_OPD] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_LT_visit_OPD]

UNION ALL
     
SELECT  [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_an_IPD] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_an_IPD]

UNION ALL

SELECT  [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[dbo].[View_Demo_HMD_Source_OSS] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_OSS]

UNION ALL

SELECT  [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_Occupancy_bedmanagement] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_Occupancy_bedmanagement]

UNION ALL

SELECT  [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_bedturn_bedmanagement] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_Bedturn_Bedmanagement]

UNION ALL

SELECT  [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_LOS_bedmanagement] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_LOS_bedmanagement]

UNION ALL

SELECT  [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_Mortality_bedmanagement] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_Mortality_bedmanagement]

UNION ALL

SELECT  [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_CMI_bedmanagement] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_CMI_bedmanagement]

UNION ALL

SELECT  [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_Ultra_Safe] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_Ultra_Safe]

UNION ALL
SELECT [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_Medication_Error_newformat] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_Medication_Error_Newformat]


UNION ALL

SELECT [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_Revenue_IPD] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_Revenue_IPD]


UNION ALL

SELECT [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[INTO_HMD_Source_Revenue_OPD] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_Revenue_OPD]


UNION ALL

SELECT  [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_Readmissionrate] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_Readmissionrate]


UNION ALL

SELECT [Fiscal_Year]
    ,[Actual_Date]
    ,[Type]
    ,[Result]
    ,[ตัวตั้ง]
    ,[ตัวหาร]
    ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_blockbed_bedmanagement] WITH(NOLOCK) 
FROM [SiIMC_MGHT].[da].[HMD_SV_Blockbed_Bedmanagement]

UNION ALL

SELECT  [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_satisfaction] WITH(NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_Satisfaction]

UNION ALL

SELECT  [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_unsatisfaction] WITH (NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_Unsatisfaction]

UNION ALL

SELECT [Fiscal_Year]
    ,[Actual_Date]
    ,[Type]
    ,[Result]
    ,[ตัวตั้ง]
    ,[ตัวหาร]
    ,[BU]
--FROM [SiIMC_MGHT].[da].[Demo_HMD_Source_OSS_UT330_%Room_2] WITH(NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_OSS_UT_ROOM]

UNION ALL

SELECT [Fiscal_Year]
    ,[Actual_Date]
    ,[Type]
    ,[Result]
    ,[ตัวตั้ง]
    ,[ตัวหาร]
    ,[BU]
--FROM [SiIMC_MGHT].[da].[View_Demo_HMD_Source_OffCaseOR] WITH(NOLOCK)
FROM [SiIMC_MGHT].[da].[HMD_SV_OffCaseOR]

GO


