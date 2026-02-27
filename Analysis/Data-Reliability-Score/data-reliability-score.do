
*----------------------------------------------------------------------
* Data Reliability Score (DRS) Calculation
* Author: Alirah Weyori
* Purpose: Compute DRS using standardized quality flags
* Date: 10/06/2025
*----------------------------------------------------------------------
* STEP 0: Load your dataset
*----------------------------------------------------------------------

use "BF_Full_Household_Analysis", clear


*----------------------------------------------------------------------
* STEP 1: Filter interviews with duration < 10 min (optional threshold)
*----------------------------------------------------------------------

* Step 1: Clean both timestamps
gen clean_timestamp = subinstr(start, "T", " ", .)
replace clean_timestamp = subinstr(clean_timestamp, "Z", "", .)

gen double full_datetime = clock(clean_timestamp, "YMDhms")
gen double start_time = full_datetime - dofc(full_datetime)*24*60*60*1000
format start_time %tcHH:MM:SS

local ten_pm = clock("22:00", "hm")
local six_am = clock("06:00", "hm")

gen byte time_late  = start_time > `ten_pm'
gen byte time_early = start_time < `six_am'

*clean and convert the end timestamp
gen clean_end_time = subinstr(end, "T", " ", .)
replace clean_end_time = subinstr(clean_end_time, "Z", "", .)
gen double dt_end = clock(clean_end_time, "YMDhms")
gen double end_time = full_datetime - dofc(dt_end)*24*60*60*1000

gen double duration_minutes = (dt_end - full_datetime)/60000

gen short_duration = duration_minutes < 10
drop if short_duration == 1

*-----------------------------------------------------
*STEP 2: Data Preparation at the Household level
*-----------------------------------------------------
*	PAage = Age of the individual in the household
*	HHID = Unique Household ID

gen is_child = RESPAge < 20 & !missing(RESPAge)
bysort HHID (is_child): gen tag = _n == 1
bysort HHID: tab tag
rename tag hh_mem_child
destring rCSI, replace
destring FCS, replace

*collapse (max) has_child=is_child, by(HHID)

*------------------------------------------------------------
* STEP 3: FCS indicator checks (weight: 0.20)
*------------------------------------------------------------
gen fcs_high_outlier = FCS > 100
gen fcs_low_outlier  = FCS < 14
gen fcs_zero         = FCS == 0
gen fcs_cereal_low   = FCSStap < 4
gen fcs_meat_high    = FCSPr > 5
gen fcsn_check1 = (FCSNPrMeatF < FCSPr) | (FCSNPrMeatO < FCSPr) | ///
                  (FCSNPrFish  < FCSPr) | (FCSNPrEggs  < FCSPr)
gen fcsn_check2 = (FCSNPrMeatF > FCSPr) | (FCSNPrMeatO > FCSPr) | ///
                  (FCSNPrFish  > FCSPr) | (FCSNPrEggs  > FCSPr)

 ****************************************************
* 3.1: FCS Flattlining Check (flatliner if same value ≥3 times)
****************************************************

foreach var in FCS* {
    destring `var', replace force
}


forvalues i = 0/10 {
    gen byte fcs_eq_`i' = ///
        (FCSStap==`i') + (FCSPulse==`i') + (FCSDairy==`i') + ///
        (FCSPr==`i') + (FCSVeg==`i') + (FCSFruit==`i') + ///
        (FCSFat==`i') + (FCSCond==`i')
}

egen fcs_repeat_count = rowmax(fcs_eq_0 fcs_eq_1 fcs_eq_2 fcs_eq_3 fcs_eq_4 ///
                               fcs_eq_5 fcs_eq_6 fcs_eq_7 fcs_eq_8 fcs_eq_9 fcs_eq_10)

gen flat_fcs = (fcs_repeat_count >= 3)
drop fcs_eq_*


egen fcs_error = rowtotal(fcs_high_outlier fcs_low_outlier fcs_zero fcs_cereal_low fcs_meat_high flat_fcs fcsn_check1 fcsn_check2)
replace fcs_error = fcs_error/8 * 0.20


*--------------------------------------------------------------------------------------
* STEP 4: LCS indicator checks (weight: 0.10)
*--------------------------------------------------------------------------------------
* 4.1: LCS inconsistent Response (Child strategies if household does not have a child)
*--------------------------------------------------------------------------------------

gen lcs_logic_error = (Lcs_crisis_ChildWork > 0 & hh_mem_child !=1)


*--------------------------------------------------------------------------------------
* 4.2.1: LCS_stress Strategies (flatliner if same value ≥3 times)
*--------------------------------------------------------------------------------------
foreach var in Lcs_stress_DomAsset Lcs_stress_HealthEdu Lcs_stress_Saving ///
              Lcs_stress_BorrowCash {
    destring `var', replace force
}

foreach i in 10 20 30 9999 {
    gen byte lcs_stress_eq_`i' = ///
        (Lcs_stress_DomAsset==`i') + ///
        (Lcs_stress_HealthEdu==`i') + ///
        (Lcs_stress_Saving==`i') + ///
        (Lcs_stress_BorrowCash==`i')
        }
		
egen lcs_stress_repeat = rowmax(lcs_stress_eq_10 lcs_stress_eq_20 lcs_stress_eq_30 lcs_stress_eq_9999)
gen flat_lcs_stress = (lcs_stress_repeat >= 3)
drop lcs_stress_eq_*


*-------------------------------------------------------------------------------------------------------
* Unsual number of N/A in the response - Detect if "9999" is answered in ≥2 of 4 LCS_stress variables
*-------------------------------------------------------------------------------------------------------
gen lcs_stress_na_count = ///													// Count number of Not Applicable per household across each indicator
    (Lcs_stress_DomAsset == 9999) + ///
    (Lcs_stress_HealthEdu == 9999) + ///
    (Lcs_stress_Saving == 9999) + ///
    (Lcs_stress_BorrowCash == 9999)

gen lcs_stress_na = (lcs_stress_na_count >= 2) 									// Flag as error if 2 or more responses are "9999"

list HHID Lcs_stress_DomAsset Lcs_stress_HealthEdu ///
     Lcs_stress_Saving Lcs_stress_BorrowCash if lcs_stress_na == 1  			//List flagged cases
	 
*----------------------------------------------------------------
* 4.2.2: LCS_crisis Crisis (flatliner if same value ≥2 times)
*----------------------------------------------------------------

foreach var in Lcs_crisis_ProdAssets Lcs_crisis_DomMigration ///
              Lcs_crisis_ChildWork {
    destring `var', replace force
}

forvalues i = 10/9999 {
    gen byte lcs_crisis_eq_`i' = ///
        (Lcs_crisis_ProdAssets==`i') + ///
        (Lcs_crisis_DomMigration==`i') + ///
        (Lcs_crisis_ChildWork==`i')
}
egen lcs_crisis_repeat = rowmax(lcs_crisis_eq_*)
gen flat_lcs_crisis = (lcs_crisis_repeat >= 2)
drop lcs_crisis_eq_*

*-------------------------------------------------------------------------------------------------------
* Pattern of N/A in the response - Detect if "9999" is answered in ≥2 of 4 LCS_crisis variables
*-------------------------------------------------------------------------------------------------------

gen lcs_crisis_na_count = ///													// Count number of Not Applicable per household across each indicator
    (Lcs_crisis_ProdAssets == 9999) + ///
    (Lcs_crisis_DomMigration == 9999) + ///
    (Lcs_crisis_ChildWork == 9999) 

gen lcs_crisis_na = (lcs_crisis_na_count >= 2) 									// Flag as error if 2 or more responses are "9999"


*---------------------------------------------------
* Group 4.2.3: LCS_em Strategies
*---------------------------------------------------
foreach var in Lcs_em_ResAsset Lcs_em_Begged ///
              Lcs_em_FemAnimal {
    destring `var', replace force
}

forvalues i = 10/9999 {
    gen byte lcs_em_eq_`i' = ///
        (Lcs_em_ResAsset==`i') + ///
        (Lcs_em_Begged==`i') + ///
        (Lcs_em_FemAnimal==`i')
}
egen lcs_em_repeat = rowmax(lcs_em_eq_*)
gen flat_lcs_em = (lcs_em_repeat >= 2)
drop lcs_em_eq_*

*-------------------------------------------------------------------------------------------------------
* Pattern of N/A in the response - Detect if "9999" is answered in ≥2 of 2 LCS_emergency variables
*-------------------------------------------------------------------------------------------------------

gen lcs_em_na_count = ///						// Count number of Not Applicable per household across each indicator
    (Lcs_em_ResAsset == 9999) + ///
    (Lcs_em_Begged == 9999) + ///
    (Lcs_em_FemAnimal == 9999) 

gen lcs_em_na = (lcs_em_na_count >= 2) 			// Flag as error if 2 or more responses are "9999"

egen lcs_error = rowtotal(lcs_em_na flat_lcs_em lcs_crisis_na flat_lcs_crisis ///
	flat_lcs_stress lcs_stress_na lcs_logic_error)
                               
replace lcs_error = lcs_error/3 * 0.1

*---------------------------------------------
* STEP 4.3: rCSI indicator checks (weight: 0.10)
*----------------------------------------------

gen rcsi_too_high = rCSI > 42

*------------------------------------------------------
* Group: rCSI (flatliner if same value ≥2 times)
*------------------------------------------------------
forvalues i = 0/7 {
    gen byte rcsi_eq_`i' = ///
        (rCSILessQlty==`i') + ///
        (rCSIBorrow==`i') + ///
        (rCSIMealSize==`i') + ///
		(rCSIMealNb==`i')
}
egen rcsi_repeat = rowmax(rcsi_eq_*)
gen flat_rcsi = (rcsi_repeat >= 2)
drop rcsi_eq_*

gen rcsi_logic_err = (rCSIMealAdult > 0 & hh_mem_child !=1)
gen rcsi_logic_err2 = (rCSI==0 & FCSG >=2)

egen rcsi_error = rowtotal(rcsi_too_high rcsi_logic_err rcsi_logic_err2 flat_rcsi)
replace rcsi_error = rcsi_error/4*0.10

*----------------------------------------------
* STEP 5: Expenditure indicator (weight: 0.25)
*----------------------------------------------
sort ADMIN5Name
bysort ADMIN5Name: egen exp_mean_admin5 = mean(HHExpTotal)
bysort ADMIN5Name: egen exp_sd_admin5 = sd(HHExpTotal)
gen exp_food_zero = HHExpFoodTotal_1M == 0
gen exp_nonfood_zero = HHExpNFTotal_1M == 0
bysort ADMIN5Name: gen exp_high_outlier = abs((HHExpTotal - exp_mean_admin5) / exp_sd_admin5) > 3
bysort ADMIN5Name: gen exp_low_outlier = abs((HHExpTotal - exp_mean_admin5) / exp_sd_admin5) < -3

egen exp_error = rowtotal(exp_food_zero exp_nonfood_zero exp_high_outlier exp_low_outlier)
replace exp_error = exp_error/4*0.25

*---------------------------------------------
* STEP 6: HHS indicator (weight: 0.05)
*---------------------------------------------

* Define the HHS variables and their scoring rules
local vars HHSNoFood_FR_S HHSBedHung_FR_S HHSNotEat_FR_S
local scores HHSQ1 HHSQ2 HHSQ3
forvalues i = 1/3 {
    local var : word `i' of `vars'
    local score : word `i' of `scores'

    gen `score' = .
    replace `score' = 0 if `var' == 0
    replace `score' = 1 if inlist(`var', 1, 2)
    replace `score' = 2 if `var' == 3
}

gen HHS = HHSQ1 + HHSQ2 + HHSQ3													// Generate total HHS score


gen HHSCat = .																	// Generate severity classification
replace HHSCat = 0 if HHS <= 1
replace HHSCat = 1 if inrange(HHS, 2, 3)
replace HHSCat = 2 if HHS >= 4
label define HHSCat 0 "Little or no hunger in the household" 1 "Moderate hunger in the household" 2 "Severe hunger in the household"
label values HHSCat HHSCat

gen hhs_logic_error = (HHS >= 5 & FCSG <= 2)
replace hhs_logic_error = hhs_logic_error/1*0.05

*---------------------------------------------
* STEP 7: FEWS NET Matrix (weight: 0.20)
*---------------------------------------------
gen fews1 = ((HHS == 2 | HHS == 3) & FCSG <= 2 & rCSI < 4)
gen fews2 = (HHS == 4 & FCSG <= 2 & rCSI < 4)
gen fews3 = (HHS >= 5 & FCSG <= 2 & rCSI < 4)

egen fews_error = rowtotal(fews1 fews2 fews3)
replace fews_error = fews_error/3*0.20


*-------------------------------------------------------------------------------
* STEP 8: Time of Interview -LateNight or EarlyMorning (weight: 0.05)
*-------------------------------------------------------------------------------


egen time_error = rowtotal(time_late time_early)
replace time_error = time_error/2*0.10


*-------------------------------------------------------------------------------
* STEP 9: General Information Checks (weight: 0.05)
*-------------------------------------------------------------------------------

local vars HHSize HHRoomUsed
foreach var of local vars {

    * Create mean and SD variables by ADMIN5Name
    egen mean_`var'_admin5 = mean(`var'), by(ADMIN5Name)
    egen sd_`var'_admin5 = sd(`var'), by(ADMIN5Name)

    * Generate the outlier flag using z-score > 3
    gen `var'_error = abs((`var' - mean_`var'_admin5) / sd_`var'_admin5) > 3
}

egen geninfo_error = rowtotal(HHSize_error HHRoomUsed_error)
replace geninfo_error = geninfo_error/2*0.05


*-------------------------------------------------------------------------------
* STEP 11: Compute Weighted DRS (scaled so higher = more reliable)
*-------------------------------------------------------------------------------
gen drs = 100 * (1 - (fcs_error + lcs_error + rcsi_error + ///
   exp_error + hhs_logic_error + fews_error + time_error + ///
    geninfo_error ))

	
*-------------------------------------------------------------------------------
* STEP 12: Categorize Reliability
*-------------------------------------------------------------------------------
gen drs_category = .
replace drs_category = 1 if drs >= 80 // Excellent
replace drs_category = 2 if drs < 80 & drs >= 70 // Good
replace drs_category = 3 if drs < 70 & drs >= 50 // Moderate
replace drs_category = 4 if drs < 50 // Poor

label define drs_cat_lbl 1 "Excellent" 2 "Good" 3 "Moderate" 4 "Poor"
label values drs_category drs_cat_lbl

sum drs
tab drs_category
histogram drs_category

*-------------------------------------------------------------------------------
save "Test_output_with_drs.dta", replace
*-------------------------------------------------------------------------------


