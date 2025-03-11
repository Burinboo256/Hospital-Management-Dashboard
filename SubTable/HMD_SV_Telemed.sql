USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[HMD_SV_Telemed]    Script Date: 11/3/2025 16:16:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [da].[HMD_SV_Telemed] AS
WITH tele AS
(select  --จำนวนผู้ป่วยนัดหมายที่มีการเปิด Visit (ไม่สนว่ามีการจ่ายเงินหรือไม่)
	a.*
	,d.*
	, YEAR(DATEADD(MONTH,3,CAST(FORMAT(DATEADD(YEAR,543,CAST([appoint_date] as Date)),'yyyy-MM-01') as date))) as [Fiscal_Year]
	, CAST(FORMAT(DATEADD(YEAR,543,CAST([appoint_date] as Date)),'yyyy-MM-01') as date) as [Actual_Date]
	--	,count( distinct  hn_fin_opd_detail +( a.clinic_code + cast(cast (charge_date as date) as nvarchar))) as vn_count
	--	,count(distinct hn) as hn_count
	from
    (
		 SELECT REPLACE(str([hn]),' ','') as hn
			  ,[appoint_date]
			  ,convert(date,[appoint_date]) as 'appoint_date_date'
			  ,[clinic_code]
              ,case when LEFT(clinic_code,2)='47' then 'S' else 'R' end as left_clinic_tele
			  ,[pid]
			  ,[address]
			  ,[tel_no]
			  ,[line_id]
			  ,[create_date]
			  ,[create_user]
              ,ServiceType
			  ,[remark] as [remark_tele]
		  FROM [SiIMC_MGHT].[dbo].[T_appoint_tele]
                    where appoint_date >= '2019-01-01'
					 AND 
        (LEFT(LOWER([remark]), 2) = 'c1' OR LOWER([remark]) = 'c' OR [remark] = 'c ขอจ่ายเอง' OR LOWER([remark]) = 'n1')
		  )a
		  
		  left join 

		  (
		  SELECT [VISIT_NUMBER]
			,[hn] AS [hn_visit]
			,[visit_date]
			,[clinic_code] AS [clinic_code_visit]
		FROM [SiIMC_MGHT].[dbo].[T_out_patient_visit_details_info]
		  ) d

		  on a.hn = d.[hn_visit]
			and a.appoint_date_date = d.[visit_date]
			and a.[clinic_code] = d.[clinic_code_visit]
		  
where d.[hn_visit] <> ''

group by a.[hn]
      ,[appoint_date]
      ,[appoint_date_date]
      ,a.[clinic_code]
      ,[left_clinic_tele]
      ,[pid]
      ,[address]
      ,[tel_no]
      ,[line_id]
      ,[create_date]
      ,[create_user]
      ,[ServiceType]
      ,[remark_tele]
	  ,[VISIT_NUMBER]
	  ,d.[hn_visit]
	  ,[visit_date]
	  ,d.[clinic_code_visit]
)


SELECT 
    [Fiscal_Year],
    [Actual_Date],
    'จำนวนผู้ป่วย Telemed (คน)' AS [Type],
  --  ,count( distinct  hn_fin_opd_detail +( a.clinic_code + cast(cast (charge_date as date) as nvarchar))) as vn_count
	count(distinct hn)  AS [Result],
    count(distinct hn) AS [ตัวตั้ง],
    '1' AS [ตัวหาร],
    'OPD' AS [BU]
FROM 
    [tele]
GROUP BY 
    [Fiscal_Year], [Actual_Date]

UNION ALL
-- Visit Count OPD
SELECT 
    [Fiscal_Year],
    [Actual_Date],
    'จำนวนผู้ป่วย Telemed (ครั้ง)' AS [Type],
    count( distinct  [hn] +( clinic_code + cast(cast (appoint_date_date as date) as nvarchar))) AS [Result],
    count( distinct  [hn] +( clinic_code + cast(cast (appoint_date_date as date) as nvarchar))) AS [ตัวตั้ง],
    '1' AS [ตัวหาร],
    'OPD' AS [BU]
FROM 
    [tele]
GROUP BY 
    [Fiscal_Year], [Actual_Date]
UNION ALL
-- Man Count HSOLUTION
SELECT 
    [Fiscal_Year],
    [Actual_Date],
    'จำนวนผู้ป่วย Telemed (คน)' AS [Type],
   count(distinct hn) AS [Result],
    count(distinct hn) AS [ตัวตั้ง],
    '1' AS [ตัวหาร],
    'Hsolution' AS [BU]
FROM 
    [tele]
WHERE  clinic_code  in  ('4780','4781','4782','4783','4784','4785','4786','4787',
                        '4788','4789','4794','4795','4796','4797','4798','4799','4744','4746','47ac'
                        )
GROUP BY 
    [Fiscal_Year], [Actual_Date]

UNION ALL
-- Visit Count HSOLUTION
SELECT 
    [Fiscal_Year],
    [Actual_Date],
    'จำนวนผู้ป่วย Telemed (ครั้ง)' AS [Type],
     count( distinct  hn +( clinic_code + cast(cast (appoint_date_date as date) as nvarchar))) AS [Result],
   count( distinct  hn +( clinic_code + cast(cast (appoint_date_date as date) as nvarchar))) AS [ตัวตั้ง],
    '1' AS [ตัวหาร],
    'Hsolution' AS [BU]
FROM 
    [tele]
WHERE  clinic_code  in  ('4780','4781','4782','4783','4784','4785','4786','4787',
                        '4788','4789','4794','4795','4796','4797','4798','4799','4744','4746','47ac'
                        )
GROUP BY 
    [Fiscal_Year], [Actual_Date]

UNION ALL
-- Man Count SiSKN
SELECT 
    [Fiscal_Year],
    [Actual_Date],
    'จำนวนผู้ป่วย Telemed (คน)' AS [Type],
    count(distinct hn) AS [Result],
    count(distinct hn) AS [ตัวตั้ง],
    '1' AS [ตัวหาร],
    'SiSKN' AS [BU]
FROM 
    [tele]
WHERE  LEFT(clinic_code,2) = '64'
GROUP BY 
    [Fiscal_Year], [Actual_Date]

UNION ALL
-- Visit Count SiSKN
SELECT 
    [Fiscal_Year],
    [Actual_Date],
    'จำนวนผู้ป่วย Telemed (ครั้ง)' AS [Type],
     count( distinct  hn +( clinic_code + cast(cast (appoint_date_date as date) as nvarchar))) AS [Result],
     count( distinct  hn +( clinic_code + cast(cast (appoint_date_date as date) as nvarchar)))  AS [ตัวตั้ง],
    '1' AS [ตัวหาร],
    'SiSKN' AS [BU]
FROM 
    [tele]
WHERE  LEFT(clinic_code,2) = '64'
GROUP BY 
    [Fiscal_Year], [Actual_Date]

UNION ALL
-- Man Count BOT
SELECT 
    [Fiscal_Year],
    [Actual_Date],
    'จำนวนผู้ป่วย Telemed (คน)' AS [Type],
   count(distinct hn) AS [Result],
    count(distinct hn) AS [ตัวตั้ง],
    '1' AS [ตัวหาร],
    'BOT' AS [BU]
FROM 
    [tele]
WHERE  clinic_code in ('4767','4779')
GROUP BY 
    [Fiscal_Year], [Actual_Date]

UNION ALL
-- Visit Count BOT
SELECT 
    [Fiscal_Year],
    [Actual_Date],
    'จำนวนผู้ป่วย Telemed (ครั้ง)' AS [Type],
     count( distinct  hn +( clinic_code + cast(cast (appoint_date_date as date) as nvarchar))) AS [Result],
     count( distinct  hn +( clinic_code + cast(cast (appoint_date_date as date) as nvarchar))) AS [ตัวตั้ง],
    '1' AS [ตัวหาร],
    'BOT' AS [BU]
FROM 
    [tele]
WHERE  clinic_code in ('4767','4779')
GROUP BY 
    [Fiscal_Year], [Actual_Date];

GO


