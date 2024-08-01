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

Variable labels PSchoolAgeDDSStapCer "Foods made from grains".
Variable labels PSchoolAgeDDSStapRoo "White roots and tubers or plantains".
Variable labels PSchoolAgeDDSPulse "Pulses (beans, peas and lentils)".
Variable labels PSchoolAgeDDSNuts "Nuts and seeds".
Variable labels PSchoolAgeDDSMilk "Milk".
Variable labels PSchoolAgeDDSDairy "Milk products".
Variable labels PSchoolAgeDDSPrMeatO "Organ meats".
Variable labels PSchoolAgeDDSPrMeatF "Red flesh meat from mammals".
Variable labels PSchoolAgeDDSPrMeatPro "Processed meat".
Variable labels PSchoolAgeDDSPrMeatWhite "Poultry and other white meats".
Variable labels PSchoolAgeDDSPrFish "Fish and Seafood".
Variable labels PSchoolAgeDDSPrEgg "Eggs from poultry or any other bird".
Variable labels PSchoolAgeDDSVegGre "Dark green leafy vegetables".
Variable labels PSchoolAgeDDSVegOrg "Vitamin A-rich vegetables, roots and tubers".
Variable labels PSchoolAgeDDSFruitOrg "Vitamin A-rich fruits".
Variable labels PSchoolAgeDDSVegOth "Other vegetables".
Variable labels PSchoolAgeDDSFruitOth "Other fruits".
Variable labels PSchoolAgeDDSSnf "Specialized Nutritious Foods (SNF) for women".
Variable labels PSchoolAgeDDSFortFoodoil "Fortified oil".
Variable labels PSchoolAgeDDSFortFoodwflour "Fortified wheat flour".
Variable labels PSchoolAgeDDSFortFoodmflour "Fortified maize flour".
Variable labels PSchoolAgeDDSFortFoodrice "Fortified Rice".
Variable labels PSchoolAgeDDSFortFooddrink "Fortified drink".
Variable labels PSchoolAgeDDSFortFoodother "Other fortified food".
Variable labels PSchoolAgeDDSFortFoodother_oth "Other fortified food (specify)".

Value labels PSchoolAgeDDSStapCer PSchoolAgeDDSStapRoo PSchoolAgeDDSPulse PSchoolAgeDDSNuts PSchoolAgeDDSMilk PSchoolAgeDDSDairy PSchoolAgeDDSPrMeatO PSchoolAgeDDSPrMeatF PSchoolAgeDDSPrMeatPro PSchoolAgeDDSPrMeatWhite PSchoolAgeDDSPrFish PSchoolAgeDDSPrEgg PSchoolAgeDDSVegGre PSchoolAgeDDSVegOrg PSchoolAgeDDSFruitOrg PSchoolAgeDDSVegOth PSchoolAgeDDSFruitOth PSchoolAgeDDSSnf PSchoolAgeDDSFortFoodoil PSchoolAgeDDSFortFoodwflour PSchoolAgeDDSFortFoodmflour PSchoolAgeDDSFortFoodrice PSchoolAgeDDSFortFooddrink PSchoolAgeDDSFortFoodother 0 'No' 1 'Yes'.

*------------------------------------------------------------------------------
* Calculate Food Groups
*------------------------------------------------------------------------------

COMPUTE PSchoolAgeDDS_Staples_wfp = 0.
IF ((PSchoolAgeDDSStapCer = 1) | (PSchoolAgeDDSStapRoo = 1) | (PSchoolAgeDDSFortFoodwflour = 1) | (PSchoolAgeDDSFortFoodmflour = 1) | (PSchoolAgeDDSFortFoodrice = 1) | (PSchoolAgeDDSFortFooddrink = 1)) PSchoolAgeDDS_Staples_wfp = 1.
EXECUTE.

COMPUTE PSchoolAgeDDS_Pulses_wfp = 0.
IF (PSchoolAgeDDSPulse = 1) PSchoolAgeDDS_Pulses_wfp = 1.
EXECUTE.

COMPUTE PSchoolAgeDDS_NutsSeeds_wfp = 0.
IF (PSchoolAgeDDSNuts = 1) PSchoolAgeDDS_NutsSeeds_wfp = 1.
EXECUTE.

COMPUTE PSchoolAgeDDS_Dairy_wfp = 0.
IF ((PSchoolAgeDDSDairy = 1) | (PSchoolAgeDDSMilk = 1)) PSchoolAgeDDS_Dairy_wfp = 1.
EXECUTE.

COMPUTE PSchoolAgeDDS_MeatFish_wfp = 0.
IF ((PSchoolAgeDDSPrMeatO = 1) | (PSchoolAgeDDSPrMeatF = 1) | (PSchoolAgeDDSPrMeatPro = 1) | (PSchoolAgeDDSPrMeatWhite = 1) | (PSchoolAgeDDSPrFish = 1) | (PSchoolAgeDDSSnf = 1)) PSchoolAgeDDS_MeatFish_wfp = 1.
EXECUTE.

COMPUTE PSchoolAgeDDS_Eggs_wfp = 0.
IF (PSchoolAgeDDSPrEgg = 1) PSchoolAgeDDS_Eggs_wfp = 1.
EXECUTE.

COMPUTE PSchoolAgeDDS_LeafGreenVeg_wfp = 0.
IF (PSchoolAgeDDSVegGre = 1) PSchoolAgeDDS_LeafGreenVeg_wfp = 1.
EXECUTE.

COMPUTE PSchoolAgeDDS_VitA_wfp = 0.
IF ((PSchoolAgeDDSVegOrg = 1) | (PSchoolAgeDDSFruitOrg = 1)) PSchoolAgeDDS_VitA_wfp = 1.
EXECUTE.

COMPUTE PSchoolAgeDDS_OtherVeg_wfp = 0.
IF (PSchoolAgeDDSVegOth = 1) PSchoolAgeDDS_OtherVeg_wfp = 1.
EXECUTE.

COMPUTE PSchoolAgeDDS_OtherFruits_wfp = 0.
IF (PSchoolAgeDDSFruitOth = 1) PSchoolAgeDDS_OtherFruits_wfp = 1.
EXECUTE.

*------------------------------------------------------------------------------
* Calculate Dietary Diversity Score
*------------------------------------------------------------------------------

COMPUTE SchoolAgeDDS_wfp = sum(PSchoolAgeDDS_Staples_wfp, PSchoolAgeDDS_Pulses_wfp, PSchoolAgeDDS_NutsSeeds_wfp, PSchoolAgeDDS_Dairy_wfp, PSchoolAgeDDS_MeatFish_wfp, PSchoolAgeDDS_Eggs_wfp, PSchoolAgeDDS_LeafGreenVeg_wfp, PSchoolAgeDDS_VitA_wfp, PSchoolAgeDDS_OtherVeg_wfp, PSchoolAgeDDS_OtherFruits_wfp).
EXECUTE.

*------------------------------------------------------------------------------
* Classify Dietary Diversity Score
*------------------------------------------------------------------------------

COMPUTE SchoolAgeDDS_5_wfp = 0.
IF (SchoolAgeDDS_wfp >= 5) SchoolAgeDDS_5_wfp = 1.
VALUE LABELS SchoolAgeDDS_5_wfp 1 '>=5' 0 '<5'.

*------------------------------------------------------------------------------
* Frequency of WFP DDS Method for Program Monitoring
*------------------------------------------------------------------------------

FREQUENCIES VARIABLES=SchoolAgeDDS_5_wfp.

* End of Scripts