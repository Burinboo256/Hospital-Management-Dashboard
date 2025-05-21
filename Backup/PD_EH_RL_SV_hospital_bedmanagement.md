# PD_EH_RL_SV_hospital_bedmanagement 21/5/2025

```mermaid
graph LR;
gold.PD_EH_RL_SV_hospital_bedmanagement --> |Table| dbo.EHIS_PR_ENCOUNTER
gold.PD_EH_RL_SV_hospital_bedmanagement --> |Table| gold.PD_EH_PL_LT_ehis_nursing_unit_bed_hist_by_date
gold.PD_EH_RL_SV_hospital_bedmanagement --> |View| silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed
gold.PD_EH_RL_SV_hospital_bedmanagement --> |View| silver.PD_EH_PL_SV_ehis_adt_trn_in_patient_agg
silver.PD_EH_PL_SV_ehis_adt_trn_in_patient_agg --> |Table| silver.PD_EH_HL_LT_ehis_adt_trn_in_patient
silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed --> |Table| EHIS.EHIS_IP_BED_BOOKING
silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed --> |Table| EHIS.EHIS_IP_BLOCKING_TYPE
silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed --> |Table| dbo.EHIS_IP_NURSING_UNIT
silver.PD_EH_HL_SV_ehis_bed_blocking_by_bed --> |View| dbo.View_Date2000-01-01_TO_toDayPlus180day
style gold.PD_EH_RL_SV_hospital_bedmanagement fill:#ffcc00,stroke:#333,stroke-width:2px;
style dbo.EHIS_PR_ENCOUNTER fill:#ccffcc,stroke:#333,stroke-width:2px;
style gold.PD_EH_PL_LT_ehis_nursing_unit_bed_hist_by_date fill:#ccffcc,stroke:#333,stroke-width:2px;
style silver.PD_EH_HL_LT_ehis_adt_trn_in_patient fill:#ccffcc,stroke:#333,stroke-width:2px;
style EHIS.EHIS_IP_BED_BOOKING fill:#ccffcc,stroke:#333,stroke-width:2px;
style EHIS.EHIS_IP_BLOCKING_TYPE fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_NURSING_UNIT fill:#ccffcc,stroke:#333,stroke-width:2px;
