*------------------------------------------------------------------------------*
*	                          WFP Standardized Scripts
*                    Calculating Asset-Based Indicator (ABI) 25
*------------------------------------------------------------------------------*

* This script calculates the Asset-Based Indicator (ABI) based on various 
* asset-related questions. It recodes the responses, sums the scores, and 
* calculates the percentage ABI for each respondent.

* Label ABI relevant variables
label var HHFFAPart          "Have you or any of your household member participated in the asset creation activities and received a food assistance transfer?"
label var HHAssetProtect     "Do you think that the assets that were built or rehabilitated in your community are better protecting your household from floods / drought / landslides / mudslides?"
label var HHAssetProduct     "Do you think that the assets that were built or rehabilitated in your community have allowed your household to increase or diversify its production (agriculture / livestock / other)?"
label var HHAssetDecHardship "Do you think that the assets that were built or rehabilitated in your community have decreased the day-to-day hardship and released time for any of your family members (including women and children)?"
label var HHAssetAccess      "Do you think that the assets that were built or rehabilitated in your community have improved the ability of any of your household member to access markets and/or basic services (water, sanitation, health, education, etc)?"
label var HHTrainingAsset    "Do you think that the trainings and other support provided in your community have improved your household’s ability to manage and maintain assets?"
label var HHAssetEnv         "Do you think that the assets that were built or rehabilitated in your community have improved your natural environment (for example more vegetal cover, water table increased, less erosion, etc.)?"
label var HHWorkAsset        "Do you think that the works undertaken in your community have restored your ability to access and/or use basic asset functionalities?"

* Define value labels
label define HHFFAPart_lbl 0 "No" 1 "Yes"
label values HHFFAPart HHFFAPart_lbl

label define ABI_lbl 0 "No" 1 "Yes" 9999 "Not applicable"
label values HHAssetProtect HHAssetProduct HHAssetDecHardship HHAssetAccess HHTrainingAsset HHAssetEnv HHWorkAsset ABI_lbl

* Recode 9999 to 0
foreach var of varlist HHAssetProtect HHAssetProduct HHAssetDecHardship HHAssetAccess HHTrainingAsset HHAssetEnv HHWorkAsset {
    replace `var' = 0 if `var' == 9999
}

* Create denominator of questions asked for each community
gen ABIdenom = .
replace ABIdenom = 5 if ADMIN5Name == "Community A"
replace ABIdenom = 6 if ADMIN5Name == "Community B"

* Create ABI score and ABI percent
gen ABIScore = HHAssetProtect + HHAssetProduct + HHAssetDecHardship + HHAssetAccess + HHTrainingAsset + HHAssetEnv + HHWorkAsset
gen ABIPerc = (ABIScore / ABIdenom) * 100

* Create table of values - participants vs non-participants
collapse (mean) ABIPerc, by(HHFFAPart)
rename ABIPerc ABIPerc_mean

* Calculate ABI using weight value of 2 for non-participants
gen ABIperc_wtd = ABIPerc_mean
replace ABIperc_wtd = ABIPerc_mean * 2 if HHFFAPart == 0

* Add weight for non-participant and compute average
gen ABIperc_total_partic = ABIperc_wtd / 3
collapse (sum) ABIperc_total_partic

* End of Scripts