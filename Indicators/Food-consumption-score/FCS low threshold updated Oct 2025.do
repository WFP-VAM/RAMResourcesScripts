*** -----------------------------------------------------------------------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                         Food Consumption Score (FCS), 21-35 thresholds


*** Last Update: Oct 2025
*** Purpose: This script calculates the Food Consumption Score (FCS) using standard methodology with HIGH thresholds (28-42) for sugar/oil consuming populations.
*** For setting the right threshold, please refer to the FCS technical guidance on the VAM Resource Centre: https://resource-centre.document360.io/docs/food-consumption-score

*** WFP Data Quality Guidance References:
***   - Recommended high frequency checks: Page 30
***   - Recommended cleaning steps: Page 36-37

*** Find the WFP Data Quality Guidance here: https://resource-centre.document360.io/docs/data-quality

*** -----------------------------------------------------------------------------------------------------------------------------------------------------------------

*** Define group labels-  these should match Survey Designer naming conventions

label variable FCSStap  "Consumption over the past 7 days: Cereals, grains and tubers"
label variable FCSPulse "Consumption over the past 7 days: Pulses"
label variable FCSDairy "Consumption over the past 7 days: Dairy"
label variable FCSPr    "Consumption over the past 7 days: Meat, fish and eggs"
label variable FCSVeg   "Consumption over the past 7 days: Vegetables and leaves"
label variable FCSFruit "Consumption over the past 7 days: Fruit"
label variable FCSFat   "Consumption over the past 7 days: Fat and oil"
label variable FCSSugar "Consumption over the past 7 days: Sugar or sweets"
label variable FCSCond  "Consumption over the past 7 days: Condiments or spices"

*** Harmonize Data Quality Guidance measures
 *** Clean impossible values 


foreach v in FCSStap FCSPulse FCSDairy FCSPr FCSVeg FCSFruit FCSFat FCSSugar {
    replace `v' = . if `v' < 0  | `v' >= 8
}

**OR

recode FCSStap FCSPulse FCSDairy FCSPr FCSVeg FCSFruit FCSFat FCSSugar (min/-1=.) (8/max=.)

*** Calculate FCS (use + instead of SUM to automatically drop missing values from the final FCS)
 *** Note: Condiments (FCSCond) are not included in standard FCS calculation
 
gen FCS = FCSStap*2 + FCSPulse*3 + FCSDairy*4 + FCSPr*4 + FCSVeg*1 + FCSFruit*1 + FCSFat*0.5 + FCSSugar*0.5

label var FCS "Food Consumption Score"

*** Harmonize Data Quality Guidance measures
 *** Check that FCS is between 0-112

 summarize FCS, detail
 
*** Clean any impossible FCS values 

recode FCS (min/-1=.) (113/max=.)

**OR

replace FCS = . if FCS < 0
replace FCS = . if FCS >= 113

*** Flagging potential Data Quality issues. If any cases reflected here, refer to the Data Quality Guidance note pages 36-37. This can be found on the VAM Ressource Centre

gen byte FCS_flag_low = 0
replace FCS_flag_low = 1 if FCS < 14
label variable FCS_flag_low "FCS has low values that could be a Data Quality issue. Refer to the Data Quality guidance for recommended actions"

gen byte FCS_flag_high = 0
replace FCS_flag_high = 1 if FCS > 100
label variable FCS_flag_high "FCS has high values that could be a Data Quality issue. Refer to the Data Quality guidance for recommended actions"

label define yesno 0"No" 1"Yes"
label values FCS_flag_low FCS_flag_high yesno

*** Check flagged cases

codebook FCS_flag_low FCS_flag_high

tabulate FCS_flag_low, missing
tabulate FCS_flag_high, missing

*** Use this when analyzing a country with HIGH consumption of sugar and oil – thresholds 28-42

gen FCSCat21 = .
replace FCSCat21 = 1 if FCS <= 21
replace FCSCat21 = 2 if FCS > 21 & FCS <= 35
replace FCSCat21 = 3 if FCS > 35

*OR

recode FCS (min/21 = 1)(21.5/35 = 2)(35.5/max = 3), generate(FCSCat21)

label variable FCSCat21 "FCS Categories: Low thresholds"

*** Define value labels and properties for "FCS Categories"

label define FCSCat21_lbl 1 "Poor" 2 "Borderline" 3 "Acceptable"
label values FCSCat21 FCSCat21_lbl

*** Check distribution of final categories

tabulate FCSCat21, missing

*** Sample check of food group distributions (recommended for data quality review)

tabstat FCSStap FCSPulse FCSDairy FCSPr FCSVeg FCSFruit FCSFat FCSSugar, s(mean median min max)
**OR
summarize FCSStap FCSPulse FCSDairy FCSPr FCSVeg FCSFruit FCSFat FCSSugar

*** Optional: Compute the same variable to be used directly for IPC analysis (referring to IPC phases)

gen FCSCat21IPC = .
replace FCSCat21IPC = 1 if FCS <= 21
replace FCSCat21IPC = 2 if FCS > 21  & FCS <= 35
replace FCSCat21IPC = 3 if FCS > 35

label variable FCSCat28IPC "Official IPC Classification for FCS - low thresholds"

label define FCSCat21IPC_lbl 1 "Poor - IPC Phase 4-5" 2 "Borderline - IPC Phase 3" 3 "Acceptable - IPC Phase 1-2"

label values FCSCat21IPC FCSCat21IPC_lbl

*** Check distribution of final categories

tabulate FCSCat21IPC, missing

****End Script****

