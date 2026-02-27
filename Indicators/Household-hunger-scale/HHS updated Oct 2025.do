*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                         Household Hunger Scale (HHS)


*** Last Update: Oct 2025
*** Purpose: This script calculates the Household Hunger Scale

***   Data Quality Guidance References:
***   - Recommended high frequency checks: Page 31
***   - Recommended cleaning steps: Page 37

*** ----------------------------------------------------------------------------------------------------

*** Define group labels -  these should match Survey Designer naming conventions
label var HHSNoFood      "In the past 30 days, was there ever no food to eat of any kind in your house because of lack of resources to get food?"
label var HHSNoFood_FR   "How often did this happen in the past 30 days?"

label var HHSBedHung     "In the past 30 days, did you or any household member go to sleep at night hungry because there was not enough food?"
label var HHSBedHung_FR  "How often did this happen in the past 30 days?"

label var HHSNotEat      "In the past 30 days, did you or any household member go a whole day and night without eating anything because there was not enough food?"
label var HHSNotEat_FR   "How often did this happen in the past 30 days?"

*** Define labels
label define yesno 0 "No" 1 "Yes"

label values HHSNoFood HHSBedHung HHSNotEat yesno

label define freq 1 "Rarely (1-2 times)" 2 "Sometimes (3-10 times)" 3 "Often (more than 10 times)"

label values HHSNoFood_FR HHSBedHung_FR HHSNotEat_FR freq

*** Harmonize Data Quality Guidance measures
*** Check that values for main indicator are between 0–1

summarize HHSNoFood HHSBedHung HHSNotEat, detail

tab1 HHSNoFood HHSBedHung HHSNotEat, missing
tab1 HHSNoFood HHSBedHung HHSNotEat /**Without including missing values**/

*** Clean values falling outside of range (0–1)

replace HHSNoFood   = . if HHSNoFood   < 0 | HHSNoFood   > 1
replace HHSBedHung  = . if HHSBedHung  < 0 | HHSBedHung  > 1
replace HHSNotEat   = . if HHSNotEat   < 0 | HHSNotEat   > 1

*** Check that values for follow‑up questions are between 1–3

summarize HHSNoFood_FR HHSBedHung_FR HHSNotEat_FR, detail

tab1 HHSNoFood_FR HHSBedHung_FR HHSNotEat_FR, missing
tab1 HHSNoFood_FR HHSBedHung_FR HHSNotEat_FR /**Without including missing values**/

*** Clean values falling outside of range (1–3)

replace HHSNoFood_FR   = . if HHSNoFood_FR   < 1 | HHSNoFood_FR   > 3
replace HHSBedHung_FR  = . if HHSBedHung_FR  < 1 | HHSBedHung_FR  > 3
replace HHSNotEat_FR   = . if HHSNotEat_FR   < 1 | HHSNotEat_FR   > 3

*** Create new variables for frequency-of-occurrence

recode HHSNoFood_FR   (1 2 = 1) (3 = 2) (else = 0), gen(HHSQ1)
recode HHSBedHung_FR  (1 2 = 1) (3 = 2) (else = 0), gen(HHSQ2)
recode HHSNotEat_FR   (1 2 = 1) (3 = 2) (else = 0), gen(HHSQ3)

label var HHSQ1 "Was there ever no food to eat in HH?"
label var HHSQ2 "Did any HH member go sleep hungry?"
label var HHSQ3 "Did any HH member go whole day without food?"

*** Calculate final HHS score
*** (+ automatically yields missing if any component is missing)

gen HHS = HHSQ1 + HHSQ2 + HHSQ3

label var HHS "Household Hunger Score"

*** According to Data Quality Guidance, flag any household reflecting potential Famine conditions.
*** If any household is flagged, the recommended action is to triangulate against other key food security indicators
*** Refer to page 31 in the Data Quality Guidance if you are in the data collection phase, or page 37 if you are in the data cleaning phase

gen HHS_flag = 0

replace HHS_flag = 1 if HHS >= 5

label var HHS_flag ///
"HHS shows potential famine conditions that could be a Data Quality issue if the context does not indicate extreme food insecurity. Triangulation is recommended"

label define HHS_flag_lbl 0 "No" 1 "Yes"
label values HHS_flag HHS_flag_lbl

tab HHS_flag, missing

*** To be used for regular reporting
*** Based on the HHS score, divide the households into three categories

recode HHS (0/1 = 1) (2/3 = 2) (4/6 = 3), gen(HHSCat)

label var HHSCat "Household Hunger Scale categories - for reporting"

label define HHSCat_lbl ///
    1 "Little to no hunger in the household" ///
    2 "Moderate hunger in the household" ///
    3 "Severe hunger in the household"

label values HHSCat HHSCat_lbl

*** Check distribution of final categories

summarize HHS, detail

tab HHSCat, missing

*** Optional: Compute the same variable to be used directly for IPC analysis (referring to IPC phases)

recode HHS (0 = 1) (1 = 2) (2/3 = 3) (4 = 4) (5/6 = 5), gen(HHSCat_IPC)

label var HHSCat_IPC "Household Hunger Scale categories - for IPC"

label define HHSCat_IPC_lbl ///
    1 "HHS [0] - IPC Phase 1: No hunger in the household" ///
    2 "HHS [1] - IPC Phase 2: Slight hunger in the household" ///
    3 "HHS [2-3] - IPC Phase 3: Moderate hunger in the household" ///
    4 "HHS [4] - IPC Phase 4: Severe hunger in the household" ///
    5 "HHS [5-6] - IPC Phase 5: Severe hunger in the household"

label values HHSCat_IPC HHSCat_IPC_lbl


tab HHSCat_IPC, missing

*** ----------------------------------------------------------------------------------------------------
*** END OF SCRIPT
*** ----------------------------------------------------------------------------------------------------