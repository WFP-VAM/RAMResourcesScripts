*** --------------------------------------------------------------------------
***	                          WFP Standardized Scripts
***             Calculating Minimum Dietary Diversity for Women (MDDW)
*** --------------------------------------------------------------------------

* Encoding: UTF-8.

*can only download repeat csv data as zip file from moda with group names - will update this code to remove group names
*rename to remove group names - because of the variable length SPSS changes name slightly

RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWStapCer = PWMDDWStapCer).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWStapRoo = PWMDDWStapRoo).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWPulse = PWMDDWPulse).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWNuts = PWMDDWNuts).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWMilk = PWMDDWMilk).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWDairy = PWMDDWDairy).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWPrMeatO = PWMDDWPrMeatO).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWPrMeatF = PWMDDWPrMeatF).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWPrMeatPro = PWMDDWPrMeatPro).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWPrMeatWhite = PWMDDWPrMeatWhite).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWPrFish = PWMDDWPrFish).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWPrEgg = PWMDDWPrEgg).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWVegGre = PWMDDWVegGre).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWVegOrg = PWMDDWVegOrg).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWFruitOrg = PWMDDWFruitOrg).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWVegOth = PWMDDWVegOth).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWFruitOth = PWMDDWFruitOth).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWSnf = PWMDDWSnf).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWFortFoodoil = PWMDDWFortFoodoil).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWFortFoodwflour = PWMDDWFortFoodwflour).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWFortFoodmflour = PWMDDWFortFoodmflour).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWFortFoodrice = PWMDDWFortFoodrice).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWFortFooddrink = PWMDDWFortFooddrink).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWFortFoodother_A = PWMDDWFortFoodother).
RENAME VARIABLES (Nutrition_moduleMDD_W_submoduleRepeatMDDWPWMDDWFortFoodother = PWMDDWFortFoodother_oth).

Variable labels PWMDDWStapCer  "Foods made from grains".
Variable labels PWMDDWStapRoo "White roots and tubers or plantains".
Variable labels PWMDDWPulse  "Pulses (beans, peas and lentils)".
Variable labels PWMDDWNuts "Nuts and seeds".
Variable labels PWMDDWMilk "Milk".
Variable labels PWMDDWDairy "Milk products".
Variable labels PWMDDWPrMeatO  "Organ meats".
Variable labels PWMDDWPrMeatF  "Red flesh meat from mammals".
Variable labels PWMDDWPrMeatPro  "Processed meat".
Variable labels PWMDDWPrMeatWhite  "Poultry and other white meats".
Variable labels PWMDDWPrFish "Fish and Seafood".
Variable labels PWMDDWPrEgg  "Eggs from poultry or any other bird".
Variable labels PWMDDWVegGre "Dark green leafy vegetable".
Variable labels PWMDDWVegOrg "Vitamin A-rich vegetables, roots and tubers".
Variable labels PWMDDWFruitOrg "Vitamin A-rich fruits".
Variable labels PWMDDWVegOth "Other vegetables".
Variable labels PWMDDWFruitOth  "Other fruits".
Variable labels PWMDDWSnf "Specialized Nutritious Foods (SNF) for women".
Variable labels PWMDDWFortFoodoil  "Fortified oil".
Variable labels PWMDDWFortFoodwflour "Fortified wheat flour".
Variable labels PWMDDWFortFoodmflour  "Fortified maize flour".
Variable labels PWMDDWFortFoodrice  "Fortified Rice".
Variable labels PWMDDWFortFooddrink "Fortified drink".
Variable labels PWMDDWFortFoodother "Other:".
Variable labels PWMDDWFortFoodother_oth "Other: please specify: ____________".

Value labels PWMDDWStapCer,PWMDDWStapRoo,PWMDDWPulse,PWMDDWNuts,PWMDDWMilk,PWMDDWDairy,PWMDDWPrMeatO,PWMDDWPrMeatF,PWMDDWPrMeatPro,PWMDDWPrMeatWhite,PWMDDWPrFish,
    PWMDDWPrEgg,PWMDDWVegGre,PWMDDWVegOrg,PWMDDWFruitOrg,PWMDDWVegOth,PWMDDWFruitOth,PWMDDWSnf,PWMDDWFortFoodoil,PWMDDWFortFoodwflour,PWMDDWFortFoodmflour,PWMDDWFortFoodrice,PWMDDWFortFooddrink,PWMDDWFortFoodother 1 'Yes' 0  'No '.

*Calculate 2 MDDW indicators based on https://docs.wfp.org/api/documents/WFP-0000140197/download/ pg.8
*Standard MDDW Indicator for population based surveys - counts SNF in home group (refer to https://docs.wfp.org/api/documents/WFP-0000139484/download/ for "home group")
*WFP Modified MDDW  WFP programme monitoring - counts SNF in "Meat, poultry and fish" Category

*Standard MDDW method  - in this example SNF home group will be grains
*in this example all - PWMDDWFortFoodwflour,PWMDDWFortFoodmflour,PWMDDWFortFoodrice,PWMDDWFortFooddrink will also count in grains
*classifying PWMDDWFortFoodother_oth will likely involve classifying line by line 

Compute  MDDW_Staples = 0.
if (PWMDDWStapCer) = 1 |  (PWMDDWStapRoo) = 1 | (PWMDDWSnf = 1) | (PWMDDWFortFoodwflour = 1) | (PWMDDWFortFoodmflour = 1) | (PWMDDWFortFoodrice = 1) | (PWMDDWFortFooddrink = 1)  MDDW_Staples= 1.
compute  MDDW_Pulses = 0.
if (PWMDDWPulse = 1) MDDW_Pulses = 1.
Compute  MDDW_NutsSeeds = 0.
if (PWMDDWNuts = 1) MDDW_NutsSeeds = 1.
Compute MDDW_Dairy = 0.
if (PWMDDWDairy = 1) | (PWMDDWMilk = 1) MDDW_Dairy = 1.
Compute  MDDW_MeatFish = 0.
if (PWMDDWPrMeatO = 1) | (PWMDDWPrMeatF = 1) | (PWMDDWPrMeatPro = 1) | (PWMDDWPrMeatWhite = 1) |  (PWMDDWPrFish = 1) MDDW_MeatFish = 1.
Compute MDDW_Eggs = 0.
if (PWMDDWPrEgg = 1) MDDW_Eggs = 1.
Compute  MDDW_LeafGreenVeg = 0.
if (PWMDDWVegGre = 1) MDDW_LeafGreenVeg = 1.. 
Compute  MDDW_VitA = 0.           
if (PWMDDWVegOrg = 1) | (PWMDDWFruitOrg = 1) MDDW_VitA = 1.
Compute  MDDW_OtherVeg = 0.
if (PWMDDWVegOth = 1) MDDW_OtherVeg = 1. 
Compute  MDDW_OtherFruits = 0.
if (PWMDDWFruitOth = 1) MDDW_OtherFruits = 1.

*WFP MDDW method for program monitoring - SNF will count in the meats group
*in this example all - PWMDDWFortFoodwflour,PWMDDWFortFoodmflour,PWMDDWFortFoodrice,PWMDDWFortFooddrink will also count in grains
*classifying PWMDDWFortFoodother_oth will likely involve classifying line by line 

compute MDDW_Staples_wfp = 0.
if  (PWMDDWStapCer) = 1 |  (PWMDDWStapRoo) = 1 | (PWMDDWFortFoodwflour = 1) | (PWMDDWFortFoodmflour = 1) | (PWMDDWFortFoodrice = 1) | (PWMDDWFortFooddrink = 1)  MDDW_Staples_wfp = 1.
Compute  MDDW_Pulses_wfp = 0.
if (PWMDDWPulse = 1) MDDW_Pulses_wfp = 1. 
Compute  MDDW_NutsSeeds_wfp = 0.
 if (PWMDDWNuts = 1)  MDDW_NutsSeeds_wfp  = 1. 
Compute MDDW_Dairy_wfp = 0.
if (PWMDDWDairy = 1) | (PWMDDWMilk = 1) MDDW_Dairy_wfp = 1. 
Compute  MDDW_MeatFish_wfp = 0.
 if (PWMDDWPrMeatO = 1) | (PWMDDWPrMeatF = 1) | (PWMDDWPrMeatPro = 1) | (PWMDDWPrMeatWhite = 1) |  (PWMDDWPrFish = 1)  | (PWMDDWSnf = 1) MDDW_MeatFish_wfp = 1.
Compute MDDW_Eggs_wfp = 0.
if (PWMDDWPrEgg = 1) MDDW_Eggs_wfp = 1.
compute  MDDW_LeafGreenVeg_wfp = 0.
if (PWMDDWVegGre = 1) MDDW_LeafGreenVeg_wfp = 1 . 
Compute  MDDW_VitA_wfp = 0.
if (PWMDDWVegOrg = 1) | (PWMDDWFruitOrg = 1) MDDW_VitA_wfp= 1.                      
Compute  MDDW_OtherVeg_wfp = 0.
if (PWMDDWVegOth = 1) MDDW_OtherVeg_wfp = 1. 
Compute  MDDW_OtherFruits_wfp = 0.
if (PWMDDWFruitOth = 1) MDDW_OtherFruits_wfp = 1. 

*calculate MDDW variable for both methods by adding together food groups and classifying whether the woman consumed 5 or more food groups

*Standard MDDW method where SNF is counted in grains

compute MDDW = sum(MDDW_Staples ,MDDW_Pulses ,MDDW_NutsSeeds ,MDDW_Dairy ,MDDW_MeatFish ,MDDW_Eggs ,MDDW_LeafGreenVeg ,MDDW_VitA ,MDDW_OtherVeg ,MDDW_OtherFruits).

*count how many women consumed 5 or more groups

Compute  MDDW_5 = 0.
if (MDDW >= 5) MDDW_5 = 1.
Value labels  MDDW_5 1 '>=5' 0  '<5 '.

Value labels  MDDW_5 1 '>=5' 0  '<5 '.

*WFP MDDW method for program monitoring - SNF will count in the meats group
 
compute MDDW_wfp = sum(MDDW_Staples_wfp,MDDW_Pulses_wfp ,MDDW_NutsSeeds_wfp ,MDDW_Dairy_wfp ,MDDW_MeatFish_wfp ,MDDW_Eggs_wfp ,MDDW_LeafGreenVeg_wfp ,MDDW_VitA_wfp ,MDDW_OtherVeg_wfp ,MDDW_OtherFruits_wfp).

*count how many women consumed 5 or more groups

Compute  MDDW_5_wfp = 0.
if (MDDW_wfp >= 5) MDDW_5_wfp = 1.
Value labels  MDDW_5_wfp 1 '>=5' 0  '<5 '.

Value labels  MDDW_5_wfp 1 '>=5' 0  '<5 '.

*Frequency of Standard MDDW Method - MDDW_5 

freq MDDW_5.

*Frequency of WFP MDDW method for program monitoring - MDDW_5_wfp

freq MDDW_5_wfp.

*** End of scripts