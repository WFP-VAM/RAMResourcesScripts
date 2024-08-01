*------------------------------------------------------------------------------
*                          WFP Standardized Scripts
*            Multidimensional Deprivation Index (MDDI) Calculation
*------------------------------------------------------------------------------

* Construction of the Multidimensional Deprivation Index (MDDI) is based on the 
* codebook questions prepared for the MDDI module available at:
* https://docs.wfp.org/api/documents/WFP-0000134356/download/

*------------------------------------------------------------------------------
* 1. Creation of variables of deprivations for each dimension
*------------------------------------------------------------------------------

*** FOOD DIMENSION ***

    ** Food Consumption Score **

* Define labels (skip if already done)
lab var FCSStap        "Consumption over the past 7 days (cereals and tubers)"
lab var FCSVeg         "Consumption over the past 7 days (vegetables)"
lab var FCSFruit       "Consumption over the past 7 days (fruit)"
lab var FCSPr          "Consumption over the past 7 days (protein-rich foods)"
lab var FCSPulse       "Consumption over the past 7 days (pulses)"
lab var FCSDairy       "Consumption over the past 7 days (dairy products)"
lab var FCSFat         "Consumption over the past 7 days (oil)"
lab var FCSSugar       "Consumption over the past 7 days (sugar)"

* Calculate FCS (skip if already done)
gen     FCS          = (FCSStap * 2) + FCSVeg + FCSFruit + (FCSPr * 4) + (FCSPulse * 3) + (FCSDairy * 4) + (FCSFat * 0.5) + (FCSSugar * 0.5)
lab var FCS           "Food Consumption Score"

* Categorize FCS (skip if already done)
    * Use this when analyzing a country with high consumption of sugar and oil – thresholds 28-42
recode  FCS           (0/28 = 1 "poor") (28.5/42 = 2 "borderline") (42.5/max = 3 "acceptable"), gen(FCSCat28)
lab var FCSCat28      "FCS Categories"
sum     FCSCat28

    * Use this when analyzing a country with low consumption of sugar and oil - thresholds 21-35
recode  FCS           (0/21 = 1 "poor") (21.5/35 = 2 "borderline") (35.5/max = 3 "acceptable"), gen(FCSCat21)
lab var FCSCat21      "FCS Categories"
sum     FCSCat21

* Turn into MDDI variable (with high consumption of sugar and oil countries)
    * Note: Use FCSCat21 for low consumption of sugar and oil countries
gen     MDDI_food1    = (FCSCat28 == 1 | FCSCat28 == 2) if FCSCat28 != .
lab var MDDI_food1    "HH with unacceptable food consumption"
tab     MDDI_food1

    ** rCSI (Reduced Consumption Strategies Index) **

* Define labels (skip if already done)
lab var rCSILessQlty  "Relied on less preferred, less expensive food"
lab var rCSIBorrow    "Borrowed food or relied on help from friends or relatives"
lab var rCSIMealNb    "Reduced the number of meals eaten per day"
lab var rCSIMealSize  "Reduced portion size of meals at meals time"
lab var rCSIMealAdult "Restrict consumption by adults in order for young-children to eat"

* Compute rCSI (skip if already done)
gen     rCSI          = (rCSILessQlty * 1) + (rCSIBorrow * 2) + (rCSIMealNb * 1) + (rCSIMealSize * 1) + (rCSIMealAdult * 3)
lab var rCSI          "Reduced Consumption Strategies Index"

* Turn into MDDI variable 
    * For the rCSI, use the threshold as 18 - this is defined as IPC3+
gen     MDDI_food2    = rCSI > 18 if rCSI != .
lab var MDDI_food2    "HH with high level of consumption coping strategies"
tab     MDDI_food2

*** EDUCATION DIMENSION ***

* At least one school age children (6-17) (adjust to country context) not attending school in the last 6 months
gen     MDDI_edu1     = HHNoSchool == 1
lab var MDDI_edu1     "HH with at least one school-age children not attending school"
tab     MDDI_edu1

*** HEALTH DIMENSION ***

* Medical treatment - Did household members being chronically or acutely ill receive medical attention while sick?
* (answers - 0="No", 1="Yes, some of them", 2="Yes, all of them")
gen     MDDI_health1  = (HHENHealthMed == 0 | HHENHealthMed == 1) if HHENHealthMed != .
lab var MDDI_health1  "HH with at least one member did not receive medical treatment while sick"
tab     MDDI_health1

* Number of sick or disabled people > 1 or >50% of household members
egen    HHSickNb      = rowtotal(HHDisabledNb HHChronIllNb)
replace HHSickNb      = . if HHDisabledNb == . & HHChronIllNb == .
gen     HHSickShare   = HHSickNb / HHSizeCalc
gen     MDDI_health2  = (HHSickNb > 1 | HHSickShare > 0.5) 
replace MDDI_health2  = . if HHSickNb == . & HHSickShare == .
lab var MDDI_health2  "HH with more than half members or more than one member sick"
tab     MDDI_health2

*** SHELTER DIMENSION ***

* Source of energy for cooking - HH uses solid fuels for cooking
gen     MDDI_shelter1 = (HEnerCookSRC == 0 | HEnerCookSRC == 100 | HEnerCookSRC == 200 | HEnerCookSRC == 500 | HEnerCookSRC == 600 | HEnerCookSRC == 900 | HEnerCookSRC == 999)  
replace MDDI_shelter1 = . if HEnerCookSRC == .
lab var MDDI_shelter1 "HH with no improved energy source for cooking"
tab     MDDI_shelter1

* Source of energy for lighting - HH has no electricity
gen     MDDI_shelter2 = HEnerLightSRC != 401 & HEnerLightSRC != 402  
replace MDDI_shelter2 = . if HEnerLightSRC == .
lab var MDDI_shelter2 "HH with not improved source of energy for lighting"
tab     MDDI_shelter2

* Crowding Index - (Number of HH members/Number of rooms (excluding kitchen, corridors)) > 3 
gen     crowding      = HHSizeCalc / HHRoomUsed
gen     MDDI_shelter3 = crowding > 3 
replace MDDI_shelter3 = . if crowding == .
lab var MDDI_shelter3 "HH with at least 3 HH members sharing one room to sleep"
tab     MDDI_shelter3

*** WASH DIMENSION ***

* Toilet Type (not-improved facility)
gen     MDDI_wash1    = (HToiletType == 20100 | HToiletType == 20200 | HToiletType == 20300 | HToiletType == 20400 | HToiletType == 20500)
replace MDDI_wash1    = . if HToiletType == .
lab var MDDI_wash1    "HH with not improved toilet facility"
tab     MDDI_wash1

* Water source (not-improved source)
gen     MDDI_wash2    = (HWaterSRC == 500 | HWaterSRC == 600 | HWaterSRC == 700 | HWaterSRC == 800)
replace MDDI_wash2    = . if HWaterSRC == .
lab var MDDI_wash2    "HH with not improved drinking water source"
tab     MDDI_wash2

*** SAFETY DIMENSION ***

* Safety: HH felt unsafe or suffered violence
gen     MDDI_safety1  = HHPercSafe == 0  | HHShInsec1Y == 1
replace MDDI_safety1  = . if HHPercSafe == . & HHShInsec1Y == .
lab var MDDI_safety1  "HH with one or more members who felt unsafe or suffered violence"
tab     MDDI_safety1

* Displaced by force in the last 12 months
* Example of calculating months since arrival (adjust if you already have a variable for the date of data collection and use it instead of `interview_date' variable)

* Step 1. Create fictitious day of data collection
gen     interview_date = date("11/25/21", "MD20Y")

* Step 2. Show current date in date format (check if HHHDisplArrive is not already in %td)
format  interview_date HHHDisplArrive %td 

* Step 3. Compute the difference
gen     Arrival_time  = datediff(interview_date, HHHDisplArrive, "month")

* Step 4. Turn into MDDI variable
gen     MDDI_safety2  = Arrival_time < 13 & HHDisplChoice == 0
replace MDDI_safety2  = 0 if HHDispl == 0
replace MDDI_safety2  = . if (Arrival_time == . | HHDisplChoice == .) & (HHDispl == 1 | HHDispl == .)
lab var MDDI_safety2  "HH displaced by force in the last 12 months"
tab     MDDI_safety2

*------------------------------------------------------------------------------
* 2. Calculate deprivation score of each dimension
*------------------------------------------------------------------------------

* Weighting: Method of nesting with equal weights
* Note: by default if any indicator is missing for a case, its deprivation score for the dimension of that indicator will be missing. 
* Consequently, also MDDI measures will be missing. Be careful with indicators that are missing for many observations (e.g. >10% of the sample).

gen     MDDI_food     = (MDDI_food1 * 1 / 2) + (MDDI_food2 * 1 / 2)
gen     MDDI_edu      = MDDI_edu1 * 1
gen     MDDI_health   = (MDDI_health1 * 1 / 2) + (MDDI_health2 * 1 / 2)
gen     MDDI_shelter  = (MDDI_shelter1 * 1 / 3) + (MDDI_shelter2 * 1 / 3) + (MDDI_shelter3 * 1 / 3)
gen     MDDI_wash     = (MDDI_wash1 * 1 / 2) + (MDDI_wash2 * 1 / 2)
gen     MDDI_safety   = (MDDI_safety1 * 1 / 2) + (MDDI_safety2 * 1 / 2)

* Label Variables
lab var MDDI_food     "Deprivation score for food dimension"
lab var MDDI_edu      "Deprivation score for education dimension"
lab var MDDI_health   "Deprivation score for health dimension"
lab var MDDI_shelter  "Deprivation score for shelter dimension"
lab var MDDI_wash     "Deprivation score for WASH dimension"
lab var MDDI_safety   "Deprivation score for safety and displacement dimension"

tabstat MDDI_food MDDI_edu MDDI_health MDDI_shelter MDDI_wash MDDI_safety, stat(mean sd min max)

*------------------------------------------------------------------------------
* 3. Calculate MDDI-related measures
*------------------------------------------------------------------------------

* Calculate the overall MDDI Score
gen     MDDI          = (MDDI_food + MDDI_edu + MDDI_health + MDDI_shelter + MDDI_wash + MDDI_safety) / 6
lab var MDDI          "MDDI score"

* Calculate MDDI Incidence (H)
    * Thresholds are 0.50 for severe deprivation and 0.33 for deprivation – it can be adjusted according to the context
gen     MDDI_poor_severe = MDDI >= 0.50
lab var MDDI_poor_severe "MDDI Incidence – severe deprivation"

gen     MDDI_poor    = MDDI >= 0.33
lab var MDDI_poor    "MDDI Incidence"

lab def MDDI_label   0 "HH is not deprived" 1 "HH is deprived"
lab val MDDI_poor_severe MDDI_label
lab val MDDI_poor    MDDI_label

* Calculate the Average MDDI Intensity (A)
gen     MDDI_intensity = MDDI if MDDI_poor == 1 // the variable is missing for non MDDI-poor households
lab var MDDI_intensity "Average MDDI Intensity (A)"

* Calculate Combined MDDI (M = H x A)
gen     MDDI_combined = MDDI_poor * MDDI_intensity if MDDI_poor == 1
replace MDDI_combined = 0 if MDDI_poor == 0 // for household non MDDI poor, combined MDDI is zero
lab var MDDI_combined "Combined MDDI (M)" 

* Show results 
tabstat MDDI_poor MDDI_poor_severe MDDI_intensity MDDI_combined, stat(mean)

* End of Scripts