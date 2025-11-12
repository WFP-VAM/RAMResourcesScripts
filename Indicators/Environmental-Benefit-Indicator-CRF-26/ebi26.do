*------------------------------------------------------------------------------*
*	                          WFP Standardized Scripts
*                     Calculating Environmental Benefit Indicator (EBI) 26
*------------------------------------------------------------------------------*

* This script calculates the Environmental Benefit Indicator (EBI) based on various 
* environmental-related questions. It recodes the responses, calculates percentages, 
* and computes the EBI for each community and overall.

* Label EBI relevant variables
label var EBIFFAPart           "Have you or any of your household member participated in the asset creation activities and received a food assistance transfer?"
label var EBISoilFertility     "Do you think that the assets that were built or rehabilitated in your community have allowed to increase agricultural potential due to greater water availability and/or soil fertility (e.g. increased or diversified production not requiring expanded irrigation)?"
label var EBIStabilization     "Do you think that the assets that were built or rehabilitated in your community have improved natural environment due to land stabilization and restoration (e.g. more natural vegetal cover, increase in indigenous flora/fauna, less erosion or siltation, etc.)?"
label var EBISanitation        "Do you think that the assets that were built or rehabilitated in your community have improved environmental surroundings due to enhanced water and sanitation measures (i.e., greater availability/longer duration of water for domestic non-human consumption, improved hygiene practices – less open defecation)?"

* Define value labels
label define EBIFFAPart_lbl    0 "No" 1 "Yes"
label values EBIFFAPart        EBIFFAPart_lbl

label define EBI_lbl           0 "No" 1 "Yes" 9999 "Not applicable"
label values EBISoilFertility  EBIStabilization EBISanitation EBI_lbl

* Recode 9999 to 0
foreach var of varlist EBISoilFertility EBIStabilization EBISanitation {
    replace `var' = 0 if `var' == 9999
}

* Create table of % of yes responses to each of the 3 questions by ADMIN5Name
collapse (mean) EBISoilFertility EBIStabilization EBISanitation, by(ADMIN5Name)
gen EBISoilFertility_perc  = EBISoilFertility * 100
gen EBIStabilization_perc  = EBIStabilization * 100
gen EBISanitation_perc     = EBISanitation * 100

* Create values with the denominator of questions asked for each community
gen EBIdenom = .
replace EBIdenom = 2 if ADMIN5Name == "Community A"
replace EBIdenom = 3 if ADMIN5Name == "Community B"

* Calculate EBI by community
gen EBI_ADMIN5Name = (EBISoilFertility_perc + EBIStabilization_perc + EBISanitation_perc) / EBIdenom

* Calculate total EBI average across all communities
summarize EBI_ADMIN5Name, meanonly
gen EBI_overall = r(mean)

* End of Scripts