*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                         Livelihood Coping Strategies - Essential Needs (LCS-EN)


*** Last Update: Oct 2025
*** Purpose: This script calculates the Livelihood Coping Strategies Index

***   Data Quality Guidance References:
***   - Recommended high frequency checks: Page 31
***   - Recommended cleaning steps: Page 38

*** ----------------------------------------------------------------------------------------------------

*** Important note
*** This syntax file is only an example. When calculating the indicator, you will need to include the 10 strategies (4 stress, 3 crisis, 3 emergency) that were selected for your assessment.
*** Please find more guidance by searching for the indicator at the VAM Resource Center https://resources.vam.wfp.org 

*** Define group labels-  these should match Survey Designer naming conventions
label var LcsEN_stress_DomAsset      "Household has sold domestic assets in past 30 days to cover essential needs"
label var LcsEN_stress_Utilities     "Reduced/ceased payments on utilities to cover essential needs"
label var LcsEN_stress_Saving        "Household has spent savings to cover essential needs"
label var LcsEN_stress_BorrowCash    "Borrowed money in last 30 days to cover essential needs"

label var LcsEN_crisis_ProdAssets    "Sold productive assets in past 30 days to cover essential needs"
label var LcsEN_crisis_Health        "Reduced spending on essential health in past 30 days"
label var LcsEN_crisis_OutSchool     "Withdrawn children from school to cover essential needs"

label var LcsEN_em_ResAsset          "Sold/mortgaged house or land to cover essential needs"
label var LcsEN_em_Begged            "Household begged in past 30 days to cover essential needs"
label var LcsEN_em_IllegalAct        "Engaged in illegal activities to cover essential needs"

*** VALUE LABELS for all coping strategy variables

label define lcslab 10 "No, because did not need to" ///
                    20 "No, because already did this in last 12 months" ///
                    30 "Yes" ///
                    9999 "Not applicable"

label values LcsEN_stress_DomAsset lcslab
label values LcsEN_stress_Utilities lcslab
label values LcsEN_stress_Saving lcslab
label values LcsEN_stress_BorrowCash lcslab
label values LcsEN_crisis_ProdAssets lcslab
label values LcsEN_crisis_Health lcslab
label values LcsEN_crisis_OutSchool lcslab
label values LcsEN_em_ResAsset lcslab
label values LcsEN_em_Begged lcslab
label values LcsEN_em_IllegalAct lcslab

*** Harmonize Data Quality Guidance measures
*** Check individual strategies. Check for missing values or non-standard values. Check for high usage of N/A. It is recommended to check this by enumerator. If this is the case, refer to the Data Quality Guidance

tab1 LcsEN_stress_DomAsset LcsEN_stress_Utilities LcsEN_stress_Saving ///
     LcsEN_stress_BorrowCash LcsEN_crisis_ProdAssets LcsEN_crisis_Health ///
     LcsEN_crisis_OutSchool LcsEN_em_ResAsset LcsEN_em_Begged LcsEN_em_IllegalAct, missing

*** Calculate LCS-EN
*** Reminder: this is an example of four stress, three crisis and three emergency strategies. You need to replace with the strategies selected for your assessment

*Compute Stress Coping (EN)

gen Stress_coping_EN = 0
replace Stress_coping_EN = 2 if (LcsEN_stress_DomAsset==20 | LcsEN_stress_DomAsset==30) ///
    | (LcsEN_stress_Utilities==20 | LcsEN_stress_Utilities==30) ///
    | (LcsEN_stress_Saving==20 | LcsEN_stress_Saving==30) ///
    | (LcsEN_stress_BorrowCash==20 | LcsEN_stress_BorrowCash==30)

label var Stress_coping_EN "Did the HH engage in stress coping strategies?"
label define stresslab 0 "No" 2 "Yes"
label values Stress_coping_EN stresslab

*Compute Crisis Coping (EN)

gen Crisis_coping_EN = 0
replace Crisis_coping_EN = 3 if (LcsEN_crisis_ProdAssets==20 | LcsEN_crisis_ProdAssets==30) ///
    | (LcsEN_crisis_Health==20 | LcsEN_crisis_Health==30) ///
    | (LcsEN_crisis_OutSchool==20 | LcsEN_crisis_OutSchool==30)

label var Crisis_coping_EN "Did the HH engage in crisis coping strategies?"
label define crisislab 0 "No" 3 "Yes"
label values Crisis_coping_EN crisislab

*Compute Emergency Coping (EN)

gen Emergency_coping_EN = 0
replace Emergency_coping_EN = 4 if (LcsEN_em_ResAsset==20 | LcsEN_em_ResAsset==30) ///
    | (LcsEN_em_Begged==20 | LcsEN_em_Begged==30) ///
    | (LcsEN_em_IllegalAct==20 | LcsEN_em_IllegalAct==30)

label var Emergency_coping_EN "Did the HH engage in emergency coping strategies?"
label define emerglab 0 "No" 4 "Yes"
label values Emergency_coping_EN emerglab

*** For CARI, we use the highest coping strategy applied by the HH. If no coping is used, recode to 1

egen Max_coping_behaviourEN = rowmax(Stress_coping_EN Crisis_coping_EN Emergency_coping_EN)
replace Max_coping_behaviourEN = 1 if Max_coping_behaviourEN==0 | missing(Max_coping_behaviourEN)

label var Max_coping_behaviourEN "Highest coping strategy applied (EN)"
label define maxenlab 1 "No coping" 2 "Stress" 3 "Crisis" 4 "Emergency"
label values Max_coping_behaviourEN maxenlab

tab1 Stress_coping_EN Crisis_coping_EN Emergency_coping_EN Max_coping_behaviourEN, missing

*** Analyse why the strategies were adopted (to cover which essential need)
*** This question is posed as multiple choice. To get each variable as binary (0,1), ensure download the dataset  to tick so each choice is regsitered in a separate column
*** When exporting from MoDa, this is done by, in addition to the default export options, ticking the following boxes:
            *** "Remove prefixed group names"
            *** Use 1 or 0 in split select muliples (the default is True or False)"
            *** Delimiter to use for separating group names from field names" -> selec ".(Dot)

*** Rename variables to remove the dot.
rename LhCSIEnAccess_1   LhCSIEnAccess1
rename LhCSIEnAccess_2   LhCSIEnAccess2
rename LhCSIEnAccess_3   LhCSIEnAccess3
rename LhCSIEnAccess_4   LhCSIEnAccess4
rename LhCSIEnAccess_5   LhCSIEnAccess5
rename LhCSIEnAccess_6   LhCSIEnAccess6
rename LhCSIEnAccess_7   LhCSIEnAccess7
rename LhCSIEnAccess_8   LhCSIEnAccess8
rename LhCSIEnAccess_999 LhCSIEnAccess999

label var LhCSIEnAccess1   "Adopted strategies to buy food"
label var LhCSIEnAccess2   "Adopted strategies to pay for rent"
label var LhCSIEnAccess3   "Adopted strategies to pay school, education costs"
label var LhCSIEnAccess4   "Adopted strategies to cover health expenses"
label var LhCSIEnAccess5   "Adopted strategies to buy essential non-food items (clothes, small furniture)"
label var LhCSIEnAccess6   "Adopted strategies to access water or sanitation facilities"
label var LhCSIEnAccess7   "Adopted strategies to access essential dwelling services (electricity, energy, waste disposal...)"
label var LhCSIEnAccess8   "Adopted strategies to pay for existing debts"
label var LhCSIEnAccess999 "Adopted strategies for other reasons"

*** To estimate food insecurity using CARI and for IPC analyses, the LCS-FS indicator must be used
*** In this case, the LCS-EN indicator should be converted to the LCS-FS.
*** This can be done by using the final question included in the LCS-EN module asking the main reasons why coping strategies were adopted (LhCSIEnAccess). 
*** If "to buy food" is not among the reasons selected for applying livelihood coping strategies then these cases/households should be considered under "not coping" when computing CARI 

gen Max_coping_behaviourFS = 0
replace Max_coping_behaviourFS = Max_coping_behaviourEN if LhCSIEnAccess1 == 1
replace Max_coping_behaviourFS = 1 if Max_coping_behaviourFS == 0 | missing(Max_coping_behaviourFS)


label var Max_coping_behaviourFS1 ///
    "Summary of asset depletion (converted from LCS-EN to LCS-FS)"

tab Max_coping_behaviourFS1, missing

*** Optional: Compute the same variable to be used directly for IPC analysis (referring to IPC phases) - can only be done with the LCS FS indicator, never LCS EN
*---------------------------------------------------------------*
* Create IPC-compatible LCSI variable (based on LCS-FS)
*---------------------------------------------------------------*

gen Max_coping_behaviourFS_IPC = Max_coping_behaviourFS

label var Max_coping_behaviourFS_IPC "Official IPC Classification for LCS"

capture label drop ipclab
label define ipclab                                                ///
    1 "LCSI [none] - IPC Phase 1"                                  ///
    2 "LCSI [stress] - IPC Phase 2"                                ///
    3 "LCSI [crisis] - IPC Phase 3"                                ///
    4 "LCSI [emergency] - IPC Phase 4-5"

label values Max_coping_behaviourFS_IPC ipclab

*---------------------------------------------------------------*
* Frequency table (distribution of final categories)
*---------------------------------------------------------------*
tabulate Max_coping_behaviourFS_IPC, missing