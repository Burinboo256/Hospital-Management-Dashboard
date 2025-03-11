USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_OSS_UT_ROOM]    Script Date: 11/3/2025 16:10:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW  [da].[HMD_SV_OSS_UT_ROOM]
AS
SELECT [Fiscal_Year]
      ,[Actual_Date]
      ,[Type]
      ,[Result]
      ,[ตัวตั้ง]
      ,[ตัวหาร]
      ,[BU]
FROM [SiIMC_MGHT].[da].[Demo_HMD_Source_OSS_UT330_%Room_2]

GO


