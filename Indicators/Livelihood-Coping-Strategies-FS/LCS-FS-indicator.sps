* Encoding: UTF-8.

*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                        Livelihood Coping Strategies - Food Security (LCS-FS)


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

VARIABLE LABELS
Lcs_stress_DomAsset        "Household has sold domestic assets in the past 30 days to cover food needs"
Lcs_stress_Utilities              "Reduced or ceased payments on essential utilities and bills due to lack of food"
Lcs_stress_Saving               "Household has spent savings in the past 30 days to cover food needs"
Lcs_stress_BorrowCash     "Household has borrowed money in the past 30 days to cover food needs"
Lcs_crisis_ProdAssets        "Household has sold productive assets in the past 30 days to cover food needs"
Lcs_crisis_Health                  "Household has reduced spendning on essential health in the past 30 days to cover food needs"
Lcs_crisis_OutSchool           "Household has withdrawn children from school in the past 30 days to cover food needs"
Lcs_em_ResAsset                "Mortgaged/sold ​house that the household was permanently living in or sold land due to lack of food"
Lcs_em_Begged                   "Household has begged in the past 30 days to cover food needs"
Lcs_em_IllegalAct                 "Household has engaged in illegal act in the past 30 days to cover food needs".
EXECUTE.

VALUE LABELS
Lcs_stress_DomAsset Lcs_stress_Utilities Lcs_stress_Saving Lcs_stress_BorrowCash Lcs_crisis_ProdAssets Lcs_crisis_Health Lcs_crisis_OutSchool 
Lcs_em_ResAsset Lcs_em_Begged Lcs_em_IllegalAct
   10 "No, because we did not need to"
   20 "No, because we already sold those assets or have engaged in this activity within the last 12 months and cannot continue"
   30 "Yes"
   9999 "Not applicable".
EXECUTE.

 *** Harmonize Data Quality Guidance measures
*** Check individual strategies. Check for missing values or non-standard values. Check for high usage of N/A. It is recommended to check this by enumerator. If this is the case, refer to the Data Quality Guidance

FREQUENCIES Lcs_stress_DomAsset Lcs_stress_Utilities Lcs_stress_Saving Lcs_stress_BorrowCash Lcs_crisis_ProdAssets Lcs_crisis_Health 
Lcs_crisis_OutSchool Lcs_em_ResAsset Lcs_em_Begged Lcs_em_IllegalAct.

*** Calculate LCSI 
*** Reminder: this is an example of four stress, three crisis and three emergency strategies. You need to replace with the strategies selected for your assessment

COMPUTE Stress_coping_FS = 0.
IF (Lcs_stress_DomAsset = 20 OR Lcs_stress_DomAsset = 30 OR Lcs_stress_Utilities = 20 OR Lcs_stress_Utilities = 30 OR Lcs_stress_Saving = 20 OR Lcs_stress_Saving = 30 OR  Lcs_stress_BorrowCash = 20 OR Lcs_stress_BorrowCash = 30) Stress_coping_FS = 2.
EXECUTE.

COMPUTE Crisis_coping_FS = 0.
IF (Lcs_crisis_ProdAssets = 20 OR Lcs_crisis_ProdAssets = 30 OR Lcs_crisis_Health = 20 OR Lcs_crisis_Health = 30 OR Lcs_crisis_OutSchool = 20 OR Lcs_crisis_OutSchool = 30) Crisis_coping_FS = 3.
EXECUTE.

COMPUTE Emergency_coping_FS = 0.
IF (Lcs_em_ResAsset = 20 OR Lcs_em_ResAsset = 30 OR Lcs_em_Begged = 20 OR Lcs_em_Begged = 30 OR Lcs_em_IllegalAct = 20 OR Lcs_em_IllegalAct = 30) Emergency_coping_FS = 4.
EXECUTE.

** Add variable labels

VARIABLE LABELS Stress_coping_FS "Did the HH engage in stress coping strategies?".
VALUE LABELS Stress_coping_FS
   0 'No'
   2 'Yes'.

VARIABLE LABELS Crisis_coping_FS "Did the HH engage in crisis coping strategies?".
VALUE LABELS Crisis_coping_FS
   0 'No'
   3 'Yes'.

VARIABLE LABELS Emergency_coping_FS "Did the HH engage in emergency coping strategies".
VALUE LABELS Emergency_coping_FS
   0 'No'
   4 'Yes'.
EXECUTE.

*** For CARI, we use the highest coping strategy applied by the HH. If no coping is used, recode to 1

COMPUTE Max_coping_behaviourFS = 0.
COMPUTE Max_coping_behaviourFS = MAX(Stress_coping_FS, Crisis_coping_FS, Emergency_coping_FS).
RECODE Max_coping_behaviourFS (0=1).
VARIABLE LABELS Max_coping_behaviourFS "Which coping strategy was the highest applied by the household?".
VALUE LABELS Max_coping_behaviourFS
   1 'Household did not apply coping strategies'
   2 'Household applied stress coping strategies'
   3 'Household applied crisis coping strategies'
   4 'Household applied emergency coping strategies'.
EXECUTE.

FREQUENCIES VARIABLES = Stress_coping_FS Crisis_coping_FS Emergency_coping_FS Max_coping_behaviourFS.

*** Optional: Compute the same variable to be used directly for IPC analysis (referring to IPC phases)

COMPUTE Max_coping_behaviourFS_IPC = Max_coping_behaviourFS.
VARIABLE LABELS Max_coping_behaviourFS_IPC "Official IPC Classification for LCS".
VALUE LABELS Max_coping_behaviourFS_IPC 
    1 "LCSI [none] - IPC Phase 1"
    2 "LCSI [stress] - IPC Phase 2"
    3 "LCSI [crisis]  - IPC Phase 3"
    4 "LCSI [emergency] - IPC Phase 4-5".
EXECUTE.

*** Check distribution of final categories

FREQUENCIES VARIABLES=Max_coping_behaviourFS_IPC 
  /ORDER=ANALYSIS.

*** ----------------------------------------------------------------------------------------------------
*** END OF SCRIPT
*** ----------------------------------------------------------------------------------------------------
