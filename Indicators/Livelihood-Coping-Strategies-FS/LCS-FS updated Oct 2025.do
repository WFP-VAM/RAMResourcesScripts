*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                         Livelihood Coping Strategies - Food Security (LCS-FS)


*** Last Update: Oct 20265
*** Purpose: This script calculates the Livelihood Coping Strategies Index

***   Data Quality Guidance References:
***   - Recommended high frequency checks: Page 31
***   - Recommended cleaning steps: Page 38

*** ----------------------------------------------------------------------------------------------------

*** Important note
*** This syntax file is only an example. When calculating the indicator, you will need to include the 10 strategies (4 stress, 3 crisis, 3 emergency) that were selected for your assessment.
*** Please find more guidance by searching for the indicator at the VAM Resource Center https://resources.vam.wfp.org 

*** Define group labels-  these should match Survey Designer naming conventions

*************************************************************
*** Variable labels for LCS indicators
*************************************************************
label var Lcs_stress_DomAsset      "Household has sold domestic assets in the past 30 days to cover food needs"
label var Lcs_stress_Utilities     "Reduced or ceased payments on essential utilities and bills due to lack of food"
label var Lcs_stress_Saving        "Household has spent savings in the past 30 days to cover food needs"
label var Lcs_stress_BorrowCash    "Household has borrowed money in the past 30 days to cover food needs"

label var Lcs_crisis_ProdAssets    "Household has sold productive assets in the past 30 days to cover food needs"
label var Lcs_crisis_Health        "Household has reduced spending on essential health in the past 30 days to cover food needs"
label var Lcs_crisis_OutSchool     "Household has withdrawn children from school in the past 30 days to cover food needs"

label var Lcs_em_ResAsset          "Mortgaged/sold house that the household was permanently living in or sold land due to lack of food"
label var Lcs_em_Begged            "Household has begged in the past 30 days to cover food needs"
label var Lcs_em_IllegalAct        "Household has engaged in illegal act in the past 30 days to cover food needs"

*************************************************************
*** Value labels for LCS indicators
*************************************************************

label define LCS_lbl ///
    10   "No, because we did not need to" ///
    20   "No, because we already sold those assets or have engaged in this activity within the last 12 months and cannot continue" ///
    30   "Yes" ///
    9999 "Not applicable"

label values Lcs_stress_DomAsset Lcs_stress_Utilities Lcs_stress_Saving Lcs_stress_BorrowCash Lcs_crisis_ProdAssets Lcs_crisis_Health Lcs_crisis_OutSchool Lcs_em_ResAsset Lcs_em_Begged Lcs_em_IllegalAct LCS_lbl

*** Harmonize Data Quality Guidance measures
*** Check individual strategies. Check for missing values or non-standard values. Check for high usage of N/A. It is recommended to check this by enumerator. If this is the case, refer to the Data Quality Guidance

tab Lcs_stress_DomAsset, missing
tab Lcs_stress_Utilities, missing
tab Lcs_stress_Saving, missing
tab Lcs_stress_BorrowCash, missing

tab Lcs_crisis_ProdAssets, missing
tab Lcs_crisis_Health, missing
tab Lcs_crisis_OutSchool, missing

tab Lcs_em_ResAsset, missing
tab Lcs_em_Begged, missing
tab Lcs_em_IllegalAct, missing

*---------------------------------------------------------------*
*   Calculate LCSI coping strategy indicators in STATA
*---------------------------------------------------------------*

*------------------------*
* Stress coping = 2
*------------------------*

gen Stress_coping_FS = 0
replace Stress_coping_FS = 2 if (Lcs_stress_DomAsset == 20 | Lcs_stress_DomAsset == 30) ///
    | (Lcs_stress_Utilities == 20 | Lcs_stress_Utilities == 30) ///
    | (Lcs_stress_Saving == 20 | Lcs_stress_Saving == 30) ///
    | (Lcs_stress_BorrowCash == 20 | Lcs_stress_BorrowCash == 30)

label var Stress_coping_FS "Did the HH engage in stress coping strategies?"
label define stresscopelab 0 "No" 2 "Yes"
label values Stress_coping_FS stresscopelab

*------------------------*
* Crisis coping = 3
*------------------------*
gen Crisis_coping_FS = 0
replace Crisis_coping_FS = 3 if (Lcs_crisis_ProdAssets == 20 | Lcs_crisis_ProdAssets == 30) ///
    | (Lcs_crisis_Health == 20 | Lcs_crisis_Health == 30) ///
    | (Lcs_crisis_OutSchool == 20 | Lcs_crisis_OutSchool == 30)

label var Crisis_coping_FS "Did the HH engage in crisis coping strategies?"
label define crisiscopelab 0 "No" 3 "Yes"
label values Crisis_coping_FS crisiscopelab

*------------------------*
* Emergency coping = 4
*------------------------*
gen Emergency_coping_FS = 0
replace Emergency_coping_FS = 4 if (Lcs_em_ResAsset == 20 | Lcs_em_ResAsset == 30) ///
    | (Lcs_em_Begged == 20 | Lcs_em_Begged == 30) ///
    | (Lcs_em_IllegalAct == 20 | Lcs_em_IllegalAct == 30)

label var Emergency_coping_FS "Did the HH engage in emergency coping strategies?"
label define emergencycopelab 0 "No" 4 "Yes"
label values Emergency_coping_FS emergencycopelab


*-------------------------------------------------------------*
* Compute Max coping strategy (CARI component)
*-------------------------------------------------------------*

egen Max_coping_behaviourFS = rowmax(Stress_coping_FS Crisis_coping_FS Emergency_coping_FS)
replace Max_coping_behaviourFS = 1 if Max_coping_behaviourFS == 0

label var Max_coping_behaviourFS "Which coping strategy was the highest applied by the household?"
label define maxcopelab 1 "Household did not apply coping strategies" ///
                       2 "Household applied stress coping strategies" ///
                       3 "Household applied crisis coping strategies" ///
                       4 "Household applied emergency coping strategies"
label values Max_coping_behaviourFS maxcopelab


*-------------------------------------------------------------*
* Frequencies (tabulations)
*-------------------------------------------------------------*
tab Stress_coping_FS
tab Crisis_coping_FS
tab Emergency_coping_FS
tab Max_coping_behaviourFS

*---------------------------------------------------------------------*
* Optional: Compute the IPC-compatible LCSI variable
*---------------------------------------------------------------------*

gen Max_coping_behaviourFS_IPC = Max_coping_behaviourFS

label var Max_coping_behaviourFS_IPC "Official IPC Classification for LCS"

label define ipclab 1 "LCSI [none] - IPC Phase 1" ///
                    2 "LCSI [stress] - IPC Phase 2" ///
                    3 "LCSI [crisis] - IPC Phase 3" ///
                    4 "LCSI [emergency] - IPC Phase 4-5"

label values Max_coping_behaviourFS_IPC ipclab


*---------------------------------------------------------------------*
* Check distribution of IPC categories
*---------------------------------------------------------------------*
tabulate Max_coping_behaviourFS_IPC, missing

*** ----------------------------------------------------------------------------------------------------
*** END OF SCRIPT
*** ----------------------------------------------------------------------------------------------------