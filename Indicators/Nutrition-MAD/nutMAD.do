********************************************************************************
*                          WFP Standardized Scripts
*                  Minimum Acceptable Diet (MAD) Calculation
********************************************************************************

* Construction of the Minimum Acceptable Diet (MAD) is based on the 
* codebook questions prepared for the MAD module.

*-------------------------------------------------------------------------------*
* 1. Rename variables to remove group names
*-------------------------------------------------------------------------------*

rename MAD_submoduleRepeatMADPCMADChildAge_months      PCMADChildAge_months
rename MAD_submoduleRepeatMADPCMADBreastfeed           PCMADBreastfeed
rename MAD_submoduleRepeatMADPCMADInfFormula           PCMADInfFormula
rename MAD_submoduleRepeatMADPCMADInfFormulaNum        PCMADInfFormulaNum
rename MAD_submoduleRepeatMADPCMADMilk                 PCMADMilk
rename MAD_submoduleRepeatMADPCMADMilkNum              PCMADMilkNum
rename MAD_submoduleRepeatMADPCMADYogurtDrink          PCMADYogurtDrink
rename MAD_submoduleRepeatMADPCMADYogurtDrinkNum       PCMADYogurtDrinkNum
rename MAD_submoduleRepeatMADPCMADYogurt               PCMADYogurt
rename MAD_submoduleRepeatMADPCMADStapCer              PCMADStapCer
rename MAD_submoduleRepeatMADPCMADVegOrg               PCMADVegOrg
rename MAD_submoduleRepeatMADPCMADStapRoo              PCMADStapRoo
rename MAD_submoduleRepeatMADPCMADVegGre               PCMADVegGre
rename MAD_submoduleRepeatMADPCMADVegOth               PCMADVegOth
rename MAD_submoduleRepeatMADPCMADFruitOrg             PCMADFruitOrg
rename MAD_submoduleRepeatMADPCMADFruitOth             PCMADFruitOth
rename MAD_submoduleRepeatMADPCMADPrMeatO              PCMADPrMeatO
rename MAD_submoduleRepeatMADPCMADPrMeatPro            PCMADPrMeatPro
rename MAD_submoduleRepeatMADPCMADPrMeatF              PCMADPrMeatF
rename MAD_submoduleRepeatMADPCMADPrEgg                PCMADPrEgg
rename MAD_submoduleRepeatMADPCMADPrFish               PCMADPrFish
rename MAD_submoduleRepeatMADPCMADPulse                PCMADPulse
rename MAD_submoduleRepeatMADPCMADCheese               PCMADCheese
rename MAD_submoduleRepeatMADPCMADSnf                  PCMADSnf
rename MAD_submoduleRepeatMADPCMADMeals                PCMADMeals

*-------------------------------------------------------------------------------*
* 2. Define variable and value labels
*-------------------------------------------------------------------------------*

label variable PCMADChildAge_months   "What is the age in months of ${PCMADChildName} ?"
label variable PCMADBreastfeed        "Was ${PCMADChildName} breastfed yesterday during the day or at night?"
label variable PCMADInfFormula        "Infant formula, such as [insert local names of common formula]?"
label variable PCMADInfFormulaNum     "How many times did ${PCMADChildName} drink formula?"
label variable PCMADMilk              "Milk from animals, such as fresh, tinned or powdered milk?"
label variable PCMADMilkNum           "How many times did ${PCMADChildName} drink milk from animals, such as fresh, tinned or powdered milk?"
label variable PCMADYogurtDrink       "Yogurt drinks such as [insert local names of common types of yogurt drinks]?"
label variable PCMADYogurtDrinkNum    "How many times did ${PCMADChildName} drink Yogurt drinks such as [insert local names of common types of yogurt drinks]?"
label variable PCMADYogurt            "Yogurt, other than yogurt drinks?"
label variable PCMADStapCer           "Porridge, bread, rice, noodles, pasta or [insert other commonly consumed grains, including foods made from grains like rice dishes, noodle dishes, etc.]?"
label variable PCMADVegOrg            "Pumpkin, carrots, sweet red peppers, squash or sweet potatoes that are yellow or orange inside?"
label variable PCMADStapRoo           "Plantains, white potatoes, white yams, manioc, cassava or [insert other commonly consumed starchy tubers or starchy tuberous roots that are white or pale inside]?"
label variable PCMADVegGre            "Dark green leafy vegetables, such as [insert commonly consumed vitamin A-rich dark green leafy vegetables]?"
label variable PCMADVegOth            "Any other vegetables, such as [insert commonly consumed vegetables]?"
label variable PCMADFruitOrg          "Ripe mangoes or ripe papayas or [insert other commonly consumed vitamin A-rich fruits]?"
label variable PCMADFruitOth          "Any other fruits, such as [insert commonly consumed fruits]?"
label variable PCMADPrMeatO           "Liver, kidney, heart or [insert other commonly consumed organ meats]?"
label variable PCMADPrMeatPro         "Sausages, hot dogs/frankfurters, ham, bacon, salami, canned meat or [insert other commonly consumed processed meats]?"
label variable PCMADPrMeatF           "Any other meat, such as beef, pork, lamb, goat, chicken, duck or [insert other commonly consumed meat]?"
label variable PCMADPrEgg             "Eggs"
label variable PCMADPrFish            "Fresh or dried fish, shellfish or seafood"
label variable PCMADPulse             "Beans, peas, lentils, nuts, seeds or [insert commonly consumed foods made from beans, peas, lentils, nuts, or seeds]?"
label variable PCMADCheese            "Hard or soft cheese such as [insert commonly consumed types of cheese]?"
label variable PCMADSnf               "Specialized Nutritious Foods (SNF) such as [insert the SNFs distributed by WFP]?"
label variable PCMADMeals             "How many times did ${PCMADChildName} eat any solid, semi-solid or soft foods yesterday during the day or night?"

label define yesno 0 "No" 1 "Yes" 888 "Don't know"
label values PCMADBreastfeed PCMADInfFormula PCMADMilk PCMADYogurtDrink PCMADYogurt PCMADStapCer PCMADVegOrg PCMADStapRoo PCMADVegGre PCMADVegOth PCMADFruitOrg PCMADFruitOth PCMADPrMeatO PCMADPrMeatPro PCMADPrMeatF PCMADPrEgg PCMADPrFish PCMADPulse PCMADCheese PCMADSnf yesno

*-------------------------------------------------------------------------------*
* 3. Create Minimum Dietary Diversity 6-23 months (MDD) for population assessments
*-------------------------------------------------------------------------------*

gen MAD_BreastMilk = 0
replace MAD_BreastMilk = 1 if PCMADBreastfeed == 1

gen MAD_PWMDDWStapCer = 0
replace MAD_PWMDDWStapCer = 1 if PCMADStapCer == 1 | PCMADStapRoo == 1 | PCMADSnf == 1

gen MAD_PulsesNutsSeeds = 0
replace MAD_PulsesNutsSeeds = 1 if PCMADPulse == 1

gen MAD_Dairy = 0
replace MAD_Dairy = 1 if PCMADInfFormula == 1 | PCMADMilk == 1 | PCMADYogurtDrink == 1 | PCMADYogurt == 1 | PCMADCheese == 1

gen MAD_MeatFish = 0
replace MAD_MeatFish = 1 if PCMADPrMeatO == 1 | PCMADPrMeatPro == 1 | PCMADPrMeatF == 1 | PCMADPrFish == 1

gen MAD_Eggs = 0
replace MAD_Eggs = 1 if PCMADPrEgg == 1

gen MAD_VitA = 0
replace MAD_VitA = 1 if PCMADVegOrg == 1 | PCMADVegGre == 1 | PCMADFruitOrg == 1

gen MAD_OtherVegFruits = 0
replace MAD_OtherVegFruits = 1 if PCMADFruitOth == 1 | PCMADVegOth == 1

* Add together food groups to see how many food groups consumed
gen MDD_score = MAD_BreastMilk + MAD_PWMDDWStapCer + MAD_PulsesNutsSeeds + MAD_Dairy + MAD_MeatFish + MAD_Eggs + MAD_VitA + MAD_OtherVegFruits

* Create MDD variable which records whether child consumed five or more food groups
gen MDD = 0
replace MDD = 1 if MDD_score >= 5
label variable MDD "Minimum Dietary Diversity (MDD)"
label define MDD_label 0 "Does not meet MDD" 1 "Meets MDD"
label values MDD MDD_label

*-------------------------------------------------------------------------------*
* 4. Create Minimum Dietary Diversity 6-23 months (MDD) for WFP programme monitoring
*-------------------------------------------------------------------------------*

gen MAD_BreastMilk_wfp = 0
replace MAD_BreastMilk_wfp = 1 if PCMADBreastfeed == 1

gen MAD_PWMDDWStapCer_wfp = 0
replace MAD_PWMDDWStapCer_wfp = 1 if PCMADStapCer == 1 | PCMADStapRoo == 1

gen MAD_PulsesNutsSeeds_wfp = 0
replace MAD_PulsesNutsSeeds_wfp = 1 if PCMADPulse == 1

gen MAD_Dairy_wfp = 0
replace MAD_Dairy_wfp = 1 if PCMADInfFormula == 1 | PCMADMilk == 1 | PCMADYogurtDrink == 1 | PCMADYogurt == 1 | PCMADCheese == 1

gen MAD_MeatFish_wfp = 0
replace MAD_MeatFish_wfp = 1 if PCMADPrMeatO == 1 | PCMADPrMeatPro == 1 | PCMADPrMeatF == 1 | PCMADPrFish == 1 | PCMADSnf == 1

gen MAD_Eggs_wfp = 0
replace MAD_Eggs_wfp = 1 if PCMADPrEgg == 1

gen MAD_VitA_wfp = 0
replace MAD_VitA_wfp = 1 if PCMADVegOrg == 1 | PCMADVegGre == 1 | PCMADFruitOrg == 1

gen MAD_OtherVegFruits_wfp = 0
replace MAD_OtherVegFruits_wfp = 1 if PCMADFruitOth == 1 | PCMADVegOth == 1

* Add together food groups to see how many food groups consumed
gen MDD_score_wfp = MAD_BreastMilk_wfp + MAD_PWMDDWStapCer_wfp + MAD_PulsesNutsSeeds_wfp + MAD_Dairy_wfp + MAD_MeatFish_wfp + MAD_Eggs_wfp + MAD_VitA_wfp + MAD_OtherVegFruits_wfp

* Create MDD variable which records whether child consumed five or more food groups
gen MDD_wfp = 0
replace MDD_wfp = 1 if MDD_score_wfp >= 5
label variable MDD_wfp "Minimum Dietary Diversity for WFP program monitoring (MDD)"
label define MDD_wfp_label 0 "Does not meet MDD" 1 "Meets MDD"
label values MDD_wfp MDD_wfp_label

*-------------------------------------------------------------------------------*
* 5. Calculate Minimum Meal Frequency 6-23 months (MMF)
*-------------------------------------------------------------------------------*

* Recode into new variables turning don't know and missing values into 0 - this makes syntax for calculation simpler
gen PCMADBreastfeed_yn = 0
replace PCMADBreastfeed_yn = 1 if PCMADBreastfeed == 1

gen PCMADMeals_r = 0
replace PCMADMeals_r = PCMADMeals if inrange(PCMADMeals, 1, 7)

gen PCMADInfFormulaNum_r = 0
replace PCMADInfFormulaNum_r = PCMADInfFormulaNum if inrange(PCMADInfFormulaNum, 1, 7)

gen PCMADMilkNum_r = 0
replace PCMADMilkNum_r = PCMADMilkNum if inrange(PCMADMilkNum, 1, 7)

gen PCMADYogurtDrinkNum_r = 0
replace PCMADYogurtDrinkNum_r = PCMADYogurtDrinkNum if inrange(PCMADYogurtDrinkNum, 1, 7)

gen MMF = 0
replace MMF = 1 if PCMADBreastfeed_yn == 1 & inrange(PCMADChildAge_months, 6, 8) & PCMADMeals_r >= 2
replace MMF = 1 if PCMADBreastfeed_yn == 1 & inrange(PCMADChildAge_months, 9, 23) & PCMADMeals_r >= 3
replace MMF = 1 if PCMADBreastfeed_yn == 0 & PCMADMeals_r >= 1 & (PCMADMeals_r + PCMADInfFormulaNum_r + PCMADMilkNum_r + PCMADYogurtDrinkNum_r >= 4)

label variable MMF "Minimum Meal Frequency (MMF)"
label define MMF_label 0 "Does not meet MMF" 1 "Meets MMF"
label values MMF MMF_label

*-------------------------------------------------------------------------------*
* 6. Calculate Minimum Milk Feeding Frequency for non-breastfed children 6-23 months (MMFF)
*-------------------------------------------------------------------------------*

gen MMFF = 0
replace MMFF = 1 if PCMADBreastfeed_yn == 0 & (PCMADInfFormulaNum_r + PCMADMilkNum_r + PCMADYogurtDrinkNum_r >= 2)

label variable MMFF "Minimum Milk Feeding Frequency for non-breastfed children (MMFF)"
label define MMFF_label 0 "Does not meet MMFF" 1 "Meets MMFF"
label values MMFF MMFF_label

*-------------------------------------------------------------------------------*
* 7. Calculate Minimum Acceptable Diet (MAD)
*-------------------------------------------------------------------------------*

* For breastfed infants: if MDD and MMF are both achieved, then MAD is achieved
* For non-breastfed infants: if MDD, MMF and MMFF are all achieved, then MAD is achieved

* Using MDD for population assessments
gen MAD = 0
replace MAD = 1 if PCMADBreastfeed_yn == 1 & MDD == 1 & MMF == 1
replace MAD = 1 if PCMADBreastfeed_yn == 0 & MDD == 1 & MMF == 1 & MMFF == 1

* Using MDD for WFP program monitoring
gen MAD_wfp = 0
replace MAD_wfp = 1 if PCMADBreastfeed_yn == 1 & MDD_wfp == 1 & MMF == 1
replace MAD_wfp = 1 if PCMADBreastfeed_yn == 0 & MDD_wfp == 1 & MMF == 1 & MMFF == 1

label variable MAD "Minimum Acceptable Diet (MAD)"
label define MAD_label 0 "Does not meet MAD" 1 "Meets MAD"
label values MAD MAD_label

*-------------------------------------------------------------------------------*
* 8. Frequency of MAD
*-------------------------------------------------------------------------------*

tabulate MAD
tabulate MAD_wfp

* End of Scripts 