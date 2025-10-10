* Encoding: UTF-8.
*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                                       Food Expenditure Share (FES)


*** Last Update  : #/#/2025
*** Purpose: This script calculates the Food Expenditure Share

***   Data Quality Guidance References:
***   - Recommended usage of constraints and warning messages in coded tool: Page 18 and page 21
***   - Recommended high frequency checks: Page 31-32
***   - Recommended cleaning steps: Page 38-40
***   - Automised data cleaning syntax: Find on the VAM Resource Centre (Food Expenditure Share page)
 ********************************************************************************************************* ODAI - PLEASE ENSURE IT IS UPLOADED TO THIS PAGE

*** ----------------------------------------------------------------------------------------------------
 
*** Important note: The value of consumed in-kind assistance/gifts must always be considered when calculating the FES - both for VAM and monitoring  

*** Define group labels -  these should match Survey Designer naming conventions
*** This syntax uses the recommended standard recall period of 7 days. If your CO has selected the 1 month recall period, you need to change the variable names accordingly (replace 7D with 1M)

VARIABLE LABELS
HHExpFCer_Purch_MN_7D                 ‘Weekly expenditures on cereals’
HHExpFCer_GiftAid_MN_7D                ‘Weekly value of consumed in-kind assistance and gifts - cereals’
HHExpFCer_Own_MN_7D                    ‘Weekly value of consumed own production - cereals’
HHExpFTub_Purch_MN_7D                 ‘Weekly expenditures on tubers’
HHExpFTub_GiftAid_MN_7D                ‘Weekly value of consumed in-kind assistance and gifts - tubers’
HHExpFTub_Own_MN_7D                   ‘Weekly value of consumed own production - tubers’
HHExpFPuls_Purch_MN_7D                ‘Weekly expenditures on pulses and nuts’
HHExpFPuls_GiftAid_MN_7D               ‘Weekly value of consumed in-kind assistance and gifts - pulses and nuts’
HHExpFPuls_Own_MN_7D                   ‘Weekly value of consumed own production - pulses & nuts’
HHExpFVeg_Purch_MN_7D                  ‘Weekly expenditures on vegetables’
HHExpFVeg_GiftAid_MN_7D                 ‘Weekly value of consumed in-kind assistance and gifts - vegetables’
HHExpFVeg_Own_MN_7D                    ‘Weekly value of consumed own production - vegetables’
HHExpFFrt_Purch_MN_7D                    ‘Weekly expenditures on fruits’
HHExpFFrt_GiftAid_MN_7D                   ‘Weekly value of consumed in-kind assistance and gifts - fruits’
HHExpFFrt_Own_MN_7D                      ‘Weekly value of consumed own production - fruits’
HHExpFAnimMeat_Purch_MN_7D      ‘Weekly expenditures on meat’
HHExpFAnimMeat_GiftAid_MN_7D     'Weekly value of consumed in-kind assistance and gifts - meat'
HHExpFAnimMeat_Own_MN_7D         ‘Weekly value of consumed own production - meat’
HHExpFAnimFish_Purch_MN_7D       ‘Weekly expenditures on fish’
HHExpFAnimFish_GiftAid_MN_7D      ‘Weekly value of consumed in-kind assistance and gifts - fish’
HHExpFAnimFish_Own_MN_7D          ‘Weekly value of consumed own production - fish’
HHExpFFats_Purch_MN_7D                 ‘Weekly expenditures on fats’
HHExpFFats_GiftAid_MN_7D                ‘Weekly value of consumed in-kind assistance and gifts - fats’
HHExpFFats_Own_MN_7D                   ‘Weekly value of consumed own production - fats’
HHExpFDairy_Purch_MN_7D               'Weekly expenditures on milk or dairy products'
HHExpFDairy_GiftAid_MN_7D              ‘Weekly value of consumed in-kind assistance and gifts - milk or dairy products’
HHExpFDairy_Own_MN_7D                 ‘Weekly value of consumed own production - milk or dairy products’
HHExpFEgg_Purch_MN_7D                 ‘Weekly expenditures on eggs’
HHExpFEgg_GiftAid_MN_7D                ‘Weekly value of consumed in-kind assistance and gifts - eggs’
HHExpFEgg_Own_MN_7D                   'Weekly value of consumed own production - eggs'
HHExpFSgr_Purch_MN_7D                  'Weekly expenditures on sugar or confectionery or desserts'
HHExpFSgr_GiftAid_MN_7D                 ‘Weekly value of consumed in-kind assistance and gifts - sugar or confectionery or desserts’
HHExpFSgr_Own_MN_7D                    ‘Weekly value of consumed own production - sugar or confectionery or desserts’
HHExpFCond_Purch_MN_7D              ‘Weekly expenditures on condiments’
HHExpFCond_GiftAid_MN_7D              ‘Weekly value of consumed in-kind assistance and gifts - condiments’
HHExpFCond_Own_MN_7D                 ‘Weekly value of consumed own production - condiments’
HHExpFBev_Purch_MN_7D                  ‘Weekly expenditures on beverages’
HHExpFBev_GiftAid_MN_7D                 ‘Weekly value of consumed in-kind assistance and gifts - beverages’
HHExpFBev_Own_MN_7D                    ‘Weekly value of consumed own production - beverages’
HHExpFOut_Purch_MN_7D                  ‘Weekly expenditures on snacks or meals prepared outside’
HHExpFOut_GiftAid_MN_7D                 ‘Weekly value of consumed in-kind assistance and gifts - snacks or meals prepared outside’
HHExpFOut_Own_MN_7D                     ‘Weekly value of consumed own production - snacks or meals prepared outside’.
EXECUTE.

***Converting system missing of the food expenditure to 0

recode HHExpFCer_Purch_MN_7D HHExpFCer_GiftAid_MN_7D HHExpFCer_Own_MN_7D HHExpFTub_Purch_MN_7D HHExpFTub_GiftAid_MN_7D HHExpFTub_Own_MN_7D HHExpFPuls_Purch_MN_7D 
HHExpFPuls_GiftAid_MN_7D  HHExpFPuls_Own_MN_7D HHExpFVeg_Purch_MN_7D HHExpFVeg_GiftAid_MN_7D HHExpFVeg_Own_MN_7D HHExpFFrt_Purch_MN_7D HHExpFFrt_GiftAid_MN_7D HHExpFFrt_Own_MN_7D 
HHExpFAnimMeat_Purch_MN_7D HHExpFAnimMeat_GiftAid_MN_7D HHExpFAnimMeat_Own_MN_7D HHExpFAnimFish_Purch_MN_7D HHExpFAnimFish_GiftAid_MN_7D HHExpFAnimFish_Own_MN_7D HHExpFFats_Purch_MN_7D 
HHExpFFats_GiftAid_MN_7D HHExpFFats_Own_MN_7D HHExpFDairy_Purch_MN_7D HHExpFDairy_GiftAid_MN_7D HHExpFDairy_Own_MN_7D HHExpFEgg_Purch_MN_7D HHExpFEgg_GiftAid_MN_7D HHExpFEgg_Own_MN_7D 
HHExpFSgr_Purch_MN_7D HHExpFSgr_GiftAid_MN_7D HHExpFSgr_Own_MN_7D HHExpFCond_Purch_MN_7D HHExpFCond_GiftAid_MN_7D HHExpFCond_Own_MN_7D HHExpFBev_Purch_MN_7D HHExpFBev_GiftAid_MN_7D 
HHExpFBev_Own_MN_7D HHExpFOut_Purch_MN_7D HHExpFOut_GiftAid_MN_7D HHExpFOut_Own_MN_7D (sysmis=0).
execute.


*** Check expenditures to get an overview of the data and potential outliers

FREQUENCIES VARIABLES=  HHExpFCer_Purch_MN_7D HHExpFCer_GiftAid_MN_7D HHExpFCer_Own_MN_7D HHExpFTub_Purch_MN_7D HHExpFTub_GiftAid_MN_7D HHExpFTub_Own_MN_7D HHExpFPuls_Purch_MN_7D 
HHExpFPuls_GiftAid_MN_7D  HHExpFPuls_Own_MN_7D HHExpFVeg_Purch_MN_7D HHExpFVeg_GiftAid_MN_7D HHExpFVeg_Own_MN_7D HHExpFFrt_Purch_MN_7D HHExpFFrt_GiftAid_MN_7D HHExpFFrt_Own_MN_7D 
HHExpFAnimMeat_Purch_MN_7D HHExpFAnimMeat_GiftAid_MN_7D HHExpFAnimMeat_Own_MN_7D HHExpFAnimFish_Purch_MN_7D HHExpFAnimFish_GiftAid_MN_7D HHExpFAnimFish_Own_MN_7D HHExpFFats_Purch_MN_7D 
HHExpFFats_GiftAid_MN_7D HHExpFFats_Own_MN_7D HHExpFDairy_Purch_MN_7D HHExpFDairy_GiftAid_MN_7D HHExpFDairy_Own_MN_7D HHExpFEgg_Purch_MN_7D HHExpFEgg_GiftAid_MN_7D HHExpFEgg_Own_MN_7D 
HHExpFSgr_Purch_MN_7D HHExpFSgr_GiftAid_MN_7D HHExpFSgr_Own_MN_7D HHExpFCond_Purch_MN_7D HHExpFCond_GiftAid_MN_7D HHExpFCond_Own_MN_7D HHExpFBev_Purch_MN_7D HHExpFBev_GiftAid_MN_7D 
HHExpFBev_Own_MN_7D HHExpFOut_Purch_MN_7D HHExpFOut_GiftAid_MN_7D HHExpFOut_Own_MN_7D
  /FORMAT=NOTABLE
  /STATISTICS=MINIMUM MAXIMUM MEAN.

*** ----------------------------------------------------------------------------------------------------


*** Important step
*** After getting the overview of the raw data, it is now recommended to use the standard cleaning syntax found on the VAM Resource Centre to do the standard cleaning. Following this, additional contextual cleaning can
be done if neccessary. It is not recommended to move to the below step until the data has been cleaned


*** ----------------------------------------------------------------------------------------------------

*** Calculate total monthly value of food expenditures/consumption by source

*** This syntax uses the recommended standard recall period of 7 days. If your CO has selected the 1 month recall period, ensure you adjust the below accordingly

*** Calculate monthly food expenditures in cash/credit

COMPUTE HHExp_Food_Purch_MN_1M = HHExpFCer_Purch_MN_7D + HHExpFTub_Purch_MN_7D + HHExpFPuls_Purch_MN_7D + HHExpFVeg_Purch_MN_7D + HHExpFFrt_Purch_MN_7D + HHExpFAnimMeat_Purch_MN_7D +
HHExpFAnimFish_Purch_MN_7D + HHExpFFats_Purch_MN_7D + HHExpFDairy_Purch_MN_7D + HHExpFEgg_Purch_MN_7D + HHExpFSgr_Purch_MN_7D + HHExpFCond_Purch_MN_7D + HHExpFBev_Purch_MN_7D + HHExpFOut_Purch_MN_7D.
COMPUTE HHExp_Food_Purch_MN_1M=HHExp_Food_Purch_MN_1M*(30/7).
VARIABLE LABELS HHExp_Food_Purch_MN_1M “Total monthly food expenditure (cash and credit)”.
EXECUTE.

*** Calculate monthly value of consumed food from gift/aid

COMPUTE HHExp_Food_GiftAid_MN_1M = HHExpFCer_GiftAid_MN_7D + HHExpFTub_GiftAid_MN_7D + HHExpFPuls_GiftAid_MN_7D + HHExpFVeg_GiftAid_MN_7D + HHExpFFrt_GiftAid_MN_7D + HHExpFAnimMeat_GiftAid_MN_7D + 
HHExpFAnimFish_GiftAid_MN_7D + HHExpFFats_GiftAid_MN_7D + HHExpFDairy_GiftAid_MN_7D + HHExpFEgg_GiftAid_MN_7D + HHExpFSgr_GiftAid_MN_7D + HHExpFCond_GiftAid_MN_7D + HHExpFBev_GiftAid_MN_7D + HHExpFOut_GiftAid_MN_7D.
COMPUTE HHExp_Food_GiftAid_MN_1M=HHExp_Food_GiftAid_MN_1M*(30/7).
VARIABLE LABELS  HHExp_Food_GiftAid_MN_1M 'Total monthly food consumption from gifts/aid'.
EXECUTE.

*** Calculate monthly value of consumed food from own production

COMPUTE HHExp_Food_Own_MN_1M = HHExpFCer_Own_MN_7D + HHExpFTub_Own_MN_7D + HHExpFPuls_Own_MN_7D + HHExpFVeg_Own_MN_7D + HHExpFFrt_Own_MN_7D + HHExpFAnimMeat_Own_MN_7D + 
HHExpFAnimFish_Own_MN_7D + HHExpFFats_Own_MN_7D + HHExpFDairy_Own_MN_7D + HHExpFEgg_Own_MN_7D + HHExpFSgr_Own_MN_7D + HHExpFCond_Own_MN_7D + HHExpFBev_Own_MN_7D + HHExpFOut_Own_MN_7D.
COMPUTE HHExp_Food_Own_MN_1M=HHExp_Food_Own_MN_1M*(30/7).
VARIABLE LABELS HHExp_Food_Own_MN_1M “Total monthly food consumption from own production”.
EXECUTE.

*** Label non-food variables, 1 month recall

VARIABLE LABELS
HHExpNFHyg_Purch_MN_1M              ‘Monthly expenditures on hygiene’
HHExpNFHyg_GiftAid_MN_1M             ‘Monthly value of consumed in-kind assistance and gifts - hygiene’
HHExpNFTransp_Purch_MN_1M        ‘Monthly expenditures on transport’
HHExpNFTransp_GiftAid_MN_1M       ‘Monthly value of consumed in-kind assistance and gifts - transport’
HHExpNFFuel_Purch_MN_1M             ‘Monthly expenditures on fuel’
HHExpNFFuel_GiftAid_MN_1M            ‘Monthly value of consumed in-kind assistance and gifts - fuel’
HHExpNFWat_Purch_MN_1M              ‘Monthly expenditures on water’
HHExpNFWat_GiftAid_MN_1M             ‘Monthly value of consumed in-kind assistance and gifts - water’
HHExpNFElec_Purch_MN_1M             ‘Monthly expenditures on electricity’
HHExpNFElec_GiftAid_MN_1M            ‘Monthly value of consumed in-kind assistance and gifts - electricity’
HHExpNFEnerg_Purch_MN_1M          ‘Monthly expenditures on energy (not electricity)’
HHExpNFEnerg_GiftAid_MN_1M         ‘Monthly value of consumed in-kind assistance and gifts - energy (not electricity)’
HHExpNFDwelSer_Purch_MN_1M      ‘Monthly expenditures on services related to dwelling’
HHExpNFDwelSer_GiftAid_MN_1M     ‘Monthly value of consumed in-kind assistance and gifts - services related to dwelling’
HHExpNFPhone_Purch_MN_1M          ‘Monthly expenditures on communication’
HHExpNFPhone_GiftAid_MN_1M         ‘Monthly value of consumed in-kind assistance and gifts - communication’
HHExpNFRecr_Purch_MN_1M             ‘Monthly expenditures on recreation’
HHExpNFRecr_GiftAid_MN_1M            ‘Monthly value of consumed in-kind assistance and gifts - recreation’
HHExpNFAlcTobac_Purch_MN_1M     ‘Monthly expenditures on alcohol or tobacco’
HHExpNFAlcTobac_GiftAid_MN_1M    ‘Monthly value of consumed in-kind assistance and gifts - alcohol or tobacco’.
EXECUTE.

***Converting system missing of the non-food expenditure to 0

recode HHExpNFHyg_Purch_MN_1M HHExpNFHyg_GiftAid_MN_1M HHExpNFTransp_Purch_MN_1M HHExpNFTransp_Purch_MN_1M HHExpNFTransp_GiftAid_MN_1M 
     HHExpNFFuel_Purch_MN_1M HHExpNFFuel_GiftAid_MN_1M HHExpNFWat_Purch_MN_1M HHExpNFWat_GiftAid_MN_1M HHExpNFElec_Purch_MN_1M HHExpNFElec_GiftAid_MN_1M    
     HHExpNFEnerg_Purch_MN_1M HHExpNFEnerg_GiftAid_MN_1M HHExpNFDwelSer_Purch_MN_1M HHExpNFDwelSer_GiftAid_MN_1M HHExpNFPhone_Purch_MN_1M 
     HHExpNFPhone_GiftAid_MN_1M HHExpNFRecr_Purch_MN_1M HHExpNFRecr_GiftAid_MN_1M HHExpNFAlcTobac_Purch_MN_1M HHExpNFAlcTobac_GiftAid_MN_1M (sysmis=0).
execute.

*** If the questionnaire included other short-term non-food categories, label the respective variables and add them to the calculations below

*** Label non-food variables, 6 months recall

VARIABLE LABELS
HHExpNFMedServ_Purch_MN_6M     ‘Expenditures on health services in the past 6 months’
HHExpNFMedServ_GiftAid_MN_6M    ‘Value of consumed in-kind assistance and gifts - health services in the past 6 months’
HHExpNFMedGood_Purch_MN_6M   ‘Expenditures on medicines and health products in the past 6 months’
HHExpNFMedGood_GiftAid_MN_6M  ‘Value of consumed in-kind assistance and gifts - medicines and health products in the past 6 months’
HHExpNFCloth_Purch_MN_6M           ‘Expenditures on clothing and footwear in the past 6 months’
HHExpNFCloth_GiftAid_MN_6M          ‘Value of consumed in-kind assistance and gifts - clothing and footwear in the past 6 months’
HHExpNFEduFee_Purch_MN_6M      ‘Expenditures on education services in the past 6 months’
HHExpNFEduFee_GiftAid_MN_6M     ‘Value of consumed in-kind assistance and gifts - education services in the past 6 months’
HHExpNFEduGood_Purch_MN_6M   ‘Expenditures on education goods in the past 6 months’
HHExpNFEduGood_GiftAid_MN_6M  ‘Value of consumed in-kind assistance and gifts - education goods in the past 6 months’
HHExpNFRent_Purch_MN_6M            ‘Expenditures on rent in the past 6 months’
HHExpNFRent_GiftAid_MN_6M           ‘Value of consumed in-kind assistance and gifts - rent in the past 6 months’
HHExpNFHHSoft_Purch_MN_6M       ‘Expenditures on non-durable furniture or utensils in the past 6 months’
HHExpNFHHSoft_GiftAid_MN_6M      ‘Value of consumed in-kind assistance and gifts - non-durable furniture or utensils in the past 6 months’
HHExpNFHHMaint_Purch_MN_6M     ‘Expenditures on household routine maintenance in the past 6 months’
HHExpNFHHMaint_GiftAid_MN_6M    ‘Value of consumed in-kind assistance and gifts - household routine maintenance in the past 6 months’.
EXECUTE.


***Converting system missing of the 6 month expediture of non-food items to 0

recode HHExpNFMedServ_Purch_MN_6M HHExpNFMedServ_GiftAid_MN_6M HHExpNFMedGood_Purch_MN_6M HHExpNFMedGood_GiftAid_MN_6M HHExpNFCloth_Purch_MN_6M
    HHExpNFCloth_Purch_MN_6M HHExpNFCloth_GiftAid_MN_6M HHExpNFEduFee_Purch_MN_6M HHExpNFEduFee_GiftAid_MN_6M HHExpNFEduGood_Purch_MN_6M
     HHExpNFEduGood_GiftAid_MN_6M HHExpNFRent_Purch_MN_6M HHExpNFRent_GiftAid_MN_6M HHExpNFHHSoft_Purch_MN_6M HHExpNFHHSoft_GiftAid_MN_6M   
     HHExpNFHHMaint_Purch_MN_6M HHExpNFHHMaint_GiftAid_MN_6M (sysmis=0).
execute.


*** If the questionnaire included other long-term non-food categories, label the respective variables and add them to the calculations below

*** Calculate total monthly non-food expenditures purchased with cash or credit

*** Short-term non-food expenditures, 1 month recall (cash/credit)


COMPUTE HHExpNFTotal_Purch_MN_30D = HHExpNFHyg_Purch_MN_1M + HHExpNFTransp_Purch_MN_1M + HHExpNFFuel_Purch_MN_1M + HHExpNFWat_Purch_MN_1M + HHExpNFElec_Purch_MN_1M + HHExpNFEnerg_Purch_MN_1M +
HHExpNFDwelSer_Purch_MN_1M + HHExpNFPhone_Purch_MN_1M + HHExpNFRecr_Purch_MN_1M + HHExpNFAlcTobac_Purch_MN_1M.
EXECUTE.

*** Long-term non-food expenditures, 6 month recall (cash/credit)

COMPUTE HHExpNFTotal_Purch_MN_6M = HHExpNFMedServ_Purch_MN_6M + HHExpNFMedGood_Purch_MN_6M + HHExpNFCloth_Purch_MN_6M + HHExpNFEduFee_Purch_MN_6M + HHExpNFEduGood_Purch_MN_6M + 
HHExpNFRent_Purch_MN_6M + HHExpNFHHSoft_Purch_MN_6M + HHExpNFHHMaint_Purch_MN_6M. /* careful with rent: should include only if also incuded in MEB.*****************************************************************************************
EXECUTE.

*** Convert long-term expenditures to monthly average (cash/credit)

COMPUTE HHExpNFTotal_Purch_MN_6M=HHExpNFTotal_Purch_MN_6M/6.
EXECUTE.

*** Calculate the total monthly non-food expenditures (cash/credit)

COMPUTE HHExpNFTotal_Purch_MN_1M = HHExpNFTotal_Purch_MN_30D + HHExpNFTotal_Purch_MN_6M.
VARIABLE LABELS HHExpNFTotal_Purch_MN_1M “Total monthly non-food expenditure (cash and credit)”.
EXECUTE.

*** Delete variables no longer needed (cash/credit)

DELETE VARIABLES HHExpNFTotal_Purch_MN_6M HHExpNFTotal_Purch_MN_30D.
EXECUTE.

*** Calculate the total monthly value of used/consumed non-food recieved as gifts and/or aid

*** Short-term non-food expenditures, 1 month recall (gifts and/or aid)

COMPUTE HHExpNFTotal_GiftAid_MN_30D = HHExpNFHyg_GiftAid_MN_1M + HHExpNFTransp_GiftAid_MN_1M + HHExpNFFuel_GiftAid_MN_1M + HHExpNFWat_GiftAid_MN_1M + HHExpNFElec_GiftAid_MN_1M + 
HHExpNFEnerg_GiftAid_MN_1M + HHExpNFDwelSer_GiftAid_MN_1M + HHExpNFPhone_GiftAid_MN_1M + HHExpNFRecr_GiftAid_MN_1M + HHExpNFAlcTobac_GiftAid_MN_1M.
EXECUTE.

*** Long-term non-food expenditures, 6 month recall (gifts and/or aid)

COMPUTE HHExpNFTotal_GiftAid_MN_6M = HHExpNFMedServ_GiftAid_MN_6M + HHExpNFMedGood_GiftAid_MN_6M + HHExpNFCloth_GiftAid_MN_6M + HHExpNFEduFee_GiftAid_MN_6M + HHExpNFEduGood_GiftAid_MN_6M + 
HHExpNFRent_GiftAid_MN_6M + HHExpNFHHSoft_GiftAid_MN_6M + HHExpNFHHMaint_GiftAid_MN_6M. /* careful with rent: should include only if also incuded in MEB.
EXECUTE.

*** Convert long-term expenditures to monthly averages (gifts and/or aid)

COMPUTE HHExpNFTotal_GiftAid_MN_6M=HHExpNFTotal_GiftAid_MN_6M/6.
EXECUTE.

*** Calculate the total monthly non-food expenditures (gifts and/or aid)

COMPUTE HHExpNFTotal_GiftAid_MN_1M = HHExpNFTotal_GiftAid_MN_30D + HHExpNFTotal_GiftAid_MN_6M.
VARIABLE LABELS HHExpNFTotal_GiftAid_MN_1M 'Total monthly non-food consumption from gifts/aid'.
EXECUTE.

DELETE VARIABLES HHExpNFTotal_GiftAid_MN_6M HHExpNFTotal_GiftAid_MN_30D.
EXECUTE.

*** Calculate total food and non-food consumption expenditures

*** Calculate total food expenditures from cash/credit expenditure, value of consumed gifts/aid and value of consumed food from own production

COMPUTE HHExpF_1M = HHExp_Food_Purch_MN_1M + HHExp_Food_GiftAid_MN_1M + HHExp_Food_Own_MN_1M.
EXECUTE.

*** Calculate total non-food expenditures from cash/credit and value of utlized/consumed non-food items received as gifts/aid

COMPUTE HHExpNF_1M = HHExpNFTotal_Purch_MN_1M + HHExpNFTotal_GiftAid_MN_1M.
EXECUTE.

*** Calculate the total monthly expenditures for the household

COMPUTE HHExp_1M = HHExpF_1M + HHExpNF_1M.
EXECUTE.

*** Check total monthly expenditures - are they realistic for your context or are they indicating that more cleaning is needed. This could be outliers (very high and/or very low expenditures for a household), scewed results including 
very high non-food expenditures with very low food expenditures etc.

*** Before deciding on cleaning, it is recommended to calculate per capita expenditures to take into account the household size
    
FREQUENCIES HHExpF_1M HHExpNF_1M HHExp_1M.

*** Calculate the Food Expenditure Share

COMPUTE FES = HHExpF_1M/HHExp_1M.
EXECUTE.

VARIABLE LABELS FES 'Food Expenditure Share'.
EXECUTE.

RECODE FES (LOWEST THRU .4999999 = 1) (.50 THRU .64999999 = 2) (.65 THRU .74999999 = 3) (.75 THRU HIGHEST = 4) INTO Foodexp_4pt.
Variable labels Foodexp_4pt 'Food expenditure share categories'.
VALUE LABELS Foodexp_4pt 
    1 'Low Food Expenditure Share (<50%)' 
    2 'Medium Food Expenditure Share (50-65%)'
    3 'High Food Expenditure Share (65-75%)'
    4 'Very High Food Expenditure Share (> 75%)'.
EXECUTE.

FREQUENCIES Foodexp_4pt.
    




