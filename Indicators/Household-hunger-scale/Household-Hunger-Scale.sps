* Encoding: UTF-8.
*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                                      Household Hunger Scale (HHS)


*** Last Update: Nov 2025
*** Purpose: This script calculates the Household Hunger Scale

***   Data Quality Guidance References:
***   - Recommended high frequency checks: Page 31
***   - Recommended cleaning steps: Page 37

*** ----------------------------------------------------------------------------------------------------

*** Define group labels -  these should match Survey Designer naming conventions

VARIABLE LABELS  
HHSNoFood            "In the past 30 days, was there ever no food to eat of any kind in your house because of lack of resources to get food?"
HHSNoFood_FR     "How often did this happen in the past 30 days?"
HHSBedHung          "In the past 30 days, did you or any household member go to sleep at night hungry because there was not enough food?"
HHSBedHung_FR   "How often did this happen in the past 30 days?"
HHSNotEat	             "In the past 30 days, did you or any household member go a whole day and night without eating anything because there was not enough food?"
HHSNotEat_FR        "How often did this happen in the past 30 days?". 

*** Define labels

VALUE LABELS HHSNoFood HHSBedHung HHSNotEat 
   0 "No"
   1 "Yes". 

VALUE LABELS HHSNoFood_FR HHSBedHung_FR HHSNotEat_FR 
   1 "Rarely (1-2 times)"
   2 "Sometimes (3-10 times)" 
   3 "Often (more than 10 times)".	 

*** Harmonize Data Quality Guidance measures
*** Check that values for main indocator are between 0-1

FREQUENCIES VARIABLES = HHSNoFood HHSBedHung HHSNotEat
  /STATISTICS=MINIMUM MAXIMUM
  /ORDER=ANALYSIS.

*** Clean values falling outside of range

RECODE HHSNoFood HHSBedHung HHSNotEat (LOWEST THRU -1 = SYSMIS).
RECODE HHSNoFood HHSBedHung HHSNotEat (2 THRU HIGHEST = SYSMIS).
EXECUTE. 

*** Check that values for follow up questions are between 1-3
    
FREQUENCIES VARIABLES = HHSNoFood_FR HHSBedHung_FR HHSNotEat_FR
  /STATISTICS=MINIMUM MAXIMUM
  /ORDER=ANALYSIS.

*** Clean values falling outside of range

RECODE HHSNoFood_FR HHSBedHung_FR HHSNotEat_FR (LOWEST THRU -1 = SYSMIS).
RECODE HHSNoFood_FR HHSBedHung_FR HHSNotEat_FR (4 THRU HIGHEST = SYSMIS).
EXECUTE. 

*** Create a new variable for each question reflecting the requency-of-occurrence

RECODE HHSNoFood_FR HHSBedHung_FR HHSNotEat_FR (1=1) (2=1) (3=2) (ELSE=0) INTO HHSQ1 HHSQ2 HHSQ3. 
VARIABLE LABELS
HHSQ1                    "Was there ever no food to eat in HH?"  
HHSQ2                    "Did any HH member go sleep hungry?"  
HHSQ3                    "Did any HH member go whole day without food?". 
EXECUTE. 

*** Use the three values to calculate the final HHS score (always use + instead of SUM to ensure missing values are not considered)

COMPUTE HHS = HHSQ1 + HHSQ2 + HHSQ3. 
VARIABLE LABELS HHS 'Household Hunger Score'. 
EXECUTE. 

*** According to Data Quality Guidance, flag any household reflecting potential Famine conditions.
*** If any household is flagged, the recommended action is to triangulate against other key food security indicators
*** Refer to page 31 in the Data Quality Guidance if you are in the data collection phase, or page 37 if you are in the data cleaning phase

COMPUTE HHS_flag = 0.
IF (HHS GE 5) HHS_flag =  1.
VARIABLE LABELS HHS_flag "HHS shows potential famine conditions that could be a Data Quality issue if the context does not indicate extreme food insecurity. Triangulation is recommended".
VALUE LABELS HHS_flag
    0 "No"
    1 "Yes".
EXECUTE.

FREQUENCIES VARIABLES = HHS_flag.

*** To be used for regular reporting
*** Based on the HHS score, divide the households into three categories

RECODE HHS (0 THRU 1 = 1) (2 THRU 3 = 2) (4 THRU 6 = 3) INTO HHSCat. 
VARIABLE LABELS HHSCat "Household Hunger Scale categories - for reporting". 
VALUE LABELS HHSCat
   1 "Little to no hunger in the household"
   2 "Moderate hunger in the household"
   3 "Severe hunger in the household". 
EXECUTE.

*** Check distribution of final categories

FREQUENCIES VARIABLES=HHS 
  /STATISTICS=MEAN MEDIAN MINIMUM MAXIMUM 
  /ORDER=ANALYSIS. 

FREQUENCIES HHSCat.

*** Optional: Compute the same variable to be used directly for IPC analysis (referring to IPC phases)

*RECODE HHS (0 = 1) (1 = 2) (2 THRU 3 = 3) (4 = 4) (5 THRU 6 = 5) INTO HHSCat_IPC. 
*VARIABLE LABELS HHSCat_IPC 'Household Hunger Scale categories - for IPC'. 
*VALUE LABELS HHSCat_IPC
    1 "HHS [0] - IPC Phase 1: No hunger in the household"
    2 "HHS [1] - IPC Phase 2: Slight hunger in the household" 
    3 "HHS [2-3] - IPC Phase 3: Moderate hunger in the household"
    4 "HHS [4] - IPC Phase 4: Severe hunger in the household" 
    5 "HHS [5-6] - IPC Phase 5: Severe hunger in the household".
*EXECUTE.

*FREQUENCIES HHSCat_IPC. 

*** ----------------------------------------------------------------------------------------------------
*** END OF SCRIPT
*** ----------------------------------------------------------------------------------------------------
