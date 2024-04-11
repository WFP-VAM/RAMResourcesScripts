* Encoding: UTF-8.

*this syntax is based on SPSS download version from MoDA 

#Calculate School Age Dietary Diversity Score based on WFP MDDW guidelines https://docs.wfp.org/api/documents/WFP-0000140197/download/ pg.8
#Following the WFP MDDW method for program monitoring - SNF will count in the meats group
#in this example fortified foods PSchoolAgeDDSFortFoodwflour,PSchoolAgeDDSFortFoodmflour,PSchoolAgeDDSFortFoodrice,PSchoolAgeDDSFortFooddrink will also count in grains
#classifying PSchoolAgeDDSFortFoodother_oth will likely involve classifying line by line 

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




#calculate SchoolAge Dietary Diversity Score variable by adding together food groups and classifying whether the child consumed 5 or more food groups

#WFP method for program monitoring - SNF will count in the meats group

COMPUTE SchoolAgeDDS_wfp = sum(PSchoolAgeDDS_Staples_wfp, PSchoolAgeDDS_Pulses_wfp, PSchoolAgeDDS_NutsSeeds_wfp, PSchoolAgeDDS_Dairy_wfp, PSchoolAgeDDS_MeatFish_wfp, PSchoolAgeDDS_Eggs_wfp, PSchoolAgeDDS_LeafGreenVeg_wfp, PSchoolAgeDDS_VitA_wfp, PSchoolAgeDDS_OtherVeg_wfp, PSchoolAgeDDS_OtherFruits_wfp).
EXECUTE.

*count how many women consumed 5 or more groups


Compute  SchoolAgeDDS_5_wfp = 0.
if (SchoolAgeDDS_wfp >= 5) SchoolAgeDDS_5_wfp = 1.
Value labels  SchoolAgeDDS_5_wfp 1 '>=5' 0  '<5 '.

Value labels  SchoolAgeDDS_5_wfp 1 '>=5' 0  '<5 '.


*Frequency of WFP DDS method for program monitoring 

freq SchoolAgeDDS_5_wfp.


