*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                         Household Dietary Diversity Score (HDDS)


*** Last Update: Oct 2025
*** Purpose: This script calculates the Household Dietary Diversity Score

***   Data Quality Guidance References:
***   - Recommended coding (can also be used for high frequency checks): Page 17
***   - Recommended cleaning steps: Page 37

*** ----------------------------------------------------------------------------------------------------

*** Define group labels-  these should match Survey Designer naming conventions

label var HDDSStapCer   "Cereals consumption in the previous 24 hours"
label var HDDSStapRoot  "Roots and tubers consumption in the previous 24 hours"
label var HDDSPulse     "Pulses/legume consumption in the previous 24 hours"
label var HDDSDairy     "Milk and dairy product consumption in the previous 24 hours"
label var HDDSPrMeat    "Meat/poultry consumption in the previous 24 hours"
label var HDDSPrEggs    "Eggs consumption in the previous 24 hours"
label var HDDSPrFish    "Fish consumption in the previous 24 hours"
label var HDDSVeg       "Vegetable consumption in the previous 24 hours"
label var HDDSFruit     "Fruit consumption in the previous 24 hours"
label var HDDSFat       "Oil/fat consumption in the previous 24 hours"
label var HDDSSugar     "Sugar/honey consumption in the previous 24 hours"
label var HDDSCond      "Miscellaneous/condiments consumption in the previous 24 hours"

*** Check individual food groups

summarize HDDSStapCer HDDSStapRoot HDDSPulse HDDSDairy HDDSPrMeat HDDSPrFish HDDSPrEggs HDDSVeg HDDSFruit HDDSFat HDDSSugar HDDSCond

**OR

tabstat HDDSStapCer HDDSStapRoot HDDSPulse HDDSDairy HDDSPrMeat HDDSPrFish HDDSPrEggs HDDSVeg HDDSFruit HDDSFat HDDSSugar HDDSCond, stats(mean median min max) columns(statistics)

*** Harmonize Data Quality Guidance measures
*** Clean impossible values 

foreach v of varlist HDDSStapCer HDDSStapRoot HDDSPulse HDDSDairy ///
                     HDDSPrMeat HDDSPrFish HDDSPrEggs HDDSVeg ///
                     HDDSFruit HDDSFat HDDSSugar HDDSCond {

    * Negative values become missing
    replace `v' = . if `v' < 0

    * Values 2 and above become missing
    replace `v' = . if `v' >= 2
}

/********************************************************************
 * Calculate HDDS (Household Dietary Diversity Score)
 * Using + so that missing values do NOT break the sum
 ********************************************************************/

gen HDDS = HDDSStapCer + HDDSStapRoot + HDDSPulse + HDDSDairy + HDDSPrMeat ///
         + HDDSPrFish + HDDSPrEggs + HDDSVeg + HDDSFruit + HDDSFat + HDDSSugar ///
         + HDDSCond

label var HDDS "Household Dietary Diversity Score"

*** Check distribution of final categories
tab1 HDDSStapCer HDDSStapRoot HDDSPulse HDDSDairy HDDSPrMeat ///
     HDDSPrFish HDDSPrEggs HDDSVeg HDDSFruit HDDSFat HDDSSugar HDDSCond
	 
**OR

foreach v in HDDSStapCer HDDSStapRoot HDDSPulse HDDSDairy HDDSPrMeat ///
            HDDSPrFish HDDSPrEggs HDDSVeg HDDSFruit HDDSFat HDDSSugar HDDSCond {
    tabulate `v'
}

*** Harmonize Data Quality Guidance measures
*** Check that HDDS is between 0-12

summarize HDDS

**OR

count if !missing(HDDS) & (HDDS < 0 | HDDS > 12)

* Recode impossible HDDS values:
* Step 1: HDDS < 0  → missing
* Step 2: HDDS > 12 → missing
replace HDDS = . if HDDS < 0
replace HDDS = . if HDDS > 12

*-------------------------------------------------------------*
* Flagging potential Data Quality issues (HDDS vs FCS checks) *
*-------------------------------------------------------------*

* Reusable value label for Yes/No flags
label define yesno 0 "No" 1 "Yes"

* --- HDDS zero ---
generate byte HDDS_flag_zero = 0
replace HDDS_flag_zero = 1 if HDDS == 0
label variable HDDS_flag_zero "HDDS has a zero value, meaning that the HH did not eat anything in the past 24 hours. Flag to team leader"
label values HDDS_flag_zero yesno

* --- HDDS low (<=2) ---
generate byte HDDS_flag_low = 0
replace HDDS_flag_low = 1 if HDDS <= 2
label variable HDDS_flag_low "HDDS has low values. Flag to team leader if acceptable FCS"
label values HDDS_flag_low yesno

* --- HDDS high (>=10) ---
generate byte HDDS_flag_high = 0
replace HDDS_flag_high = 1 if HDDS >= 10
label variable HDDS_flag_high "HDDS has high values. Flag to team leader if poor or borderline FCS"
label values HDDS_flag_high yesno

* --- Cereal consistency (FCS stapled but no HDDS staple) ---
generate byte HDDS_flag_cereal = 0
replace HDDS_flag_cereal = 1 if FCSStap == 7 & HDDSStapCer == 0 & HDDSStapRoot == 0
label variable HDDS_flag_cereal "HH consumed cereal in FCS module but not in HDDS module. Flag issue to team leader"
label values HDDS_flag_cereal yesno

* --- Pulses consistency ---
generate byte HDDS_flag_pulses = 0
replace HDDS_flag_pulses = 1 if FCSPulse == 7 & HDDSPulse == 0
label variable HDDS_flag_pulses "HH consumed pulses in FCS module but not in HDDS module. Flag issue to team leader"
label values HDDS_flag_pulses yesno

* --- Dairy consistency ---
generate byte HDDS_flag_dairy = 0
replace HDDS_flag_dairy = 1 if FCSDairy == 7 & HDDSDairy == 0
label variable HDDS_flag_dairy "HH consumed dairy in FCS module but not in HDDS module. Flag issue to team leader"
label values HDDS_flag_dairy yesno

* --- Protein consistency (meat/eggs/fish all zero in HDDS) ---
generate byte HDDS_flag_protein = 0
replace HDDS_flag_protein = 1 if FCSPr == 7 & HDDSPrMeat == 0 & HDDSPrEggs == 0 & HDDSPrFish == 0
label variable HDDS_flag_protein "HH consumed protein in FCS module but not in HDDS module. Flag issue to team leader"
label values HDDS_flag_protein yesno

* --- Vegetables consistency ---
generate byte HDDS_flag_veg = 0
replace HDDS_flag_veg = 1 if FCSVeg == 7 & HDDSVeg == 0
label variable HDDS_flag_veg "HH consumed vegetables in FCS module but not in HDDS module. Flag issue to team leader"
label values HDDS_flag_veg yesno

* --- Fruit consistency ---
generate byte HDDS_flag_fruit = 0
replace HDDS_flag_fruit = 1 if FCSFruit == 7 & HDDSFruit == 0
label variable HDDS_flag_fruit "HH consumed fruit in FCS module but not in HDDS module. Flag issue to team leader"
label values HDDS_flag_fruit yesno

* --- Fat consistency ---
generate byte HDDS_flag_fat = 0
replace HDDS_flag_fat = 1 if FCSFat == 7 & HDDSFat == 0
label variable HDDS_flag_fat "HH consumed fat in FCS module but not in HDDS module. Flag issue to team leader"
label values HDDS_flag_fat yesno

* --- Sugar consistency ---
generate byte HDDS_flag_sugar = 0
replace HDDS_flag_sugar = 1 if FCSSugar == 7 & HDDSSugar == 0
label variable HDDS_flag_sugar "HH consumed sugar in FCS module but not in HDDS module. Flag issue to team leader"
label values HDDS_flag_sugar yesno

* --- Condiments consistency ---
generate byte HDDS_flag_cond = 0
replace HDDS_flag_cond = 1 if FCSCond == 7 & HDDSCond == 0
label variable HDDS_flag_cond "HH consumed condiments in FCS module but not in HDDS module. Flag issue to team leader"
label values HDDS_flag_cond yesno

*** Check flagged cases
*** If it is found that flags might be data quality issues (i.e. high number of flag_low in very food insecure areas or flag_high in seeminly food secure areas), it is recommended to do a crosstab to see the frequency by enumerator to understand if flags are coming from the same few enumerators. Cases of flag_zero will be impossible in most contexts   

tab1 HDDS_flag_zero HDDS_flag_low HDDS_flag_high HDDS_flag_cereal ///
     HDDS_flag_pulses HDDS_flag_dairy HDDS_flag_protein HDDS_flag_veg ///
     HDDS_flag_fruit HDDS_flag_fat HDDS_flag_sugar, missing
	 
**OR

local flags HDDS_flag_zero HDDS_flag_low HDDS_flag_high HDDS_flag_cereal ///
            HDDS_flag_pulses HDDS_flag_dairy HDDS_flag_protein ///
            HDDS_flag_veg HDDS_flag_fruit HDDS_flag_fat HDDS_flag_sugar

foreach v of local flags {
    di "-----------------------------------------------"
    di "Frequency table for `v'"
    tab `v', missing
}

*---------------------------------------------------------*
* Optional: HDDS categories using the IPC severity scale  *
*---------------------------------------------------------*

* Create the variable
generate HDDSCat_IPC = .

* IPC Category 3: 0–2 food groups (IPC Phase 4–5)
replace HDDSCat_IPC = 3 if HDDS <= 2

* IPC Category 2: 3–4 food groups (IPC Phase 3)
replace HDDSCat_IPC = 2 if HDDS==3 | HDDS==4

* IPC Category 1: 5–12 food groups (IPC Phase 1–2)
replace HDDSCat_IPC = 1 if HDDS >= 5

* Label the variable
label variable HDDSCat_IPC "HDDS categories using the IPC severity scale"

* Value labels
label define HDDSCat_IPC_lbl ///
    1 "5-12 food groups (IPC phase 1 to 2)" ///
    2 "3-4 food groups (IPC phase 3)" ///
    3 "0-2 food groups (IPC phase 4 to 5)"
label values HDDSCat_IPC HDDSCat_IPC_lbl

*** Check distribution of final categories
tab HDDSCat_IPC, missing

*** ----------------------------------------------------------------------------------------------------
*** END OF SCRIPT
*** ----------------------------------------------------------------------------------------------------