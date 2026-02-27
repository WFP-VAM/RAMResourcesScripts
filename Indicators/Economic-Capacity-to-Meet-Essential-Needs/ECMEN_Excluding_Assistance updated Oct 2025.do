*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                         Economic Capacity to Meet Essential Needs (ECMEN) - for assessments


*** Last Update  : October 2025
*** Purpose: This script calculates the Economic Capacity to Meet Essential Needs indicator - version excluding assistance (for assessments)

***   Data Quality Guidance References:
***   - Recommended usage of constraints and warning messages in coded tool: Page 18 and page 21
***   - Recommended high frequency checks: Page 31-32
***   - Recommended cleaning steps: Page 38-40

*** ----------------------------------------------------------------------------------------------------

*** Note: In the version used for assessment: 
  **a) the household economic capacity aggregate should not include the value of consumed in-kind assistance gifts; 
  **b) the value of the cash assistance received from the humanitarian sector should be deducted from the household economic capacity aggregate (but only for the estimated share of the cash assistance that is used for consumption, when available).

*** Note that the computation of the ECMEN requires having already established a Minimum Expenditure Basket (MEB) 
    **************************************************************************** NOT ACCORDING TO THE GUIDANCE. CHECK WITH LENA FOR COHERENT MESSAGING

	
*** Define group labels -  these should match Survey Designer naming conventions
*** This syntax uses the recommended standard recall period of 7 days. If your CO has selected the 1 month recall period, you need to change the variable names accordingly (replace 7D with 1M)

label var HHExpFCer_Purch_MN_7D "Weekly expenditures on cereals"
label var HHExpFCer_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - cereals"
label var HHExpFCer_Own_MN_7D "Weekly value of consumed own production - cereals"

label var HHExpFTub_Purch_MN_7D "Weekly expenditures on tubers"
label var HHExpFTub_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - tubers"
label var HHExpFTub_Own_MN_7D "Weekly value of consumed own production - tubers"

label var HHExpFPuls_Purch_MN_7D "Weekly expenditures on pulses and nuts"
label var HHExpFPuls_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - pulses and nuts"
label var HHExpFPuls_Own_MN_7D "Weekly value of consumed own production - pulses & nuts"

label var HHExpFVeg_Purch_MN_7D "Weekly expenditures on vegetables"
label var HHExpFVeg_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - vegetables"
label var HHExpFVeg_Own_MN_7D "Weekly value of consumed own production - vegetables"

label var HHExpFFrt_Purch_MN_7D "Weekly expenditures on fruits"
label var HHExpFFrt_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - fruits"
label var HHExpFFrt_Own_MN_7D "Weekly value of consumed own production - fruits"

label var HHExpFAnimMeat_Purch_MN_7D "Weekly expenditures on meat"
label var HHExpFAnimMeat_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - meat"
label var HHExpFAnimMeat_Own_MN_7D "Weekly value of consumed own production - meat"

label var HHExpFAnimFish_Purch_MN_7D "Weekly expenditures on fish"
label var HHExpFAnimFish_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - fish"
label var HHExpFAnimFish_Own_MN_7D "Weekly value of consumed own production - fish"

label var HHExpFFats_Purch_MN_7D "Weekly expenditures on fats"
label var HHExpFFats_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - fats"
label var HHExpFFats_Own_MN_7D "Weekly value of consumed own production - fats"

label var HHExpFDairy_Purch_MN_7D "Weekly expenditures on milk or dairy products"
label var HHExpFDairy_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - milk or dairy products"
label var HHExpFDairy_Own_MN_7D "Weekly value of consumed own production - milk or dairy products"

label var HHExpFEgg_Purch_MN_7D "Weekly expenditures on eggs"
label var HHExpFEgg_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - eggs"
label var HHExpFEgg_Own_MN_7D "Weekly value of consumed own production - eggs"

label var HHExpFSgr_Purch_MN_7D "Weekly expenditures on sugar or confectionery or desserts"
label var HHExpFSgr_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - sugar or confectionery or desserts"
label var HHExpFSgr_Own_MN_7D "Weekly value of consumed own production - sugar or confectionery or desserts"

label var HHExpFCond_Purch_MN_7D "Weekly expenditures on condiments"
label var HHExpFCond_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - condiments"
label var HHExpFCond_Own_MN_7D "Weekly value of consumed own production - condiments"

label var HHExpFBev_Purch_MN_7D "Weekly expenditures on beverages"
label var HHExpFBev_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - beverages"
label var HHExpFBev_Own_MN_7D "Weekly value of consumed own production - beverages"

label var HHExpFOut_Purch_MN_7D "Weekly expenditures on snacks or meals prepared outside"
label var HHExpFOut_GiftAid_MN_7D "Weekly value of consumed in-kind assistance and gifts - snacks or meals prepared outside"
label var HHExpFOut_Own_MN_7D "Weekly value of consumed own production - snacks or meals prepared outside"

***Converting system missing of the food expenditure to 0

foreach v in HHExpFCer_Purch_MN_7D HHExpFCer_GiftAid_MN_7D HHExpFCer_Own_MN_7D ///
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

    replace `v' = 0 if missing(`v')
}

*** Check expenditures to get an overview of the data and potential outliers
summarize HHExpFCer_Purch_MN_7D HHExpFCer_GiftAid_MN_7D HHExpFCer_Own_MN_7D ///
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
	
**OR**

tabstat HHExpFCer_Purch_MN_7D HHExpFCer_GiftAid_MN_7D HHExpFCer_Own_MN_7D ///
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
    s (mean median min max) 

*** ----------------------------------------------------------------------------------------------------

*** Important step
*** After getting the overview of the raw data, it is now recommended to use the standard cleaning syntax found on the VAM Resource Centre to do the standard cleaning. Following this, additional contextual cleaning can be done if neccessary. It is not recommended to move to the below step until the data has been cleaned

*** ----------------------------------------------------------------------------------------------------

*** Calculate total monthly value of food expenditures/consumption by source

*** This syntax uses the recommended standard recall period of 7 days. If your CO has selected the 1 month recall period, ensure you adjust the below accordingly

*** Calculate monthly food expenditures in cash/credit	

* --- Create monthly total food expenditure (cash & credit) ---
gen HHExp_Food_Purch_MN_1M = HHExpFCer_Purch_MN_7D ///
    + HHExpFTub_Purch_MN_7D ///
    + HHExpFPuls_Purch_MN_7D ///
    + HHExpFVeg_Purch_MN_7D ///
    + HHExpFFrt_Purch_MN_7D ///
    + HHExpFAnimMeat_Purch_MN_7D ///
    + HHExpFAnimFish_Purch_MN_7D ///
    + HHExpFFats_Purch_MN_7D ///
    + HHExpFDairy_Purch_MN_7D ///
    + HHExpFEgg_Purch_MN_7D ///
    + HHExpFSgr_Purch_MN_7D ///
    + HHExpFCond_Purch_MN_7D ///
    + HHExpFBev_Purch_MN_7D ///
    + HHExpFOut_Purch_MN_7D

replace HHExp_Food_Purch_MN_1M = HHExp_Food_Purch_MN_1M * (30/7)

label var HHExp_Food_Purch_MN_1M "Total monthly food expenditure (cash and credit)"

* --- Monthly value of consumed food from gifts / aid ---

gen HHExp_Food_GiftAid_MN_1M = HHExpFCer_GiftAid_MN_7D ///
    + HHExpFTub_GiftAid_MN_7D ///
    + HHExpFPuls_GiftAid_MN_7D ///
    + HHExpFVeg_GiftAid_MN_7D ///
    + HHExpFFrt_GiftAid_MN_7D ///
    + HHExpFAnimMeat_GiftAid_MN_7D ///
    + HHExpFAnimFish_GiftAid_MN_7D ///
    + HHExpFFats_GiftAid_MN_7D ///
    + HHExpFDairy_GiftAid_MN_7D ///
    + HHExpFEgg_GiftAid_MN_7D ///
    + HHExpFSgr_GiftAid_MN_7D ///
    + HHExpFCond_GiftAid_MN_7D ///
    + HHExpFBev_GiftAid_MN_7D ///
    + HHExpFOut_GiftAid_MN_7D

replace HHExp_Food_GiftAid_MN_1M = HHExp_Food_GiftAid_MN_1M * (30/7)

label var HHExp_Food_GiftAid_MN_1M "Total monthly food consumption from gifts/aid"

* --- Monthly value of consumed food from own production ---

gen HHExp_Food_Own_MN_1M = HHExpFCer_Own_MN_7D ///
    + HHExpFTub_Own_MN_7D ///
    + HHExpFPuls_Own_MN_7D ///
    + HHExpFVeg_Own_MN_7D ///
    + HHExpFFrt_Own_MN_7D ///
    + HHExpFAnimMeat_Own_MN_7D ///
    + HHExpFAnimFish_Own_MN_7D ///
    + HHExpFFats_Own_MN_7D ///
    + HHExpFDairy_Own_MN_7D ///
    + HHExpFEgg_Own_MN_7D ///
    + HHExpFSgr_Own_MN_7D ///
    + HHExpFCond_Own_MN_7D ///
    + HHExpFBev_Own_MN_7D ///
    + HHExpFOut_Own_MN_7D

replace HHExp_Food_Own_MN_1M = HHExp_Food_Own_MN_1M * (30/7)

label var HHExp_Food_Own_MN_1M "Total monthly food consumption from own production"

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

foreach v in HHExpNFHyg_Purch_MN_1M HHExpNFHyg_GiftAid_MN_1M ///
    HHExpNFTransp_Purch_MN_1M HHExpNFTransp_GiftAid_MN_1M ///
    HHExpNFFuel_Purch_MN_1M HHExpNFFuel_GiftAid_MN_1M ///
    HHExpNFWat_Purch_MN_1M HHExpNFWat_GiftAid_MN_1M ///
    HHExpNFElec_Purch_MN_1M HHExpNFElec_GiftAid_MN_1M ///
    HHExpNFEnerg_Purch_MN_1M HHExpNFEnerg_GiftAid_MN_1M ///
    HHExpNFDwelSer_Purch_MN_1M HHExpNFDwelSer_GiftAid_MN_1M ///
    HHExpNFPhone_Purch_MN_1M HHExpNFPhone_GiftAid_MN_1M ///
    HHExpNFRecr_Purch_MN_1M HHExpNFRecr_GiftAid_MN_1M ///
    HHExpNFAlcTobac_Purch_MN_1M HHExpNFAlcTobac_GiftAid_MN_1M {

    replace `v' = 0 if missing(`v')
}

*** If the questionnaire included other short-term non-food categories, label the respective variables and add them to the calculations below

*** Label non-food variables, 6 months recall

label var HHExpNFMedServ_Purch_MN_6M     "Expenditures on health services in the past 6 months"
label var HHExpNFMedServ_GiftAid_MN_6M   "Value of consumed in-kind assistance and gifts - health services in the past 6 months"

label var HHExpNFMedGood_Purch_MN_6M     "Expenditures on medicines and health products in the past 6 months"
label var HHExpNFMedGood_GiftAid_MN_6M   "Value of consumed in-kind assistance and gifts - medicines and health products in the past 6 months"

label var HHExpNFCloth_Purch_MN_6M       "Expenditures on clothing and footwear in the past 6 months"
label var HHExpNFCloth_GiftAid_MN_6M     "Value of consumed in-kind assistance and gifts - clothing and footwear in the past 6 months"

label var HHExpNFEduFee_Purch_MN_6M      "Expenditures on education services in the past 6 months"
label var HHExpNFEduFee_GiftAid_MN_6M    "Value of consumed in-kind assistance and gifts - education services in the past 6 months"

label var HHExpNFEduGood_Purch_MN_6M     "Expenditures on education goods in the past 6 months"
label var HHExpNFEduGood_GiftAid_MN_6M   "Value of consumed in-kind assistance and gifts - education goods in the past 6 months"

label var HHExpNFRent_Purch_MN_6M        "Expenditures on rent in the past 6 months"
label var HHExpNFRent_GiftAid_MN_6M      "Value of consumed in-kind assistance and gifts - rent in the past 6 months"

label var HHExpNFHHSoft_Purch_MN_6M      "Expenditures on non-durable furniture or utensils in the past 6 months"
label var HHExpNFHHSoft_GiftAid_MN_6M    "Value of consumed in-kind assistance and gifts - non-durable furniture or utensils in the past 6 months"

label var HHExpNFHHMaint_Purch_MN_6M     "Expenditures on household routine maintenance in the past 6 months"
label var HHExpNFHHMaint_GiftAid_MN_6M   "Value of consumed in-kind assistance and gifts - household routine maintenance in the past 6 months"

***Converting system missing of the 6 month expediture of non-food items to 0

foreach v in HHExpNFMedServ_Purch_MN_6M HHExpNFMedServ_GiftAid_MN_6M ///
    HHExpNFMedGood_Purch_MN_6M HHExpNFMedGood_GiftAid_MN_6M ///
    HHExpNFCloth_Purch_MN_6M HHExpNFCloth_GiftAid_MN_6M ///
    HHExpNFEduFee_Purch_MN_6M HHExpNFEduFee_GiftAid_MN_6M ///
    HHExpNFEduGood_Purch_MN_6M HHExpNFEduGood_GiftAid_MN_6M ///
    HHExpNFRent_Purch_MN_6M HHExpNFRent_GiftAid_MN_6M ///
    HHExpNFHHSoft_Purch_MN_6M HHExpNFHHSoft_GiftAid_MN_6M ///
    HHExpNFHHMaint_Purch_MN_6M HHExpNFHHMaint_GiftAid_MN_6M {

    replace `v' = 0 if missing(`v')
}

*---------------------------------------------------------------*
* Short-term non-food expenditures (1-month recall, cash/credit)
*---------------------------------------------------------------*
gen HHExpNFTotal_Purch_MN_30D = HHExpNFHyg_Purch_MN_1M ///
    + HHExpNFTransp_Purch_MN_1M ///
    + HHExpNFFuel_Purch_MN_1M ///
    + HHExpNFWat_Purch_MN_1M ///
    + HHExpNFElec_Purch_MN_1M ///
    + HHExpNFEnerg_Purch_MN_1M ///
    + HHExpNFDwelSer_Purch_MN_1M ///
    + HHExpNFPhone_Purch_MN_1M ///
    + HHExpNFRecr_Purch_MN_1M ///
    + HHExpNFAlcTobac_Purch_MN_1M

*---------------------------------------------------------------*
* Long-term non-food expenditures (6-month recall, cash/credit)
* NOTE: Include rent only if it is part of your MEB definition.
*---------------------------------------------------------------*
gen HHExpNFTotal_Purch_MN_6M = HHExpNFMedServ_Purch_MN_6M ///
    + HHExpNFMedGood_Purch_MN_6M ///
    + HHExpNFCloth_Purch_MN_6M ///
    + HHExpNFEduFee_Purch_MN_6M ///
    + HHExpNFEduGood_Purch_MN_6M ///
    + HHExpNFRent_Purch_MN_6M ///  <-- include only if rent is part of MEB
    + HHExpNFHHSoft_Purch_MN_6M ///
    + HHExpNFHHMaint_Purch_MN_6M

* Convert 6-month totals to monthly averages
replace HHExpNFTotal_Purch_MN_6M = HHExpNFTotal_Purch_MN_6M / 6

*---------------------------------------------------------------*
* Total monthly non-food expenditures (cash & credit)
*---------------------------------------------------------------*
gen HHExpNFTotal_Purch_MN_1M = HHExpNFTotal_Purch_MN_30D + HHExpNFTotal_Purch_MN_6M
label var HHExpNFTotal_Purch_MN_1M "Total monthly non-food expenditure (cash and credit)"

*** Delete variables no longer needed (cash/credit)
drop HHExpNFTotal_Purch_MN_6M HHExpNFTotal_Purch_MN_30D

*** Calculate the total monthly value of used/consumed non-food recieved as gifts and/or aid

*---------------------------------------------------------------*
* Short-term non-food expenditures (1-month recall, gifts/aid)
*---------------------------------------------------------------*
gen HHExpNFTotal_GiftAid_MN_30D = HHExpNFHyg_GiftAid_MN_1M ///
    + HHExpNFTransp_GiftAid_MN_1M ///
    + HHExpNFFuel_GiftAid_MN_1M ///
    + HHExpNFWat_GiftAid_MN_1M ///
    + HHExpNFElec_GiftAid_MN_1M ///
    + HHExpNFEnerg_GiftAid_MN_1M ///
    + HHExpNFDwelSer_GiftAid_MN_1M ///
    + HHExpNFPhone_GiftAid_MN_1M ///
    + HHExpNFRecr_GiftAid_MN_1M ///
    + HHExpNFAlcTobac_GiftAid_MN_1M

*---------------------------------------------------------------*
* Long-term non-food expenditures (6-month recall, gifts/aid)
* NOTE: Include rent only if it is part of your MEB definition.
*---------------------------------------------------------------*
gen HHExpNFTotal_GiftAid_MN_6M = HHExpNFMedServ_GiftAid_MN_6M ///
    + HHExpNFMedGood_GiftAid_MN_6M ///
    + HHExpNFCloth_GiftAid_MN_6M ///
    + HHExpNFEduFee_GiftAid_MN_6M ///
    + HHExpNFEduGood_GiftAid_MN_6M ///
    + HHExpNFRent_GiftAid_MN_6M ///  <-- include only if rent is part of MEB
    + HHExpNFHHSoft_GiftAid_MN_6M ///
    + HHExpNFHHMaint_GiftAid_MN_6M

* Convert 6-month totals to monthly averages
replace HHExpNFTotal_GiftAid_MN_6M = HHExpNFTotal_GiftAid_MN_6M / 6

*---------------------------------------------------------------*
* Total monthly non-food consumption (gifts/aid)
*---------------------------------------------------------------*
gen HHExpNFTotal_GiftAid_MN_1M = HHExpNFTotal_GiftAid_MN_30D + HHExpNFTotal_GiftAid_MN_6M
label var HHExpNFTotal_GiftAid_MN_1M "Total monthly non-food consumption from gifts/aid"

* Housekeeping: drop temporary intermediates

drop HHExpNFTotal_GiftAid_MN_6M HHExpNFTotal_GiftAid_MN_30D

*** Calculate household economic capacity
*** Remember that in the version of ECMEN used for assessments (excluding humanitarian assistance), the value of consumed in-kind assistance and gifts should be excluded from the household economic capacity aggregate

*--------------------------------------------------------------------
* Aggregate FOOD expenditures (purchases + own production)
*--------------------------------------------------------------------
gen HHExpF_ECMEN = HHExp_Food_Purch_MN_1M + HHExp_Food_Own_MN_1M

*--------------------------------------------------------------------
* NON-FOOD ECMEN uses ONLY cash/credit expenditures
*--------------------------------------------------------------------
gen HHExpNF_ECMEN = HHExpNFTotal_Purch_MN_1M

*--------------------------------------------------------------------
* Total monthly household ECONOMIC CAPACITY
*--------------------------------------------------------------------
gen HHExp_ECMEN = HHExpF_ECMEN + HHExpNF_ECMEN
label var HHExp_ECMEN "Household Economic Capacity - monthly"


*** To calculate ECMEN, deduct cash assistance
*** Note that this step is done for assessments only, not when monitoring the effect of multipurpose cash programmes

label var HHAsstWFPCBTRecTot   "Amount of cash assistance received from WFP - last 3 months"
label var HHAsstUNNGOCBTRecTot "Amount of cash assistance received by other humanitarian partners - last 3 months"
label var HHAsstCBTCShare      "Share of cash assistance spent on consumption"

*** Sum the amount of cash assistancef received by WFP and other humanitarian partners (UN Agencies and NGOs) - do not include cash received from government, other organizations, and other households as this will not be deducted

foreach v in HHAsstWFPCBTRecTot HHAsstUNNGOCBTRecTot {
    replace `v' = 0 if missing(`v')
}

gen HHAsstCBTRec = HHAsstWFPCBTRecTot + HHAsstUNNGOCBTRecTot

*** Change to monthly recall
*** Note that the below is based on the standard mfodule with a 3 months recall period. If using any other recall period, adjust the syntax accordingly
gen HHAsstCBTRec_1M = HHAsstCBTRec / 3

**** Estimate the median share of assistance used for consumption
*--------------------------------------------------------------------
* Create a constant = 1 (SPSS uses this for grouping; Stata does not need it)
*--------------------------------------------------------------------
gen Constant = 1

*--------------------------------------------------------------------
* Compute the median of HHAsstCBTCShare across the entire dataset
*--------------------------------------------------------------------
quietly summarize HHAsstCBTCShare, detail
scalar median_CBTCShare = r(p50)

*--------------------------------------------------------------------
* Add the median value as a new variable for all observations
*--------------------------------------------------------------------
gen HHAsstCBTCShare_median = median_CBTCShare

*--------------------------------------------------------------------
* Rename to match SPSS version
*--------------------------------------------------------------------
rename HHAsstCBTCShare_median HHAsstCBTCShare_med

*--------------------------------------------------------------------
* Remove temporary constant variable
*--------------------------------------------------------------------
drop Constant

*** Multiply the cash assistance received by the median share used for consumption

gen HHAsstCBTRec_Cons_1M = HHAsstCBTRec_1M * (HHAsstCBTCShare_med / 100)

*** Deduct the cash assistance from the household economic capacity. If missing, replace by 0 (= no assistance received)

replace HHAsstCBTRec_Cons_1M = 0 if missing(HHAsstCBTRec_Cons_1M)

replace HHExp_ECMEN = HHExp_ECMEN - HHAsstCBTRec_Cons_1M

*** Express household economic capacity in per capita terms

gen PCExp_ECMEN = HHExp_ECMEN / HHSize   // Ensure HHSize is the correct household size variable name

label var PCExp_ECMEN "Household Economic Capacity per capita - monthly"

*** Compute ECMEN
*** Important: Ensure that MEB and SMEB variables are expressed in per capita terms

*** Option a: MEB

*** Define variable indicating if per capita Household Economic Capacity is equal or greater than MEB

*--------------------------------------------------------------------
* Create ECMEN_exclAsst only where BOTH PCExp_ECMEN and MEB are not missing
*--------------------------------------------------------------------
gen ECMEN_exclAsst = .    // initialize as missing

replace ECMEN_exclAsst = (PCExp_ECMEN > MEB) if !missing(PCExp_ECMEN) | !missing(MEB)

label var ECMEN_exclAsst "Economic capacity to meet essential needs - excluding assistance"

label define ECMENlbl 1 "Above MEB" 0 "Below MEB"
label values ECMEN_exclAsst ECMENlbl

tabulate ECMEN_exclAsst


*** Option b: SMEB (when applicabfle)

*** Define variable indicating if per capita Household Economic Capacity is equal or greater than SMEB.

*--------------------------------------------------------------------
* Create the SMEB ECMEN indicator (excluding assistance)
*--------------------------------------------------------------------
gen ECMEN_exclAsst_SMEB = .   // start as missing * Compute only if NOT (both are missing)

replace ECMEN_exclAsst_SMEB = (PCExp_ECMEN > SMEB) if !missing(PCExp_ECMEN) | !missing(SMEB)

label var ECMEN_exclAsst_SMEB "Economic capacity to meet essential needs - SMEB - excluding assistance"

label define smeblbl 1 "Above SMEB" 0 "Below SMEB"
label values ECMEN_exclAsst_SMEB smeblbl

tabulate ECMEN_exclAsst_SMEB