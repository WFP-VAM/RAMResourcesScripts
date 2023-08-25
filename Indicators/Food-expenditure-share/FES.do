********************************************************************************
 * STATA Syntax for the Food Expenditure Share (FES) indicator
 *******************************************************************************
						   
*Important note: the value of consumed in-kind assistance/gifts should be considered in the calculation of FES for both assessment exercises as well as monitoring exercises

*-------------------------------------------------------------------------------*
*1. Create variables for food expenditure, by source	
*-------------------------------------------------------------------------------*
*Important note: add recall period of _7D or _1M to the variables names below depending on what has been selected for your CO. It is recommended to follow standard recall periods as in the module.

*** 1.a Label variables: 
lab var HHExpFCer_Purch_MN_7D "Expenditures on cereals"
lab var HHExpFCer_GiftAid_MN_7D "Value of consumed in-kind assistance and gifts - cereals"
lab var HHExpFCer_Own_MN_7D "Value of consumed own production - cereals"

lab var HHExpFTub_Purch_MN_7D "Expenditures on tubers"
lab var HHExpFTub_GiftAid_MN_7D "Value of consumed in-kind assistance and gifts - tubers"
lab var HHExpFTub_Own_MN_7D "Value of consumed own production - tubers"

lab var HHExpFPuls_Purch_MN_7D "Expenditures on pulses & nuts"
lab var HHExpFPuls_GiftAid_MN_7D "Value of consumed in-kind assistance and gifts - pulses and nuts"
lab var HHExpFPuls_Own_MN_7D "Value of consumed own production - pulses & nuts"

lab var HHExpFVeg_Purch_MN_7D "Expenditures on vegetables"
lab var HHExpFVeg_GiftAid_MN_7D "Value of consumed in-kind assistance and gifts - vegetables"
lab var HHExpFVeg_Own_MN_7D "Value of consumed own production - vegetables"

lab var HHExpFFrt_Purch_MN_7D "Expenditures on fruits"
lab var HHExpFFrt_GiftAid_MN_7D "Value of consumed in-kind assistance and gifts - fruits"
lab var HHExpFFrt_Own_MN_7D "Value of consumed own production - fruits"

lab var HHExpFAnimMeat_Purch_MN_7D "Expenditures on meat"
lab var HHExpFAnimMeat_GiftAid_MN_7D "Value of consumed in-kind assistance and gifts - meat"
lab var HHExpFAnimMeat_Own_MN_7D "Value of consumed own production - meat"

lab var HHExpFAnimFish_Purch_MN_7D "Expenditures on fish"
lab var HHExpFAnimFish_GiftAid_MN_7D "Value of consumed in-kind assistance and gifts - fish"
lab var HHExpFAnimFish_Own_MN_7D "Value of consumed own production - fish"

lab var HHExpFFats_Purch_MN_7D "Expenditures on fats"
lab var HHExpFFats_GiftAid_MN_7D "Value of consumed in-kind assistance and gifts - fats"
lab var HHExpFFats_Own_MN_7D "Value of consumed own production - fats"

lab var HHExpFDairy_Purch_MN_7D "Expenditures on milk/dairy products"
lab var HHExpFDairy_GiftAid_MN_7D "Value of consumed in-kind assistance and gifts - milk/dairy products"
lab var HHExpFDairy_Own_MN_7D "Value of consumed own production - milk/dairy products"

lab var HHExpFEgg_Purch_MN_7D "Expenditures on eggs"
lab var HHExpFEgg_GiftAid_MN_7D "Value of consumed in-kind assistance and gifts - eggs"
lab var HHExpFEgg_Own_MN_7D "Value of consumed own production - eggs"

lab var HHExpFSgr_Purch_MN_7D "Expenditures on sugar/confectionery/desserts"
lab var HHExpFSgr_GiftAid_MN_7D "Value of consumed in-kind assistance and gifts - sugar/confectionery/desserts"
lab var HHExpFSgr_Own_MN_7D "Value of consumed own production - sugar/confectionery/desserts"

lab var HHExpFCond_Purch_MN_7D "Expenditures on condiments"
lab var HHExpFCond_GiftAid_MN_7D "Value of consumed in-kind assistance and gifts - condiments"
lab var HHExpFCond_Own_MN_7D "Value of consumed own production - condiments"

lab var HHExpFBev_Purch_MN_7D "Expenditures on beverages"
lab var HHExpFBev_GiftAid_MN_7D "Value of consumed in-kind assistance and gifts - beverages"
lab var HHExpFBev_Own_MN_7D "Value of consumed own production - beverages"

lab var HHExpFOut_Purch_MN_7D "Expenditures on snacks/meals prepared outside"
lab var HHExpFOut_GiftAid_MN_7D "Value of consumed in-kind assistance and gifts - snacks/meals prepared outside"
lab var HHExpFOut_Own_MN_7D "Value of consumed own production - snacks/meals prepared outside"
* If the questionnaire included further food categories/items label the respective variables

*** 1.b Calculate total value of food expenditures/consumption by source

*If the expenditure recall period is 7 days; make sure to express the newly created variables in monthly terms by multiplying by 30/7

*Monthly food expenditures in cash/credit
egen HHExp_Food_Purch_MN_1M=rowtotal(HHExpFCer_Purch_MN_7D HHExpFTub_Purch_MN_7D HHExpFPuls_Purch_MN_7D HHExpFVeg_Purch_MN_7D HHExpFFrt_Purch_MN_7D HHExpFAnimMeat_Purch_MN_7D HHExpFAnimFish_Purch_MN_7D HHExpFFats_Purch_MN_7D HHExpFDairy_Purch_MN_7D HHExpFEgg_Purch_MN_7D HHExpFSgr_Purch_MN_7D HHExpFCond_Purch_MN_7D HHExpFBev_Purch_MN_7D HHExpFOut_Purch_MN_7D)
replace HHExp_Food_Purch_MN_1M=HHExp_Food_Purch_MN_1M*(30/7) // conversion in monthly terms - do it only if recall period for food was 7 days
lab var HHExp_Food_Purch_MN_1M "Total monthly food expenditure (cash and credit)"

*Monthly value of consumed food from gifts/aid
egen HHExp_Food_GiftAid_MN_1M=rowtotal(HHExpFCer_GiftAid_MN_7D HHExpFTub_GiftAid_MN_7D HHExpFPuls_GiftAid_MN_7D HHExpFVeg_GiftAid_MN_7D HHExpFFrt_GiftAid_MN_7D HHExpFAnimMeat_GiftAid_MN_7D HHExpFAnimFish_GiftAid_MN_7D HHExpFFats_GiftAid_MN_7D HHExpFDairy_GiftAid_MN_7D HHExpFEgg_GiftAid_MN_7D HHExpFSgr_GiftAid_MN_7D HHExpFCond_GiftAid_MN_7D HHExpFBev_GiftAid_MN_7D HHExpFOut_GiftAid_MN_7D)
replace HHExp_Food_GiftAid_MN_1M=HHExp_Food_GiftAid_MN_1M*(30/7) // conversion in monthly terms - do it only if recall period for food was 7 days
lab var HHExp_Food_GiftAid_MN_1M "Total monthly food consumption from gifts/aid"

*Monthly value of consumed food from own-production
egen HHExp_Food_Own_MN_1M=rowtotal(HHExpFCer_Own_MN_7D HHExpFTub_Own_MN_7D HHExpFPuls_Own_MN_7D HHExpFVeg_Own_MN_7D HHExpFFrt_Own_MN_7D HHExpFAnimMeat_Own_MN_7D HHExpFAnimFish_Own_MN_7D HHExpFFats_Own_MN_7D HHExpFDairy_Own_MN_7D HHExpFEgg_Own_MN_7D HHExpFSgr_Own_MN_7D HHExpFCond_Own_MN_7D HHExpFBev_Own_MN_7D HHExpFOut_Own_MN_7D)
replace HHExp_Food_Own_MN_1M=HHExp_Food_Own_MN_1M*(30/7) // conversion in monthly terms - do it only if recall period for food was 7 days
lab var HHExp_Food_Own_MN_1M "Total monthly food consumption from own-production"


*-------------------------------------------------------------------------------*
*2. Create variables for non-food expenditure, by source	
*-------------------------------------------------------------------------------*

*** 2.a Label variables: 

*1 month recall period - variables labels:
lab var HHExpNFHyg_Purch_MN_1M  "Expenditures on hygiene"
lab var HHExpNFHyg_GiftAid_MN_1M "Value of consumed in-kind assistance-gifts - hygiene"
lab var HHExpNFTransp_Purch_MN_1M "Expenditures on transport"
lab var HHExpNFTransp_GiftAid_MN_1M "Value of consumed in-kind assistance-gifts - transport"
lab var HHExpNFFuel_Purch_MN_1M "Expenditures on fuel"
lab var HHExpNFFuel_GiftAid_MN_1M "Value of consumed in-kind assistance-gifts - fuel"
lab var HHExpNFWat_Purch_MN_1M "Expenditures on water"
lab var HHExpNFWat_GiftAid_MN_1M "Value of consumed in-kind assistance-gifts - water"
lab var HHExpNFElec_Purch_MN_1M "Expenditures on electricity"
lab var HHExpNFElec_GiftAid_MN_1M "Value of consumed in-kind assistance-gifts - electricity"
lab var HHExpNFEnerg_Purch_MN_1M "Expenditures on energy (not electricity)"
lab var HHExpNFEnerg_GiftAid_MN_1M "Value of consumed in-kind assistance-gifts - energy (not electricity)"
lab var HHExpNFDwelSer_Purch_MN_1M "Expenditures on services related to dwelling"
lab var HHExpNFDwelSer_GiftAid_MN_1M "Value of consumed in-kind assistance-gifts - services related to dwelling"
lab var HHExpNFPhone_Purch_MN_1M "Expenditures on communication"
lab var HHExpNFPhone_GiftAid_MN_1M "Value of consumed in-kind assistance-gifts - communication"
lab var HHExpNFRecr_Purch_MN_1M "Expenditures on recreation"
lab var HHExpNFRecr_GiftAid_MN_1M "Value of consumed in-kind assistance-gifts - recreation"
lab var HHExpNFAlcTobac_Purch_MN_1M "Expenditures on alchol/tobacco"
lab var HHExpNFAlcTobac_GiftAid_MN_1M "Value of consumed in-kind assistance-gifts - alchol/tobacco"
* If the questionnaire included further non-food categories/items, label the respective variables

*6 months recall period - variables lables:
lab var HHExpNFMedServ_Purch_MN_6M "Expenditures on health services"
lab var HHExpNFMedServ_GiftAid_MN_6M "Value of consumed in-kind assistance-gifts - health services"
lab var HHExpNFMedGood_Purch_MN_6M "Expenditures on medicines and health products"
lab var HHExpNFMedGood_GiftAid_MN_6M "Value of consumed in-kind assistance-gifts - medicines and health products"
lab var HHExpNFCloth_Purch_MN_6M "Expenditures on clothing and footwear"
lab var HHExpNFCloth_GiftAid_MN_6M "Value of consumed in-kind assistance-gifts - clothing and footwear"
lab var HHExpNFEduFee_Purch_MN_6M "Expenditures on education services"
lab var HHExpNFEduFee_GiftAid_MN_6M "Value of consumed in-kind assistance-gifts - education services"
lab var HHExpNFEduGood_Purch_MN_6M "Expenditures on education goods"
lab var HHExpNFEduGood_GiftAid_MN_6M "Value of consumed in-kind assistance-gifts - education goods"
lab var HHExpNFRent_Purch_MN_6M "Expenditures on rent"
lab var HHExpNFRent_GiftAid_MN_6M "Value of consumed in-kind assistance-gifts - rent"
lab var HHExpNFHHSoft_Purch_MN_6M "Expenditures on non-durable furniture/utensils"
lab var HHExpNFHHSoft_GiftAid_MN_6M "Value of consumed in-kind assistance-gifts - non-durable furniture/utensils"
lab var HHExpNFHHMaint_Purch_MN_6M "Expenditures on household routine maintenance"
lab var HHExpNFHHMaint_GiftAid_MN_6M "Value of consumed in-kind assistance-gifts - household routine maintenance"
* If the questionnaire included further non-food categories/items, label the respective variables

*** 2.b Calculate total value of non-food expenditures/consumption by source

** Total non-food expenditure (cash/credit)

* 30 days recall
egen HHExpNFTotal_Purch_MN_30D=rowtotal(HHExpNFHyg_Purch_MN_1M HHExpNFTransp_Purch_MN_1M HHExpNFFuel_Purch_MN_1M HHExpNFWat_Purch_MN_1M HHExpNFElec_Purch_MN_1M HHExpNFEnerg_Purch_MN_1M HHExpNFDwelSer_Purch_MN_1M HHExpNFPhone_Purch_MN_1M HHExpNFRecr_Purch_MN_1M HHExpNFAlcTobac_Purch_MN_1M) 

* 6 months recall
egen HHExpNFTotal_Purch_MN_6M=rowtotal(HHExpNFMedServ_Purch_MN_6M HHExpNFMedGood_Purch_MN_6M HHExpNFCloth_Purch_MN_6M HHExpNFEduFee_Purch_MN_6M HHExpNFEduGood_Purch_MN_6M HHExpNFRent_Purch_MN_6M HHExpNFHHSoft_Purch_MN_6M HHExpNFHHMaint_Purch_MN_6M) // careful with rent: should include only if also incuded in MEB

* Express 6 months in monthly terms
replace HHExpNFTotal_Purch_MN_6M=HHExpNFTotal_Purch_MN_6M/6

* Sum
egen HHExpNFTotal_Purch_MN_1M=rowtotal(HHExpNFTotal_Purch_MN_30D HHExpNFTotal_Purch_MN_6M)
lab var HHExpNFTotal_Purch_MN_1M "Total monthly non-food expenditure (cash and credit)"

drop HHExpNFTotal_Purch_MN_6M HHExpNFTotal_Purch_MN_30D


** Total value of consumed non-food from gift/aid

* 30 days recall
egen HHExpNFTotal_GiftAid_MN_30D=rowtotal(HHExpNFHyg_GiftAid_MN_1M HHExpNFTransp_GiftAid_MN_1M HHExpNFFuel_GiftAid_MN_1M HHExpNFWat_GiftAid_MN_1M HHExpNFElec_GiftAid_MN_1M HHExpNFEnerg_GiftAid_MN_1M HHExpNFDwelSer_GiftAid_MN_1M HHExpNFPhone_GiftAid_MN_1M HHExpNFRecr_GiftAid_MN_1M HHExpNFAlcTobac_GiftAid_MN_1M) 

* 6 months recall
egen HHExpNFTotal_GiftAid_MN_6M=rowtotal(HHExpNFMedServ_GiftAid_MN_6M HHExpNFMedGood_GiftAid_MN_6M HHExpNFCloth_GiftAid_MN_6M HHExpNFEduFee_GiftAid_MN_6M HHExpNFEduGood_GiftAid_MN_6M HHExpNFRent_GiftAid_MN_6M HHExpNFHHSoft_GiftAid_MN_6M HHExpNFHHMaint_GiftAid_MN_6M) // careful with rent: should include only if also incuded in MEB

* Express 6 months in monthly terms
replace HHExpNFTotal_GiftAid_MN_6M=HHExpNFTotal_GiftAid_MN_6M/6

* Sum
egen HHExpNFTotal_GiftAid_MN_1M=rowtotal(HHExpNFTotal_GiftAid_MN_30D HHExpNFTotal_GiftAid_MN_6M)
lab var HHExpNFTotal_GiftAid_MN_1M "Total monthly non-food consumption from gifts/aid"

drop HHExpNFTotal_GiftAid_MN_6M HHExpNFTotal_GiftAid_MN_30D


*-------------------------------------------------------------------------------*
*3.Calculate total food and non-food consumption expenditures
*-------------------------------------------------------------------------------*

* Aggregate food expenditures, value of consumed food from gifts/assistance, and value of consumed food from own production.
egen HHExpF_1M=rowtotal(HHExp_Food_Purch_MN_1M HHExp_Food_GiftAid_MN_1M HHExp_Food_Own_MN_1M)


*Aggregate NF expenditures and value of consumed non-food from gifts/assistance 
egen HHExpNF_1M=rowtotal(HHExpNFTotal_Purch_MN_1M HHExpNFTotal_GiftAid_MN_1M)

    
*-------------------------------------------------------------------------------*
*4.Compute FES
*-------------------------------------------------------------------------------*

* Aggregate total food and non food expenditures
egen HHExpTot_1M=rowtotal(HHExpF_1M HHExpNF_1M)

* Compute FES for each household
gen FES = HHExpF_1M/HHExpTot_1M
lab var FES "Household food expenditure share"

drop HHExpTot_1M

* Transfor FES to 4 categories
recode FES (min/.4999999=1) (.50/.64999999=2) (.65/.74999999=3) (.75/max=4), gen(Foodexp_4pt)
lab var Foodexp_4pt "Food expenditure share categories"

label define Foodexp_4pt_lab 1 "<50%" 2 "50-65%" 3 "65-75%" 4" > 75%"
label value Foodexp_4pt Foodexp_4pt_lab 

* Compute FES indicator
tab Foodexp_4pt
    			   
