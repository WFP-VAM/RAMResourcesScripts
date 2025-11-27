* Encoding: UTF-8.

*** --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                           Food Consumption Score (FCS), 21-35 thresholds


*** Last Update: Nov 2025
*** Purpose: This script calculates the Food Consumption Score (FCS) using standard methodology with low thresholds (21-35) for populations with low sugar/oil consumption
*** For setting the right threshold, please refer to the FCS technical guidance on the VAM Resource Centre: https://resource-centre.document360.io/docs/food-consumption-score

*** WFP Data Quality Guidance References:
***   - Recommended high frequency checks: Page 30
***   - Recommended cleaning steps: Page 36-37

*** Find the WFP Data Quality Guidance here: https://resource-centre.document360.io/docs/data-quality

*** --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

*** Define food group labels - these should match Survey Designer naming conventions

VARIABLE LABELS
FCSStap                 "Consumption over the past 7 days: Cereals, grains and tubers"
FCSPulse              "Consumption over the past 7 days: Pulses"
FCSDairy                "Consumption over the past 7 days: Dairy"
FCSPr                     "Consumption over the past 7 days: Meat, fish and eggs"
FCSVeg                  "Consumption over the past 7 days: Vegetables and leaves"
FCSFruit                 "Consumption over the past 7 days: Fruit"
FCSFat                   "Consumption over the past 7 days: Fat and oil"
FCSSugar              "Consumption over the past 7 days: Sugar or sweets"
FCSCond               "Consumption over the past 7 days: Condiments or spices".

*** Harmonize Data Quality Guidance measures
*** Clean impossible values 

RECODE FCSStap FCSPulse FCSDairy FCSPr FCSVeg FCSFruit FCSFat FCSSugar (LOWEST THRU -1 = SYSMIS).
RECODE FCSStap FCSPulse FCSDairy FCSPr FCSVeg FCSFruit FCSFat FCSSugar (8 THRU HIGHEST = SYSMIS).
EXECUTE.

*** Calculate FCS (use + instead of SUM to automatically drop missing values from the final FCS)
*** Note: Condiments (FCSCond) are not included in standard FCS calculation

COMPUTE FCS = FCSStap*2 + FCSPulse*3 + FCSDairy*4 + FCSPr*4 + FCSVeg*1 + FCSFruit*1 + FCSFat*0.5 + FCSSugar*0.5.
VARIABLE LABELS FCS "Food Consumption Score".
EXECUTE.

*** Harmonize Data Quality Guidance measures
*** Check that FCS is between 0-112

DESCRIPTIVES VARIABLES=FCS
  /STATISTICS=MEAN STDDEV MIN MAX.

*** Clean any impossible FCS values

RECODE FCS (LOWEST THRU -1 = SYSMIS).
RECODE FCS (113 THRU HIGHEST = SYSMIS).
EXECUTE.

*** Flagging potential Data Quality issues. If any cases reflected here, refer to the Data Quality Guidance note pages 36-37. This can be found on the VAM Ressource Centre

COMPUTE FCS_flag_low = 0.    
IF (FCS LT 14) FCS_flag_low = 1.
VARIABLE LABELS FCS_flag_low "FCS has low values that could be a Data Quality issue. Refer to the Data Quality guidance for recommended actions".
VALUE LABELS FCS_flag_low
    0 "No"
    1 "Yes".

COMPUTE FCS_flag_high = 0.    
IF (FCS GT 100) FCS_flag_high = 1.
VARIABLE LABELS FCS_flag_high "FCS has high values that could be a Data Quality issue. Refer to the Data Quality guidance for recommended actions".
VALUE LABELS FCS_flag_high
    0 "No"
    1 "Yes".

*** Check flagged cases

FREQUENCIES VARIABLES=FCS_flag_low FCS_flag_high
  /ORDER=ANALYSIS.

*** Use this when analyzing a country with LOW consumption of sugar and oil - thresholds 21-35

RECODE FCS (LOWEST THRU 21 = 1) (21.5 THRU 35 = 2) (35.5 THRU HIGHEST = 3) INTO FCSCat21.
VARIABLE LABELS FCSCat21 "FCS Categories: Low thresholds".
EXECUTE.

*** Define value labels and properties for "FCS Categories".

VALUE LABELS FCSCat21 
    1 "Poor" 
    2 "Borderline" 
    3 "Acceptable".
EXECUTE.

*** Check distribution of final categories

FREQUENCIES VARIABLES=FCSCat21
  /ORDER=ANALYSIS.

*** Sample check of food group distributions (recommended for data quality review)

FREQUENCIES VARIABLES=FCSStap FCSPulse FCSDairy FCSPr FCSVeg FCSFruit FCSFat FCSSugar
  /FORMAT=NOTABLE
  /STATISTICS=MINIMUM MAXIMUM MEAN.

*** Optional: Compute the same variable to be used directly for IPC analysis (referring to IPC phases)

*RECODE FCS (LOWEST THRU 21 = 3) (21.5 THRU 35 = 2) (35.5 THRU HIGHEST = 1) INTO FCSCat21IPC.
*VARIABLE LABELS FCSCat21IPC "Official IPC Classification for FCS - low thresholds".
*VALUE LABELS FCSCat21IPC 
    1 "Acceptable - IPC Phase 1-2" 
    2 "Borderline - IPC Phase 3" 
    3 "Poor - IPC Phase 4-5".
*EXECUTE.

*** Check distribution of final categories

*FREQUENCIES VARIABLES=FCSCat21IPC
  /ORDER=ANALYSIS.

*** ----------------------------------------------------------------------------------------------------
*** END OF SCRIPT
*** ----------------------------------------------------------------------------------------------------




