# Original PD_EH_RL_SV_hospital_bedmanagement

```mermaid
graph LR;
gold.PD_EH_RL_SV_hospital_bedmanagement --> |Table| dbo.EHIS_PR_ENCOUNTER
gold.PD_EH_RL_SV_hospital_bedmanagement --> |View| silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed
gold.PD_EH_RL_SV_hospital_bedmanagement --> |View| silver.PD_EH_PL_SV_ehis_adt_trn_in_patient_agg
gold.PD_EH_RL_SV_hospital_bedmanagement --> |View| silver.PD_EH_PL_SV_ehis_nursing_unit_bed_hist_by_date2
silver.PD_EH_PL_SV_ehis_nursing_unit_bed_hist2 --> |Table| EHIS.IP_NURSING_UNIT_BED_HIST
silver.PD_EH_PL_GV_ehis_bed_sanp_by_bedno_imputation --> |Table| dbo.EHIS_IP_NURSING_UNIT_BED_Snap
silver.PD_EH_PL_SV_ehis_adt_trn_in_patient_agg --> |Table| silver.PD_EH_HL_LT_ehis_adt_trn_in_patient
silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed --> |Table| EHIS.EHIS_IP_BED_BOOKING
silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed --> |Table| EHIS.EHIS_IP_BLOCKING_TYPE
silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed --> |Table| dbo.EHIS_IP_NURSING_UNIT
silver.PD_EH_PL_SV_ehis_nursing_unit_bed_hist_by_date2 --> |View| silver.PD_EH_PL_SV_ehis_nursing_unit_bed_hist2
silver.PD_EH_PL_SV_ehis_nursing_unit_bed_hist_by_date2 --> |View| dbo.View_Date2017-01-01_TO_toDay
silver.PD_EH_PL_SV_ehis_nursing_unit_bed_hist2 --> |View| silver.PD_EH_PL_GV_ehis_bed_sanp_by_bedno_imputation
silver.PD_EH_PL_GV_ehis_bed_sanp_by_bedno_imputation --> |View| dbo.View_Date2017-01-01_TO_toDay
silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed --> |View| dbo.View_Date2000-01-01_TO_toDayPlus180day
style gold.PD_EH_RL_SV_hospital_bedmanagement fill:#ffcc00,stroke:#333,stroke-width:2px;
style dbo.EHIS_PR_ENCOUNTER fill:#ccffcc,stroke:#333,stroke-width:2px;
style EHIS.IP_NURSING_UNIT_BED_HIST fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_NURSING_UNIT_BED_Snap fill:#ccffcc,stroke:#333,stroke-width:2px;
style silver.PD_EH_HL_LT_ehis_adt_trn_in_patient fill:#ccffcc,stroke:#333,stroke-width:2px;
style EHIS.EHIS_IP_BED_BOOKING fill:#ccffcc,stroke:#333,stroke-width:2px;
style EHIS.EHIS_IP_BLOCKING_TYPE fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_NURSING_UNIT fill:#ccffcc,stroke:#333,stroke-width:2px;
