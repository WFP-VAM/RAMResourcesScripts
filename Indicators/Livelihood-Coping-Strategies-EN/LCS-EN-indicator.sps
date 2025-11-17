* Encoding: UTF-8.

*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                        Livelihood Coping Strategies - Essential Needs (LCS-EN)


*** Last Update: Nov 2025
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
LcsEN_stress_DomAsset       "Household has sold domestic assets in the past 30 days to cover essential needs"
LcsEN_stress_Utilities             "Reduced or ceased payments on essential utilities and bills to cover essential needs"
LcsEN_stress_Saving               "Household has spent savings in the past 30 days to cover essential needs"
LcsEN_stress_BorrowCash     "Household has borrowed money in the past 30 days to essentialer food needs"
LcsEN_crisis_ProdAssets        "Household has sold productive assets in the past 30 days to cover essential needs"
LcsEN_crisis_Health                  "Household has reduced spendning on essential health in the past 30 days to cover essential needs"
LcsEN_crisis_OutSchool          "Household has withdrawn children from school in the past 30 days to cover essential needs"
LcsEN_em_ResAsset                "Mortgaged/sold house that the household was permanently living in or sold land to cover essential needs"
LcsEN_em_Begged                   "Household has begged in the past 30 days to cover essential needs"
LcsEN_em_IllegalAct                 "Household has engaged in illegal act in the past 30 days to cover essential needs".
EXECUTE.

VALUE LABELS
LcsEN_stress_DomAsset LcsEN_stress_Utilities LcsEN_stress_Saving LcsEN_stress_BorrowCash LcsEN_crisis_ProdAssets LcsEN_crisis_Health LcsEN_crisis_OutSchool 
LcsEN_em_ResAsset LcsEN_em_Begged LcsEN_em_IllegalAct
   10 "No, because we did not need to"
   20 "No, because we already sold those assets or have engaged in this activity within the last 12 months and cannot continue"
   30 "Yes"
   9999 "Not applicable".
EXECUTE.

 *** Harmonize Data Quality Guidance measures
*** Check individual strategies. Check for missing values or non-standard values. Check for high usage of N/A. It is recommended to check this by enumerator. If this is the case, refer to the Data Quality Guidance

FREQUENCIES LcsEN_stress_DomAsset LcsEN_stress_Utilities LcsEN_stress_Saving LcsEN_stress_BorrowCash LcsEN_crisis_ProdAssets LcsEN_crisis_Health 
LcsEN_crisis_OutSchool LcsEN_em_ResAsset LcsEN_em_Begged LcsEN_em_IllegalAct.

*** Calculate LCS-EN
*** Reminder: this is an example of four stress, three crisis and three emergency strategies. You need to replace with the strategies selected for your assessment

COMPUTE Stress_coping_EN = 0.
IF (LcsEN_stress_DomAsset = 20 OR LcsEN_stress_DomAsset = 30 OR LcsEN_stress_Utilities = 20 OR LcsEN_stress_Utilities = 30 OR LcsEN_stress_Saving = 20
     OR LcsEN_stress_Saving = 30 OR  LcsEN_stress_BorrowCash = 20 OR LcsEN_stress_BorrowCash = 30) Stress_coping_EN = 2.
EXECUTE.

COMPUTE Crisis_coping_EN = 0.
IF (LcsEN_crisis_ProdAssets = 20 OR LcsEN_crisis_ProdAssets = 30 OR LcsEN_crisis_Health = 20 OR LcsEN_crisis_Health = 30 OR LcsEN_crisis_OutSchool = 20 OR LcsEN_crisis_OutSchool = 30) Crisis_coping_EN = 3.
EXECUTE.

COMPUTE Emergency_coping_EN = 0.
IF (LcsEN_em_ResAsset = 20 OR LcsEN_em_ResAsset = 30 OR LcsEN_em_Begged = 20 OR LcsEN_em_Begged = 30 OR LcsEN_em_IllegalAct = 20 OR LcsEN_em_IllegalAct = 30) Emergency_coping_EN = 4.
EXECUTE.

*** Add variable labels

VARIABLE LABELS Stress_coping_EN "Did the HH engage in stress coping strategies?".
VALUE LABELS Stress_coping_EN
   0 'No'
   2 'Yes'.

VARIABLE LABELS Crisis_coping_EN "Did the HH engage in crisis coping strategies?".
VALUE LABELS Crisis_coping_EN
   0 'No'
   3 'Yes'.

VARIABLE LABELS Emergency_coping_EN "Did the HH engage in emergency coping strategies".
VALUE LABELS Emergency_coping_EN
   0 'No'
   4 'Yes'.
EXECUTE.

*** For CARI, we use the highest coping strategy applied by the HH. If no coping is used, recode to 1

COMPUTE Max_coping_behaviourEN = 0.
COMPUTE Max_coping_behaviourEN = MAX(Stress_coping_EN, Crisis_coping_EN, Emergency_coping_EN).
RECODE Max_coping_behaviourEN (0=1).
VARIABLE LABELS Max_coping_behaviourEN "Which coping strategy was the highest applied by the household?".
VALUE LABELS Max_coping_behaviourEN
   1 'Household did not apply coping strategies'
   2 'Household applied stress coping strategies'
   3 'Household applied crisis coping strategies'
   4 'Household applied emergency coping strategies'.
EXECUTE.

FREQUENCIES Stress_coping_EN Crisis_coping_EN Emergency_coping_EN Max_coping_behaviourEN.

*** Analyse why the strategies were adopted (to cover which essential need)
*** This question is posed as multiple choice. To get each variable as binary (0,1), ensure download the dataset  to tick so each choice is regsitered in a separate column
*** When exporting from MoDa, this is done by, in addition to the default export options, ticking the following boxes:
            *** "Remove prefixed group names"
            *** Use 1 or 0 in split select muliples (the default is True or False)"
            *** Delimiter to use for separating group names from field names" -> selec ".(Dot)
            
*** Rename variables to remove the dot.
RENAME VARIABLES (LhCSIEnAccess.1 LhCSIEnAccess.2 LhCSIEnAccess.3 LhCSIEnAccess.4 LhCSIEnAccess.5 LhCSIEnAccess.6 LhCSIEnAccess.7 LhCSIEnAccess.8 LhCSIEnAccess.999 = 
LhCSIEnAccess1 LhCSIEnAccess2 LhCSIEnAccess3 LhCSIEnAccess4 LhCSIEnAccess5 LhCSIEnAccess6 LhCSIEnAccess7 LhCSIEnAccess8 LhCSIEnAccess999).
VARIABLE LABELS
 LhCSIEnAccess1                      "Adopted strategies to buy food" 
 LhCSIEnAccess2                      "Adopted strategies to pay for rent" 
 LhCSIEnAccess3                      "Adopted strategies to pay school, education costs" 
 LhCSIEnAccess4                      "Adopted strategies to cover health expenses" 
 LhCSIEnAccess5                      "Adopted strategies to buy essential non-food items (clothes, small furniture)" 
 LhCSIEnAccess6                      "Adopted strategies to access water or sanitation facilities" 
 LhCSIEnAccess7                      "Adopted strategies to access essential dwelling services (electricity, energy, waste disposal...)" 
 LhCSIEnAccess8                      "Adopted strategies to pay for existing debts" 
 LhCSIEnAccess999                 "Adopted strategies for other reasons" .
EXECUTE.

*** Analyse results
 
DESCRIPTIVES VARIABLES=LhCSIEnAccess1 LhCSIEnAccess2 LhCSIEnAccess3 LhCSIEnAccess4 LhCSIEnAccess5 
LhCSIEnAccess6 LhCSIEnAccess7 LhCSIEnAccess8 LhCSIEnAccess999
  /STATISTICS=MEAN.

*** To estimate food insecurity using CARI and for IPC analyses, the LCS-FS indicator must be used
*** In this case, the LCS-EN indicator should be converted to the LCS-FS.
*** This can be done by using the final question included in the LCS-EN module asking the main reasons why coping strategies were adopted (LhCSIEnAccess). 
*** If "to buy food" is not among the reasons selected for applying livelihood coping strategies then these cases/households should be considered under "not coping" when computing CARI 


compute Max_coping_behaviourFS=0.
IF LhCSIEnAccess1=1  Max_coping_behaviourFS=Max_coping_behaviourEN.
RECODE Max_coping_behaviourEN (0=1).

VARIABLE LABELS Max_coping_behaviourFS "Summary of asset depletion (converted from LCS-EN to LCS-FS)". 
EXECUTE.

FREQUENCIES Max_coping_behaviourFS.

*** Optional: Compute the same variable to be used directly for IPC analysis (referring to IPC phases) - can only be done with the LCS FS indicator, never LCS EN

*COMPUTE Max_coping_behaviourFS_IPC = Max_coping_behaviourFS.
*VARIABLE LABELS Max_coping_behaviourFS_IPC "Official IPC Classification for LCS".
*VALUE LABELS Max_coping_behaviourFS_IPC 
    1 "LCSI [none] - IPC Phase 1"
    2 "LCSI [stress] - IPC Phase 2"
    3 "LCSI [crisis]  - IPC Phase 3"
    4 "LCSI [emergency] - IPC Phase 4-5".
*EXECUTE.

*** Check distribution of final categories

*FREQUENCIES VARIABLES=Max_coping_behaviourFS_IPC 
  /ORDER=ANALYSIS.

*** ----------------------------------------------------------------------------------------------------
*** END OF SCRIPT
*** ----------------------------------------------------------------------------------------------------
