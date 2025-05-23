```mermaid
graph LR;
dbo.View_Financial_Information_of_IPD_5Year --> |Table| dbo.EHIS_IP_ADT_TRN
dbo.View_Financial_Information_of_IPD_5Year --> |Table| dbo.EHIS_PR_ENCOUNTER
dbo.View_Financial_Information_of_IPD_5Year --> |Table| dbo.INTO_in_patient_AllDept
dbo.View_Financial_Information_of_IPD_5Year --> |Table| dbo.M_CO_ITEMCODE_GROUP
dbo.View_Financial_Information_of_IPD_5Year --> |Table| dbo.M_doctor
dbo.View_Financial_Information_of_IPD_5Year --> |Table| dbo.M_patient_info2
dbo.View_Financial_Information_of_IPD_5Year --> |Table| dbo.M_province
dbo.View_Financial_Information_of_IPD_5Year --> |Table| dbo.M_Province_Area_Health
dbo.View_Financial_Information_of_IPD_5Year --> |Table| dbo.T_EHIS_Transaction_All_Item
dbo.View_Financial_Information_of_IPD_5Year --> |Table| dbo.T_EHIS_Transaction_All_Item_Discount
dbo.View_Financial_Information_of_IPD_5Year --> |Table| dbo.T_final_diag
dbo.View_Financial_Information_of_IPD_5Year --> |Table| dbo.T_in_patient
dbo.View_Financial_Information_of_IPD_5Year --> |Table| dbo.T_MR_ENCOUNTER_DRG_INFO
dbo.View_Financial_Information_of_IPD_5Year --> |View| dbo.View_ICD9_ReOperation
dbo.View_Financial_Information_of_IPD_5Year --> |View| dbo.View_SUM_PIVOT_IPD_ICD10_by_AN
dbo.View_Financial_Information_of_IPD_5Year --> |View| dbo.View_SUM_PIVOT_IPD_ICD9CM_O_by_AN
dbo.View_Financial_Information_of_IPD_5Year --> |View| dbo.View_SUM_PIVOT_IPD_ICD9CM_T_by_AN
dbo.View_Financial_Information_of_IPD_5Year --> |View| da.View_ZFI_AR_MAP_DEPT
da.View_ZFI_AR_MAP_DEPT --> |Table| dbo.ZFI_AR_MAP_UNIT
dbo.View_SUM_PIVOT_IPD_ICD9CM_T_by_AN --> |Table| dbo.M_ICD9CM
dbo.View_SUM_PIVOT_IPD_ICD9CM_T_by_AN --> |Table| dbo.T_final_diag
dbo.View_SUM_PIVOT_IPD_ICD9CM_O_by_AN --> |Table| dbo.M_ICD9CM
dbo.View_SUM_PIVOT_IPD_ICD9CM_O_by_AN --> |Table| dbo.T_final_diag
dbo.View_SUM_PIVOT_IPD_ICD10_by_AN --> |Table| dbo.T_final_diag
dbo.M_ICD10_Inter --> |Table| master_data.M_ICD10_Inter
dbo.View_ICD9_ReOperation --> |Table| dbo.T_final_diag
dbo.View_SUM_PIVOT_IPD_ICD10_by_AN --> |View| dbo.M_ICD10_Inter
style dbo.View_Financial_Information_of_IPD_5Year fill:#ffcc00,stroke:#333,stroke-width:2px;
style dbo.EHIS_IP_ADT_TRN fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.EHIS_PR_ENCOUNTER fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.INTO_in_patient_AllDept fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.M_CO_ITEMCODE_GROUP fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.M_doctor fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.M_patient_info2 fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.M_province fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.M_Province_Area_Health fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_EHIS_Transaction_All_Item fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_EHIS_Transaction_All_Item_Discount fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_final_diag fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_in_patient fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_MR_ENCOUNTER_DRG_INFO fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.ZFI_AR_MAP_UNIT fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.M_ICD9CM fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_final_diag fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.M_ICD9CM fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_final_diag fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_final_diag fill:#ccffcc,stroke:#333,stroke-width:2px;
style master_data.M_ICD10_Inter fill:#ccffcc,stroke:#333,stroke-width:2px;
style dbo.T_final_diag fill:#ccffcc,stroke:#333,stroke-width:2px;
```
