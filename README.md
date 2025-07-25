```mermaid
graph LR;
da.View_HMD_Data_Source4 --> |Table| da.HMD_LT_visit_OPD
da.View_HMD_Data_Source4 --> |View| da.HMD_SV_CMI_bedmanagement
da.View_HMD_Data_Source4 --> |View| da.HMD_SV_Blockbed_Bedmanagement
da.View_HMD_Data_Source4 --> |View| da.HMD_SV_Infection_Rate
da.View_HMD_Data_Source4 --> |View| da.HMD_SV_Bed_Utilization_UnOcc24
da.View_HMD_Data_Source4 --> |View| da.HMD_SV_Bed_Utilization
da.View_HMD_Data_Source4 --> |View| da.HMD_SV_Bedturn_Bedmanagement
da.View_HMD_Data_Source4 --> |View| da.HMD_SV_Mortality_bedmanagement
da.View_HMD_Data_Source4 --> |View| da.HMD_SV_Readmissionrate
da.View_HMD_Data_Source4 --> |View| da.HMD_SV_an_IPD
da.View_HMD_Data_Source4 --> |View| da.HMD_SV_LOS_bedmanagement
da.View_HMD_Data_Source4 --> |View| da.HMD_SV_SirirajConnect
da.View_HMD_Data_Source4 --> |View| da.HMD_SV_Telemed
da.View_HMD_Data_Source4 --> |View| da.HMD_SV_Occupancy_bedmanagement
da.HMD_SV_Mortality_Bedmanagement --> |Table| dbo.M_Discharge_Type
gold.PD_EH_SV_AM_hospital_bedmanagement_unocc24 --> |Table| dbo.EHIS_IP_NURSING_UNIT
gold.PD_EH_SV_AM_hospital_bedmanagement_unocc24 --> |Table| gold.PD_EH_PL_LT_ehis_nursing_unit_bed_hist_by_date
da.HMD_SV_LOS_Bedmanagement --> |Table| gold.PD_EH_RL_AM_hospital_bedmanagement
da.HMD_SV_Readmissionrate --> |Table| dbo.EHIS_PR_ENCOUNTER
da.HMD_SV_Readmissionrate --> |Table| dbo.T_final_diag
da.HMD_SV_Blockbed_Bedmanagement --> |Table| da.HMD_LT_AM_Bedmanagement
da.View_EHIS_MASTER_BED --> |Table| dbo.EHIS_IP_NURSING_UNIT_BED
da.HMD_SV_Telemed --> |Table| dbo.T_out_patient_visit_details_info
da.HMD_SV_Mortality_Bedmanagement --> |Table| dbo.EHIS_PR_ENCOUNTER
da.HMD_SV_Bed_Utilization --> |Table| gold.PD_EH_RL_AM_hospital_bedmanagement
da.HMD_SV_CMI_bedmanagement --> |Table| dbo.EHIS_PR_ENCOUNTER
dbo.View_EHIS_Bed_Blocking_By_Bed --> |Table| EHIS.EHIS_IP_BED_BOOKING
dbo.View_EHIS_Bed_Blocking_By_Bed --> |Table| EHIS.EHIS_IP_BLOCKING_TYPE
silver.PD_EH_RL_SV_hospital_bedmanagement_unocc24 --> |Table| Gold.PD_EH_RL_AM_hospital_bedmanagement
da.HMD_SV_Telemed --> |Table| dbo.T_appoint_tele
da.HMD_SV_LOS_Bedmanagement --> |Table| dbo.EHIS_PR_ENCOUNTER
da.HMD_SV_Infection_Rate --> |Table| dbo.T_IC
da.HMD_SV_Occupancy_Bedmanagement --> |Table| gold.PD_EH_RL_AM_hospital_bedmanagement
da.HMD_SV_Mortality_Bedmanagement --> |Table| gold.PD_EH_RL_AM_hospital_bedmanagement
da.HMD_SV_CMI_bedmanagement --> |Table| dbo.T_MR_ENCOUNTER_DRG_INFO
dbo.View_EHIS_Bed_Blocking_By_Bed --> |Table| dbo.EHIS_IP_NURSING_UNIT
da.HMD_SV_CMI_bedmanagement --> |Table| gold.PD_EH_RL_AM_hospital_bedmanagement
da.HMD_SV_Bedturn_Bedmanagement --> |Table| gold.PD_EH_RL_AM_hospital_bedmanagement
EHIS.EHIS_BED_CLASS_GROUP --> |Table| dbo.EHIS_IP_BED_CLASS
da.HMD_SV_an_IPD --> |Table| dbo.T_in_patient
da.HMD_SV_SirirajConnect --> |Table| dbo.T_smart_user
silver.PD_EH_RL_SV_hospital_bedmanagement_unocc24 --> |View| EHIS.EHIS_BED_CLASS_GROUP
gold.PD_EH_SV_AM_hospital_bedmanagement_unocc24 --> |View| silver.PD_EH_RL_SV_hospital_bedmanagement_unocc24
silver.PD_EH_RL_SV_hospital_bedmanagement_unocc24 --> |View| dbo.View_Date2017-01-01_TO_toDay
dbo.View_EHIS_Bed_Blocking_By_Bed --> |View| dbo.View_Date2000-01-01_TO_toDayPlus180day
gold.PD_EH_SV_AM_hospital_bedmanagement_unocc24 --> |View| dbo.View_EHIS_Bed_Blocking_By_Bed
silver.PD_EH_RL_SV_hospital_bedmanagement_unocc24 --> |View| dbo.View_EHIS_Bed_Blocking_By_Bed
da.HMD_SV_Bed_Utilization_UnOcc24 --> |View| gold.PD_EH_SV_AM_hospital_bedmanagement_unocc24
gold.PD_EH_SV_AM_hospital_bedmanagement_unocc24 --> |View| da.View_EHIS_MASTER_BED
silver.PD_EH_RL_SV_hospital_bedmanagement_unocc24 --> |View| da.View_EHIS_MASTER_BED
style da.View_HMD_Data_Source4 fill:#ffcc00,stroke:#333,stroke-width:2px;
style dbo.EHIS_PR_ENCOUNTER fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_NURSING_UNIT_BED fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_in_patient fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_MR_ENCOUNTER_DRG_INFO fill:#ccffcc,stroke:#333,stroke-width:2px;
style EHIS.EHIS_IP_BLOCKING_TYPE fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_out_patient_visit_details_info fill:#ccffcc,stroke:#333,stroke-width:2px;
style EHIS.EHIS_IP_BED_BOOKING fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.M_Discharge_Type fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.HMD_LT_visit_OPD fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_final_diag fill:#ccffcc,stroke:#333,stroke-width:2px;
style da.HMD_LT_AM_Bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_appoint_tele fill:#ccffcc,stroke:#333,stroke-width:2px;
style gold.PD_EH_PL_LT_ehis_nursing_unit_bed_hist_by_date fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_BED_CLASS fill:#ccffcc,stroke:#333,stroke-width:2px;
style gold.PD_EH_RL_AM_hospital_bedmanagement fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_IC fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_NURSING_UNIT fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_smart_user fill:#ccffcc,stroke:#333,stroke-width:2px;


