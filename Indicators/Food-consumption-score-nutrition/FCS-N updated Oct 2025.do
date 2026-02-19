*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                         Food Consumption Score - Nutrition (FCS-N) 


*** Last Update: Oct 2025
*** Purpose: This script calculates the Food Consumption Score - Nutrition (FCS-N) 

***   Data Quality Guidance References:
***   - Recommended high frequency checks: Page 30
***   - Recommended cleaning steps: Page 37

*** ----------------------------------------------------------------------------------------------------

*** Define group labels-  these should match Survey Designer naming conventions

label var FCSNPrMeatF  "Consumption in past 7 days: Flesh meat"
label var FCSNPrMeatO  "Consumption in past 7 days: Organ meat"
label var FCSNPrFish   "Consumption in past 7 days: Fish/shellfish"
label var FCSNPrEggs   "Consumption in past 7 days: Eggs"
label var FCSNVegOrg   "Consumption in past 7 days: Orange vegetables (vegetables rich in Vitamin A)"
label var FCSNVegGre   "Consumption in past 7 days: Green leafy vegetables"
label var FCSNFruiOrg  "Consumption in past 7 days: Orange fruits (fruits rich in Vitamin A)"

*** Check individual food groups

tabstat FCSNPrMeatF FCSNPrMeatO FCSNPrFish FCSNPrEggs FCSNVegOrg FCSNVegGre FCSNFruiOrg, s(mean median min max)
**OR
summarize FCSNPrMeatF FCSNPrMeatO FCSNPrFish FCSNPrEggs FCSNVegOrg FCSNVegGre FCSNFruiOrg

*** In cases where 0 consumption of main group automatically codes subgroup values as missing, recoding to 0 consumption

foreach v in FCSNPrMeatO FCSNPrMeatF FCSNPrFish FCSNPrEggs FCSNVegOrg FCSNVegGre FCSNFruiOrg {
    replace `v' = 0 if missing(`v')
}

*** Harmonize Data Quality Guidance measures
*** Clean impossible values 

foreach v in FCSNPrMeatF FCSNPrMeatO FCSNPrFish FCSNPrEggs FCSNVegOrg FCSNVegGre FCSNFruiOrg {
    replace `v' = . if `v' < 0  | `v' >= 8
}

**OR

recode FCSNPrMeatF FCSNPrMeatO FCSNPrFish FCSNPrEggs FCSNVegOrg FCSNVegGre FCSNFruiOrg (min/-1=.) (8/max=.)

*** Flagging potential Data Quality issues. If any cases reflected here, refer to the Data Quality Guidance note page 37. This can be found on the VAM Ressource Centre

* Reusable Yes/No value label

label define yesno 0 "No" 1 "Yes"
**OR to reuse already defined label use
capture label define yesno 0 "No" 1 "Yes"

* -----------------------------
* Protein subgroup vs main group
* -----------------------------
gen byte FCSN_flag_protein = 0
replace FCSN_flag_protein = 1 if ///
    !missing(FCSNPrMeatF, FCSPr) & FCSNPrMeatF > FCSPr | ///
    !missing(FCSNPrMeatO, FCSPr) & FCSNPrMeatO > FCSPr | ///
    !missing(FCSNPrFish,  FCSPr) & FCSNPrFish  > FCSPr | ///
    !missing(FCSNPrEggs,  FCSPr) & FCSNPrEggs  > FCSPr

label variable FCSN_flag_protein ///
"Subgroup exceeds main group. Flag issue to team leader during high frequency check. During cleaning, recode value to be capped at value for main group"
label values FCSN_flag_protein yesno

* -----------------------------
* Vegetable subgroups vs main group
* -----------------------------
gen byte FCSN_flag_veg = 0
replace FCSN_flag_veg = 1 if ///
    !missing(FCSNVegOrg, FCSVeg) & FCSNVegOrg > FCSVeg | ///
    !missing(FCSNVegGre, FCSVeg) & FCSNVegGre > FCSVeg

label variable FCSN_flag_veg ///
"Subgroup exceeds main group. Flag issue to team leader during high frequency check. During cleaning, recode value to be capped at value for main group"
label values FCSN_flag_veg yesno

* -----------------------------
* Fruit subgroup vs main group
* -----------------------------
gen byte FCSN_flag_fruit = 0
replace FCSN_flag_fruit = 1 if ///
    !missing(FCSNFruiOrg, FCSFruit) & FCSNFruiOrg > FCSFruit

label variable FCSN_flag_fruit ///
"Subgroup exceeds main group. Flag issue to team leader during high frequency check. During cleaning, recode value to be capped at value for main group"
label values FCSN_flag_fruit yesno

*** Check flagged cases
codebook FCSN_flag_protein FCSN_flag_veg FCSN_flag_fruit

tabulate FCSN_flag_protein, missing
tabulate FCSN_flag_veg, missing
tabulate FCSN_flag_fruit, missing

*** Calculate Vitamin A, protein and haem iron intake


* ---------- Compute food-group sums ----------
gen FGVitA    = FCSDairy + FCSNPrMeatO + FCSNPrEggs + FCSNVegOrg + FCSNVegGre + FCSNFruiOrg
gen FGProtein = FCSPulse + FCSDairy + FCSNPrMeatF + FCSNPrMeatO + FCSNPrFish + FCSNPrEggs
gen FGHIron   = FCSNPrMeatF + FCSNPrMeatO + FCSNPrFish

* ---------- Vitamin A category ----------
gen VitA_Cat = .
replace VitA_Cat = 1 if FGVitA == 0
replace VitA_Cat = 2 if FGVitA >= 1  & FGVitA <= 6
replace VitA_Cat = 3 if FGVitA >= 7  & FGVitA <= 42
label variable VitA_Cat "Household consumption of vitamin A"

* ---------- Protein category ----------
gen Protein_Cat = .
replace Protein_Cat = 1 if FGProtein == 0
replace Protein_Cat = 2 if FGProtein >= 1  & FGProtein <= 6
replace Protein_Cat = 3 if FGProtein >= 7  & FGProtein <= 42
label variable Protein_Cat "Household consumption of protein"

* ---------- Haem iron category ----------
gen Haem_iron_Cat = .
replace Haem_iron_Cat = 1 if FGHIron == 0
replace Haem_iron_Cat = 2 if FGHIron >= 1  & FGHIron <= 6
replace Haem_iron_Cat = 3 if FGHIron >= 7  & FGHIron <= 42
label variable Haem_iron_Cat "Household consumption of haem iron"

* ---------- Reusable value labels ----------
capture label define cons3_lbl ///
    1 "0 time (never consumed)" ///
    2 "1-6 times (consumed sometimes)" ///
    3 "7 times or more (consumed at least daily)"

label values VitA_Cat      cons3_lbl
label values Protein_Cat   cons3_lbl
label values Haem_iron_Cat cons3_lbl

*** Check results
codebook VitA_Cat Protein_Cat Haem_iron_Cat

tabulate VitA_Cat, missing
tabulate Protein_Cat, missing
tabulate Haem_iron_Cat, missing

****End Script****
