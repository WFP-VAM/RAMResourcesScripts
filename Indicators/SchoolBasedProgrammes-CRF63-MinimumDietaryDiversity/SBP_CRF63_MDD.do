*------------------------------------------------------------------------------
*                          WFP Standardized Scripts
*          School Age Dietary Diversity Score (SADD) Calculation
*------------------------------------------------------------------------------

* This script calculates the School Age Dietary Diversity Score (SADD) based on 
* WFP MDDW guidelines. Specialized Nutritious Foods (SNF) will count in the 
* meats group, and fortified foods will also count in grains.
* Detailed guidelines can be found at:
* https://docs.wfp.org/api/documents/WFP-0000140197/download/

* This syntax is based on SPSS download version from MoDA.
* Following the WFP MDDW method for program monitoring - SNF will count in the meats group.
* In this example, fortified foods (PSchoolAgeDDSFortFoodwflour, PSchoolAgeDDSFortFoodmflour, PSchoolAgeDDSFortFoodrice, PSchoolAgeDDSFortFooddrink)
* will also count in grains. Classifying PSchoolAgeDDSFortFoodother_oth will likely involve classifying line by line.
* More details can be found in the background document at: 
* https://wfp.sharepoint.com/sites/CRF2022-2025/CRF%20Outcome%20indicators/Forms/AllItems.aspx?id=%2Fsites%2FCRF2022%2D2025%2FCRF%20Outcome%20indicators%2F2%2E%20Nutrition%2F63%2E%20Percentage%20of%20school%2Daged%20children%20meeting%20minimum%20dietary%20diversity%20score%20%5BNEW%5D%2Epdf&viewid=68ec615a%2D665b%2D4f2d%2Da495%2D9e5f10bc60b2&parent=%2Fsites%2FCRF2022%2D2025%2FCRF%20Outcome%20indicators%2F2%2E%20Nutrition

*------------------------------------------------------------------------------
* Variable and Value Labels
*------------------------------------------------------------------------------

label variable PSchoolAgeDDSStapCer          "Foods made from grains"
label variable PSchoolAgeDDSStapRoo          "White roots and tubers or plantains"
label variable PSchoolAgeDDSPulse            "Pulses (beans, peas and lentils)"
label variable PSchoolAgeDDSNuts             "Nuts and seeds"
label variable PSchoolAgeDDSMilk             "Milk"
label variable PSchoolAgeDDSDairy            "Milk products"
label variable PSchoolAgeDDSPrMeatO          "Organ meats"
label variable PSchoolAgeDDSPrMeatF          "Red flesh meat from mammals"
label variable PSchoolAgeDDSPrMeatPro        "Processed meat"
label variable PSchoolAgeDDSPrMeatWhite      "Poultry and other white meats"
label variable PSchoolAgeDDSPrFish           "Fish and Seafood"
label variable PSchoolAgeDDSPrEgg            "Eggs from poultry or any other bird"
label variable PSchoolAgeDDSVegGre           "Dark green leafy vegetables"
label variable PSchoolAgeDDSVegOrg           "Vitamin A-rich vegetables, roots and tubers"
label variable PSchoolAgeDDSFruitOrg         "Vitamin A-rich fruits"
label variable PSchoolAgeDDSVegOth           "Other vegetables"
label variable PSchoolAgeDDSFruitOth         "Other fruits"
label variable PSchoolAgeDDSSnf              "Specialized Nutritious Foods (SNF) for women"
label variable PSchoolAgeDDSFortFoodoil      "Fortified oil"
label variable PSchoolAgeDDSFortFoodwflour   "Fortified wheat flour"
label variable PSchoolAgeDDSFortFoodmflour   "Fortified maize flour"
label variable PSchoolAgeDDSFortFoodrice     "Fortified Rice"
label variable PSchoolAgeDDSFortFooddrink    "Fortified drink"
label variable PSchoolAgeDDSFortFoodother    "Other fortified food"
label variable PSchoolAgeDDSFortFoodother_oth "Other fortified food (specify)"

label define yes_no 0 "No" 1 "Yes"
label values PSchoolAgeDDSStapCer PSchoolAgeDDSStapRoo PSchoolAgeDDSPulse PSchoolAgeDDSNuts PSchoolAgeDDSMilk PSchoolAgeDDSDairy PSchoolAgeDDSPrMeatO PSchoolAgeDDSPrMeatF PSchoolAgeDDSPrMeatPro PSchoolAgeDDSPrMeatWhite PSchoolAgeDDSPrFish PSchoolAgeDDSPrEgg PSchoolAgeDDSVegGre PSchoolAgeDDSVegOrg PSchoolAgeDDSFruitOrg PSchoolAgeDDSVegOth PSchoolAgeDDSFruitOth PSchoolAgeDDSSnf PSchoolAgeDDSFortFoodoil PSchoolAgeDDSFortFoodwflour PSchoolAgeDDSFortFoodmflour PSchoolAgeDDSFortFoodrice PSchoolAgeDDSFortFooddrink PSchoolAgeDDSFortFoodother yes_no

*------------------------------------------------------------------------------
* Calculate Food Groups
*------------------------------------------------------------------------------

gen PSchoolAgeDDS_Staples_wfp = 0
replace PSchoolAgeDDS_Staples_wfp = 1 if PSchoolAgeDDSStapCer == 1 | PSchoolAgeDDSStapRoo == 1 | PSchoolAgeDDSFortFoodwflour == 1 | PSchoolAgeDDSFortFoodmflour == 1 | PSchoolAgeDDSFortFoodrice == 1 | PSchoolAgeDDSFortFooddrink == 1

gen PSchoolAgeDDS_Pulses_wfp = 0
replace PSchoolAgeDDS_Pulses_wfp = 1 if PSchoolAgeDDSPulse == 1

gen PSchoolAgeDDS_NutsSeeds_wfp = 0
replace PSchoolAgeDDS_NutsSeeds_wfp = 1 if PSchoolAgeDDSNuts == 1

gen PSchoolAgeDDS_Dairy_wfp = 0
replace PSchoolAgeDDS_Dairy_wfp = 1 if PSchoolAgeDDSDairy == 1 | PSchoolAgeDDSMilk == 1

gen PSchoolAgeDDS_MeatFish_wfp = 0
replace PSchoolAgeDDS_MeatFish_wfp = 1 if PSchoolAgeDDSPrMeatO == 1 | PSchoolAgeDDSPrMeatF == 1 | PSchoolAgeDDSPrMeatPro == 1 | PSchoolAgeDDSPrMeatWhite == 1 | PSchoolAgeDDSPrFish == 1 | PSchoolAgeDDSSnf == 1

gen PSchoolAgeDDS_Eggs_wfp = 0
replace PSchoolAgeDDS_Eggs_wfp = 1 if PSchoolAgeDDSPrEgg == 1

gen PSchoolAgeDDS_LeafGreenVeg_wfp = 0
replace PSchoolAgeDDS_LeafGreenVeg_wfp = 1 if PSchoolAgeDDSVegGre == 1

gen PSchoolAgeDDS_VitA_wfp = 0
replace PSchoolAgeDDS_VitA_wfp = 1 if PSchoolAgeDDSVegOrg == 1 | PSchoolAgeDDSFruitOrg == 1

gen PSchoolAgeDDS_OtherVeg_wfp = 0
replace PSchoolAgeDDS_OtherVeg_wfp = 1 if PSchoolAgeDDSVegOth == 1

gen PSchoolAgeDDS_OtherFruits_wfp = 0
replace PSchoolAgeDDS_OtherFruits_wfp = 1 if PSchoolAgeDDSFruitOth == 1

*------------------------------------------------------------------------------
* Calculate Dietary Diversity Score
*------------------------------------------------------------------------------

gen SchoolAgeDDS_wfp = PSchoolAgeDDS_Staples_wfp + PSchoolAgeDDS_Pulses_wfp + PSchoolAgeDDS_NutsSeeds_wfp + PSchoolAgeDDS_Dairy_wfp + PSchoolAgeDDS_MeatFish_wfp + PSchoolAgeDDS_Eggs_wfp + PSchoolAgeDDS_LeafGreenVeg_wfp + PSchoolAgeDDS_VitA_wfp + PSchoolAgeDDS_OtherVeg_wfp + PSchoolAgeDDS_OtherFruits_wfp

*------------------------------------------------------------------------------
* Classify Dietary Diversity Score
*------------------------------------------------------------------------------

gen SchoolAgeDDS_5_wfp = 0
replace SchoolAgeDDS_5_wfp = 1 if SchoolAgeDDS_wfp >= 5
label define DDS_5_wfp 0 "<5" 1 ">=5"
label values SchoolAgeDDS_5_wfp DDS_5_wfp

*------------------------------------------------------------------------------
* Frequency of WFP DDS Method for Program Monitoring
*------------------------------------------------------------------------------

tabulate SchoolAgeDDS_5_wfp

* End of Scripts