graph LR;
da.View_HMD_Data_Source --> |Table| da.HMD_LT_Revenue_OPD
da.View_HMD_Data_Source --> |Table| da.HMD_LT_visit_OPD
da.View_HMD_Data_Source --> |View| da.HMD_SV_ALERT_DUTY_MED
da.View_HMD_Data_Source --> |View| da.HMD_SV_ALERT_ER
da.View_HMD_Data_Source --> |View| da.HMD_SV_an_IPD
da.View_HMD_Data_Source --> |View| da.HMD_SV_Bed_Utilization
da.View_HMD_Data_Source --> |View| da.HMD_SV_Bed_Utilization_UnOcc24
da.View_HMD_Data_Source --> |View| da.HMD_SV_Bedturn_Bedmanagement
da.View_HMD_Data_Source --> |View| da.HMD_SV_Blockbed_Bedmanagement
da.View_HMD_Data_Source --> |View| da.HMD_SV_CMI_bedmanagement
da.View_HMD_Data_Source --> |View| da.HMD_SV_ER_DUTY
da.View_HMD_Data_Source --> |View| da.HMD_SV_Infection_Rate
da.View_HMD_Data_Source --> |View| da.HMD_SV_LOS_bedmanagement
da.View_HMD_Data_Source --> |View| da.HMD_SV_Medication_Error_Newformat
da.View_HMD_Data_Source --> |View| da.HMD_SV_Mortality_Bedmanagement
da.View_HMD_Data_Source --> |View| da.HMD_SV_NetPromoterScore
da.View_HMD_Data_Source --> |View| da.HMD_SV_Occupancy_bedmanagement
da.View_HMD_Data_Source --> |View| da.HMD_SV_OffCaseOR
da.View_HMD_Data_Source --> |View| da.HMD_SV_OSS
da.View_HMD_Data_Source --> |View| da.HMD_SV_OSS_UT_ROOM
da.View_HMD_Data_Source --> |View| da.HMD_SV_PATIENT_LOAD_ER
da.View_HMD_Data_Source --> |View| da.HMD_SV_Readmissionrate
da.View_HMD_Data_Source --> |View| da.HMD_SV_Revenue_IPD
da.View_HMD_Data_Source --> |View| da.HMD_SV_Satisfaction
da.View_HMD_Data_Source --> |View| da.HMD_SV_SirirajConnect
da.View_HMD_Data_Source --> |View| da.HMD_SV_Telemed
da.View_HMD_Data_Source --> |View| da.HMD_SV_Ultra_Safe
da.View_HMD_Data_Source --> |View| da.HMD_SV_Unsatisfaction
da.HMD_SV_Unsatisfaction --> |Table| SiSurvey.Surveys_Transaction
da.HMD_SV_Ultra_Safe --> |Table| dbo.T_IRMdata
da.HMD_SV_Telemed --> |Table| dbo.T_appoint_tele
da.HMD_SV_Telemed --> |Table| dbo.T_out_patient_visit_details_info
da.HMD_SV_SirirajConnect --> |Table| dbo.T_smart_user
da.HMD_SV_Satisfaction --> |Table| SiSurvey.Surveys_Transaction
da.HMD_SV_Revenue_IPD --> |Table| dbo.INTO_Financial_Information_of_IPD_5Year
dbo.View_Financial_Information_of_IPD_Cost_Ratio --> |Table| dbo.T_CO_Cost_Per_Period_OPD_IPD
dbo.View_SAP_ChargeCostRatioReport_Join --> |Table| dbo.M_CO_Master_SerCode_to_SerGroup_to_SerType
dbo.View_SAP_ChargeCostRatioReport_Join --> |Table| dbo.SAP_ChargeCostRatioReport
da.hospitalbedmanagement_clean --> |Table| dbo.EHIS_PR_ENCOUNTER
da.hospitalbedmanagement_clean --> |Table| da.M_old_new_bedmanagement
da.hospitalbedmanagement_clean --> |Table| silver.PD_EH_PL_LT_ehis_bed_snap_bybedno
silver.PD_EH_RL_SV_ehis_adt_trn_in_patient_with_bedno --> |Table| silver.PD_EH_HL_LT_ehis_adt_trn_in_patient
silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed --> |Table| EHIS.EHIS_IP_BED_BOOKING
silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed --> |Table| EHIS.EHIS_IP_BLOCKING_TYPE
silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed --> |Table| dbo.EHIS_IP_NURSING_UNIT
da.HMD_SV_Readmissionrate --> |Table| dbo.EHIS_PR_ENCOUNTER
da.HMD_SV_Readmissionrate --> |Table| dbo.T_final_diag
da.view_machform_er_duty_rpa --> |Table| da.machform_er_duty_rpa
dbo.M_Holiday --> |Table| master_data.M_Holiday
da.View_OSS_Utilization --> |Table| dbo.OSS_M_ROOM_Quota_Dept
da.View_OSS_Utilization --> |Table| dbo.OSS_T_Orutilize_ORAdmission
dbo.M_Holiday --> |Table| master_data.M_Holiday
da.HMD_SV_OSS --> |Table| dbo.OSS_T_Orutilize_ORAdmission
da.HMD_SV_OffCaseOR --> |Table| dbo.OSS_SetCase
da.vT_RM_OffCaseOR_Excel1 --> |Table| dbo.T_IRMdata
da.vT_RM_OffCaseOR_Excel1 --> |Table| da.T_RM_OffCaseOR_Excel3
da.HMD_SV_Occupancy_Bedmanagement --> |Table| gold.PD_EH_RL_AM_hospital_bedmanagement
da.HMD_SV_NetPromoterScore --> |Table| SiSurvey.Surveys_Transaction
da.HMD_SV_Mortality_Bedmanagement --> |Table| dbo.EHIS_PR_ENCOUNTER
da.HMD_SV_Mortality_Bedmanagement --> |Table| dbo.M_Discharge_Type
da.HMD_SV_Mortality_Bedmanagement --> |Table| gold.PD_EH_RL_AM_hospital_bedmanagement
da.HMD_SV_Medication_Error_Newformat --> |Table| dbo.EHIS_PR_ENCOUNTER
da.HMD_SV_Medication_Error_Newformat --> |Table| gold.PD_EH_RL_AM_hospital_bedmanagement
da.HMD_SV_Medication_Error_Newformat --> |Table| dbo.siod_phopd
da.HMD_SV_Medication_Error_Newformat --> |Table| dbo.T_IRMdata
da.HMD_SV_LOS_Bedmanagement --> |Table| dbo.EHIS_PR_ENCOUNTER
da.HMD_SV_LOS_Bedmanagement --> |Table| gold.PD_EH_RL_AM_hospital_bedmanagement
da.HMD_SV_Infection_Rate --> |Table| dbo.T_IC
da.view_machform_er_duty_rpa --> |Table| da.machform_er_duty_rpa
dbo.M_Holiday --> |Table| master_data.M_Holiday
da.HMD_SV_CMI_bedmanagement --> |Table| dbo.EHIS_PR_ENCOUNTER
da.HMD_SV_CMI_bedmanagement --> |Table| gold.PD_EH_RL_AM_hospital_bedmanagement
da.HMD_SV_CMI_bedmanagement --> |Table| dbo.T_MR_ENCOUNTER_DRG_INFO
da.HMD_SV_Blockbed_Bedmanagement --> |Table| da.HMD_LT_AM_Bedmanagement
da.HMD_SV_Bedturn_Bedmanagement --> |Table| gold.PD_EH_RL_AM_hospital_bedmanagement
gold.PD_EH_SV_AM_hospital_bedmanagement_unocc24 --> |Table| dbo.EHIS_IP_NURSING_UNIT
gold.PD_EH_SV_AM_hospital_bedmanagement_unocc24 --> |Table| gold.PD_EH_PL_LT_ehis_nursing_unit_bed_hist_by_date
da.View_EHIS_MASTER_BED --> |Table| dbo.EHIS_IP_NURSING_UNIT_BED
dbo.View_EHIS_Bed_Blocking_By_Bed --> |Table| EHIS.EHIS_IP_BED_BOOKING
dbo.View_EHIS_Bed_Blocking_By_Bed --> |Table| EHIS.EHIS_IP_BLOCKING_TYPE
dbo.View_EHIS_Bed_Blocking_By_Bed --> |Table| dbo.EHIS_IP_NURSING_UNIT
silver.PD_EH_RL_SV_hospital_bedmanagement_unocc24 --> |Table| Gold.PD_EH_RL_AM_hospital_bedmanagement
da.View_EHIS_MASTER_BED --> |Table| dbo.EHIS_IP_NURSING_UNIT_BED
dbo.View_EHIS_Bed_Blocking_By_Bed --> |Table| EHIS.EHIS_IP_BED_BOOKING
dbo.View_EHIS_Bed_Blocking_By_Bed --> |Table| EHIS.EHIS_IP_BLOCKING_TYPE
dbo.View_EHIS_Bed_Blocking_By_Bed --> |Table| dbo.EHIS_IP_NURSING_UNIT
EHIS.EHIS_BED_CLASS_GROUP --> |Table| dbo.EHIS_IP_BED_CLASS
da.HMD_SV_Bed_Utilization --> |Table| gold.PD_EH_RL_AM_hospital_bedmanagement
da.HMD_SV_an_IPD --> |Table| dbo.T_in_patient
da.view_machform_er_rpa --> |Table| da.machform_er_rpa
dbo.M_Holiday --> |Table| master_data.M_Holiday
da.view_machform_er_duty_rpa --> |Table| da.machform_er_duty_rpa
dbo.M_Holiday --> |Table| master_data.M_Holiday
da.HMD_SV_Revenue_IPD --> |View| da.hospitalbedmanagement_clean
da.HMD_SV_Revenue_IPD --> |View| dbo.View_Financial_Information_of_IPD_Cost_Ratio
dbo.View_Financial_Information_of_IPD_Cost_Ratio --> |View| dbo.View_SAP_ChargeCostRatioReport_Final
dbo.View_SAP_ChargeCostRatioReport_Final --> |View| dbo.View_SAP_ChargeCostRatioReport_Join
da.hospitalbedmanagement_clean --> |View| silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed
da.hospitalbedmanagement_clean --> |View| silver.PD_EH_RL_SV_ehis_adt_trn_in_patient_with_bedno
silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed --> |View| dbo.View_Date2000-01-01_TO_toDayPlus180day
da.HMD_SV_PATIENT_LOAD_ER --> |View| da.HMD_Patient_Load_Shift
da.HMD_Patient_Load_Shift --> |View| da.view_machform_er_duty_rpa
da.view_machform_er_duty_rpa --> |View| dbo.M_Holiday_With_Weekend
dbo.M_Holiday_With_Weekend --> |View| dbo.M_Holiday
da.HMD_SV_OSS_UT_ROOM --> |View| da.Demo_HMD_Source_OSS_UT330_%Room_2
da.Demo_HMD_Source_OSS_UT330_%Room_2 --> |View| da.View_OSS_Utilization
da.View_OSS_Utilization --> |View| dbo.M_Holiday
da.View_OSS_Utilization --> |View| dbo.View_Date2000-01-01_TO_toDay
da.HMD_SV_OffCaseOR --> |View| da.vT_RM_OffCaseOR_Excel1
da.HMD_SV_ER_DUTY --> |View| da.view_machform_er_duty_rpa
da.view_machform_er_duty_rpa --> |View| dbo.M_Holiday_With_Weekend
dbo.M_Holiday_With_Weekend --> |View| dbo.M_Holiday
da.HMD_SV_Bed_Utilization_UnOcc24 --> |View| gold.PD_EH_SV_AM_hospital_bedmanagement_unocc24
gold.PD_EH_SV_AM_hospital_bedmanagement_unocc24 --> |View| silver.PD_EH_RL_SV_hospital_bedmanagement_unocc24
gold.PD_EH_SV_AM_hospital_bedmanagement_unocc24 --> |View| dbo.View_EHIS_Bed_Blocking_By_Bed
gold.PD_EH_SV_AM_hospital_bedmanagement_unocc24 --> |View| da.View_EHIS_MASTER_BED
dbo.View_EHIS_Bed_Blocking_By_Bed --> |View| dbo.View_Date2000-01-01_TO_toDayPlus180day
silver.PD_EH_RL_SV_hospital_bedmanagement_unocc24 --> |View| EHIS.EHIS_BED_CLASS_GROUP
silver.PD_EH_RL_SV_hospital_bedmanagement_unocc24 --> |View| dbo.View_Date2017-01-01_TO_toDay
silver.PD_EH_RL_SV_hospital_bedmanagement_unocc24 --> |View| dbo.View_EHIS_Bed_Blocking_By_Bed
silver.PD_EH_RL_SV_hospital_bedmanagement_unocc24 --> |View| da.View_EHIS_MASTER_BED
dbo.View_EHIS_Bed_Blocking_By_Bed --> |View| dbo.View_Date2000-01-01_TO_toDayPlus180day
da.HMD_SV_ALERT_ER --> |View| dbo.View_Datetime2024-12-01_TO_toDay_Every60min
da.HMD_SV_ALERT_ER --> |View| da.view_machform_er_rpa
da.view_machform_er_rpa --> |View| dbo.M_Holiday_With_Weekend
dbo.M_Holiday_With_Weekend --> |View| dbo.M_Holiday
da.HMD_SV_ALERT_DUTY_MED --> |View| dbo.View_Datetime2024-12-01_TO_toDay_Every60min
da.HMD_SV_ALERT_DUTY_MED --> |View| da.view_machform_er_duty_rpa
da.view_machform_er_duty_rpa --> |View| dbo.M_Holiday_With_Weekend
dbo.M_Holiday_With_Weekend --> |View| dbo.M_Holiday
style da.View_HMD_Data_Source fill:#ffcc00,stroke:#333,stroke-width:2px;
style da.HMD_LT_Revenue_OPD fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.HMD_LT_visit_OPD fill:#ccffcc,stroke:#333,stroke-width:2px;
style SiSurvey.Surveys_Transaction fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_IRMdata fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_appoint_tele fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_out_patient_visit_details_info fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_smart_user fill:#ccffcc,stroke:#333,stroke-width:2px;
style SiSurvey.Surveys_Transaction fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.INTO_Financial_Information_of_IPD_5Year fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_CO_Cost_Per_Period_OPD_IPD fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.M_CO_Master_SerCode_to_SerGroup_to_SerType fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.SAP_ChargeCostRatioReport fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_PR_ENCOUNTER fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.M_old_new_bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style silver.PD_EH_PL_LT_ehis_bed_snap_bybedno fill:#ccffcc,stroke:#333,stroke-width:2px;
style silver.PD_EH_HL_LT_ehis_adt_trn_in_patient fill:#ccffcc,stroke:#333,stroke-width:2px;
style EHIS.EHIS_IP_BED_BOOKING fill:#ccffcc,stroke:#333,stroke-width:2px;
style EHIS.EHIS_IP_BLOCKING_TYPE fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_NURSING_UNIT fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_PR_ENCOUNTER fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_final_diag fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.machform_er_duty_rpa fill:#ccffcc,stroke:#333,stroke-width:2px;
style master_data.M_Holiday fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.OSS_M_ROOM_Quota_Dept fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.OSS_T_Orutilize_ORAdmission fill:#ccffcc,stroke:#333,stroke-width:2px;
style master_data.M_Holiday fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.OSS_T_Orutilize_ORAdmission fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.OSS_SetCase fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_IRMdata fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.T_RM_OffCaseOR_Excel3 fill:#ccffcc,stroke:#333,stroke-width:2px;
style gold.PD_EH_RL_AM_hospital_bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style SiSurvey.Surveys_Transaction fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_PR_ENCOUNTER fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.M_Discharge Type fill:#ccffcc,stroke:#333,stroke-width:2px;
style gold.PD_EH_RL_AM_hospital_bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_PR_ENCOUNTER fill:#ccffcc,stroke:#333,stroke-width:2px;
style gold.PD_EH_RL_AM_hospital_bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.siod_phopd fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_IRMdata fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_PR_ENCOUNTER fill:#ccffcc,stroke:#333,stroke-width:2px;
style gold.PD_EH_RL_AM_hospital_bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_IC fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.machform_er_duty_rpa fill:#ccffcc,stroke:#333,stroke-width:2px;
style master_data.M_Holiday fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_PR_ENCOUNTER fill:#ccffcc,stroke:#333,stroke-width:2px;
style gold.PD_EH_RL_AM_hospital_bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_MR_ENCOUNTER_DRG_INFO fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.HMD_LT_AM_Bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style gold.PD_EH_RL_AM_hospital_bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_NURSING_UNIT fill:#ccffcc,stroke:#333,stroke-width:2px;
style gold.PD_EH_PL_LT_ehis_nursing_unit_bed_hist_by_date fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_NURSING_UNIT_BED fill:#ccffcc,stroke:#333,stroke-width:2px;
style EHIS.EHIS_IP_BED_BOOKING fill:#ccffcc,stroke:#333,stroke-width:2px;
style EHIS.EHIS_IP_BLOCKING_TYPE fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_NURSING_UNIT fill:#ccffcc,stroke:#333,stroke-width:2px;
style Gold.PD_EH_RL_AM_hospital_bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_NURSING_UNIT_BED fill:#ccffcc,stroke:#333,stroke-width:2px;
style EHIS.EHIS_IP_BED_BOOKING fill:#ccffcc,stroke:#333,stroke-width:2px;
style EHIS.EHIS_IP_BLOCKING_TYPE fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_NURSING_UNIT fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_BED_CLASS fill:#ccffcc,stroke:#333,stroke-width:2px;
style gold.PD_EH_RL_AM_hospital_bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_in_patient fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.machform_er_rpa fill:#ccffcc,stroke:#333,stroke-width:2px;
style master_data.M_Holiday fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.machform_er_duty_rpa fill:#ccffcc,stroke:#333,stroke-width:2px;
style master_data.M_Holiday fill:#ccffcc,stroke:#333,stroke-width:2px;
