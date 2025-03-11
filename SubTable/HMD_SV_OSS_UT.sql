USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_OSS_UT]    Script Date: 11/3/2025 16:09:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE view [da].[HMD_SV_OSS_UT]
as
	SELECT [Fiscal_Year]
		,[Actual_Date]
		,[Type]
		,[Result]
		,[ตัวตั้ง]
		,[ตัวหาร]
		,[BU]
	FROM [SiIMC_MGHT].[da].[Demo_HMD_Source_OSS_UT] WITH (NOLOCK)
GO


