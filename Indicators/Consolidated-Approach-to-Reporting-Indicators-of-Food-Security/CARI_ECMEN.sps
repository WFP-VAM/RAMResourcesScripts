* Encoding: UTF-8.

*** --------------------------------------------------------------------------

***	                   WFP Standard Scripts
***            Consolidated Approach for Reporting Indicators of Food Security (CARI)
***                     CALCULATE CARI using FCS, rCSI, LCS and ECMEN

*** --------------------------------------------------------------------------
    
*Note that there are two ways to calculate CARI - using FES or ECMEN. This version is for FES. However, please navigate to the script for ECMEN as relevant. 

***Food Consumption Score***

***Define labels  

Variable labels
FCSStap      'Consumption of cereals, grains, roots and tubers'
FCSPulse    'Consumption of pulses'
FCSDairy     'Consumption of dairy products'
FCSPr          'Consumption of meat, fish and eggs'
FCSVeg       'Consumption of vegetables and leaves'
FCSFruit      'Consumption of fruit'
FCSFat        'Consumption of fats and oils'
FCSSugar   'Consumption of sugar or sweets'
FCSCond    'Consumption of condiments or spices'.

*Note that after cleaning, there are likely to be some missing values, so ensure that you are using + and not sum() so that those missing values are not included in the calculation.*

Compute FCS = FCSStap*2 + FCSPulse*3 + FCSDairy*4 + FCSPr*4 + FCSVeg*1 + FCSFruit*1 + FCSFat*0.5 + FCSSugar*0.5.
Variable labels FCS "Food Consumption Score".
EXECUTE.

*** Important note: pay attention to the threshold used by your CO when selecting the syntax (21 cat. vs 28 cat.)
*** Use this when analyzing a country with low consumption of sugar and oil - thresholds 21-35

Recode FCS (lowest thru 21 = 1) (21.5 thru 35 = 2) (35.5 thru highest = 3) into FCSCat21.
Variable labels FCSCat21 "FCS Categories: 21/35 thresholds".
EXECUTE.

*** Define value labels for "FCS Categories".

Value labels FCSCat21 1.00 "Poor" 2.00 "Borderline" 3.00 "Acceptable".
EXECUTE.

*** Use this when analyzing a country with high consumption of sugar and oil – thresholds 28-42

Recode FCS (lowest thru 28 = 1) (28.5 thru 42 = 2) (42.5 thru highest = 3) into FCSCat28.
Variable labels FCSCat28 "FCS Categories: 28/42 thresholds".
EXECUTE.

*** Define value labels for "FCS Categories"

Value labels FCSCat28 1.00 "Poor" 2.00 "Borderline" 3.00 "Acceptable".
EXECUTE.

*** Important note: reminder to pay attention to the threshold used by your CO when selecting the syntax (FCSCat21 or FCSCat28)
    *** Create FCS_4pt for CARI calculation

Recode FCSCat21 (1=4) (2=3) (3=1) INTO FCS_4pt. 
Variable labels FCS_4pt '4pt FCG'.
Value labels FCS_4pt 1.00 'Acceptable' 3.00 'Borderline' 4.00 'Poor'. 
EXECUTE.

Frequencies VARIABLES=FCS_4pt /ORDER=ANALYSIS. 
EXECUTE.

***Reduced Coping Strategy Index***
***define labels  

Variable labels
rCSILessQlty    Rely on less preferred and less expensive food in the past 7 days
rCSIBorrow       Borrow food or rely on help from a relative or friend in the past 7 days
rCSIMealNb      Reduce number of meals eaten in a day in the past 7 days
rCSIMealSize    Limit portion size of meals at meal times in the past 7 days
rCSIMealAdult   Restrict consumption by adults in order for small children to eat in the past 7 days.

Compute rCSI = sum(rCSILessQlty*1,rCSIBorrow*2,rCSIMealNb*1,rCSIMealSize*1,rCSIMealAdult*3).
variable labels rCSI 'Reduced coping strategies index (rCSI)'.
EXECUTE.

FREQUENCIES VARIABLES=rCSI
  /FORMAT=NOTABLE
  /STATISTICS=MEAN MAXIMUM MINIMUM
  /ORDER=ANALYSIS.

***Combining rCSI with FCS_4pt for CARI calculation (current consumption) 

Do if (rCSI  >= 4).
Recode FCS_4pt (1=2).
End if.
EXECUTE.

Value labels FCS_4pt 1.00 'Acceptable' 2.00 ' Acceptable and rCSI>4' 3.00 'Borderline' 4.00 'Poor'. 
EXECUTE.

Frequencies FCS_4pt.

***Livelihood Coping Strategies***
*** Define labels

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* STRESS STRATEGIES

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 
* reminder: this is just an example of four stress strategies. You will need to replace with the four strategies selected for your specific case

*Variable labels: 

VARIABLE LABELS
 Lcs_stress_DomAsset "Sold household assets/goods (radio, furniture, refrigerator, relevision, jewellery, etc.)" 
 Lcs_stress_Utilities "Reduced or ceased payments on essential utilities and bills " 
 Lcs_stress_Saving "Spent saving" 
 Lcs_stress_BorrowCash "Borrowed cash".

*% of household who adopted one or more stress coping strategies 

DO IF Lcs_stress_DomAsset=20 | Lcs_stress_DomAsset=30 | Lcs_stress_Utilities=20 | Lcs_stress_Utilities=30 | Lcs_stress_Saving=20 | Lcs_stress_Saving=30 | Lcs_stress_BorrowCash=20 | Lcs_stress_BorrowCash=30. 
COMPUTE stress_coping_FS=1.
ELSE. 
COMPUTE stress_coping_FS = 0. 
 END IF.

VARIABLE LABELS stress_coping_FS "Did the HH engage in stress coping strategies?" .

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* CRISIS STRATEGIES

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 
* reminder: this is just an example of three crisis strategies. You will need to replace with the three strategies selected for your specific case

*Variables lables: 

Variable labels 
Lcs_crisis_ProdAssets "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.) "
Lcs_crisis_Health "Reduced expenses on health (including drugs)"
Lcs_crisis_OutSchool  "Withdrew children from school".

*% of household who adopted one or more crisis coping strategies 

DO IF Lcs_crisis_ProdAssets = 20 | Lcs_crisis_ProdAssets = 30 | Lcs_crisis_Health  = 20 | Lcs_crisis_Health  = 30 | Lcs_crisis_OutSchool =20 | Lcs_crisis_OutSchool =30.

COMPUTE crisis_coping_FS =1. 
ELSE. 
COMPUTE crisis_coping_FS =0.  
END IF. 

EXECUTE. 

VARIABLE LABELS crisis_coping_FS "Did the HH engage in crisis coping strategies?" .

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* EMERGENCY STRATEGIES:

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 
* reminder: this is just an example of three emergency strategies. You will need to replace with the three strategies selected for your specific case

*Variables lables: 

VARIABLE LABELS
 Lcs_em_ResAsset "Mortaged/Sold house or land" 
 Lcs_em_Begged "Begged and/or scavenged (asked strangers for money/food/other goods)" 
 Lcs_em_IllegalAct "Had to engage in illegal income activities (theft, prostitution)" .

*% of household who adopted one or more emergency coping strategies 

DO IF Lcs_em_ResAsset = 20 | Lcs_em_ResAsset = 30 | Lcs_em_Begged  = 20 | Lcs_em_Begged  = 30 | Lcs_em_IllegalAct =20 | Lcs_em_IllegalAct =30.

COMPUTE emergency_coping_FS =1. 
ELSE. 
COMPUTE emergency_coping_FS =0.  
END IF. 

VARIABLE LABELS emergency_coping_FS  'Did the HH engage in emergency coping strategies?'.

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* COPING behaviour 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*

* this variable counts the strategies with valid (i.e. non missing) values - normally it should be equal to 10 for all respondents.
COMPUTE temp_nonmiss_number=NVALID(Lcs_stress_DomAsset, Lcs_stress_Utilities , Lcs_stress_Saving , Lcs_stress_BorrowCash , Lcs_crisis_ProdAssets , Lcs_crisis_Health , Lcs_crisis_OutSchool , Lcs_em_ResAsset , Lcs_em_Begged , Lcs_em_IllegalAct).
EXECUTE.
VARIABLE LABELS temp_nonmiss_number  "Number of strategies with non missing values".

DO IF  temp_nonmiss_number>0. 
COMPUTE Max_coping_behaviourFS=1.
END IF.
* the Max_coping_behaviourFS variable will be missing for an observation if answers to strategies are all missing.

DO IF stress_coping_FS=1.
COMPUTE Max_coping_behaviourFS=2.
END IF.

DO IF crisis_coping_FS=1 .
COMPUTE Max_coping_behaviourFS=3.
END IF.

DO IF  emergency_coping_FS=1.
COMPUTE Max_coping_behaviourFS=4.
END IF.
 EXECUTE.

VALUE LABELS Max_coping_behaviourFS 1 'HH not adopting coping strategies' 2 'Stress coping strategies ' 3 'Crisis coping strategies ' 4 'Emergencies coping strategies'.
VARIABLE LABELS Max_coping_behaviourFS "Summary of asset depletion".


DELETE VARIABLES temp_nonmiss_number.
EXECUTE.

* tabulate results.
FREQUENCIES Max_coping_behaviourFS.


********************************************************************************
 * SPSS Syntax for the Economic Capacity to Meet Essential Needs (ECMEN) – Version excluding assistance (for assessments)
 *******************************************************************************
						   
*ECMEN calculation is based on the standard module available here: https://docs.wfp.org/api/documents/WFP-0000115416/download/

* Detailed guidance on the computation of the ECMEN can be found here: https://docs.wfp.org/api/documents/WFP-0000145644/download/

* Note 1: In the version used for assessment: 
       * a) the household economic capacity aggregate should not include the value of consumed in-kind assistance gifts; 
       * b) the value of the cash assistance received from the humanitarian sector should be deducted from the household economic capacity aggregate (but only for the estimated share of the cash assistance that is used for consumption, when available).

* Note 2: the computation of the ECMEN requires having already established a Minimum Expenditure Basket (MEB). More information on MEBs can be found here: https://docs.wfp.org/api/documents/WFP-0000074198/download/

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
 HHExpNFAlcTobac_Purch_MN_1M 'Expenditures on alcohol/tobacco'
 HHExpNFAlcTobac_GiftAid_MN_1M 'Value of consumed in-kind assistance-gifts - alcohol/tobacco'.
EXECUTE.
* If the questionnaire included further non-food categories/items label the respective variables

*6 months recall period - variables labels.
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
HHExpNFEduFee_Purch_MN_6M, HHExpNFEduGood_Purch_MN_6M, HHExpNFRent_Purch_MN_6M, HHExpNFHHSoft_Purch_MN_6M, HHExpNFHHMaint_Purch_MN_6M). /* careful with rent: should include only if also included in MEB.
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
 HHExpNFEduFee_GiftAid_MN_6M, HHExpNFEduGood_GiftAid_MN_6M, HHExpNFRent_GiftAid_MN_6M, HHExpNFHHSoft_GiftAid_MN_6M, HHExpNFHHMaint_GiftAid_MN_6M). /* careful with rent: should include only if also included in MEB.
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
*3. Calculate household economic capacity
*-------------------------------------------------------------------------------*
*Note: Remember that for the version of ECMEN used for assessments (excluding assistance), the value of consumed in-kind assistance and gifts should be excluded from the household economic capacity aggregate.

* Aggregate food expenditures and value of consumed food from own production.
COMPUTE HHExpF_ECMEN=SUM(HHExp_Food_Purch_MN_1M, HHExp_Food_Own_MN_1M).
EXECUTE.

*For NF only expenditures are considered. 
COMPUTE HHExpNF_ECMEN=HHExpNFTotal_Purch_MN_1M.
EXECUTE.

* Aggregate food and non-food.
COMPUTE HHExp_ECMEN=SUM(HHExpF_ECMEN, HHExpNF_ECMEN).
VARIABLE LABELS  HHExp_ECMEN 'Household Economic Capacity - monthly'.
 EXECUTE.


*-------------------------------------------------------------------------------*
*4. Deduct cash assistance
*--------------------------------------------------------------------------------*

VARIABLE LABELS
 HHAsstWFPCBTRecTot     'Amount of cash assistance received from WFP - last 3 months'
 HHAsstUNNGOCBTRecTot   'Amount of cash assistance received by other humanitarian partners - last 3 months'
 HHAsstCBTCShare        'Share of cash assistance spent on consumption'.
EXECUTE.

* Sum the amount of cash assistance received by WFP and other humanitarian partners (UN Agencies and NGOs) - do not include cash received from government, other organizations, and other households.
COMPUTE HHAsstCBTRec = SUM(HHAsstWFPCBTRecTot, HHAsstUNNGOCBTRecTot).
EXECUTE.

* Express in monthly terms .
COMPUTE HHAsstCBTRec_1M = HHAsstCBTRec/3. /*Attention: if recall period is different than standard 3 months, divide by the relevant number of months.
EXECUTE.

* Estimate the median share of assistance used for consumption.
COMPUTE constant = 1.
EXECUTE.

AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=constant
  /HHAsstCBTCShare_median=MEDIAN(HHAsstCBTCShare).
EXECUTE.

RENAME VARIABLES (HHAsstCBTCShare_median=HHAsstCBTCShare_med).

delete variables constant.

* Multiply the cash assistance received by the median share used for consumption.
COMPUTE HHAsstCBTRec_Cons_1M = HHAsstCBTRec_1M*(HHAsstCBTCShare_med/100).
EXECUTE.

* Deduct the cash assistance from the hh economic capacity.
RECODE HHAsstCBTRec_Cons_1M (sysmis=0). /* code missing assistance as zero.
EXECUTE.

COMPUTE HHExp_ECMEN = HHExp_ECMEN - HHAsstCBTRec_Cons_1M. /* here we specify that if cash assistance is missing it should be interpreted as = 0.
EXECUTE.
*-------------------------------------------------------------------------------*
*5. Express household economic capacity in per capita terms
*-------------------------------------------------------------------------------*

* Express in per capita terms.
COMPUTE PCExp_ECMEN=HHExp_ECMEN/HHSize. /* Make sure to rename the hh size variable as appropriate.
VARIABLE LABELS PCExp_ECMEN 'Household Economic Capacity per capita - monthly'.
 EXECUTE.
					   
*-------------------------------------------------------------------------------*
*6. Compute ECMEN
*-------------------------------------------------------------------------------*
* Important: make sure that MEB and SMEB variables are expressed in per capita terms!

*** 6.a MEB

* Define variable indicating if PC Household Economic Capacity is equal or greater than MEB.
IF NOT(SYSMIS(PCExp_ECMEN) AND SYSMIS(MEB)) ECMEN_exclAsst=PCExp_ECMEN > MEB. /* Make sure to rename MEB variable as appropriate.
EXECUTE.

VARIABLE LABELS
    ECMEN_exclAsst  'Economic capacity to meet essential needs - excluding assistance'.
    EXECUTE.

VALUE LABELS ECMEN_exclAsst
    1 'Above MEB'
    0 'Below MEB'.
EXECUTE.

* Compute the indicator (use weights when applicable!).
FREQUENCIES VARIABLES = ECMEN_exclAsst.

*** 6.b SMEB (when applicable)

* Define variable indicating if PC Household Economic Capacity is equal or greater than SMEB.
IF NOT(SYSMIS(PCExp_ECMEN) AND SYSMIS(SMEB)) ECMEN_exclAsst_SMEB=PCExp_ECMEN > SMEB. /* Make sure to rename MEB variable as appropriate.
EXECUTE.

VARIABLE LABELS
    ECMEN_exclAsst_SMEB  'Economic capacity to meet essential needs - SMEB - excluding assistance'.
    EXECUTE.

VALUE LABELS ECMEN_exclAsst_SMEB
    1 'Above SMEB'
    0 'Below SMEB'.
EXECUTE.

* Compute the indicator (use weights when applicable!).
FREQUENCIES VARIABLES = ECMEN_exclAsst_SMEB.

***Recode ECMEN based on the MEB and SMEB cut-off points in the area/country for CARI calculation 

IF (ECMEN_exclAsst=1) ECMEN_MEB=1. 
IF (ECMEN_exclAsst=0 & ECMEN_exclAsst_SMEB=1) ECMEN_MEB=2. 
IF (ECMEN_exclAsst & ECMEN_exclAsst_SMEB=0) ECMEN_MEB=3.

***Recode the ‘ECMEN_MEB’ variable into a 4pt scale for CARI console.

Recode ECMEN_MEB (1=1) (2=3) (3=4) INTO ECMEN_class_4pt. 
Variable labels ECMEN_class_4pt 'ECMEN 4pt'.
EXECUTE.

Frequencies variables= ECMEN_class_4pt  /ORDER=ANALYSIS. 
Value labels ECMEN_class_4pt 1.00 'Least vulnerable' 3.00 'Vulnerable' 4.00 'Highly vulnerable'. 
EXECUTE.	

***CARI (WITH ECMEN) ***

Compute Mean_coping_capacity_ECMEN = MEAN (Max_coping_behaviourFS, ECMEN_class_4pt).  
Compute CARI_unrounded_ECMEN = MEAN (FCS_4pt, Mean_coping_capacity_ECMEN). 
Compute CARI_ECMEN = RND (CARI_unrounded_ECMEN).  
EXECUTE. 

Value labels CARI_ECMEN 1 'Food secure'   2 'Marginally food secure'   3 'Moderately food insecure'   4 'Severely food insecure'.
EXECUTE.

Frequencies CARI_ECMEN.

***create population distribution table, to to explore how the domains interact within the different food security categories 

CTABLES
  /VLABELS VARIABLES= ECMEN_class_4pt FCS_4pt Max_coping_behaviourFS DISPLAY=LABEL
  /TABLE ECMEN_class_4pt [C] BY FCS_4pt [C] > Max_coping_behaviourFS [C][ROWPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES= ECMEN_class_4pt ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=FCS_4pt Max_coping_behaviourFS ORDER=A KEY=VALUE EMPTY=INCLUDE.
