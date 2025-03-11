USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_Satisfaction]    Script Date: 11/3/2025 16:15:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [da].[HMD_SV_Satisfaction] 
AS

SELECT --OPD ในเวลา version ใช้งาน OPD (ver.29/03/67)
	YEAR(DATEADD(MONTH,3,CAST(answer_updated_at AS date)))+543 AS [Fiscal_Year]
	--,DATEADD(YEAR, 543,DATEADD(MONTH,3,CAST(answer_updated_at AS date))) AS test_date
	,FORMAT(DATEADD(YEAR,543,CAST(answer_updated_at AS date)), 'yyyy-MM-01') AS Actual_Date
	,'ความพึงพอใจของผู้ป่วยในเวลา (OPD)' AS Type
	,LEFT(ROUND(COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer = '10' AND answer <> 'None' THEN answer
			ELSE NULL
			END ) *1.0 / 
			
			COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer <> 'None' THEN question_text
			ELSE NULL
			END),4), 6) AS Result
	,COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer = '10' AND answer <> 'None' THEN answer
			ELSE NULL
			END ) AS 'ตัวตั้ง'
	,COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer <> 'None' THEN question_text
			ELSE NULL
			END) AS 'ตัวหาร'
	,'OPD' AS BU
FROM(
SELECT distinct [response_id]
    ,[ip_address]
    ,[collector_type]
    ,[url]
    ,[collector_id]
    ,[date_form_created]
    ,[date_form_updated]
    ,t.[survey_id]
    ,[response_status]
    ,[answer_rate]
    ,[review_status]
    ,[team_id]
    ,[team_name]
    ,[answer_created_at]
    ,[answer_updated_at]
	,q.survey_name
,q.ver_name
    ,t.[question]
	,q.[question_text]
    ,t.[question_type]
    ,t.[answer]
	,ISNULL(a.[choice_text],t.[answer]) AS [choice_text]
FROM [SiIMC_MGHT].[SiSurvey].[Surveys_Transaction] AS t WITH (NOLOCK)
LEFT JOIN [SiIMC_MGHT].[SiSurvey].[Surveys_Master_Questions] AS q WITH (NOLOCK)
	ON t.survey_id = q.survey_id
		AND	(t.question = q.question_name)
LEFT JOIN [SiIMC_MGHT].[SiSurvey].[Surveys_Master_Questions] AS a WITH (NOLOCK)
	ON t.survey_id = a.survey_id
		AND	(t.question = a.question_name)
		AND	(t.answer = a.choice_name)
WHERE t.survey_id = '1A493E1F-36D0-4AE7-9918-24A0D7F616CB' --OPD ในเวลา version ใช้งาน OPD (ver.29/03/67)
) a

GROUP BY 
	YEAR(DATEADD(MONTH,3,CAST(answer_updated_at AS date)))+543 
	,FORMAT(DATEADD(YEAR,543,CAST(answer_updated_at AS date)), 'yyyy-MM-01')


UNION--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


SELECT --IPD ในเวลา version ใช้งาน OPD (ver.29/03/67)
	YEAR(DATEADD(MONTH,3,CAST(answer_updated_at AS date)))+543 AS [Fiscal_Year]
	--,DATEADD(YEAR, 543,DATEADD(MONTH,3,CAST(answer_updated_at AS date))) AS test_date
	,FORMAT(DATEADD(YEAR,543,CAST(answer_updated_at AS date)), 'yyyy-MM-01') AS Actual_Date
	,'ความพึงพอใจของผู้ป่วยในเวลา (IPD)' AS Type
	,LEFT(ROUND(COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer = '10' AND answer <> 'None' THEN answer
			ELSE NULL
			END ) *1.0 / 
			
			COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer <> 'None' THEN question_text
			ELSE NULL
			END),4), 6) AS Result
	,COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer = '10' AND answer <> 'None' THEN answer
			ELSE NULL
			END ) AS 'ตัวตั้ง'
	,COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer <> 'None' THEN question_text
			ELSE NULL
			END) AS 'ตัวหาร'
	,'IPD' AS BU
FROM(
SELECT distinct [response_id]
    ,[ip_address]
    ,[collector_type]
    ,[url]
    ,[collector_id]
    ,[date_form_created]
    ,[date_form_updated]
    ,t.[survey_id]
    ,[response_status]
    ,[answer_rate]
    ,[review_status]
    ,[team_id]
    ,[team_name]
    ,[answer_created_at]
    ,[answer_updated_at]
	,q.survey_name
,q.ver_name
    ,t.[question]
	,q.[question_text]
    ,t.[question_type]
    ,t.[answer]
	,ISNULL(a.[choice_text],t.[answer]) AS [choice_text]
FROM [SiIMC_MGHT].[SiSurvey].[Surveys_Transaction] AS t WITH (NOLOCK)
LEFT JOIN [SiIMC_MGHT].[SiSurvey].[Surveys_Master_Questions] AS q WITH (NOLOCK)
	ON t.survey_id = q.survey_id
		AND	(t.question = q.question_name)
LEFT JOIN [SiIMC_MGHT].[SiSurvey].[Surveys_Master_Questions] AS a WITH (NOLOCK)
	ON t.survey_id = a.survey_id
		AND	(t.question = a.question_name)
		AND	(t.answer = a.choice_name)
WHERE t.survey_id = '7081D7C5-B059-4E5F-96CA-FD8867B38733' --IPD ในเวลา version ใช้งาน OPD (ver.29/03/67)
) b

GROUP BY 
	YEAR(DATEADD(MONTH,3,CAST(answer_updated_at AS date)))+543 
	,FORMAT(DATEADD(YEAR,543,CAST(answer_updated_at AS date)), 'yyyy-MM-01')


UNION--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


SELECT --OPD นอกเวลา
	YEAR(DATEADD(MONTH,3,CAST(answer_updated_at AS date)))+543 AS [Fiscal_Year]
	--,DATEADD(YEAR, 543,DATEADD(MONTH,3,CAST(answer_updated_at AS date))) AS test_date
	,FORMAT(DATEADD(YEAR,543,CAST(answer_updated_at AS date)), 'yyyy-MM-01') AS Actual_Date
	,'ความพึงพอใจของผู้ป่วยนอกเวลา (OPD)' AS Type
	,LEFT(ROUND(COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer = '10' AND answer <> 'None' THEN answer
			ELSE NULL
			END ) *1.0 / 
			
			COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer <> 'None' THEN question_text
			ELSE NULL
			END),4), 6) AS Result
	,COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer = '10' AND answer <> 'None' THEN answer
			ELSE NULL
			END ) AS 'ตัวตั้ง'
	,COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer <> 'None' THEN question_text
			ELSE NULL
			END) AS 'ตัวหาร'
	,'OPD' AS BU
FROM(
SELECT distinct [response_id]
    ,[ip_address]
    ,[collector_type]
    ,[url]
    ,[collector_id]
    ,[date_form_created]
    ,[date_form_updated]
    ,t.[survey_id]
    ,[response_status]
    ,[answer_rate]
    ,[review_status]
    ,[team_id]
    ,[team_name]
    ,[answer_created_at]
    ,[answer_updated_at]
	,q.survey_name
,q.ver_name
    ,t.[question]
	,q.[question_text]
    ,t.[question_type]
    ,t.[answer]
	,ISNULL(a.[choice_text],t.[answer]) AS [choice_text]
FROM [SiIMC_MGHT].[SiSurvey].[Surveys_Transaction] AS t WITH (NOLOCK)
LEFT JOIN [SiIMC_MGHT].[SiSurvey].[Surveys_Master_Questions] AS q WITH (NOLOCK)
	ON t.survey_id = q.survey_id
		AND	(t.question = q.question_name)
LEFT JOIN [SiIMC_MGHT].[SiSurvey].[Surveys_Master_Questions] AS a WITH (NOLOCK)
	ON t.survey_id = a.survey_id
		AND	(t.question = a.question_name)
		AND	(t.answer = a.choice_name)
WHERE t.survey_id = 'A72E62F0-75AC-43BF-9BCE-08A6F797DCC9' --OPD นอกเวลา
) c

GROUP BY 
	YEAR(DATEADD(MONTH,3,CAST(answer_updated_at AS date)))+543 
	,FORMAT(DATEADD(YEAR,543,CAST(answer_updated_at AS date)), 'yyyy-MM-01')



UNION--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


SELECT --IPD นอกเวลา
	YEAR(DATEADD(MONTH,3,CAST(answer_updated_at AS date)))+543 AS [Fiscal_Year]
	--,DATEADD(YEAR, 543,DATEADD(MONTH,3,CAST(answer_updated_at AS date))) AS test_date
	,FORMAT(DATEADD(YEAR,543,CAST(answer_updated_at AS date)), 'yyyy-MM-01') AS Actual_Date
	,'ความพึงพอใจของผู้ป่วยนอกเวลา (IPD)' AS Type
	,LEFT(ROUND(COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer = '10' AND answer <> 'None' THEN answer
			ELSE NULL
			END ) *1.0 / 
			
			COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer <> 'None' THEN question_text
			ELSE NULL
			END),4), 6) AS Result
	,COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer = '10' AND answer <> 'None' THEN answer
			ELSE NULL
			END ) AS 'ตัวตั้ง'
	,COUNT(CASE
			WHEN question_text = 'ระดับความพึงพอใจในภาพรวม' AND answer <> 'None' THEN question_text
			ELSE NULL
			END) AS 'ตัวหาร'
	,'IPD' AS BU
FROM(
SELECT distinct [response_id]
    ,[ip_address]
    ,[collector_type]
    ,[url]
    ,[collector_id]
    ,[date_form_created]
    ,[date_form_updated]
    ,t.[survey_id]
    ,[response_status]
    ,[answer_rate]
    ,[review_status]
    ,[team_id]
    ,[team_name]
    ,[answer_created_at]
    ,[answer_updated_at]
	,q.survey_name
,q.ver_name
    ,t.[question]
	,q.[question_text]
    ,t.[question_type]
    ,t.[answer]
	,ISNULL(a.[choice_text],t.[answer]) AS [choice_text]
FROM [SiIMC_MGHT].[SiSurvey].[Surveys_Transaction] AS t WITH (NOLOCK)
LEFT JOIN [SiIMC_MGHT].[SiSurvey].[Surveys_Master_Questions] AS q WITH (NOLOCK)
	ON t.survey_id = q.survey_id
		AND	(t.question = q.question_name)
LEFT JOIN [SiIMC_MGHT].[SiSurvey].[Surveys_Master_Questions] AS a WITH (NOLOCK)
	ON t.survey_id = a.survey_id
		AND	(t.question = a.question_name)
		AND	(t.answer = a.choice_name)
WHERE t.survey_id = '7624B834-72AB-489D-9A52-C581D2868282' --IPD นอกเวลา
) d

GROUP BY 
	YEAR(DATEADD(MONTH,3,CAST(answer_updated_at AS date)))+543 
	,FORMAT(DATEADD(YEAR,543,CAST(answer_updated_at AS date)), 'yyyy-MM-01')



GO


