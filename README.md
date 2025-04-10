# Tableau-Admin-EcoSystem

```mermaid
graph LR;


da.View_HMD_Data_Source --> da.HMD_SV_Bedturn_Bedmanagement
da.View_HMD_Data_Source --> da.HMD_SV_Blockbed_Bedmanagement
da.View_HMD_Data_Source --> da.HMD_SV_CMI_bedmanagement
da.View_HMD_Data_Source --> da.HMD_SV_LOS_bedmanagement
da.View_HMD_Data_Source --> da.HMD_SV_Mortality_bedmanagement
da.View_HMD_Data_Source --> da.HMD_SV_Occupancy_bedmanagement
da.View_HMD_Data_Source --> da.HMD_SV_Medication_Error_Newformat
da.View_HMD_Data_Source --> da.HMD_SV_Infection_Rate
da.View_HMD_Data_Source --> da.HMD_SV_OffCaseOR
da.View_HMD_Data_Source --> da.HMD_SV_OSS
da.View_HMD_Data_Source --> da.HMD_SV_OSS_UT_ROOM
da.View_HMD_Data_Source --> da.HMD_SV_an_IPD
da.View_HMD_Data_Source --> da.HMD_LT_visit_OPD
da.View_HMD_Data_Source --> da.HMD_SV_Readmissionrate
da.View_HMD_Data_Source --> da.HMD_SV_Revenue_IPD
da.View_HMD_Data_Source --> da.HMD_SV_Revenue_OPD
da.View_HMD_Data_Source --> da.HMD_SV_Satisfaction
da.View_HMD_Data_Source --> da.HMD_SV_SirirajConnect
da.View_HMD_Data_Source --> da.HMD_SV_Telemed
da.View_HMD_Data_Source --> da.HMD_SV_Ultra_Safe
da.View_HMD_Data_Source --> da.HMD_SV_Unsatisfaction
da.HMD_SV_an_IPD --> dbo.T_in_patient
da.HMD_SV_Bedturn_Bedmanagement --> da.HMD_LT_AM_Bedmanagement
da.HMD_SV_Blockbed_Bedmanagement --> da.HMD_LT_AM_Bedmanagement
da.HMD_SV_CMI_bedmanagement --> da.HMD_LT_AM_Bedmanagement
da.HMD_SV_LOS_bedmanagement --> da.HMD_LT_AM_Bedmanagement
da.HMD_SV_Mortality_bedmanagement --> da.HMD_LT_AM_Bedmanagement
da.HMD_SV_Occupancy_bedmanagement --> da.HMD_LT_AM_Bedmanagement
da.HMD_SV_Infection_Rate --> dbo.T_IC
da.HMD_SV_Medication_Error_Newformat --> dbo.INTO_in_patient_AllDept
da.HMD_SV_Medication_Error_Newformat --> dbo.siod_phopd
da.HMD_SV_Medication_Error_Newformat --> dbo.T_IRMdata
da.HMD_SV_OffCaseOR --> da.T_RM_OffCaseOR_Excel1
da.HMD_SV_OffCaseOR --> dbo.OSS_SetCase
da.HMD_SV_OSS --> dbo.OSS_T_Orutilize_ORAdmission
da.HMD_SV_OSS_UT_ROOM --> da.Demo_HMD_Source_OSS_UT330_%Room_2
da.HMD_SV_Readmissionrate --> dbo.T_in_patient
da.HMD_SV_Readmissionrate --> dbo.EHIS_IP_ADT_TRN
da.HMD_SV_Readmissionrate --> dbo.T_final_diag
da.HMD_SV_Readmissionrate --> dbo.INTO_Financial_Information_of_IPD_5Year
da.HMD_SV_Revenue_IPD --> dbo.INTO_Financial_Information_of_IPD_5Year
da.HMD_SV_Revenue_IPD --> dbo.M_CO_Master_SerCode_to_SerGroup_to_SerType
da.HMD_SV_Revenue_IPD --> dbo.SAP_ChargeCostRatioReport
da.HMD_SV_Revenue_IPD --> dbo.T_CO_Cost_Per_Period_OPD_IPD
da.HMD_SV_Revenue_IPD --> dbo.T_Occupancy_Bed
da.HMD_SV_Revenue_OPD --> da.HMD_Financial_Information_of_OPD
da.HMD_SV_SirirajConnect --> dbo.T_smart_user
da.HMD_SV_Telemed --> dbo.T_appoint_tele
da.HMD_SV_Telemed --> dbo.T_out_patient_visit_details_info
da.HMD_SV_Ultra_Safe --> dbo.T_IRMdata
da.HMD_SV_Satisfaction --> SiSurvey.Surveys_Master_Questions
da.HMD_SV_Satisfaction --> SiSurvey.Surveys_Transaction
da.HMD_SV_Unsatisfaction --> SiSurvey.Surveys_Master_Questions
da.HMD_SV_Unsatisfaction --> SiSurvey.Surveys_Transaction
da.HMD_LT_visit_OPD --> da.HMD_SV_visit_OPD
da.HMD_LT_AM_Bedmanagement --> da.hospitalbedmanagement_clean_joinmaster
da.HMD_Financial_Information_of_OPD --> dbo.INTO_Financial_Information_of_OPD


style da.View_HMD_Data_Source fill:#ffcc00,stroke:#333,stroke-width:2px;
style da.HMD_LT_visit_OPD fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_in_patient fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.HMD_LT_AM_Bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.HMD_LT_AM_Bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.HMD_LT_AM_Bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_IC fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.HMD_LT_AM_Bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.INTO_in_patient_AllDept fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.siod_phopd fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_IRMdata fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.HMD_LT_AM_Bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.HMD_LT_AM_Bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.T_RM_OffCaseOR_Excel1 fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.OSS_SetCase fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.OSS_T_Orutilize_ORAdmission fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.Demo_HMD_Source_OSS_UT330_%Room_2 fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_ADT_TRN fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.INTO_Financial_Information_of_IPD_5Year fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_final_diag fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_in_patient fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.INTO_Financial_Information_of_IPD_5Year fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.M_CO_Master_SerCode_to_SerGroup_to_SerType fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.SAP_ChargeCostRatioReport fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_CO_Cost_Per_Period_OPD_IPD fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_Occupancy_Bed fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.HMD_Financial_Information_of_OPD fill:#ccffcc,stroke:#333,stroke-width:2px;
style SiSurvey.Surveys_Master_Questions fill:#ccffcc,stroke:#333,stroke-width:2px;
style SiSurvey.Surveys_Transaction fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_smart_user fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_appoint_tele fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_out_patient_visit_details_info fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_IRMdata fill:#ccffcc,stroke:#333,stroke-width:2px;
style SiSurvey.Surveys_Master_Questions fill:#ccffcc,stroke:#333,stroke-width:2px;
style SiSurvey.Surveys_Transaction fill:#ccffcc,stroke:#333,stroke-width:2px;


