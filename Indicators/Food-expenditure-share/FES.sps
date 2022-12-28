﻿* Encoding: UTF-8.
********************************************************************************
 * SPSS Syntax for the Food Expenditure Share (FES) indicator
 *******************************************************************************
 
*Important note: the value of consumed in-kind assistance/gifts should be considered in the calculation of FES for both assessment exercises as well as monitoring exercises  
 
*-------------------------------------------------------------------------------*
*1. Create variables for food expenditure, by source	
*-------------------------------------------------------------------------------*

*Important note: add recall period of _7D or _1M to the variables names below depending on what has been selected for your CO. It is recommended to follow standard recall periods as in the module.

*** 1.a Label variables: 

VARIABLE LABELS
 HHExpFCer_Purch_MN_7D 'Expenditures on cereals'
 HHExpFCer_GiftAid_MN_7D 'Value of consumed in-kind assistance and gifts - cereals'
 HHExpFCer_Own_MN_7D 'Value of consumed own production - cereals'
 HHExpFTub_Purch_MN_7D 'Expenditures on tubers'
 HHExpFTub_GiftAid_MN_7D 'Value of consumed in-kind assistance and gifts - tubers'
 HHExpFTub_Own_MN_7D 'Value of consumed own production - tubers'
 HHExpFPuls_Purch_MN_7D 'Expenditures on pulses & nuts'
 HHExpFPuls_GiftAid_MN_7D 'Value of consumed in-kind assistance and gifts - pulses and nuts'
 HHExpFPuls_Own_MN_7D 'Value of consumed own production - pulses & nuts'
 HHExpFVeg_Purch_MN_7D 'Expenditures on vegetables'
 HHExpFVeg_GiftAid_MN_7D 'Value of consumed in-kind assistance and gifts - vegetables'
 HHExpFVeg_Own_MN_7D 'Value of consumed own production - vegetables'
 HHExpFFrt_Purch_MN_7D 'Expenditures on fruits'
 HHExpFFrt_GiftAid_MN_7D 'Value of consumed in-kind assistance and gifts - fruits'
 HHExpFFrt_Own_MN_7D 'Value of consumed own production - fruits'
 HHExpFAnimMeat_Purch_MN_7D 'Expenditures on meat'
 HHExpFAnimMeat_GiftAid_MN_7D 'Value of consumed in-kind assistance and gifts - meat'
 HHExpFAnimMeat_Own_MN_7D 'Value of consumed own production - meat'
 HHExpFAnimFish_Purch_MN_7D 'Expenditures on fish'
 HHExpFAnimFish_GiftAid_MN_7D 'Value of consumed in-kind assistance and gifts - fish'
 HHExpFAnimFish_Own_MN_7D 'Value of consumed own production - fish'
 HHExpFFats_Purch_MN_7D 'Expenditures on fats'
 HHExpFFats_GiftAid_MN_7D 'Value of consumed in-kind assistance and gifts - fats'
 HHExpFFats_Own_MN_7D 'Value of consumed own production - fats'
 HHExpFDairy_Purch_MN_7D 'Expenditures on milk/dairy products'
 HHExpFDairy_GiftAid_MN_7D 'Value of consumed in-kind assistance and gifts - milk/dairy products'
 HHExpFDairy_Own_MN_7D 'Value of consumed own production - milk/dairy products'
 HHExpFEgg_Purch_MN_7D 'Expenditures on eggs'
 HHExpFEgg_GiftAid_MN_7D 'Value of consumed in-kind assistance and gifts - eggs'
 HHExpFEgg_Own_MN_7D 'Value of consumed own production - eggs'
 HHExpFSgr_Purch_MN_7D 'Expenditures on sugar/confectionery/desserts'
 HHExpFSgr_GiftAid_MN_7D 'Value of consumed in-kind assistance and gifts - sugar/confectionery/desserts'
 HHExpFSgr_Own_MN_7D 'Value of consumed own production - sugar/confectionery/desserts'
 HHExpFCond_Purch_MN_7D 'Expenditures on condiments'
 HHExpFCond_GiftAid_MN_7D 'Value of consumed in-kind assistance and gifts - condiments'
 HHExpFCond_Own_MN_7D 'Value of consumed own production - condiments'
 HHExpFBev_Purch_MN_7D 'Expenditures on beverages'
 HHExpFBev_GiftAid_MN_7D 'Value of consumed in-kind assistance and gifts - beverages'
 HHExpFBev_Own_MN_7D 'Value of consumed own production - beverages'
 HHExpFOut_Purch_MN_7D 'Expenditures on snacks/meals prepared outside'
 HHExpFOut_GiftAid_MN_7D 'Value of consumed in-kind assistance and gifts - snacks/meals prepared outside'
 HHExpFOut_Own_MN_7D 'Value of consumed own production - snacks/meals prepared outside'.
EXECUTE.

* If the questionnaire included further food categories/items label the respective variables


*** 1.b Calculate total value of food expenditures/consumption by source

*If the expenditure recall period is 7 days; make sure to express the newly created variables in monthly terms by multiplying by 30/7

*Monthly food expenditures in cash/credit

COMPUTE  HHExp_Food_Purch_MN_1M=SUM(HHExpFCer_Purch_MN_7D, HHExpFTub_Purch_MN_7D, HHExpFPuls_Purch_MN_7D, + 
    HHExpFVeg_Purch_MN_7D, HHExpFFrt_Purch_MN_7D,  HHExpFAnimMeat_Purch_MN_7D, HHExpFAnimFish_Purch_MN_7D, HHExpFFats_Purch_MN_7D, +
     HHExpFDairy_Purch_MN_7D, HHExpFEgg_Purch_MN_7D, HHExpFSgr_Purch_MN_7D, HHExpFCond_Purch_MN_7D, HHExpFBev_Purch_MN_7D, HHExpFOut_Purch_MN_7D).
COMPUTE HHExp_Food_Purch_MN_1M=HHExp_Food_Purch_MN_1M*(30/7).  /* conversion in monthly terms - do it only if recall period for food was 7 days.
 VARIABLE LABELS HHExp_Food_Purch_MN_1M 'Total monthly food expenditure (cash and credit)'.
EXECUTE.

*Monthly value of consumed food from gift/aid

COMPUTE HHExp_Food_GiftAid_MN_1M=SUM(HHExpFCer_GiftAid_MN_7D, HHExpFTub_GiftAid_MN_7D, HHExpFPuls_GiftAid_MN_7D, + 
HHExpFVeg_GiftAid_MN_7D, HHExpFFrt_GiftAid_MN_7D, HHExpFAnimMeat_GiftAid_MN_7D, HHExpFAnimFish_GiftAid_MN_7D, HHExpFFats_GiftAid_MN_7D, + 
HHExpFDairy_GiftAid_MN_7D, HHExpFEgg_GiftAid_MN_7D, HHExpFSgr_GiftAid_MN_7D, HHExpFCond_GiftAid_MN_7D, HHExpFBev_GiftAid_MN_7D, HHExpFOut_GiftAid_MN_7D).
COMPUTE HHExp_Food_GiftAid_MN_1M=HHExp_Food_GiftAid_MN_1M*(30/7). /*conversion in monthly terms - do it only if recall period for food was 7 days.
 VARIABLE LABELS  HHExp_Food_GiftAid_MN_1M 'Total monthly food consumption from gifts/aid'.
EXECUTE.

*Monthly value of consumed food from own-production

COMPUTE HHExp_Food_Own_MN_1M=SUM(HHExpFCer_Own_MN_7D, HHExpFTub_Own_MN_7D, HHExpFPuls_Own_MN_7D, + 
HHExpFVeg_Own_MN_7D, HHExpFFrt_Own_MN_7D, HHExpFAnimMeat_Own_MN_7D, HHExpFAnimFish_Own_MN_7D, HHExpFFats_Own_MN_7D, + 
 HHExpFDairy_Own_MN_7D, HHExpFEgg_Own_MN_7D, HHExpFSgr_Own_MN_7D, HHExpFCond_Own_MN_7D, HHExpFBev_Own_MN_7D, HHExpFOut_Own_MN_7D).
COMPUTE HHExp_Food_Own_MN_1M=HHExp_Food_Own_MN_1M*(30/7). /* conversion in monthly terms - do it only if recall period for food was 7 day.
 VARIABLE LABELS HHExp_Food_Own_MN_1M 'Total monthly food consumption from own-production'.
EXECUTE.


*-------------------------------------------------------------------------------*
*2. Create variables for non-food expenditure, by source	
*-------------------------------------------------------------------------------*

*** 2.a Label variables: 

*1 month recall period - variables labels.
VARIABLE LABELS
 HHExpNFHyg_Purch_MN_1M  'Expenditures on hygiene'
 HHExpNFHyg_GiftAid_MN_1M 'Value of consumed in-kind assistance-gifts - hygiene'
 HHExpNFTransp_Purch_MN_1M 'Expenditures on transport'
 HHExpNFTransp_GiftAid_MN_1M 'Value of consumed in-kind assistance-gifts - transport'
 HHExpNFFuel_Purch_MN_1M 'Expenditures on fuel'
 HHExpNFFuel_GiftAid_MN_1M 'Value of consumed in-kind assistance-gifts - fuel'
 HHExpNFWat_Purch_MN_1M 'Expenditures on water'
 HHExpNFWat_GiftAid_MN_1M 'Value of consumed in-kind assistance-gifts - water'
 HHExpNFElec_Purch_MN_1M 'Expenditures on electricity'
 HHExpNFElec_GiftAid_MN_1M 'Value of consumed in-kind assistance-gifts - electricity'
 HHExpNFEnerg_Purch_MN_1M 'Expenditures on energy (not electricity)'
 HHExpNFEnerg_GiftAid_MN_1M 'Value of consumed in-kind assistance-gifts - energy (not electricity)'
 HHExpNFDwelSer_Purch_MN_1M 'Expenditures on services related to dwelling'
 HHExpNFDwelSer_GiftAid_MN_1M 'Value of consumed in-kind assistance-gifts - services related to dwelling'
 HHExpNFPhone_Purch_MN_1M 'Expenditures on communication'
 HHExpNFPhone_GiftAid_MN_1M 'Value of consumed in-kind assistance-gifts - communication'
 HHExpNFRecr_Purch_MN_1M 'Expenditures on recreation'
 HHExpNFRecr_GiftAid_MN_1M 'Value of consumed in-kind assistance-gifts - recreation'
 HHExpNFAlcTobac_Purch_MN_1M 'Expenditures on alchol/tobacco'
 HHExpNFAlcTobac_GiftAid_MN_1M 'Value of consumed in-kind assistance-gifts - alchol/tobacco'.
EXECUTE.
* If the questionnaire included further non-food categories/items label the respective variables

*6 months recall period - variables lables.
VARIABLE LABELS
 HHExpNFMedServ_Purch_MN_6M 'Expenditures on health services'
 HHExpNFMedServ_GiftAid_MN_6M 'Value of consumed in-kind assistance-gifts - health services'
 HHExpNFMedGood_Purch_MN_6M 'Expenditures on medicines and health products'
 HHExpNFMedGood_GiftAid_MN_6M 'Value of consumed in-kind assistance-gifts - medicines and health products'
 HHExpNFCloth_Purch_MN_6M 'Expenditures on clothing and footwear'
 HHExpNFCloth_GiftAid_MN_6M 'Value of consumed in-kind assistance-gifts - clothing and footwear'
 HHExpNFEduFee_Purch_MN_6M 'Expenditures on education services'
 HHExpNFEduFee_GiftAid_MN_6M 'Value of consumed in-kind assistance-gifts - education services'
 HHExpNFEduGood_Purch_MN_6M 'Expenditures on education goods'
 HHExpNFEduGood_GiftAid_MN_6M 'Value of consumed in-kind assistance-gifts - education goods'
 HHExpNFRent_Purch_MN_6M 'Expenditures on rent'
 HHExpNFRent_GiftAid_MN_6M 'Value of consumed in-kind assistance-gifts - rent'
 HHExpNFHHSoft_Purch_MN_6M 'Expenditures on non-durable furniture/utensils'
 HHExpNFHHSoft_GiftAid_MN_6M 'Value of consumed in-kind assistance-gifts - non-durable furniture/utensils'
 HHExpNFHHMaint_Purch_MN_6M 'Expenditures on household routine maintenance'
 HHExpNFHHMaint_GiftAid_MN_6M 'Value of consumed in-kind assistance-gifts - household routine maintenance'.
EXECUTE.
* If the questionnaire included further non-food categories/items label the respective variables.

*** 2.b Calculate total value of non-food expenditures/consumption by source

** Total non-food expenditure (cash/credit)

* 30 days recall.
COMPUTE HHExpNFTotal_Purch_MN_30D=SUM(HHExpNFHyg_Purch_MN_1M, HHExpNFTransp_Purch_MN_1M, HHExpNFFuel_Purch_MN_1M, + 
 HHExpNFWat_Purch_MN_1M, HHExpNFElec_Purch_MN_1M, HHExpNFEnerg_Purch_MN_1M, HHExpNFDwelSer_Purch_MN_1M, HHExpNFPhone_Purch_MN_1M, HHExpNFRecr_Purch_MN_1M, HHExpNFAlcTobac_Purch_MN_1M).
EXECUTE.

* 6 months recall.
COMPUTE HHExpNFTotal_Purch_MN_6M=SUM(HHExpNFMedServ_Purch_MN_6M, HHExpNFMedGood_Purch_MN_6M, HHExpNFCloth_Purch_MN_6M, + 
HHExpNFEduFee_Purch_MN_6M, HHExpNFEduGood_Purch_MN_6M, HHExpNFRent_Purch_MN_6M, HHExpNFHHSoft_Purch_MN_6M, HHExpNFHHMaint_Purch_MN_6M). /* careful with rent: should include only if also incuded in MEB.
EXECUTE.

* Express 6 months in monthly terms.
COMPUTE HHExpNFTotal_Purch_MN_6M=HHExpNFTotal_Purch_MN_6M/6.
EXECUTE.

* Sum.
COMPUTE HHExpNFTotal_Purch_MN_1M=SUM(HHExpNFTotal_Purch_MN_30D, HHExpNFTotal_Purch_MN_6M).
EXECUTE.
 VARIABLE LABELS HHExpNFTotal_Purch_MN_1M 'Total monthly non-food expenditure (cash and credit)'.

delete variables HHExpNFTotal_Purch_MN_6M HHExpNFTotal_Purch_MN_30D.
EXECUTE.

** Total value of consumed non-food from gift/aid

* 30 days recall.
COMPUTE HHExpNFTotal_GiftAid_MN_30D=SUM(HHExpNFHyg_GiftAid_MN_1M, HHExpNFTransp_GiftAid_MN_1M, HHExpNFFuel_GiftAid_MN_1M,+
 HHExpNFWat_GiftAid_MN_1M, HHExpNFElec_GiftAid_MN_1M, HHExpNFEnerg_GiftAid_MN_1M, HHExpNFDwelSer_GiftAid_MN_1M, HHExpNFPhone_GiftAid_MN_1M, HHExpNFRecr_GiftAid_MN_1M, HHExpNFAlcTobac_GiftAid_MN_1M).
EXECUTE.

* 6 months recall.
COMPUTE HHExpNFTotal_GiftAid_MN_6M=SUM(HHExpNFMedServ_GiftAid_MN_6M, HHExpNFMedGood_GiftAid_MN_6M, HHExpNFCloth_GiftAid_MN_6M, +
 HHExpNFEduFee_GiftAid_MN_6M, HHExpNFEduGood_GiftAid_MN_6M, HHExpNFRent_GiftAid_MN_6M, HHExpNFHHSoft_GiftAid_MN_6M, HHExpNFHHMaint_GiftAid_MN_6M). /* careful with rent: should include only if also incuded in MEB.
EXECUTE.

* Express 6 months in monthly terms.
COMPUTE HHExpNFTotal_GiftAid_MN_6M=HHExpNFTotal_GiftAid_MN_6M/6.
EXECUTE.

* Sum.
COMPUTE HHExpNFTotal_GiftAid_MN_1M=SUM(HHExpNFTotal_GiftAid_MN_30D, HHExpNFTotal_GiftAid_MN_6M).
 VARIABLE LABELS HHExpNFTotal_GiftAid_MN_1M 'Total monthly non-food consumption from gifts/aid'.
 EXECUTE.

delete variables HHExpNFTotal_GiftAid_MN_6M HHExpNFTotal_GiftAid_MN_30D.
EXECUTE.

*-------------------------------------------------------------------------------*
*3.Calculate total food and non-food consumption expenditures
*-------------------------------------------------------------------------------*

* Aggregate food expenditures, value of consumed food from gifts/assistance, and value of consumed food from own production.
COMPUTE HHExpF_1M=SUM(HHExp_Food_Purch_MN_1M,HHExp_Food_GiftAid_MN_1M, HHExp_Food_Own_MN_1M).
EXECUTE.

*Aggregate NF expenditures and value of consumed non-food from gifts/assistance. 
COMPUTE HHExpNF_1M=SUM(HHExpNFTotal_Purch_MN_1M, HHExpNFTotal_GiftAid_MN_1M).
EXECUTE.
    
*-------------------------------------------------------------------------------*
*4.Compute FES
*-------------------------------------------------------------------------------*

COMPUTE FES= HHExpF_1M /SUM(HHExpF_1M , HHExpNF_1M).
EXECUTE.

VARIABLE LABELS FES 'Household food expenditure share'.
EXECUTE.

RECODE FES (Lowest thru .4999999=1) (.50 thru .64999999=2) (.65 thru .74999999=3) (.75 thru Highest=4) 
    into Foodexp_4pt.
EXECUTE.


Value labels Foodexp_4pt 1 '<50%' 2 '50-65%' 3 '65-75%' 4' > 75%'.

Variable labels Foodexp_4pt 'Food expenditure share categories'.
EXECUTE.

FREQUENCIES Foodexp_4pt.
    


