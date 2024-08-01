*------------------------------------------------------------------------------
*                          WFP Standardized Scripts
*                  Minimum Acceptable Diet (MAD) Calculation
*------------------------------------------------------------------------------

* Construction of the Minimum Acceptable Diet (MAD) is based on the 
* codebook questions prepared for the MAD module.

*-------------------------------------------------------------------------------*
* 1. Rename variables to remove group names
*-------------------------------------------------------------------------------*

RENAME VARIABLES (MAD_submoduleRepeatMADPCMADChildAge_months = PCMADChildAge_months).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADBreastfeed = PCMADBreastfeed).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADInfFormula = PCMADInfFormula).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADInfFormulaNum = PCMADInfFormulaNum).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADMilk = PCMADMilk).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADMilkNum = PCMADMilkNum).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADYogurtDrink = PCMADYogurtDrink).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADYogurtDrinkNum = PCMADYogurtDrinkNum).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADYogurt = PCMADYogurt).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADStapCer = PCMADStapCer).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADVegOrg = PCMADVegOrg).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADStapRoo = PCMADStapRoo).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADVegGre = PCMADVegGre).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADVegOth = PCMADVegOth).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADFruitOrg = PCMADFruitOrg).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADFruitOth = PCMADFruitOth).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADPrMeatO = PCMADPrMeatO).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADPrMeatPro = PCMADPrMeatPro).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADPrMeatF = PCMADPrMeatF).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADPrEgg = PCMADPrEgg).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADPrFish = PCMADPrFish).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADPulse = PCMADPulse).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADCheese = PCMADCheese).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADSnf = PCMADSnf).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADMeals = PCMADMeals).

*-------------------------------------------------------------------------------*
* 2. Define variable and value labels
*-------------------------------------------------------------------------------*

VARIABLE LABELS 
  PCMADChildAge_months "What is the age in months of ${PCMADChildName} ?" 
  PCMADBreastfeed "Was ${PCMADChildName} breastfed yesterday during the day or at night?"
  PCMADInfFormula "Infant formula, such as [insert local names of common formula]?"
  PCMADInfFormulaNum "How many times did ${PCMADChildName} drink formula?"
  PCMADMilk "Milk from animals, such as fresh, tinned or powdered milk?"
  PCMADMilkNum "How many times did ${PCMADChildName} drink milk from animals, such as fresh, tinned or powdered milk?"
  PCMADYogurtDrink "Yogurt drinks such as [insert local names of common types of yogurt drinks]?"
  PCMADYogurtDrinkNum "How many times did ${PCMADChildName} drink Yogurt drinks such as [insert local names of common types of yogurt drinks]?"
  PCMADYogurt "Yogurt, other than yogurt drinks?"
  PCMADStapCer "Porridge, bread, rice, noodles, pasta or [insert other commonly consumed grains, including foods made from grains like rice dishes, noodle dishes, etc.]?"
  PCMADVegOrg "Pumpkin, carrots, sweet red peppers, squash or sweet potatoes that are yellow or orange inside?"
  PCMADStapRoo "Plantains, white potatoes, white yams, manioc, cassava or [insert other commonly consumed starchy tubers or starchy tuberous roots that are white or pale inside]?"
  PCMADVegGre "Dark green leafy vegetables, such as [insert commonly consumed vitamin A-rich dark green leafy vegetables]?"
  PCMADVegOth "Any other vegetables, such as [insert commonly consumed vegetables]?"
  PCMADFruitOrg "Ripe mangoes or ripe papayas or [insert other commonly consumed vitamin A-rich fruits]?"
  PCMADFruitOth "Any other fruits, such as [insert commonly consumed fruits]?"
  PCMADPrMeatO "Liver, kidney, heart or [insert other commonly consumed organ meats]?"
  PCMADPrMeatPro "Sausages, hot dogs/frankfurters, ham, bacon, salami, canned meat or [insert other commonly consumed processed meats]?"
  PCMADPrMeatF "Any other meat, such as beef, pork, lamb, goat, chicken, duck or [insert other commonly consumed meat]?"
  PCMADPrEgg "Eggs"
  PCMADPrFish "Fresh or dried fish, shellfish or seafood"
  PCMADPulse "Beans, peas, lentils, nuts, seeds or [insert commonly consumed foods made from beans, peas, lentils, nuts, or seeds]?"
  PCMADCheese "Hard or soft cheese such as [insert commonly consumed types of cheese]?"
  PCMADSnf "Specialized Nutritious Foods (SNF) such as [insert the SNFs distributed by WFP]?"
  PCMADMeals "How many times did ${PCMADChildName} eat any solid, semi-solid or soft foods yesterday during the day or night?".

VALUE LABELS PCMADBreastfeed PCMADInfFormula PCMADMilk PCMADYogurtDrink PCMADYogurt PCMADStapCer PCMADVegOrg PCMADStapRoo PCMADVegGre PCMADVegOth PCMADFruitOrg PCMADFruitOth PCMADPrMeatO PCMADPrMeatPro PCMADPrMeatF PCMADPrEgg PCMADPrFish PCMADPulse PCMADCheese PCMADSnf
  1 "Yes"
  0 "No"
  888 "Don't know".
EXECUTE.

*-------------------------------------------------------------------------------*
* 3. Create Minimum Dietary Diversity 6-23 months (MDD) for population assessments
*-------------------------------------------------------------------------------*

COMPUTE MAD_BreastMilk = 0.
IF PCMADBreastfeed = 1 MAD_BreastMilk = 1.
COMPUTE MAD_PWMDDWStapCer = 0.
IF PCMADStapCer = 1 OR PCMADStapRoo = 1 OR PCMADSnf = 1 MAD_PWMDDWStapCer = 1.
COMPUTE MAD_PulsesNutsSeeds = 0.
IF PCMADPulse = 1 MAD_PulsesNutsSeeds = 1.
COMPUTE MAD_Dairy = 0.
IF PCMADInfFormula = 1 OR PCMADMilk = 1 OR PCMADYogurtDrink = 1 OR PCMADYogurt = 1 OR PCMADCheese = 1 MAD_Dairy = 1.
COMPUTE MAD_MeatFish = 0.
IF PCMADPrMeatO = 1 OR PCMADPrMeatPro = 1 OR PCMADPrMeatF = 1 OR PCMADPrFish = 1 MAD_MeatFish = 1.
COMPUTE MAD_Eggs = 0.
IF PCMADPrEgg = 1 MAD_Eggs = 1.
COMPUTE MAD_VitA = 0.
IF PCMADVegOrg = 1 OR PCMADVegGre = 1 OR PCMADFruitOrg = 1 MAD_VitA = 1.
COMPUTE MAD_OtherVegFruits = 0.
IF PCMADFruitOth = 1 OR PCMADVegOth = 1 MAD_OtherVegFruits = 1.

* Add together food groups to see how many food groups consumed
COMPUTE MDD_score = SUM(MAD_BreastMilk, MAD_PWMDDWStapCer, MAD_PulsesNutsSeeds, MAD_Dairy, MAD_MeatFish, MAD_Eggs, MAD_VitA, MAD_OtherVegFruits).

* Create MDD variable which records whether child consumed five or more food groups
COMPUTE MDD = 0.
IF MDD_score >= 5 MDD = 1.
VARIABLE LABELS MDD "Minimum Dietary Diversity (MDD)".
VALUE LABELS MDD 1 'Meets MDD' 0 'Does not meet MDD'.
EXECUTE.

*-------------------------------------------------------------------------------*
* 4. Create Minimum Dietary Diversity 6-23 months (MDD) for WFP programme monitoring
*-------------------------------------------------------------------------------*

COMPUTE MAD_BreastMilk_wfp = 0.
IF PCMADBreastfeed = 1 MAD_BreastMilk_wfp = 1.
COMPUTE MAD_PWMDDWStapCer_wfp = 0.
IF PCMADStapCer = 1 OR PCMADStapRoo = 1 MAD_PWMDDWStapCer_wfp = 1.
COMPUTE MAD_PulsesNutsSeeds_wfp = 0.
IF PCMADPulse = 1 MAD_PulsesNutsSeeds_wfp = 1.
COMPUTE MAD_Dairy_wfp = 0.
IF PCMADInfFormula = 1 OR PCMADMilk = 1 OR PCMADYogurtDrink = 1 OR PCMADYogurt = 1 OR PCMADCheese = 1 MAD_Dairy_wfp = 1.
COMPUTE MAD_MeatFish_wfp = 0.
IF PCMADPrMeatO = 1 OR PCMADPrMeatPro = 1 OR PCMADPrMeatF = 1 OR PCMADPrFish = 1 OR PCMADSnf = 1 MAD_MeatFish_wfp = 1.
COMPUTE MAD_Eggs_wfp = 0.
IF PCMADPrEgg = 1 MAD_Eggs_wfp = 1.
COMPUTE MAD_VitA_wfp = 0.
IF PCMADVegOrg = 1 OR PCMADVegGre = 1 OR PCMADFruitOrg = 1 MAD_VitA_wfp = 1.
COMPUTE MAD_OtherVegFruits_wfp = 0.
IF PCMADFruitOth = 1 OR PCMADVegOth = 1 MAD_OtherVegFruits_wfp = 1.

* Add together food groups to see how many food groups consumed
COMPUTE MDD_score_wfp = SUM(MAD_BreastMilk_wfp, MAD_PWMDDWStapCer_wfp, MAD_PulsesNutsSeeds_wfp, MAD_Dairy_wfp, MAD_MeatFish_wfp, MAD_Eggs_wfp, MAD_VitA_wfp, MAD_OtherVegFruits_wfp).

* Create MDD variable which records whether child consumed five or more food groups
COMPUTE MDD_wfp = 0.
IF MDD_score_wfp >= 5 MDD_wfp = 1.
VARIABLE LABELS MDD_wfp "Minimum Dietary Diversity for WFP program monitoring (MDD)".
VALUE LABELS MDD_wfp 1 'Meets MDD' 0 'Does not meet MDD'.
EXECUTE.

*-------------------------------------------------------------------------------*
* 5. Calculate Minimum Meal Frequency 6-23 months (MMF)
*-------------------------------------------------------------------------------*

* Recode into new variables turning don't know and missing values into 0 - this makes syntax for calculation simpler
RECODE PCMADBreastfeed (1=1) (ELSE=0) INTO PCMADBreastfeed_yn.
RECODE PCMADMeals (1 THRU 7=Copy) (ELSE=0) INTO PCMADMeals_r.
RECODE PCMADInfFormulaNum (1 THRU 7=Copy) (ELSE=0) INTO PCMADInfFormulaNum_r.
RECODE PCMADMilkNum (1 THRU 7=Copy) (ELSE=0) INTO PCMADMilkNum_r.
RECODE PCMADYogurtDrinkNum (1 THRU 7=Copy) (ELSE=0) INTO PCMADYogurtDrinkNum_r.

COMPUTE MMF = 0.
IF PCMADBreastfeed_yn = 1 AND (PCMADChildAge_months >= 6 AND PCMADChildAge_months <= 8) AND PCMADMeals_r >= 2 MMF = 1.
IF PCMADBreastfeed_yn = 1 AND (PCMADChildAge_months >= 9 AND PCMADChildAge_months <= 23) AND PCMADMeals_r >= 3 MMF = 1.
IF PCMADBreastfeed_yn = 0 AND PCMADMeals_r >= 1 AND (PCMADMeals_r + PCMADInfFormulaNum_r + PCMADMilkNum_r + PCMADYogurtDrinkNum_r >= 4) MMF = 1.

VARIABLE LABELS MMF "Minimum Meal Frequency (MMF)".
VALUE LABELS MMF 1 'Meets MMF' 0 'Does not meet MMF'.
EXECUTE.

*-------------------------------------------------------------------------------*
* 6. Calculate Minimum Milk Feeding Frequency for non-breastfed children 6-23 months (MMFF)
*-------------------------------------------------------------------------------*

COMPUTE MMFF = 0.
IF PCMADBreastfeed_yn = 0 AND (PCMADInfFormulaNum_r + PCMADMilkNum_r + PCMADYogurtDrinkNum_r >= 2) MMFF = 1.

VARIABLE LABELS MMFF "Minimum Milk Feeding Frequency for non-breastfed children (MMFF)".
VALUE LABELS MMFF 1 'Meets MMFF' 0 'Does not meet MMFF'.
EXECUTE.

*-------------------------------------------------------------------------------*
* 7. Calculate Minimum Acceptable Diet (MAD)
*-------------------------------------------------------------------------------*

* For breastfed infants: if MDD and MMF are both achieved, then MAD is achieved
* For non-breastfed infants: if MDD, MMF and MMFF are all achieved, then MAD is achieved

* Using MDD for population assessments
COMPUTE MAD = 0.
IF PCMADBreastfeed_yn = 1 AND MDD = 1 AND MMF = 1 MAD = 1.
IF PCMADBreastfeed_yn = 0 AND MDD = 1 AND MMF = 1 AND MMFF = 1 MAD = 1.

* Using MDD for WFP program monitoring
COMPUTE MAD_wfp = 0.
IF PCMADBreastfeed_yn = 1 AND MDD_wfp = 1 AND MMF = 1 MAD_wfp = 1.
IF PCMADBreastfeed_yn = 0 AND MDD_wfp = 1 AND MMF = 1 AND MMFF = 1 MAD_wfp = 1.

VARIABLE LABELS MAD "Minimum Acceptable Diet (MAD)".
VALUE LABELS MAD 1 'Meets MAD' 0 'Does not meet MAD'.
EXECUTE.

*-------------------------------------------------------------------------------*
* 8. Frequency of MAD
*-------------------------------------------------------------------------------*

FREQUENCIES VARIABLES=MAD.
FREQUENCIES VARIABLES=MAD_wfp.

* End of Scripts