* Encoding: UTF-8.

*can only download repeat csv data as zip file from moda with group names - will update this code to remove group names
*rename to remove group names - because of the variable length SPSS changes name slightly


RENAME VARIABLES (MAD_submoduleRepeatMADPCMADChildAge_months = PCMADChildAge_months ).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADBreastfeed =  PCMADBreastfeed ).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADInfFormula = PCMADInfFormula).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADInfFormulaNum = PCMADInfFormulaNum).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADMilk = PCMADMilk).
RENAME VARIABLES (MAD_submoduleRepeatMADPCMADMilkNum =  PCMADMilkNum).
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

Variable labels PCMADChildAge_months "What is the age in months of ${PCMADChildName} ?" .
Variable labels PCMADBreastfeed "Was ${PCMADChildName} breastfed yesterday during the day or at night?".
Variable labels PCMADInfFormula "Infant formula, such as [insert local names of common formula]?".
Variable labels PCMADInfFormulaNum  "How many times did ${PCMADChildName} drink formula".
Variable labels  PCMADMilk  "Milk from animals, such as fresh, tinned or powdered milk?".
Variable labels  PCMADMilkNum  "How many times did ${PCMADChildName} drink milk from animals, such as fresh, tinned or powdered milk?".
Variable labels  PCMADYogurtDrink  "Yogurt drinks such as [insert local names of common types of yogurt drinks]?".
Variable labels  PCMADYogurtDrinkNum  "How many times did  ${PCMADChildName} drink Yogurt drinks such as [insert local names of common types of yogurt drinks]?".
Variable labels  PCMADYogurt  "Yogurt, other than yogurt drinks ?".
Variable labels   PCMADStapCer  "Porridge, bread, rice, noodles, pasta or [insert other commonly consumed grains, including foods made from grains like rice dishes, noodle dishes, etc.]?".
Variable labels  PCMADVegOrg  "Pumpkin, carrots, sweet red peppers, squash or sweet potatoes that are yellow or orange inside? [any additions to this list should meet “Criteria for defining foods and liquids as ‘sources’ of vitamin A”]".
Variable labels  PCMADStapRoo  "Plantains, white potatoes, white yams, manioc, cassava or [insert other commonly consumed starchy tubers or starchy tuberous roots that are white or pale inside]".
Variable labels  PCMADVegGre  "Dark green leafy vegetables, such as [insert  commonly consumed vitamin A-rich dark green leafy vegetables]?".
Variable labels   PCMADVegOth  "Any other vegetables, such as [insert commonly consumed vegetables]?".
Variable labels   PCMADFruitOrg  "Ripe mangoes or ripe papayas or [insert other commonly consumed vitamin A-rich fruits]?".
Variable labels   PCMADFruitOth  "Any other fruits, such as [insert commonly consumed fruits]?".
Variable labels   PCMADPrMeatO  "Liver, kidney, heart or [insert other commonly consumed organ meats]?".
Variable labels   PCMADPrMeatPro  "Sausages, hot dogs/frankfurters, ham, bacon, salami, canned meat or [insert other commonly consumed processed meats]?".
Variable labels   PCMADPrMeatF  "Any other meat, such as beef, pork, lamb, goat, chicken, duck or [insert other commonly consumed meat]?".
Variable labels  PCMADPrEgg  "Eggs".
Variable labels   PCMADPrFish  "Fresh or dried fish, shellfish or seafood".
Variable labels   PCMADPulse  "Beans, peas, lentils, nuts , seeds or [insert commonly consumed foods made from beans, peas, lentils, nuts, or seeds]?".
Variable labels   PCMADCheese  "Hard or soft cheese such as [insert commonly consumed types of cheese]?".
Variable labels   PCMADSnf  "Specialized Nutritious Foods (SNF) such as [insert the SNFs distributed by WFP]?".
Variable labels   PCMADMeals  "How many times did ${PCMADChildName}  eat any solid, semi -solid or soft foods yesterday during the day or night?" .

Value labels PCMADBreastfeed,PCMADInfFormula,PCMADMilk,PCMADYogurtDrink, PCMADYogurt,PCMADStapCer,PCMADVegOrg,PCMADStapRoo,PCMADVegGre,PCMADVegOth,PCMADFruitOrg,
    PCMADFruitOth,PCMADPrMeatO,PCMADPrMeatPro,PCMADPrMeatF,PCMADPrEgg,PCMADPrFish,PCMADPulse,PCMADCheese,PCMADSnf 1 "Yes" 0  "No" 888 "Don't know".
    
 *Creat Minimum Dietary Diversity 6-23 months (MDD)
* for population assesments - SNF is counted in cereals group (MDD)
*for WFP programme monitoring - SNF is counted in meats group (MDD_wfp)

*this version of MDD is for population assessments - SNF is counted in cereals group

Compute MAD_BreastMilk  = 0.
if  PCMADBreastfeed = 1 MAD_BreastMilk  = 1.
Compute MAD_PWMDDWStapCer  = 0.
if  PCMADStapCer = 1 | PCMADStapRoo = 1  | PCMADSnf = 1 MAD_PWMDDWStapCer= 1.
Compute MAD_PulsesNutsSeeds  = 0.
if  PCMADPulse =  1 MAD_PulsesNutsSeeds = 1.
Compute MAD_Dairy   = 0.
if  PCMADInfFormula = 1 | PCMADMilk = 1 | PCMADYogurtDrink = 1 | PCMADYogurt = 1 | PCMADCheese = 1 MAD_Dairy= 1.
Compute MAD_MeatFish   = 0.
if  PCMADPrMeatO = 1 |  PCMADPrMeatPro = 1 | PCMADPrMeatF = 1 | PCMADPrFish = 1 MAD_MeatFish= 1.
Compute MAD_Eggs   = 0.
if PCMADPrEgg = 1 MAD_Eggs = 1.
Compute MAD_VitA   = 0.
if  PCMADVegOrg = 1 | PCMADVegGre = 1 | PCMADFruitOrg = 1 MAD_VitA = 1.
Compute  MAD_OtherVegFruits  = 0.
if   PCMADFruitOth = 1 | PCMADVegOth = 1 MAD_OtherVegFruits= 1.

*add together food groups to see how many food groups consumed

compute MDD_score = sum(MAD_BreastMilk,MAD_PWMDDWStapCer,MAD_PulsesNutsSeeds,MAD_Dairy,MAD_MeatFish,MAD_Eggs,MAD_VitA,MAD_OtherVegFruits).

*create MDD variable which records whether child consumed five or more food groups

Compute  MDD = 0.
if (MDD_score >= 5) MDD = 1.
Variable labels MDD "Minimum Dietary Diversity (MDD)".
Value labels  MDD 1 'Meets MDD' 0  'Does not meet MDD'.

*this version of MDD for WFP programme monitoring - SNF is counted in meats group

Compute MAD_BreastMilk_wfp  = 0.
if  PCMADBreastfeed = 1 MAD_BreastMilk_wfp  = 1.
Compute MAD_PWMDDWStapCer_wfp  = 0.
if  PCMADStapCer = 1 | PCMADStapRoo = 1   MAD_PWMDDWStapCer_wfp= 1.
Compute MAD_PulsesNutsSeeds_wfp  = 0.
if  PCMADPulse =  1 MAD_PulsesNutsSeeds_wfp = 1.
Compute MAD_Dairy_wfp   = 0.
if  PCMADInfFormula = 1 | PCMADMilk = 1 | PCMADYogurtDrink = 1 | PCMADYogurt = 1 | PCMADCheese = 1 MAD_Dairy_wfp= 1.
Compute MAD_MeatFish_wfp   = 0.
if  PCMADPrMeatO = 1 |  PCMADPrMeatPro = 1 | PCMADPrMeatF = 1 | PCMADPrFish = 1 | PCMADSnf = 1 MAD_MeatFish_wfp= 1.
Compute MAD_Eggs_wfp   = 0.
if PCMADPrEgg = 1 MAD_Eggs_wfp = 1.
Compute MAD_VitA_wfp   = 0.
if  PCMADVegOrg = 1 | PCMADVegGre = 1 | PCMADFruitOrg = 1 MAD_VitA_wfp = 1.
Compute  MAD_OtherVegFruits_wfp  = 0.
if   PCMADFruitOth = 1 | PCMADVegOth = 1 MAD_OtherVegFruits_wfp= 1.

*add together food groups to see how many food groups consumed

compute MDD_score_wfp = sum(MAD_BreastMilk_wfp,MAD_PWMDDWStapCer_wfp,MAD_PulsesNutsSeeds_wfp,MAD_Dairy_wfp,MAD_MeatFish_wfp,MAD_Eggs_wfp,MAD_VitA_wfp,MAD_OtherVegFruits_wfp).

*create MDD variable which records whether child consumed five or more food groups

Compute  MDD_wfp = 0.
if (MDD_score_wfp >= 5) MDD_wfp = 1.
Variable labels MDD_wfp "Minimum Dietary Diversity for WFP program monitoring (MDD)".
Value labels  MDD_wfp 1 'Meets MDD' 0  'Does not meet MDD'.

*Calculate Minimum Meal Frequency 6-23 months (MMF) 
*Recode into new variables turning dont know and missing valules into 0  - this makes syntax for calculation simpler

RECODE PCMADBreastfeed (1=1) (ELSE=0) INTO PCMADBreastfeed_yn.
RECODE PCMADMeals (1 thru 7=Copy) (ELSE=0) INTO PCMADMeals_r.
RECODE PCMADInfFormulaNum (1 thru 7=Copy) (ELSE=0) INTO PCMADInfFormulaNum_r.
RECODE PCMADMilkNum (1 thru 7=Copy) (ELSE=0) INTO PCMADMilkNum_r.
RECODE PCMADYogurtDrinkNum (1 thru 7=Copy) (ELSE=0) INTO PCMADYogurtDrinkNum_r.

Compute MMF = 0.
if PCMADBreastfeed_yn = 1 & (PCMADChildAge_months >= 6 & PCMADChildAge_months <= 8) & PCMADMeals_r >= 2 MMF = 1.
if PCMADBreastfeed_yn = 1 & (PCMADChildAge_months >= 9 & PCMADChildAge_months <= 23) & PCMADMeals_r >= 3 MMF = 1.
if PCMADBreastfeed_yn = 0 & PCMADMeals_r >= 1 & (PCMADMeals_r + PCMADInfFormulaNum_r + PCMADMilkNum_r + PCMADYogurtDrinkNum_r >= 4) MMF = 1.

Variable labels MDD_wfp "Minimum Meal Frequency (MMF)".
Value labels  MDD_wfp 1 'Meets MMF' 0  'Does not meet MMF'.

*Calculate Minimum Milk Feeding Frequency for non-breastfed children 6-23 months (MMFF) 

Compute MMFF = 0.
 if PCMADBreastfeed_yn = 0 & (PCMADInfFormulaNum_r + PCMADMilkNum_r + PCMADYogurtDrinkNum_r >= 2) MMFF = 1.

Variable labels MMFF "Minimum Milk Feeding Frequency for non-breastfed children (MMFF)".
Value labels  MMFF 1 'Meets MMFF' 0  'Does not meet MMFF'.


* Minimum Acceptable Diet (MAD)

* For breastfed infants: if MDD and MMF are both achieved, then MAD is achieved
* For nonbreastfed infants: if MDD, MMF and MMFF are all achieved, then MAD is achieved


* using MDD for population assesments

Compute MAD = 0.
if PCMADBreastfeed_yn = 1 & MDD = 1 & MMF = 1 MAD = 1.
if PCMADBreastfeed_yn = 0 & MDD = 1 & MMF = 1 & MMFF = 1 MAD = 1.


* using MDD for WFP program monitoring

Compute MAD  = 0.
Compute MAD = 0.
if PCMADBreastfeed_yn = 1 & MDD_wfp = 1 & MMF = 1 MAD = 1.
if PCMADBreastfeed_yn = 0 & MDD_wfp = 1 & MMF = 1 & MMFF = 1 MAD = 1.


Variable labels MAD "Minimum Acceptable Diet (MAD)".
Value labels  MAD 1 'Meets MAD' 0  'Does not meet MAD'.

freq MAD.



