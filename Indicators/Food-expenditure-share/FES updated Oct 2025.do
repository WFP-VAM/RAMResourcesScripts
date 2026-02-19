*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                         Food Expenditure Share (FES)


*** Last Update  : #/#/2025
*** Purpose: This script calculates the Food Expenditure Share

***   Data Quality Guidance References:
***   - Recommended usage of constraints and warning messages in coded tool: Page 18 and page 21
***   - Recommended high frequency checks: Page 31-32
***   - Recommended cleaning steps: Page 38-40

*** ----------------------------------------------------------------------------------------------------
 
*** Important note: The value of consumed in-kind assistance/gifts must always be considered when calculating the FES - both for VAM and monitoring  

*** Define group labels -  these should match Survey Designer naming conventions
*** This syntax uses the recommended standard recall period of 7 days. If your CO has selected the 1 month recall period, you need to change the variable names accordingly (replace 7D with 1M)

label var HHExpFCer_Purch_MN_7D        "Weekly expenditures on cereals"
label var HHExpFCer_GiftAid_MN_7D      "Weekly value of consumed in-kind assistance and gifts - cereals"
label var HHExpFCer_Own_MN_7D          "Weekly value of consumed own production - cereals"
label var HHExpFTub_Purch_MN_7D        "Weekly expenditures on tubers"
label var HHExpFTub_GiftAid_MN_7D      "Weekly value of consumed in-kind assistance and gifts - tubers"
label var HHExpFTub_Own_MN_7D          "Weekly value of consumed own production - tubers"
label var HHExpFPuls_Purch_MN_7D       "Weekly expenditures on pulses and nuts"
label var HHExpFPuls_GiftAid_MN_7D     "Weekly value of consumed in-kind assistance and gifts - pulses and nuts"
label var HHExpFPuls_Own_MN_7D         "Weekly value of consumed own production - pulses & nuts"
label var HHExpFVeg_Purch_MN_7D        "Weekly expenditures on vegetables"
label var HHExpFVeg_GiftAid_MN_7D      "Weekly value of consumed in-kind assistance and gifts - vegetables"
label var HHExpFVeg_Own_MN_7D          "Weekly value of consumed own production - vegetables"
label var HHExpFFrt_Purch_MN_7D        "Weekly expenditures on fruits"
label var HHExpFFrt_GiftAid_MN_7D      "Weekly value of consumed in-kind assistance and gifts - fruits"
label var HHExpFFrt_Own_MN_7D          "Weekly value of consumed own production - fruits"
label var HHExpFAnimMeat_Purch_MN_7D   "Weekly expenditures on meat"
label var HHExpFAnimMeat_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - meat"
label var HHExpFAnimMeat_Own_MN_7D     "Weekly value of consumed own production - meat"
label var HHExpFAnimFish_Purch_MN_7D   "Weekly expenditures on fish"
label var HHExpFAnimFish_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - fish"
label var HHExpFAnimFish_Own_MN_7D     "Weekly value of consumed own production - fish"
label var HHExpFFats_Purch_MN_7D       "Weekly expenditures on fats"
label var HHExpFFats_GiftAid_MN_7D     "Weekly value of consumed in-kind assistance and gifts - fats"
label var HHExpFFats_Own_MN_7D         "Weekly value of consumed own production - fats"
label var HHExpFDairy_Purch_MN_7D      "Weekly expenditures on milk or dairy products"
label var HHExpFDairy_GiftAid_MN_7D    "Weekly value of consumed in-kind assistance and gifts - milk or dairy products"
label var HHExpFDairy_Own_MN_7D        "Weekly value of consumed own production - milk or dairy products"
label var HHExpFEgg_Purch_MN_7D        "Weekly expenditures on eggs"
label var HHExpFEgg_GiftAid_MN_7D      "Weekly value of consumed in-kind assistance and gifts - eggs"
label var HHExpFEgg_Own_MN_7D          "Weekly value of consumed own production - eggs"
label var HHExpFSgr_Purch_MN_7D        "Weekly expenditures on sugar or confectionery or desserts"

***Converting system missing of the food expenditure to 0

foreach var of varlist ///
    HHExpFCer_Purch_MN_7D HHExpFCer_GiftAid_MN_7D HHExpFCer_Own_MN_7D ///
    HHExpFTub_Purch_MN_7D HHExpFTub_GiftAid_MN_7D HHExpFTub_Own_MN_7D ///
    HHExpFPuls_Purch_MN_7D HHExpFPuls_GiftAid_MN_7D HHExpFPuls_Own_MN_7D ///
    HHExpFVeg_Purch_MN_7D HHExpFVeg_GiftAid_MN_7D HHExpFVeg_Own_MN_7D ///
    HHExpFFrt_Purch_MN_7D HHExpFFrt_GiftAid_MN_7D HHExpFFrt_Own_MN_7D ///
    HHExpFAnimMeat_Purch_MN_7D HHExpFAnimMeat_GiftAid_MN_7D HHExpFAnimMeat_Own_MN_7D ///
    HHExpFAnimFish_Purch_MN_7D HHExpFAnimFish_GiftAid_MN_7D HHExpFAnimFish_Own_MN_7D ///
    HHExpFFats_Purch_MN_7D HHExpFFats_GiftAid_MN_7D HHExpFFats_Own_MN_7D ///
    HHExpFDairy_Purch_MN_7D HHExpFDairy_GiftAid_MN_7D HHExpFDairy_Own_MN_7D ///
    HHExpFEgg_Purch_MN_7D HHExpFEgg_GiftAid_MN_7D HHExpFEgg_Own_MN_7D ///
    HHExpFSgr_Purch_MN_7D HHExpFSgr_GiftAid_MN_7D HHExpFSgr_Own_MN_7D ///
    HHExpFCond_Purch_MN_7D HHExpFCond_GiftAid_MN_7D HHExpFCond_Own_MN_7D ///
    HHExpFBev_Purch_MN_7D HHExpFBev_GiftAid_MN_7D HHExpFBev_Own_MN_7D ///
    HHExpFOut_Purch_MN_7D HHExpFOut_GiftAid_MN_7D HHExpFOut_Own_MN_7D {

    replace `var' = 0 if missing(`var')
}

*** Check expenditures to get an overview of the data and potential outliers
summarize ///
HHExpFCer_Purch_MN_7D HHExpFCer_GiftAid_MN_7D HHExpFCer_Own_MN_7D ///
HHExpFTub_Purch_MN_7D HHExpFTub_GiftAid_MN_7D HHExpFTub_Own_MN_7D ///
HHExpFPuls_Purch_MN_7D HHExpFPuls_GiftAid_MN_7D HHExpFPuls_Own_MN_7D ///
HHExpFVeg_Purch_MN_7D HHExpFVeg_GiftAid_MN_7D HHExpFVeg_Own_MN_7D ///
HHExpFFrt_Purch_MN_7D HHExpFFrt_GiftAid_MN_7D HHExpFFrt_Own_MN_7D ///
HHExpFAnimMeat_Purch_MN_7D HHExpFAnimMeat_GiftAid_MN_7D HHExpFAnimMeat_Own_MN_7D ///
HHExpFAnimFish_Purch_MN_7D HHExpFAnimFish_GiftAid_MN_7D HHExpFAnimFish_Own_MN_7D ///
HHExpFFats_Purch_MN_7D HHExpFFats_GiftAid_MN_7D HHExpFFats_Own_MN_7D ///
HHExpFDairy_Purch_MN_7D HHExpFDairy_GiftAid_MN_7D HHExpFDairy_Own_MN_7D ///
HHExpFEgg_Purch_MN_7D HHExpFEgg_GiftAid_MN_7D HHExpFEgg_Own_MN_7D ///
HHExpFSgr_Purch_MN_7D HHExpFSgr_GiftAid_MN_7D HHExpFSgr_Own_MN_7D ///
HHExpFCond_Purch_MN_7D HHExpFCond_GiftAid_MN_7D HHExpFCond_Own_MN_7D ///
HHExpFBev_Purch_MN_7D HHExpFBev_GiftAid_MN_7D HHExpFBev_Own_MN_7D ///
HHExpFOut_Purch_MN_7D HHExpFOut_GiftAid_MN_7D HHExpFOut_Own_MN_7D

**OR

tabstat ///
HHExpFCer_Purch_MN_7D HHExpFCer_GiftAid_MN_7D HHExpFCer_Own_MN_7D ///
HHExpFTub_Purch_MN_7D HHExpFTub_GiftAid_MN_7D HHExpFTub_Own_MN_7D ///
HHExpFPuls_Purch_MN_7D HHExpFPuls_GiftAid_MN_7D HHExpFPuls_Own_MN_7D ///
HHExpFVeg_Purch_MN_7D HHExpFVeg_GiftAid_MN_7D HHExpFVeg_Own_MN_7D ///
HHExpFFrt_Purch_MN_7D HHExpFFrt_GiftAid_MN_7D HHExpFFrt_Own_MN_7D ///
HHExpFAnimMeat_Purch_MN_7D HHExpFAnimMeat_GiftAid_MN_7D HHExpFAnimMeat_Own_MN_7D ///
HHExpFAnimFish_Purch_MN_7D HHExpFAnimFish_GiftAid_MN_7D HHExpFAnimFish_Own_MN_7D ///
HHExpFFats_Purch_MN_7D HHExpFFats_GiftAid_MN_7D HHExpFFats_Own_MN_7D ///
HHExpFDairy_Purch_MN_7D HHExpFDairy_GiftAid_MN_7D HHExpFDairy_Own_MN_7D ///
HHExpFEgg_Purch_MN_7D HHExpFEgg_GiftAid_MN_7D HHExpFEgg_Own_MN_7D ///
HHExpFSgr_Purch_MN_7D HHExpFSgr_GiftAid_MN_7D HHExpFSgr_Own_MN_7D ///
HHExpFCond_Purch_MN_7D HHExpFCond_GiftAid_MN_7D HHExpFCond_Own_MN_7D ///
HHExpFBev_Purch_MN_7D HHExpFBev_GiftAid_MN_7D HHExpFBev_Own_MN_7D ///
HHExpFOut_Purch_MN_7D HHExpFOut_GiftAid_MN_7D HHExpFOut_Own_MN_7D, ///
stats(mean median min max) columns(statistics)

*** ----------------------------------------------------------------------------------------------------


*** Important step
*** After getting the overview of the raw data, it is now recommended to use the standard cleaning syntax found on the VAM Resource Centre to do the standard cleaning. Following this, additional contextual cleaning can be done if neccessary. It is not recommended to move to the below step until the data has been cleaned


*** ----------------------------------------------------------------------------------------------------

*** Calculate total monthly value of food expenditures/consumption by source

*** This syntax uses the recommended standard recall period of 7 days. If your CO has selected the 1 month recall period, ensure you adjust the below accordingly

****************************************************
* Calculate monthly food expenditures (cash/credit)
****************************************************

gen HHExp_Food_Purch_MN_1M = HHExpFCer_Purch_MN_7D + HHExpFTub_Purch_MN_7D ///
    + HHExpFPuls_Purch_MN_7D + HHExpFVeg_Purch_MN_7D + HHExpFFrt_Purch_MN_7D ///
    + HHExpFAnimMeat_Purch_MN_7D + HHExpFAnimFish_Purch_MN_7D + HHExpFFats_Purch_MN_7D ///
    + HHExpFDairy_Purch_MN_7D + HHExpFEgg_Purch_MN_7D + HHExpFSgr_Purch_MN_7D ///
    + HHExpFCond_Purch_MN_7D + HHExpFBev_Purch_MN_7D + HHExpFOut_Purch_MN_7D

replace HHExp_Food_Purch_MN_1M = HHExp_Food_Purch_MN_1M * (30/7)

label var HHExp_Food_Purch_MN_1M ///
    "Total monthly food expenditure (cash and credit)"


****************************************************
* Calculate monthly value of consumed food from gifts/aid
****************************************************

gen HHExp_Food_GiftAid_MN_1M = HHExpFCer_GiftAid_MN_7D + HHExpFTub_GiftAid_MN_7D ///
    + HHExpFPuls_GiftAid_MN_7D + HHExpFVeg_GiftAid_MN_7D + HHExpFFrt_GiftAid_MN_7D ///
    + HHExpFAnimMeat_GiftAid_MN_7D + HHExpFAnimFish_GiftAid_MN_7D + HHExpFFats_GiftAid_MN_7D ///
    + HHExpFDairy_GiftAid_MN_7D + HHExpFEgg_GiftAid_MN_7D + HHExpFSgr_GiftAid_MN_7D ///
    + HHExpFCond_GiftAid_MN_7D + HHExpFBev_GiftAid_MN_7D + HHExpFOut_GiftAid_MN_7D 

replace HHExp_Food_GiftAid_MN_1M = HHExp_Food_GiftAid_MN_1M * (30/7)

label var HHExp_Food_GiftAid_MN_1M ///
    "Total monthly food consumption from gifts/aid"


****************************************************
* Calculate monthly value of consumed food from own production
****************************************************

gen HHExp_Food_Own_MN_1M = HHExpFCer_Own_MN_7D + HHExpFTub_Own_MN_7D ///
    + HHExpFPuls_Own_MN_7D + HHExpFVeg_Own_MN_7D + HHExpFFrt_Own_MN_7D ///
    + HHExpFAnimMeat_Own_MN_7D + HHExpFAnimFish_Own_MN_7D + HHExpFFats_Own_MN_7D ///
    + HHExpFDairy_Own_MN_7D + HHExpFEgg_Own_MN_7D + HHExpFSgr_Own_MN_7D + HHExpFCond_Own_MN_7D ///
    + HHExpFBev_Own_MN_7D + HHExpFOut_Own_MN_7D 

replace HHExp_Food_Own_MN_1M = HHExp_Food_Own_MN_1M * (30/7)

label var HHExp_Food_Own_MN_1M ///
    "Total monthly food consumption from own production"
	
*** Label non-food variables, 1 month recall

label var HHExpNFHyg_Purch_MN_1M        "Monthly expenditures on hygiene"
label var HHExpNFHyg_GiftAid_MN_1M      "Monthly value of consumed in-kind assistance and gifts - hygiene"
label var HHExpNFTransp_Purch_MN_1M     "Monthly expenditures on transport"
label var HHExpNFTransp_GiftAid_MN_1M   "Monthly value of consumed in-kind assistance and gifts - transport"
label var HHExpNFFuel_Purch_MN_1M       "Monthly expenditures on fuel"
label var HHExpNFFuel_GiftAid_MN_1M     "Monthly value of consumed in-kind assistance and gifts - fuel"
label var HHExpNFWat_Purch_MN_1M        "Monthly expenditures on water"
label var HHExpNFWat_GiftAid_MN_1M      "Monthly value of consumed in-kind assistance and gifts - water"
label var HHExpNFElec_Purch_MN_1M       "Monthly expenditures on electricity"
label var HHExpNFElec_GiftAid_MN_1M     "Monthly value of consumed in-kind assistance and gifts - electricity"
label var HHExpNFEnerg_Purch_MN_1M      "Monthly expenditures on energy (not electricity)"
label var HHExpNFEnerg_GiftAid_MN_1M    "Monthly value of consumed in-kind assistance and gifts - energy (not electricity)"
label var HHExpNFDwelSer_Purch_MN_1M    "Monthly expenditures on services related to dwelling"
label var HHExpNFDwelSer_GiftAid_MN_1M  "Monthly value of consumed in-kind assistance and gifts - services related to dwelling"
label var HHExpNFPhone_Purch_MN_1M      "Monthly expenditures on communication"
label var HHExpNFPhone_GiftAid_MN_1M    "Monthly value of consumed in-kind assistance and gifts - communication"
label var HHExpNFRecr_Purch_MN_1M       "Monthly expenditures on recreation"
label var HHExpNFRecr_GiftAid_MN_1M     "Monthly value of consumed in-kind assistance and gifts - recreation"
label var HHExpNFAlcTobac_Purch_MN_1M   "Monthly expenditures on alcohol or tobacco"
label var HHExpNFAlcTobac_GiftAid_MN_1M "Monthly value of consumed in-kind assistance and gifts - alcohol or tobacco"

***Converting system missing of the non-food expenditure to 0

foreach var of varlist ///
    HHExpNFHyg_Purch_MN_1M HHExpNFHyg_GiftAid_MN_1M ///
    HHExpNFTransp_Purch_MN_1M HHExpNFTransp_GiftAid_MN_1M ///
    HHExpNFFuel_Purch_MN_1M HHExpNFFuel_GiftAid_MN_1M ///
    HHExpNFWat_Purch_MN_1M HHExpNFWat_GiftAid_MN_1M ///
    HHExpNFElec_Purch_MN_1M HHExpNFElec_GiftAid_MN_1M ///
    HHExpNFEnerg_Purch_MN_1M HHExpNFEnerg_GiftAid_MN_1M ///
    HHExpNFDwelSer_Purch_MN_1M HHExpNFDwelSer_GiftAid_MN_1M ///
    HHExpNFPhone_Purch_MN_1M HHExpNFPhone_GiftAid_MN_1M ///
    HHExpNFRecr_Purch_MN_1M HHExpNFRecr_GiftAid_MN_1M ///
    HHExpNFAlcTobac_Purch_MN_1M HHExpNFAlcTobac_GiftAid_MN_1M {

    replace `var' = 0 if missing(`var')
}

*** If the questionnaire included other short-term non-food categories, label the respective variables and add them to the calculations below

*** Label non-food variables, 6 months recall

label var HHExpNFMedServ_Purch_MN_6M "Expenditures on health services in the past 6 months"
label var HHExpNFMedServ_GiftAid_MN_6M "Value of consumed in-kind assistance and gifts - health services in the past 6 months"
label var HHExpNFMedGood_Purch_MN_6M "Expenditures on medicines and health products in the past 6 months"
label var HHExpNFMedGood_GiftAid_MN_6M "Value of consumed in-kind assistance and gifts - medicines and health products in the past 6 months"
label var HHExpNFCloth_Purch_MN_6M "Expenditures on clothing and footwear in the past 6 months"
label var HHExpNFCloth_GiftAid_MN_6M "Value of consumed in-kind assistance and gifts - clothing and footwear in the past 6 months"
label var HHExpNFEduFee_Purch_MN_6M "Expenditures on education services in the past 6 months"
label var HHExpNFEduFee_GiftAid_MN_6M "Value of consumed in-kind assistance and gifts - education services in the past 6 months"
label var HHExpNFEduGood_Purch_MN_6M "Expenditures on education goods in the past 6 months"
label var HHExpNFEduGood_GiftAid_MN_6M "Value of consumed in-kind assistance and gifts - education goods in the past 6 months"
label var HHExpNFRent_Purch_MN_6M "Expenditures on rent in the past 6 months
label var HHExpNFRent_GiftAid_MN_6M "Value of consumed in-kind assistance and gifts - rent in the past 6 months"
label var HHExpNFHHSoft_Purch_MN_6M "Expenditures on non-durable furniture or utensils in the past 6 months"
label var HHExpNFHHSoft_GiftAid_MN_6M "Value of consumed in-kind assistance and gifts - non-durable furniture or utensils in the past 6 months"
label var HHExpNFHHMaint_Purch_MN_6M "Expenditures on household routine maintenance in the past 6 months"
label var HHExpNFHHMaint_GiftAid_MN_6M "Value of consumed in-kind assistance and gifts - household routine maintenance in the past 6 months"

***Converting system missing of the 6 month expediture of non-food items to 0

foreach var of varlist ///
    HHExpNFMedServ_Purch_MN_6M HHExpNFMedServ_GiftAid_MN_6M ///
    HHExpNFMedGood_Purch_MN_6M HHExpNFMedGood_GiftAid_MN_6M ///
    HHExpNFCloth_Purch_MN_6M HHExpNFCloth_GiftAid_MN_6M ///
    HHExpNFEduFee_Purch_MN_6M HHExpNFEduFee_GiftAid_MN_6M ///
    HHExpNFEduGood_Purch_MN_6M HHExpNFEduGood_GiftAid_MN_6M ///
    HHExpNFRent_Purch_MN_6M HHExpNFRent_GiftAid_MN_6M ///
    HHExpNFHHSoft_Purch_MN_6M HHExpNFHHSoft_GiftAid_MN_6M ///
    HHExpNFHHMaint_Purch_MN_6M HHExpNFHHMaint_GiftAid_MN_6M {

    replace `var' = 0 if missing(`var')
}

/********************************************************************
 * Total monthly non-food expenditures purchased with cash/credit
 * - Short-term (1-month recall)
 * - Long-term (6-month recall) converted to monthly
 * - Combined total
 ********************************************************************/

****************************************************
* Short-term non-food expenditures, 1 month recall
****************************************************
gen HHExpNFTotal_Purch_MN_30D = HHExpNFHyg_Purch_MN_1M + HHExpNFTransp_Purch_MN_1M ///
    + HHExpNFFuel_Purch_MN_1M + HHExpNFWat_Purch_MN_1M + HHExpNFElec_Purch_MN_1M ///
    + HHExpNFEnerg_Purch_MN_1M + HHExpNFDwelSer_Purch_MN_1M + HHExpNFPhone_Purch_MN_1M ///
    + HHExpNFRecr_Purch_MN_1M + HHExpNFAlcTobac_Purch_MN_1M

label var HHExpNFTotal_Purch_MN_30D "Total 1-month non-food expenditures (cash/credit, short-term)"


****************************************************
* Long-term non-food expenditures, 6 month recall
* NOTE: Include rent ONLY if it is included in the MEB definition.
****************************************************
gen HHExpNFTotal_Purch_MN_6M = HHExpNFMedServ_Purch_MN_6M + HHExpNFMedGood_Purch_MN_6M ///
    + HHExpNFCloth_Purch_MN_6M + HHExpNFEduFee_Purch_MN_6M + HHExpNFEduGood_Purch_MN_6M ///
    + HHExpNFRent_Purch_MN_6M + HHExpNFHHSoft_Purch_MN_6M + HHExpNFHHMaint_Purch_MN_6M

* Convert long-term (6 months) to monthly average
replace HHExpNFTotal_Purch_MN_6M = HHExpNFTotal_Purch_MN_6M / 6

label var HHExpNFTotal_Purch_MN_6M "Total monthly non-food expenditures (cash/credit) from 6-month recall"


****************************************************
* Total monthly non-food expenditures (cash/credit)
* = Short-term 1M + adjusted long-term (6M / 6)
****************************************************
gen HHExpNFTotal_Purch_MN_1M = HHExpNFTotal_Purch_MN_30D + HHExpNFTotal_Purch_MN_6M

label var HHExpNFTotal_Purch_MN_1M "Total monthly non-food expenditure (cash and credit)"

*** Delete variables no longer needed (cash/credit)

drop HHExpNFTotal_Purch_MN_6M HHExpNFTotal_Purch_MN_30D

/********************************************************************
 * Total monthly value of used/consumed non-food received as gifts/aid
 * - Short-term (1-month recall)
 * - Long-term (6-month recall) converted to monthly
 * - Combined total
 ********************************************************************/

****************************************************
* Short-term non-food, 1 month recall (gifts/aid)
****************************************************
gen HHExpNFTotal_GiftAid_MN_30D = HHExpNFHyg_GiftAid_MN_1M + HHExpNFTransp_GiftAid_MN_1M ///
    + HHExpNFFuel_GiftAid_MN_1M + HHExpNFWat_GiftAid_MN_1M + HHExpNFElec_GiftAid_MN_1M ///
    + HHExpNFEnerg_GiftAid_MN_1M + HHExpNFDwelSer_GiftAid_MN_1M + HHExpNFPhone_GiftAid_MN_1M ///
    + HHExpNFRecr_GiftAid_MN_1M + HHExpNFAlcTobac_GiftAid_MN_1M

label var HHExpNFTotal_GiftAid_MN_30D ///
    "Total 1-month non-food consumption from gifts/aid (short-term)"


****************************************************
* Long-term non-food, 6 month recall (gifts/aid)
* NOTE: Include rent ONLY if it is included in the MEB definition.
****************************************************
gen HHExpNFTotal_GiftAid_MN_6M = HHExpNFMedServ_GiftAid_MN_6M + HHExpNFMedGood_GiftAid_MN_6M ///
    + HHExpNFCloth_GiftAid_MN_6M + HHExpNFEduFee_GiftAid_MN_6M + HHExpNFEduGood_GiftAid_MN_6M ///
    + HHExpNFRent_GiftAid_MN_6M + HHExpNFHHSoft_GiftAid_MN_6M + HHExpNFHHMaint_GiftAid_MN_6M 

* Convert long-term (6 months) to monthly average
replace HHExpNFTotal_GiftAid_MN_6M = HHExpNFTotal_GiftAid_MN_6M / 6

label var HHExpNFTotal_GiftAid_MN_6M ///
    "Total monthly non-food consumption from gifts/aid (from 6-month recall)"


****************************************************
* Total monthly non-food consumption from gifts/aid
* = Short-term 1M + adjusted long-term (6M / 6)
****************************************************
gen HHExpNFTotal_GiftAid_MN_1M = HHExpNFTotal_GiftAid_MN_30D + HHExpNFTotal_GiftAid_MN_6M

label var HHExpNFTotal_GiftAid_MN_1M ///
    "Total monthly non-food consumption from gifts/aid"

*** Delete variables no longer needed (gifts/aid)

drop HHExpNFTotal_GiftAid_MN_6M HHExpNFTotal_GiftAid_MN_30D

/********************************************************************
 * Total monthly food and non-food consumption expenditures
 ********************************************************************/
*------------------------------------------------------*
* Total monthly food consumption:
*   cash/credit + gifts/aid + own production
*------------------------------------------------------*
gen HHExpF_1M = HHExp_Food_Purch_MN_1M + HHExp_Food_GiftAid_MN_1M + HHExp_Food_Own_MN_1M

label var HHExpF_1M "Total monthly food consumption (purch + gift/aid + own)"

*------------------------------------------------------*
* Total monthly non-food consumption:
*   cash/credit + gifts/aid
*------------------------------------------------------*
gen HHExpNF_1M = HHExpNFTotal_Purch_MN_1M + HHExpNFTotal_GiftAid_MN_1M

label var HHExpNF_1M "Total monthly non-food consumption (purch + gift/aid)"

*------------------------------------------------------*
* Total monthly household consumption:
*   total food + total non-food
*------------------------------------------------------*
gen HHExp_1M = HHExpF_1M + HHExpNF_1M

label var HHExp_1M "Total monthly household consumption (food + non-food)"

*** Check total monthly expenditures - are they realistic for your context or are they indicating that more cleaning is needed. This could be outliers (very high and/or very low expenditures for a household), scewed results including  very high non-food expenditures with very low food expenditures etc.

*** Before deciding on cleaning, it is recommended to calculate per capita expenditures to take into account the household size

summarize HHExpF_1M HHExpNF_1M HHExp_1M

tabulate HHExpF_1M, missing
tabulate HHExpNF_1M, missing
tabulate HHExp_1M, missing

/********************************************************************
 * Food Expenditure Share (FES)
 ********************************************************************/

*------------------------------------------------------*
* Compute the Food Expenditure Share
*   FES = Food expenditure / Total household expenditure
*------------------------------------------------------*
gen FES = HHExpF_1M / HHExp_1M
label var FES "Food Expenditure Share"

/*------------------------------------------------------------------*
* Recode FES into 4-category Food Expenditure Share classification
*------------------------------------------------------------------*/
gen Foodexp_4pt = . 
replace Foodexp_4pt = 1 if FES < 0.50
replace Foodexp_4pt = 2 if FES >= 0.50 & FES < 0.65
replace Foodexp_4pt = 3 if FES >= 0.65 & FES < 0.75
replace Foodexp_4pt = 4 if FES >= 0.75

label var Foodexp_4pt "Food expenditure share categories"

label define Foodexp_lbl ///
    1 "Low Food Expenditure Share (<50%)" ///
    2 "Medium Food Expenditure Share (50-65%)" ///
    3 "High Food Expenditure Share (65-75%)" ///
    4 "Very High Food Expenditure Share (>75%)"

label values Foodexp_4pt Foodexp_lbl


*------------------------------------------------------*
* Frequency distribution of the 4-category FES variable
*------------------------------------------------------*
tabulate Foodexp_4pt

*** ----------------------------------------------------------------------------------------------------
*** END OF SCRIPT
*** ----------------------------------------------------------------------------------------------------