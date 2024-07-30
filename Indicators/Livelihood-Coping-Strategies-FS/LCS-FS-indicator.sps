*------------------------------------------------------------------------------*
*                          WFP Standardized Scripts
*          Calculating Livelihood Coping Strategy for Food Security (LCS-FS)
*------------------------------------------------------------------------------*

* This script calculates the Livelihood Coping Strategy for Food Security (LCS-FS) 
* indicator based on household responses to various coping strategies. The indicator 
* considers stress, crisis, and emergency strategies and summarizes coping behavior.

* Important note: this syntax file is only an example. When calculating the indicator, 
* you will need to include the 10 strategies (4 stress, 3 crisis, 3 emergency) that 
* were selected for your specific case.

* Please find more guidance on the indicator at the LCS-FS VAM Resource Center page: 
* https://resources.vam.wfp.org/data-analysis/quantitative/food-security/livelihood-coping-strategies-food-security

* VALUE LABELS
VALUE LABELS
     Lcs_stress_DomAsset 
     Lcs_stress_Utilities 
     Lcs_stress_Saving 
     Lcs_stress_BorrowCash 
     Lcs_crisis_ProdAssets 
     Lcs_crisis_Health 
     Lcs_crisis_OutSchool 
     Lcs_em_ResAsset 
     Lcs_em_Begged 
     Lcs_em_IllegalAct 
    10 'No, because we did not need to' 
    20 'No, because we already sold those assets or have engaged in this activity within the last 12 months and cannot continue to' 
    30 'Yes' 
  9999 'Not applicable (do not have children/these assets)'.

* TREATMENT OF MISSING VALUES

* The LCS-FS standard module does not allow for skipping questions, so there should not be missing values. Check that indeed this is the case.
FREQUENCIES 
  Lcs_stress_DomAsset 
  Lcs_stress_Utilities 
  Lcs_stress_Saving 
  Lcs_stress_BorrowCash 
  Lcs_crisis_ProdAssets 
  Lcs_crisis_Health 
  Lcs_crisis_OutSchool 
  Lcs_em_ResAsset 
  Lcs_em_Begged 
  Lcs_em_IllegalAct.

* If there are no missings, you can just go ahead. If there are missing values, then you will need to understand why and, based on that, treat these missing values.

    * POTENTIAL REASON 1: Although not recommended, customized modules might include skip patterns to avoid asking about strategies that are not relevant for the household. 
                          * For example, a skip pattern might be introduced so that a question on withdrawing children from school is not asked to households with no children. 
                          * In these cases, it is important to recode missing values to 9999 'Not applicable (don't have children/these assets)'. 

    * POTENTIAL REASON 2: Although in the standard module questions should be mandatory, customized modules might allow to skip questions (for example because the respondent refuse to answer). 
                          * In these cases, missing values should be left as such.

* STRESS STRATEGIES
* Reminder: this is just an example of four stress strategies. You will need to replace with the four strategies selected for your specific case

* Variable labels: 
VARIABLE LABELS
  Lcs_stress_DomAsset    "Sold household assets/goods (radio, furniture, refrigerator, television, jewellery, etc.)" 
  Lcs_stress_Utilities   "Reduced or ceased payments on essential utilities and bills" 
  Lcs_stress_Saving      "Spent savings" 
  Lcs_stress_BorrowCash  "Borrowed cash".

* % of households who adopted one or more stress coping strategies
DO IF 
  Lcs_stress_DomAsset    = 20 | 
  Lcs_stress_DomAsset    = 30 | 
  Lcs_stress_Utilities   = 20 | 
  Lcs_stress_Utilities   = 30 | 
  Lcs_stress_Saving      = 20 | 
  Lcs_stress_Saving      = 30 | 
  Lcs_stress_BorrowCash  = 20 | 
  Lcs_stress_BorrowCash  = 30.
    COMPUTE stress_coping_FS = 1.
ELSE.
    COMPUTE stress_coping_FS = 0.
END IF.
VARIABLE LABELS 
  stress_coping_FS "Did the HH engage in stress coping strategies?".

* CRISIS STRATEGIES
* Reminder: this is just an example of three crisis strategies. You will need to replace with the three strategies selected for your specific case

* Variable labels: 
VARIABLE LABELS
  Lcs_crisis_ProdAssets  "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.)"
  Lcs_crisis_Health      "Reduced expenses on health (including drugs)"
  Lcs_crisis_OutSchool   "Withdrew children from school".

* % of households who adopted one or more crisis coping strategies
DO IF 
  Lcs_crisis_ProdAssets  = 20 | 
  Lcs_crisis_ProdAssets  = 30 | 
  Lcs_crisis_Health      = 20 | 
  Lcs_crisis_Health      = 30 | 
  Lcs_crisis_OutSchool   = 20 | 
  Lcs_crisis_OutSchool   = 30.
    COMPUTE crisis_coping_FS = 1.
ELSE.
    COMPUTE crisis_coping_FS = 0.
END IF.
EXECUTE.
VARIABLE LABELS 
  crisis_coping_FS "Did the HH engage in crisis coping strategies?".

* EMERGENCY STRATEGIES
* Reminder: this is just an example of three emergency strategies. You will need to replace with the three strategies selected for your specific case

* Variable labels: 
VARIABLE LABELS
  Lcs_em_ResAsset    "Mortgaged/Sold house or land" 
  Lcs_em_Begged      "Begged and/or scavenged (asked strangers for money/food/other goods)" 
  Lcs_em_IllegalAct  "Had to engage in illegal income activities (theft, prostitution)".

* % of households who adopted one or more emergency coping strategies
DO IF 
  Lcs_em_ResAsset    = 20 | 
  Lcs_em_ResAsset    = 30 | 
  Lcs_em_Begged      = 20 | 
  Lcs_em_Begged      = 30 | 
  Lcs_em_IllegalAct  = 20 | 
  Lcs_em_IllegalAct  = 30.
    COMPUTE emergency_coping_FS = 1.
ELSE.
    COMPUTE emergency_coping_FS = 0.
END IF.
VARIABLE LABELS 
  emergency_coping_FS "Did the HH engage in emergency coping strategies?".

* COPING BEHAVIOR
* This variable counts the strategies with valid (i.e. non-missing) values - normally it should be equal to 10 for all respondents.
COMPUTE temp_nonmiss_number = NVALID(
  Lcs_stress_DomAsset, 
  Lcs_stress_Utilities, 
  Lcs_stress_Saving, 
  Lcs_stress_BorrowCash, 
  Lcs_crisis_ProdAssets, 
  Lcs_crisis_Health, 
  Lcs_crisis_OutSchool, 
  Lcs_em_ResAsset, 
  Lcs_em_Begged, 
  Lcs_em_IllegalAct).
EXECUTE.
VARIABLE LABELS 
  temp_nonmiss_number "Number of strategies with non-missing values".

DO IF temp_nonmiss_number > 0.
    COMPUTE Max_coping_behaviourFS = 1.
END IF.
* The Max_coping_behaviourFS variable will be missing for an observation if answers to strategies are all missing.
DO IF stress_coping_FS = 1.
    COMPUTE Max_coping_behaviourFS = 2.
END IF.
DO IF crisis_coping_FS = 1.
    COMPUTE Max_coping_behaviourFS = 3.
END IF.
DO IF emergency_coping_FS = 1.
    COMPUTE Max_coping_behaviourFS = 4.
END IF.
EXECUTE.

VALUE LABELS 
  Max_coping_behaviourFS 
  1 'HH not adopting coping strategies' 
  2 'Stress coping strategies' 
  3 'Crisis coping strategies' 
  4 'Emergency coping strategies'.
VARIABLE LABELS 
  Max_coping_behaviourFS "Summary of asset depletion".

DELETE VARIABLES 
  temp_nonmiss_number.
EXECUTE.

* Tabulate results.
FREQUENCIES 
  Max_coping_behaviourFS.

* End of Scripts