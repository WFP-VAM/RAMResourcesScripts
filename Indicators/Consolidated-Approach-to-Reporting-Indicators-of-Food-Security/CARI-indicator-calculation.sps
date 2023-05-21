Methods to calculating the Consolidated Approach for Reporting Indicators of Food Security
********CALCULATE CARI using FCS, rCSI, LCS and FES ********

***Food Consumption Score***

***define labels  

Variable labels
FCSStap          ‘How many days over the last 7 days, did members of your household eat cereals, rains, roots and tubers?’
FCSPulse         ‘How many days over the last 7 days, did members of your household eat legumes/nuts?’
FCSDairy         ‘How many days over the last 7 days, did members of your household drink/eat milk and other dairy products?’
FCSPr              ‘How many days over the last 7 days, did members of your household eat meat, fish and eggs?’
FCSVeg           ‘How many days over the last 7 days, did members of your household eat vegetables and leaves?’
FCSFruit          ‘How many days over the last 7 days, did members of your household eat fruits?’
FCSFat             ‘How many days over the last 7 days, did members of your household consume oil?’
FCSSugar        ‘How many days over the last 7 days, did members of your household eat sugar, or sweets?’
FCSCond	       ‘How many days over the last 7 days, did members of your household eat condiments / spices?’.

Compute FCS = sum(FCSStap*2, FCSPulse*3, FCSDairy*4, FCSPr*4, FCSVeg*1, FCSFruit*1, FCSFat*0.5, FCSSugar*0.5). 
Variable labels FCS "Food Consumption Score".
EXECUTE.

***Use this when analyzing a country with low consumption of sugar and oil - thresholds 21-35

Recode FCS (lowest thru 21 =1) (21.5 thru 35 =2) (35.5 thru highest =3) into FCSCat21.¬
Variable labels FCSCat21 ‘FCS Categories’.
EXECUTE.

*** define value labels and properties for "FCS Categories".

Value labels FCSCat21 1.00 'Poor' 2.00 'Borderline' 3.00 'Acceptable '.
EXECUTE.

*** Important note: pay attention to the threshold used by your CO when selecting the syntax (21 cat. vs 28 cat.)
*** Use this when analyzing a country with high consumption of sugar and oil – thresholds 28-42

***Recode FCS (lowest thru 28 =1) (28.5 thru 42 =2) (42.5 thru highest =3) into FCSCat28.
Variable labels FCSCat28 ‘FCS Categories’.
EXECUTE.

Value labels FCSCat28 1.00 'Poor' 2.00 'Borderline' 3.00 'Acceptable '.
EXECUTE.

Recode FCSCat21 (1=4) (2=3) (3=1) INTO FCS_4pt. 
Variable labels FCS_4pt '4pt FCG'.
EXECUTE.

Frequencies VARIABLES=FCS_4pt /ORDER=ANALYSIS. 
Value labels FCS_4pt 1.00 'Acceptable' 3.00 'Borderline' 4.00 'Poor'. 
EXECUTE.

***Reduced Coping Strategy Index***
***define labels  

Variable labels
rCSILessQlty        ‘Rely on less preferred and less expensive food in the past 7 days’
rCSIBorrow          ‘Borrow food or rely on help from a relative or friend in the past 7 days’
rCSIMealNb         ‘Reduce number of meals eaten in a day in the past 7 days’
rCSIMealSize       ‘Limit portion size of meals at meal times in the past 7 days’
rCSIMealAdult     ‘Restrict consumption by adults in order for small children to eat in the past 7 days’.

Compute rCSI = sum(rCSILessQlty*1,rCSIBorrow*2,rCSIMealNb*1,rCSIMealSize*1,rCSIMealAdult*3).
variable labels rCSI 'Reduced coping strategies index (rCSI)'.
EXECUTE.

FREQUENCIES VARIABLES=rCSI
  /FORMAT=NOTABLE
  /STATISTICS=MEAN
  /ORDER=ANALYSIS.

***Combining rCSI with FCS_4pt for CARI calculation (current consumption) 

Do if (rCSI  >= 4).
Recode FCS_4pt (1=2).
End if.
EXECUTE.

Value labels FCS_4pt 1.00 'Acceptable' 2.00 ' Acceptable and rCSI>4' 3.00 'Borderline' 4.00 'Poor'. 
EXECUTE.

Frequencies FCS_4pt.

***Livelihood Coping *** 
***define labels 

Value labels 
Lcs_stress_DomAsset	
Lcs_stress_CrdtFood	
Lcs_stress_saving		
Lcs_stress_BorrowCash
Lcs_crisis_ProdAsset	
Lcs_crisis_HealthEdu	
Lcs_crisis_OutSchool
Lcs_em_ResAsset
Lcs_em_Begged
Lcs_em_IllegalAct
10 ‘No, because I did not need to’
20 ‘No because I already sold those assets or have engaged in this activity within the last 12 months and cannot continue to do it’
30 ‘Yes’
9999 ‘Not applicable (don’t have children/ these assets)’.

***stress strategies*** (must have 4 stress strategies to calculate LCS, if you have more then use the most frequently applied strategies)
 ***define variables labels 

Variable labels 
Lcs_stress_DomAsset		‘Sold household assets/goods (radio, furniture, refrigerator, television, jewellery, etc.) due to lack of food’
Lcs_stress_CrdtFood		‘Purchased food/non-food on credit (incur debts) due to lack of food’
Lcs_stress_saving		‘Spent savings due to lack of food’
Lcs_stress_BorrowCash 	‘Borrow money due to lack of food’.

do if (Lcs_stress_DomAsset = 20) | (Lcs_stress_DomAsset = 30) | (Lcs_stress_CrdtFood = 20) | (Lcs_stress_CrdtFood = 30) | (Lcs_stress_saving =20) | (Lcs_stress_saving =30) | (Lcs_stress_BorrowCash =20) | (Lcs_stress_BorrowCash =30).

compute stress_coping =1.
else.
compute stress_coping =0.
end if.
EXECUTE.


  ***crisis strategies***(must have 3 crisis strategies to calculate LCS, if you have more then use the most frequently applied strategies)
 
***define variables  

Variable labels 
Lcs_crisis_ProdAsset	‘Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.) due to lack of food’
Lcs_crisis_HealthEdu	‘Reduced expenses on health (including drugs) or education due to lack of food’
Lcs_crisis_OutSchool	‘Withdrew children from school due to lack of food’.

Do if (Lcs_crisis_ProdAsset = 20) | (Lcs_crisis_ProdAsset =30) | (Lcs_crisis_HealthEdu =20) | (Lcs_crisis_HealthEdu=30) | (Lcs_crisis_OutSchool =20) | (Lcs_crisis_OutSchool =30).

Compute crisis_coping =1.
Else.
Compute crisis_coping =0. 
End if.
EXECUTE.
 
***emergency strategies ***(must have 3 emergency strategies to calculate LCS, if you have more then use the most frequently applied strategies)

***define variables  

Variable labels 
Lcs_em_ResAsset	‘Mortgaged/Sold house or land due to lack of food’
Lcs_em_Begged	‘Begged and/or scavenged (asked strangers for money/food) due to lack of food’
Lcs_em_IllegalAct	‘Engaged in illegal income activities (theft, prostitution) due to lack of food’.

do if (Lcs_em_ResAsset = 20) | (Lcs_em_ResAsset = 30) | (Lcs_em_Begged = 20) | (Lcs_em_Begged =30) | (Lcs_em_IllegalAct = 20) | (Lcs_em_IllegalAct = 30).

Compute emergency_coping =1. 
Else. 
Compute emergency_coping = 0. 
End if. 
EXECUTE. 
 
*** label new variable 

Variable labels stress_coping 'Did the HH engage in stress coping strategies?'. 
Variable labels crisis_coping 'Did the HH engage in crisis coping strategies?'. 
Variable labels emergency_coping  'Did the HH engage in emergency coping strategies?'. 

*** recode variables to compute one variable with coping behavior  

Recode  stress_coping (0=0) (1=2). 
Recode  crisis_coping (0=0) (1=3). 
Recode  emergency_coping (0=0) (1=4). 
 
Compute Max_coping_behaviour=MAX(stress_coping,  crisis_coping,  emergency_coping). 
Recode Max_coping_behaviour (0=1). 
 
Value labels Max_coping_behaviour 1 'HH not adopting coping strategies' 2 'Stress coping strategies ' 3 'Crisis coping strategies ' 4 'Emergencies coping strategies'. 
 
Variable Labels Max_coping_behaviour 'Summary of asset depletion'. 
EXECUTE. 



***Food Expenditure Share *** 
**Important note: assistance is considered in both assessments as well as monitoring 

***food expenditure***

***define labels  
*Important note: add recall periods of _1M or _7D to the variable names below depending on what has been selected for your CO. It is recommended to follow standard recall periods as in the module. 
 
/*Expenditure on cereals (maize, rice, sorghum, wheat, flour of cereals, bread, pasta...)
/*Expenditure on tubers (potatoes, sweet potatoes, cassava, plantains, yams)
/*Expenditure on fruit (fresh and frozen fruit)
/*Expenditure on vegetables (dark green leafy vegetables, orange vegetable, other vegetable)
/*Expenditure on meat (fresh, chilled, frozen meat and poultry, dry and slated meat)
/*Expenditure on eggs
/*Expenditure on fish (fresh and frozen fish and other seafood)
/*Expenditure on oil, fat, and butter
/*Expenditure on milk, cheese, and yogurt
/*Expenditure on sugar, confectionery, and desserts
/*Expenditure on condiments (salt, spices, cubes, fish powder)
/*Expenditure on non-alcoholic beverages (coffee, tea, herbal infusion; bottled water; soft drinks; juice)
/*Expenditure on other meals/snacks consumed outside the home
/*Expenditure on pulses (beans, peas, lentils, nuts in shell or shelled)

Variable labels
HHExpFCer_MN_1M			‘Cash expenditure value on cereals’
HHExpFCer_CRD_1M			‘Credit expenditure value on cereals’
HHExpFCer_GiftAid_1M		‘Assistance expenditure value on cereals’
HHExpFCer_Own_1M	                                        ‘Own production expenditure value on cereals’
HHExpFTub_MN_1M			‘Cash expenditure value on tubers’
HHExpFTub_CRD_1M			‘Credit expenditure value on tubers’
HHExpFTub_GiftAid_1M		‘Assistance expenditure value on tubers’
HHExpFTub_Own_1M		                    ‘Own production expenditure value on tubers’
HHExpFPuls_MN_1M			‘Cash expenditure on pulses & nuts’
HHExpFPuls_CRD_1M			‘Credit expenditure on pulses & nuts’
HHExpFPuls_GiftAid_1M		‘Assistance expenditure value on pulses & nuts’
HHExpFPuls_Own_1M		‘Own production expenditure value on pulses & nuts’
HHExpFVeg_MN_1M			‘Cash expenditure on vegetables’
HHExpFVeg_CRD_1M			‘Credit expenditure on vegetables’
HHExpFVeg_GiftAid_1M		‘Assistance expenditure value on vegetables’
HHExpFVeg_Own_1M		                    ‘Own production expenditure value on vegetables’
HHExpFFrt_MN_1M			‘Cash expenditure on fruits’
HHExpFFrt_CRD_1M			‘Credit expenditure on fruits’
HHExpFFrt_GiftAid_1M		‘Assistance expenditure value on fruits’
HHExpFFrt_Own_1M		                    ‘Own production expenditure value on fruits’
HHExpFAnimMeat_MN_1M		‘Cash expenditure on meat’
HHExpFAnimMeat_CRD_1M		‘Credit expenditure on meat’
HHExpFAnimMeat_GiftAid_1M		‘Assistance expenditure value on meat’
HHExpFAnimMeat_Own_1M		‘Own production expenditure value on meat’
HHExpFAnimFish_MN_1M		‘Cash expenditure on fish’
HHExpFAnimFish_CRD_1M		‘Credit expenditure on fish’
HHExpFAnimFish_GiftAid_1M		‘Assistance expenditure value on fish’
HHExpFAnimFish_Own_1M		‘Own production expenditure value on fish’
HHExpFFats_MN_1M			‘Cash expenditure on oil/fat/butter’
HHExpFFats_CRD_1M			‘Credit expenditure on oil/fat/butter’
HHExpFFats_GiftAid_1M		‘Assistance expenditure value on oil/fat/butter’
HHExpFFats_Own_1M		 ‘Own production expenditure value on oil/fat/butter’
HHExpFDairy_MN_1M		‘Cash expenditure on milk/dairy products’
HHExpFDairy_CRD_1M		‘Credit expenditure on milk/dairy products’
HHExpFDairy_GiftAid_1M		‘Assistance expenditure value on milk/dairy products’
HHExpFDairy_Own_1M		‘Own production expenditure value on milk/dairy products’
HHExpFAnimEgg_MN_1M		‘Cash expenditure on eggs’
HHExpFAnimEgg_CRD_1M		‘Credit expenditure on eggs’
HHExpFAnimEgg_GiftAid_1M		‘Assistance expenditure value on eggs’
HHExpFAnimEgg_Own_1M		‘Own production expenditure value on eggs’
HHExpFSgr_MN_1M			‘Cash expenditure on sugar’
HHExpFSgr_CRD_1M			‘Credit expenditure on sugar’
HHExpFSgr_GiftAid_1M		‘Assistance expenditure value on sugar’
HHExpFSgr_Own_1M	                                        ‘Own production expenditure value on sugar’
HHExpFCond_MN_1M		‘Cash expenditure on condiments’
HHExpFCond_CRD_1M		‘Credit expenditure on condiments’ 
HHExpFCond_GiftAid_1M		‘Assistance expenditure value on condiments’
HHExpFCond_Own_1M		‘Own production expenditure value on condiments’
HHExpFBeverage_MN_1M		‘Cash expenditure on beverages’
HHExpFBeverage_CRD_1M		‘Credit expenditure on beverages’
HHExpFBeverage_GiftAid_1M		‘Assistance expenditure value on beverages’
HHExpFBeverage_Own_1M		‘Own production expenditure value on beverages’
HHExpFOut_MN_1M			‘Cash expenditure on snacks consumed outside the home’
HHExpFOut_CRD_1M			‘Credit expenditure on snacks consumed outside the home’
HHExpFOut_GiftAid_1M		‘Assistance expenditure value on snacks consumed outside the home’
HHExpFOut_Own_1M		                    ‘Own production expenditure value on snacks consumed outside the home’.
Execute.

***Calculate the overall monthly food expenditure
    /*If the expenditure was calculated separately for cash, credit, aid/gift and own production, calculate the overall total by summing them up
    /*If the expenditure recall period is 7 days; make sure to transform it to 30 days

Compute HHExpFood_MN_1M =sum(HHExpFCer_MN_1M, HHExpFTub_MN_1M, 
HHExpFPuls_MN_1M,  HHExpFVeg_MN_1M, HHExpFFrt_MN_1M, HHExpFAnimMeat_MN_1M, 
HHExpFAnimFish_MN_1M, HHExpFFats_MN_1M, HHExpFDairy_MN_1M, 
HHExpFAnimEgg_MN_1M, HHExpFSgr_MN_1M, HHExpFCond_MN_1M, HHExpFBeverage_MN_1M, 
HHExpFOut_MN_1M). 

Compute HHExp_Food_CRD_1M =sum(HHExpFCer_CRD_1M, HHExpFTub_CRD_1M, 
HHExpFPuls_CRD_1M,  HHExpFVeg_CRD_1M, HHExpFFrt_CRD_1M, HHExpFAnimMeat_CRD_1M, 
HHExpFAnimFish_CRD_1M, HHExpFFats_CRD_1M, HHExpFDairy_CRD_1M, 
HHExpFAnimEgg_CRD_1M, HHExpFSgr_CRD_1M, HHExpFCond_CRD_1M, HHExpFBeverage_CRD_1M, 
HHExpFOut_CRD_1M).

Compute HHExp_Food_GiftAid_1M =sum(HHExpFCer_GiftAid_1M, HHExpFTub_GiftAid_1M, 
HHExpFPuls_GiftAid_1M, HHExpFVeg_GiftAid_1M, HHExpFFrt_GiftAid_1M, HHExpFAnimMeat_GiftAid_1M, 
HHExpFAnimFish_GiftAid_1M, HHExpFFats_GiftAid_1M, HHExpFDairy_GiftAid_1M, 
HHExpFAnimEgg_GiftAid_1M, HHExpFSgr_GiftAid_1M, HHExpFCond_GiftAid_1M, HHExpFBeverage_GiftAid_1M, 
HHExpFOut_GiftAid_1M).

Compute HHExp_Food_Own_1M =sum(HHExpFCer_Own_1M, HHExpFTub_Own_1M, 
HHExpFPuls_Own_1M,  HHExpFVeg_Own_1M, HHExpFFrt_Own_1M, HHExpFAnimMeat_Own_1M, 
HHExpFAnimFish_Own_1M, HHExpFFats_Own_1M, HHExpFDairy_Own_1M, 
HHExpFAnimEgg_Own_1M, HHExpFSgr_Own_1M, HHExpFCond_Own_1M, HHExpFBeverage_Own_1M, 
HHExpFOut_Own_1M).

Variable labels 
HHExp_Food_MN_1M    'Total food expenditure on cash'
HHExp_Food_CRD_1M    'Total food expenditure on credit'
HHExp_Food_GiftAid_1M    'Total food expenditure value from assistance'
HHExp_Food_Own_1M    'Total food expenditure value from own production'.
Execute.








***Non-food expenditure (30 days)***

***define labels  

Variable labels
HHExpNFHyg_MN_1M		'Cash expenditure on soap, hygiene & personal care items'
HHExpNFHyg_CRD_1M		'Credit expenditure on soap, hygiene & personal care items'
HHExpNFHyg_GiftAid_1M		'Assistance expenditure value on soap, hygiene & personal care items'
HHExpNFTransp_MN_1M		'Cash expenditure on transport'
HHExpNFTransp_CRD_1M		'Credit expenditure on transport'
HHExpNFTransp_GiftAid_1M		'Assistance expenditure value on transport'
HHExpNFWat_MN_1M		'Cash expenditure on water supply for domestic consumption'
HHExpNFWat_CRD_1M		'Credit expenditure on water supply for domestic consumption'
HHExpNFWat_GiftAid_1M		'Assistance expenditure value on water supply for domestic consumption'
HHExpNFElec_MN_1M		'Cash expenditure on electricity'
HHExpNFElec_CRD_1M		'Credit expenditure on electricity'
HHExpNFElec_GiftAid_1M		'Assistance expenditure value on electricity'
HHExpNFEnerg_MN_1M		'Cash expenditure on energy (cooking, heating, lighting) from other sources (not electricity)'
HHExpNFEnerg_CRD_1M		'Credit expenditure on energy (cooking, heating, lighting) from other sources (not electricity)'
HHExpNFEnerg_GiftAid_1M		‘Assistance expenditure value on energy (cooking, heating, lighting) from other sources (not electricity)’
HHExpNFDwelServ_MN_1M		‘Cash expenditure on miscellaneous services relating to the dwelling’
HHExpNFDwelServ_CRD_1M		‘Credit expenditure on miscellaneous services relating to the dwelling’
HHExpNFDwelServ_GiftAid_1M		‘Assistance expenditure value on miscellaneous services relating to the dwelling’
HHExpNFPhone_MN_1M		‘Cash expenditure on information and communication’
HHExpNFPhone_CRD_1M		‘Credit expenditure on information and communication’
HHExpNFPhone_GiftAid_1M		‘Assistance expenditure value on information and communication’
HHExpNFAlcTobac_MN_1M		‘Cash expenditure on alcoholic beverages and tobacco’
HHExpNFAlcTobac_CRD_1M		‘Credit expenditure on alcoholic beverages and tobacco’
HHExpNFAlcTobac_GiftAid_1M		‘Assistance expenditure value on alcoholic beverages and tobacco’
HHExpNFSpec1_MN_1M		‘Cash expenditure on [specific to country]’
HHExpNFSpec1_CRD_1M		‘Credit expenditure on [Specific to country]’
HHExpNFSpec1_GiftAid_1M		‘Assistance expenditure value on [Specific to country]’.

***Non-food expenditure (6 months) ***

Variable labels
HHExpNFMedServ_MN_6M		‘Cash expenditure on health services’
HHExpNFMedServ_CRD_6M		"Credit expenditure on health services"
HHExpNFMedServ_GiftAid_6M		‘Assistance expenditure value  on health services’
HHExpNFMedGood_MN_6M 		‘Cash expenditure on medicines & health products’
HHExpNFMedGood_CRD_6M 		‘Credit expenditure on medicines & health products’
HHExpNFMedGood_GiftAid_6M 		‘Assistance expenditure value  on medicines & health products’
HHExpNFCloth_MN_6M		‘Cash expenditure on clothing and footwear’
HHExpNFCloth_CRD_6M		‘Credit expenditure on clothing and footwear’
HHExpNFCloth_GiftAid_6M		‘Assistance expenditure value  on clothing and footwear’
HHExpNFEduFee_MN_6M		‘Cash expenditure on education services’
HHExpNFEduFee_CRD_6M		‘Credit expenditure on education services’
HHExpNFEduFee_GiftAid_6M		‘Assistance expenditure value  on education services’
HHExpNFEduGood_MN_6M		‘Cash expenditure on education goods’
HHExpNFEduGood_CRD_6M		‘Credit expenditure on education goods’
HHExpNFEduGood_GiftAid_6M		‘Assistance expenditure value  on education goods’
HHExpNFRent_MN_6M		‘Cash expenditure on rent’
HHExpNFRent_CRD_6M		‘Credit expenditure on rent’
HHExpNFRent_GiftAid _6M		"Assistance expenditure value  on rent" 
HHExpNFHHSoft_MN_6M		‘Cash expenditure on household non-durable furniture and routine maintenance’
HHExpNFHHSoft_CRD_6M		‘Credit expenditure on household non-durable furniture and routine maintenance’
HHExpNFHHSoft_GiftAid_6M		‘Assistance expenditure value  on household non-durable furniture and routine maintenance’
HHExpNFSav_MN_6M		‘Cash expenditure on savings’
HHExpNFSav_CRD_6M		‘Credit expenditure on savings’
HHExpNFSav_GiftAid_6M		‘Assistance expenditure value  on savings’
HHExpNFDebt_MN_6M		"Cash expenditure on debt repayment"
HHExpNFDebt_CRD_6M		‘Credit expenditure on debt repayment’
HHExpNFDebt_GiftAid_6M		‘Assistance expenditure value  on debt repayment’  
HHExpNFInsurance_MN_6M		‘Cash expenditure on insurance’
HHExpNFInsurance_CRD_6M		‘Credit expenditure on insurance’
HHExpNFInsurance_GiftAid_6M		‘Assistance expenditure value  on insurance’.

***Calculate the overall monthly non-food expenditure
    /*Make sure to calculate separately for cash, credit, aid/gift and own production, calculate the overall by summing them up
    /*If the expenditure recall period is 7 days or 6 months; make sure to transform it to 30 days

Compute HHExpNFTotal_MN_6M=sum (HHExpNFRent_MN_6M, HHExpNFMedServ_MN_6M, 
    HHExpNFMedGood_MN_6M, HHExpNFCloth_MN_6M, HHExpNFEduFee_MN_6M, HHExpNFEduGood_MN_6M,
    HHExpNFSoft_MN_6M, HHExpNFSav_MN_6M, HHExpNFInsurance_MN_6M, HHExpNFDebt_MN_6M).

Compute HHExpNFTotal_MN_30D=sum (HHExpNFAlcTobac_MN_1M, HHExpNFHyg_MN_1M,
    HHExpNFTransp_MN_1M, HHExpNFWat_MN_1M, HHExpNFDwelServ_MN_1M, HHExpNFElec_MN_1M, HHExpNFEnerg_MN_1M, HHExpNFPhone_MN_1M, HHExpNFSpec1_MN_1M).

/*Sum the non-food 1 month and 6-month expenditures 
Compute HHExpNFTotal_MN_1M=(HHExpNFTotal_MN_30D+HHExpNFTotal_MN_6M/6).

/*note: to reduce the number of variables in your dataset, you could run the delete function below. 
delete variables HHExpNFTotal_MN_6M HHExpNFTotal_MN_30D.
Compute HHExpNFTotal_CRD_6M=sum(HHExpNFRent_CRD_6M, HHExpNFMedServ_CRD_6M,
    HHExpNFMedGood_CRD_6M, HHExpNFCloth_CRD_6M, HHExpNFEduFee_CRD_6M, HHExpNFEduGood_CRD_6M,
    HHExpNFSoft_CRD_6M, HHExpNFInsurance_CRD_6M, HHExpNFDebt_CRD_6M).

Compute HHExpNFTotal_CRD_30D = sum(HHExpNFAlcTobac_CRD_1M,HHExpNFHyg_CRD_1M,
    HHExpNFTransp_CRD_1M, HHExpNFWat_CRD_1M, HHExpNFDwelServ_CRD_1M, HHExpNFElec_CRD_1M, HHExpNFEnerg_CRD_1M, HHExpNFPhone_CRD_1M, HHExpNFSpec1_CRD_1M).

/*sum the non-food 1 month and 6-month expenditures 
Compute HHExpNFTotal_CRD_1M=(HHExpNFTotal_CRD_30D+HHExpNFTotal_CRD_6M/6).

/*note: to reduce the number of variables in your dataset, you could run the delete function below. 

delete variables HHExpNFTotal_CRD_6M HHExpNFTotal_CRD_30D.

Compute HHExpNFTotal_GiftAid_6M=sum(HHExpNFRent_GiftAid_6M,HHExpNFMedServ_GiftAid_6M,
    HHExpNFMedGood_GiftAid_6M, HHExpNFCloth_GiftAid_6M, HHExpNFEduFee_GiftAid_6M, HHExpNFEduGood_GiftAid_6M,
    HHExpNFSoft_GiftAid_6M, HHExpNFSav_GiftAid_6M, HHExpNFInsurance_GiftAid_6M, HHExpNFDebt_GiftAid_6M).

Compute HHExpNFTotal_GiftAid_30D = sum(HHExpNFAlcTobac_GiftAid_1M, HHExpNFHyg_GiftAid_1M,
    HHExpNFTransp_GiftAid_1M, HHExpNFWat_GiftAid_1M, HHExpNFDwelServ_GiftAid_1M, HHExpNFElec_GiftAid_1M, HHExpNFEnerg_GiftAid_1M, HHExpNFPhone_GiftAid_1M, HHExpNFSpec1_GiftAid_1M).

/*sum the non-food 1 month and 6-month expenditures 
Compute HHExpNFTotal_GiftAid_1M=(HHExpNFTotal_GiftAid_30D+HHExpNFTotal_GiftAid_6M/6).

/*note: to reduce the number of variables in your dataset, you could run the delete function below. 
delete variables HHExpNFTotal_GiftAid_6M HHExpNFTotal_GiftAid_30D.
Variable labels HHExpNFTotal_MN_1M 'Total non-food exp on cash'.
Variable labels HHExpNFTotal_CRD_1M 'Total non-food exp on credit'.
Variable labels HHExpNFTotal_GiftAid_1M 'Total non-food exp from gift aid'.
Execute.



***Calculate totals for food and non-food expenditure

Compute HHExpNFTotal_1M=sum(HHExpNFTotal_MN_1M, HHExpNFTotal_CRD_1M, HHExpNFTotal_GiftAid_1M).
Compute HHExpFood_1M=sum(HHExpFood_MN_1M, HHExp_Food_CRD_1M, HHExp_Food_Own_1M, HHExp_Food_GiftAid_1M).
EXECUTE.

**Food Expenditure Share**
Compute FES= HHExpFood_1M /SUM(HHExpFood_1M , HHExpNFTotal_1M).

Variable labels FES 'Household food expenditure share'
EXECUTE.

Recode FES (Lowest thru .4999999=1) (.50 thru .64999999=2) (.65 thru .74999999=3) (.75 thru Highest=4) 
    into Foodexp_4pt.

Variable labels Foodexp_4pt 'Food expenditure share categories'.
EXECUTE.

***CARI (WITH FOOD EXPENDITURE) ***

Compute Mean_coping_capacity_FES = MEAN (Max_coping_behaviour, Foodexp_4pt).  
Compute CARI_unrounded_FES = MEAN (FCS_4pt, Mean_coping_capacity_FES). 
Compute CARI_FES = RND (CARI_unrounded_FES).  
Execute. 

Value labels CARI_FES 1 'Food secure'   2 'Marginally food secure'   3 'Moderately food insecure'   4 'Severely food insecure'.
EXECUTE.

Frequencies CARI_FES.

***create population distribution table, to to explore how the domains interact within the different food security categories 

CTABLES
  /VLABELS VARIABLES=Foodexp_4pt FCS_4pt Max_coping_behaviour DISPLAY=LABEL
  /TABLE Foodexp_4pt [C] BY FCS_4pt [C] > Max_coping_behaviour [C][ROWPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=Foodexp_4pt ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=FCS_4pt Max_coping_behaviour ORDER=A KEY=VALUE EMPTY=INCLUDE.


***CALCULATE CARI using FCS, rCSI, LCS and ECMEN

***Food Consumption Score***

***define labels  

Variable labels
FCSStap          ‘How many days over the last 7 days, did members of your household eat cereals, rains, roots and tubers?’
FCSPulse         ‘How many days over the last 7 days, did members of your household eat legumes/nuts?’
FCSDairy         ‘How many days over the last 7 days, did members of your household drink/eat milk and other dairy products?’
FCSPr              ‘How many days over the last 7 days, did members of your household eat meat, fish and eggs?’
FCSVeg           ‘How many days over the last 7 days, did members of your household eat vegetables and leaves?’
FCSFruit          ‘How many days over the last 7 days, did members of your household eat fruits?’
FCSFat             ‘How many days over the last 7 days, did members of your household consume oil?’
FCSSugar        ‘How many days over the last 7 days, did members of your household eat sugar, or sweets?’
FCSCond	     ‘How many days over the last 7 days, did members of your household eat condiments / spices?’.



Compute FCS = sum(FCSStap*2, FCSPulse*3, FCSDairy*4, FCSPr*4, FCSVeg*1, FCSFruit*1, FCSFat*0.5, FCSSugar*0.5). 
Variable labels FCS "Food Consumption Score".
EXECUTE.

***Use this when analyzing a country with low consumption of sugar and oil - thresholds 21-35

Recode FCS (lowest thru 21 =1) (21.5 thru 35 =2) (35.5 thru highest =3) into FCSCat21.
Variable labels FCSCat21 ‘FCS Categories’.
EXECUTE.

*** define value labels and properties for "FCS Categories".

Value labels FCSCat21 1.00 'Poor' 2.00 'Borderline' 3.00 'Acceptable '.
EXECUTE.

*** Important note: pay attention to the threshold used by your CO when selecting the syntax (21 cat. vs 28 cat.)
*** Use this when analyzing a country with high consumption of sugar and oil – thresholds 28-42

Recode FCS (lowest thru 28 =1) (28.5 thru 42 =2) (42.5 thru highest =3) into FCSCat28.
Variable labels FCSCat28 ‘FCS Categories’.
EXECUTE.

*** define value labels and properties for "FCS Categories".
Value labels FCSCat28 1.00 'Poor' 2.00 'Borderline' 3.00 'Acceptable '.
EXECUTE.

Recode FCSCat21 (1=4) (2=3) (3=1) INTO FCS_4pt. 
Variable labels FCS_4pt '4pt FCG'.
EXECUTE.

Frequencies VARIABLES=FCS_4pt /ORDER=ANALYSIS. 
Value labels FCS_4pt 1.00 'Acceptable' 3.00 'Borderline' 4.00 'Poor'. 
EXECUTE.

***Reduced Coping Strategy Index***
***define labels  

Variable labels
rCSILessQlty        ‘Rely on less preferred and less expensive food in the past 7 days’
rCSIBorrow          ‘Borrow food or rely on help from a relative or friend in the past 7 days’
rCSIMealNb         ‘Reduce number of meals eaten in a day in the past 7 days’
rCSIMealSize       ‘Limit portion size of meals at meal times in the past 7 days’
rCSIMealAdult     ‘Restrict consumption by adults in order for small children to eat in the past 7 days’.

Compute rCSI = sum(rCSILessQlty*1,rCSIBorrow*2,rCSIMealNb*1,rCSIMealSize*1,rCSIMealAdult*3).
Variable labels rCSI 'Reduced coping strategies index (rCSI)'.
EXECUTE.

FREQUENCIES VARIABLES=rCSI
  /FORMAT=NOTABLE
  /STATISTICS=MEAN
  /ORDER=ANALYSIS.

***Combining rCSI with FCS_4pt for CARI calculation (current consumption) 

Do if (rCSI  >= 4).
Recode FCS_4pt (1=2).
End if.
EXECUTE.

Value labels FCS_4pt 1.00 'Acceptable' 2.00 ' Acceptable and rCSI>4' 3.00 'Borderline' 4.00 'Poor'. 
EXECUTE.

Frequencies FCS_4pt.

***Livelihood Coping *** 

***define labels 

Value labels 
Lcs_stress_DomAsset	
Lcs_stress_CrdtFood	
Lcs_stress_saving		
Lcs_stress_BorrowCash
Lcs_crisis_ProdAsset	
Lcs_crisis_HealthEdu	
Lcs_crisis_OutSchool
Lcs_em_ResAsset
Lcs_em_Begged
Lcs_em_IllegalAct
10 ‘No, because I did not need to’
20 ‘No because I already sold those assets or have engaged in this activity within the last 12 months and cannot continue to do it’
30 ‘Yes’
9999 ‘Not applicable (don’t have children/ these assets)’.

***stress strategies*** (must have 4 stress strategies to calculate LCS, if you have more then use the most frequently applied strategies)
 ***define variables labels 

Variable labels 
Lcs_stress_DomAsset		‘Sold household assets/goods (radio, furniture, refrigerator, television, jewellery, etc.) due to lack of food’
Lcs_stress_CrdtFood		‘Purchased food/non-food on credit (incur debts) due to lack of food’
Lcs_stress_saving		‘Spent savings due to lack of food’
Lcs_stress_BorrowCash 	‘Borrow money due to lack of food’.

Do if (Lcs_stress_DomAsset = 20) | (Lcs_stress_DomAsset = 30) | (Lcs_stress_CrdtFood = 20) | (Lcs_stress_CrdtFood = 30) | (Lcs_stress_saving =20) | (Lcs_stress_saving =30) | (Lcs_stress_BorrowCash =20) | (Lcs_stress_BorrowCash =30).

Compute stress_coping =1.
Else.
Compute stress_coping =0.
End if.
EXECUTE.
  
***crisis strategies***(must have 3 crisis strategies to calculate LCS, if you have more then use the most frequently applied strategies)
 
***define variables  

Variable labels 
Lcs_crisis_ProdAsset	‘Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.) due to lack of food’
Lcs_crisis_HealthEdu	‘Reduced expenses on health (including drugs) or education due to lack of food’
Lcs_crisis_OutSchool	‘Withdrew children from school due to lack of food’.

Do if (Lcs_crisis_ProdAsset = 20) | (Lcs_crisis_ProdAsset =30) | (Lcs_crisis_HealthEdu =20) | (Lcs_crisis_HealthEdu=30) | (Lcs_crisis_OutSchool =20) | (Lcs_crisis_OutSchool =30).

Compute crisis_coping =1.
Else.
Compute crisis_coping =0. 
End if.
EXECUTE.
 
***emergency strategies ***(must have 3 emergency strategies to calculate LCS, if you have more then use the most frequently applied strategies)

***define variables  

Variable labels 
Lcs_em_ResAsset	‘Mortgaged/Sold house or land due to lack of food’
Lcs_em_Begged	‘Begged and/or scavenged (asked strangers for money/food) due to lack of food’
Lcs_em_IllegalAct	‘Engaged in illegal income activities (theft, prostitution) due to lack of food’.

Do if (Lcs_em_ResAsset = 20) | (Lcs_em_ResAsset = 30) | (Lcs_em_Begged = 20) | (Lcs_em_Begged =30) | (Lcs_em_IllegalAct = 20) | (Lcs_em_IllegalAct = 30).

Compute emergency_coping =1. 
Else. 
Compute emergency_coping = 0. 
End if. 
EXECUTE. 
 
*** label new variable 

Variable labels stress_coping 'Did the HH engage in stress coping strategies?'. 
Variable labels crisis_coping 'Did the HH engage in crisis coping strategies?'. 
Variable labels emergency_coping  'Did the HH engage in emergency coping strategies?'. 
 
*** recode variables to compute one variable with coping behavior  
 
Recode  stress_coping (0=0) (1=2). 
Recode  crisis_coping (0=0) (1=3). 
Recode  emergency_coping (0=0) (1=4). 
 
Compute Max_coping_behaviour=MAX(stress_coping,  crisis_coping,  emergency_coping). 
Recode Max_coping_behaviour (0=1). 
 
Value labels Max_coping_behaviour 1 'HH not adopting coping strategies' 2 'Stress coping strategies ' 3 'Crisis coping strategies ' 4 'Emergencies coping strategies'. 
 
Variable Labels Max_coping_behaviour 'Summary of asset depletion'. 
EXECUTE. 

***Economic Capacity to Meet Essential Needs: HHs under the MEB/Poverty line***

/****ECMEN calculation is based on the standard module here:
    /*https://docs.wfp.org/api/documents/WFP-0000115416/download/

**Important note: Original ECMEN calculation only includes expenditure on cash and own production - credit and assistance (gift/aid) should not be added

***food expenditure***

***define labels  
*Important note: add recall periods of _1M or _7D to the variable names below depending on what has been selected for your CO. It is recommended to follow standard recall periods as in the module. 

/*Expenditure on cereals (maize, rice, sorghum, wheat, flour of cereals, bread, pasta...)
/*Expenditure on tubers (potatoes, sweet potatoes, cassava, plantains, yams)
/*Expenditure on fruit (fresh and frozen fruit)
/*Expenditure on vegetables (dark green leafy vegetables, orange vegetable, other vegetable)
/*Expenditure on meat (fresh, chilled, frozen meat and poultry, dry and slated meat)
/*Expenditure on eggs
/*Expenditure on fish (fresh and frozen fish and other seafood)
/*Expenditure on oil, fat, and butter
/*Expenditure on milk, cheese, and yogurt
/*Expenditure on sugar, confectionery, and desserts
/*Expenditure on condiments (salt, spices, cubes, fish powder)
/*Expenditure on non-alcoholic beverages (coffee, tea, herbal infusion; bottled water; soft drinks; juice)
/*Expenditure on other meals/snacks consumed outside the home
/*Expenditure on pulses (beans, peas, lentils, nuts in shell or shelled)

variable labels
HHExpFCer_MN_1M			‘Cash expenditure value on cereals’
HHExpFCer_CRD_1M			‘Credit expenditure value on cereals’
HHExpFCer_GiftAid_1M		‘Assistance expenditure value on cereals’
HHExpFCer_Own_1M	                                        ‘Own production expenditure value on cereals’
HHExpFTub_MN_1M			‘Cash expenditure value on tubers’
HHExpFTub_CRD_1M			‘Credit expenditure value on tubers’
HHExpFTub_GiftAid_1M		‘Assistance expenditure value on tubers’
HHExpFTub_Own_1M		                    ‘Own production expenditure value on tubers’
HHExpFPuls_MN_1M			‘Cash expenditure on pulses & nuts’
HHExpFPuls_CRD_1M			‘Credit expenditure on pulses & nuts’
HHExpFPuls_GiftAid_1M		‘Assistance expenditure value on pulses & nuts’
HHExpFPuls_Own_1M		‘Own production expenditure value on pulses & nuts’
HHExpFVeg_MN_1M			‘Cash expenditure on vegetables’
HHExpFVeg_CRD_1M			‘Credit expenditure on vegetables’
HHExpFVeg_GiftAid_1M		‘Assistance expenditure value on vegetables’
HHExpFVeg_Own_1M		                    ‘Own production expenditure value on vegetables’
HHExpFFrt_MN_1M			‘Cash expenditure on fruits’
HHExpFFrt_CRD_1M			‘Credit expenditure on fruits’
HHExpFFrt_GiftAid_1M		‘Assistance expenditure value on fruits’
HHExpFFrt_Own_1M		                    ‘Own production expenditure value on fruits’
HHExpFAnimMeat_MN_1M		‘Cash expenditure on meat’
HHExpFAnimMeat_CRD_1M		‘Credit expenditure on meat’
HHExpFAnimMeat_GiftAid_1M		‘Assistance expenditure value on meat’
HHExpFAnimMeat_Own_1M		‘Own production expenditure value on meat’
HHExpFAnimFish_MN_1M		‘Cash expenditure on fish’
HHExpFAnimFish_CRD_1M		‘Credit expenditure on fish’
HHExpFAnimFish_GiftAid_1M		‘Assistance expenditure value on fish’
HHExpFAnimFish_Own_1M		‘Own production expenditure value on fish’
HHExpFFats_MN_1M			‘Cash expenditure on oil/fat/butter’
HHExpFFats_CRD_1M			‘Credit expenditure on oil/fat/butter’
HHExpFFats_GiftAid_1M		‘Assistance expenditure value on oil/fat/butter’
HHExpFFats_Own_1M		 ‘Own production expenditure value on oil/fat/butter’
HHExpFDairy_MN_1M		‘Cash expenditure on milk/dairy products’
HHExpFDairy_CRD_1M		‘Credit expenditure on milk/dairy products’
HHExpFDairy_GiftAid_1M		‘Assistance expenditure value on milk/dairy products’
HHExpFDairy_Own_1M		‘Own production expenditure value on milk/dairy products’
HHExpFAnimEgg_MN_1M		‘Cash expenditure on eggs’
HHExpFAnimEgg_CRD_1M		‘Credit expenditure on eggs’
HHExpFAnimEgg_GiftAid_1M		‘Assistance expenditure value on eggs’
HHExpFAnimEgg_Own_1M		‘Own production expenditure value on eggs’
HHExpFSgr_MN_1M			‘Cash expenditure on sugar’
HHExpFSgr_CRD_1M			‘Credit expenditure on sugar’
HHExpFSgr_GiftAid_1M		‘Assistance expenditure value on sugar’
HHExpFSgr_Own_1M	                                        ‘Own production expenditure value on sugar’
HHExpFCond_MN_1M		‘Cash expenditure on condiments’
HHExpFCond_CRD_1M		‘Credit expenditure on condiments’ 
HHExpFCond_GiftAid_1M		‘Assistance expenditure value on condiments’
HHExpFCond_Own_1M		‘Own production expenditure value on condiments’
HHExpFBeverage_MN_1M		‘Cash expenditure on beverages’
HHExpFBeverage_CRD_1M		‘Credit expenditure on beverages’
HHExpFBeverage_GiftAid_1M		‘Assistance expenditure value on beverages’
HHExpFBeverage_Own_1M		‘Own production expenditure value on beverages’
HHExpFOut_MN_1M			‘Cash expenditure on snacks consumed outside the home’
HHExpFOut_CRD_1M			‘Credit expenditure on snacks consumed outside the home’
HHExpFOut_GiftAid_1M		‘Assistance expenditure value on snacks consumed outside the home’
HHExpFOut_Own_1M		                    ‘Own production expenditure value on snacks consumed outside the home’.
Execute.

**Calculate the overall monthly food expenditure per household for each category
    /*If the expenditure was calculated separately for cash, credit, aid/gift and own production, calculate the overall total by summing them up
    /*For ECMEN, only cash and own production to be included
    /*If the expenditure recall period is 7 days; make sure to transform it to 30 days

Compute HHExpFood_MN_1M =sum(HHExpFCer_MN_1M, HHExpFTub_MN_1M, 
HHExpFPuls_MN_1M,  HHExpFVeg_MN_1M, HHExpFFrt_MN_1M, HHExpFAnimMeat_MN_1M, 
HHExpFAnimFish_MN_1M, HHExpFFats_MN_1M, HHExpFDairy_MN_1M, 
HHExpFAnimEgg_MN_1M, HHExpFSgr_MN_1M, HHExpFCond_MN_1M, HHExpFBeverage_MN_1M, 
HHExpFOut_MN_1M). 

Compute HHExp_Food_CRD_1M =sum(HHExpFCer_CRD_1M, HHExpFTub_CRD_1M, 
HHExpFPuls_CRD_1M,  HHExpFVeg_CRD_1M, HHExpFFrt_CRD_1M, HHExpFAnimMeat_CRD_1M, 
HHExpFAnimFish_CRD_1M, HHExpFFats_CRD_1M, HHExpFDairy_CRD_1M, 
HHExpFAnimEgg_CRD_1M, HHExpFSgr_CRD_1M, HHExpFCond_CRD_1M, HHExpFBeverage_CRD_1M, 
HHExpFOut_CRD_1M).

Compute HHExp_Food_GiftAid_1M =sum(HHExpFCer_GiftAid_1M, HHExpFTub_GiftAid_1M, 
HHExpFPuls_GiftAid_1M, HHExpFVeg_GiftAid_1M, HHExpFFrt_GiftAid_1M, HHExpFAnimMeat_GiftAid_1M, 
HHExpFAnimFish_GiftAid_1M, HHExpFFats_GiftAid_1M, HHExpFDairy_GiftAid_1M, 
HHExpFAnimEgg_GiftAid_1M, HHExpFSgr_GiftAid_1M, HHExpFCond_GiftAid_1M, HHExpFBeverage_GiftAid_1M, 
HHExpFOut_GiftAid_1M).

Compute HHExp_Food_Own_1M =sum(HHExpFCer_Own_1M, HHExpFTub_Own_1M, 
HHExpFPuls_Own_1M,  HHExpFVeg_Own_1M, HHExpFFrt_Own_1M, HHExpFAnimMeat_Own_1M, 
HHExpFAnimFish_Own_1M, HHExpFFats_Own_1M, HHExpFDairy_Own_1M, 
HHExpFAnimEgg_Own_1M, HHExpFSgr_Own_1M, HHExpFCond_Own_1M, HHExpFBeverage_Own_1M, 
HHExpFOut_Own_1M).

Variable labels 
HHExp_Food_MN_1M    	'Total food expenditure on cash'
HHExp_Food_CRD_1M    	'Total food expenditure on credit'
HHExp_Food_GiftAid_1M    	'Total food expenditure value from assistance'
HHExp_Food_Own_1M    	'Total food expenditure value from own production'.
Execute.

***Non-food expenditure (30 days)***

Variable labels
HHExpNFHyg_MN_1M		'Cash expenditure on soap, hygiene & personal care items'
HHExpNFHyg_CRD_1M		'Credit expenditure on soap, hygiene & personal care items'
HHExpNFHyg_GiftAid_1M		'Assistance expenditure value on soap, hygiene & personal care items'
HHExpNFTransp_MN_1M		'Cash expenditure on transport'
HHExpNFTransp_CRD_1M		'Credit expenditure on transport'
HHExpNFTransp_GiftAid_1M		'Assistance expenditure value on transport'
HHExpNFWat_MN_1M		'Cash expenditure on water supply for domestic consumption'
HHExpNFWat_CRD_1M		'Credit expenditure on water supply for domestic consumption'
HHExpNFWat_GiftAid_1M		'Assistance expenditure value on water supply for domestic consumption'
HHExpNFElec_MN_1M		'Cash expenditure on electricity'
HHExpNFElec_CRD_1M		'Credit expenditure on electricity'
HHExpNFElec_GiftAid_1M		'Assistance expenditure value on electricity'
HHExpNFEnerg_MN_1M		'Cash expenditure on energy (cooking, heating, lighting) from other sources (not electricity)'
HHExpNFEnerg_CRD_1M		'Credit expenditure on energy (cooking, heating, lighting) from other sources (not electricity)'
HHExpNFEnerg_GiftAid_1M		‘Assistance expenditure value on energy (cooking, heating, lighting) from other sources (not electricity)’
HHExpNFDwelServ_MN_1M		‘Cash expenditure on miscellaneous services relating to the dwelling’
HHExpNFDwelServ_CRD_1M		‘Credit expenditure on miscellaneous services relating to the dwelling’
HHExpNFDwelServ_GiftAid_1M		‘Assistance expenditure value on miscellaneous services relating to the dwelling’
HHExpNFPhone_MN_1M		‘Cash expenditure on information and communication’
HHExpNFPhone_CRD_1M		‘Credit expenditure on information and communication’
HHExpNFPhone_GiftAid_1M		‘Assistance expenditure value on information and communication’
HHExpNFAlcTobac_MN_1M		‘Cash expenditure on alcoholic beverages and tobacco’
HHExpNFAlcTobac_CRD_1M		‘Credit expenditure on alcoholic beverages and tobacco’
HHExpNFAlcTobac_GiftAid_1M		‘Assistance expenditure value on alcoholic beverages and tobacco’
HHExpNFSpec1_MN_1M		‘Cash expenditure on [specific to country]’
HHExpNFSpec1_CRD_1M		‘Credit expenditure on [Specific to country]’
HHExpNFSpec1_GiftAid_1M		‘Assistance expenditure value on [Specific to country]’.

***Non-food expenditure (6 months)***

Variable labels
HHExpNFMedServ_MN_6M		‘Cash expenditure on health services’
HHExpNFMedServ_CRD_6M		"Credit expenditure on health services"
HHExpNFMedServ_GiftAid_6M		‘Assistance expenditure value  on health services’
HHExpNFMedGood_MN_6M 		‘Cash expenditure on medicines & health products’
HHExpNFMedGood_CRD_6M 		‘Credit expenditure on medicines & health products’
HHExpNFMedGood_GiftAid_6M 		‘Assistance expenditure value  on medicines & health products’
HHExpNFCloth_MN_6M		‘Cash expenditure on clothing and footwear’
HHExpNFCloth_CRD_6M		‘Credit expenditure on clothing and footwear’
HHExpNFCloth_GiftAid_6M		‘Assistance expenditure value  on clothing and footwear’
HHExpNFEduFee_MN_6M		‘Cash expenditure on education services’
HHExpNFEduFee_CRD_6M		‘Credit expenditure on education services’
HHExpNFEduFee_GiftAid_6M		‘Assistance expenditure value  on education services’
HHExpNFEduGood_MN_6M		‘Cash expenditure on education goods’
HHExpNFEduGood_CRD_6M		‘Credit expenditure on education goods’
HHExpNFEduGood_GiftAid_6M		‘Assistance expenditure value  on education goods’
HHExpNFRent_MN_6M		‘Cash expenditure on rent’
HHExpNFRent_CRD_6M		‘Credit expenditure on rent’
HHExpNFRent_GiftAid _6M		"Assistance expenditure value  on rent" 
HHExpNFHHSoft_MN_6M		‘Cash expenditure on household non-durable furniture and routine maintenance’
HHExpNFHHSoft_CRD_6M		‘Credit expenditure on household non-durable furniture and routine maintenance’
HHExpNFHHSoft_GiftAid_6M		‘Assistance expenditure value  on household non-durable furniture and routine maintenance’
HHExpNFSav_MN_6M		‘Cash expenditure on savings’
HHExpNFSav_CRD_6M		‘Credit expenditure on savings’
HHExpNFSav_GiftAid_6M		‘Assistance expenditure value  on savings’
HHExpNFDebt_MN_6M		"Cash expenditure on debt repayment"
HHExpNFDebt_CRD_6M		‘Credit expenditure on debt repayment’
HHExpNFDebt_GiftAid_6M		‘Assistance expenditure value  on debt repayment’  
HHExpNFInsurance_MN_6M		‘Cash expenditure on insurance’
HHExpNFInsurance_CRD_6M		‘Credit expenditure on insurance’
HHExpNFInsurance_GiftAid_6M		‘Assistance expenditure value  on insurance’.

***Calculate the overall monthly non-food expenditure per household
    /*Make sure to calculate separately for cash, credit, aid/gift and own production, calculate the overall by summing them up
    /*If the expenditure recall period is 7 days or 6 months; make sure to transform it to 30 days
    
Compute HHExpNFTotal_MN_6M=sum(HHExpNFRent_MN_6M,HHExpNFMedServ_MN_6M, 
    HHExpNFMedGood_MN_6M, HHExpNFCloth_MN_6M, HHExpNFEduFee_MN_6M, HHExpNFEduGood_MN_6M,
    HHExpNFSoft_MN_6M, HHExpNFSav_MN_6M, HHExpNFInsurance_MN_6M, HHExpNFDebt_MN_6M).

Compute HHExpNFTotal_MN_30D=sum(HHExpNFAlcTobac_MN_1M,HHExpNFHyg_MN_1M,
    HHExpNFTransp_MN_1M, HHExpNFWat_MN_1M, HHExpNFDwelServ_MN_1M, HHExpNFElec_MN_1M, HHExpNFEnerg_MN_1M, HHExpNFPhone_MN_1M, HHExpNFSpec1_MN_1M).

*sum the non-food 1 month and 6 month expenditures 
Compute HHExpNFTotal_MN_1M=(HHExpNFTotal_MN_30D+HHExpNFTotal_MN_6M/6).

 *note: to reduce the number of variables in your dataset, you could run the delete function below.    
delete variables HHExpNFTotal_MN_6M HHExpNFTotal_MN_30D.

Compute HHExpNFTotal_CRD_6M=sum(HHExpNFRent_CRD_6M, HHExpNFMedServ_CRD_6M,
    HHExpNFMedGood_CRD_6M, HHExpNFCloth_CRD_6M, HHExpNFEduFee_CRD_6M, HHExpNFEduGood_CRD_6M,
    HHExpNFSoft_CRD_6M, HHExpNFInsurance_CRD_6M, HHExpNFDebt_CRD_6M).

Compute HHExpNFTotal_CRD_30D = sum(HHExpNFAlcTobac_CRD_1M,HHExpNFHyg_CRD_1M,
    HHExpNFTransp_CRD_1M, HHExpNFWat_CRD_1M, HHExpNFDwelServ_CRD_1M, HHExpNFElec_CRD_1M, HHExpNFEnerg_CRD_1M,
    HHExpNFPhone_CRD_1M, HHExpNFSpec1_CRD_1M).
compute HHExpNFTotal_CRD_1M=(HHExpNFTotal_CRD_30D+HHExpNFTotal_CRD_6M/6).

*note: to reduce the number of variables in your dataset, you could run the delete function below.    
delete variables HHExpNFTotal_CRD_6M HHExpNFTotal_CRD_30D.
   
Compute HHExpNFTotal_GiftAid_6M=sum(HHExpNFRent_GiftAid_6M,HHExpNFMedServ_GiftAid_6M,
    HHExpNFMedGood_GiftAid_6M, HHExpNFCloth_GiftAid_6M, HHExpNFEduFee_GiftAid_6M, HHExpNFEduGood_GiftAid_6M,
    HHExpNFSoft_GiftAid_6M, HHExpNFSav_GiftAid_6M, HHExpNFInsurance_GiftAid_6M, HHExpNFDebt_GiftAid_6M).

Compute HHExpNFTotal_GiftAid_30D = sum(HHExpNFAlcTobac_GiftAid_1M, HHExpNFHyg_GiftAid_1M,
    HHExpNFTransp_GiftAid_1M, HHExpNFWat_GiftAid_1M, HHExpNFDwelServ_GiftAid_1M, HHExpNFElec_GiftAid_1M, HHExpNFEnerg_GiftAid_1M, HHExpNFPhone_GiftAid_1M, HHExpNFSpec1_GiftAid_1M).

*sum the non-food 1 month and 6-month expenditures 
Compute HHExpNFTotal_GiftAid_1M=(HHExpNFTotal_GiftAid_30D+HHExpNFTotal_GiftAid_6M/6).

*note: to reduce the number of variables in your dataset, you could run the delete function below.    
delete variables HHExpNFTotal_GiftAid_6M HHExpNFTotal_GiftAid_30D.

Variable labels HHExpNFTotal_MN_1M 'Total non-food exp on cash'.
Variable labels HHExpNFTotal_CRD_1M 'Total non-food exp on credit'.
Variable labels HHExpNFTotal_GiftAid_1M 'Total non-food exp from gift aid'.
Execute.
    
***Calculate totals for food and non-food expenditure

Compute HHExpNFTotal_1M=sum(HHExpNFTotal_MN_1M, HHExpNFTotal_CRD_1M, HHExpNFTotal_GiftAid_1M).
Compute HHExpFood_1M=sum( HHExpFood_MN_1M, HHExp_Food_CRD_1M, HHExp_Food_Own_1M, HHExp_Food_GiftAid_1M).
EXECUTE.

***Note: For ECMEN analysis, do not include assistance and credit expenditure. Credit expenditures do not refer to credits repaid in the same month*** 
    /*Only include cash and own production analysis 
    /*Please feel free to create variations according to the context 
/*HHSize variable refers to total household size

***Calculate total household and per capita expenditure*** 

Compute HHExpTotal=HHExpFood_1M + HHExpNFTotal_1M.
Compute PCExpTotal=HHExpTotal/HHSize.
Variable labels PCExpTotal 'Monthly total per capita exp incl all food and non-food exp in cash, credit, assistance'.
Variable labels HHExpTotal 'Monthly total HH exp incl all food and non-food exp in cash, credit, assistance'.
Execute.

Frequencies HHExpTotal /statistics /histogram.

***Calculate total expenditure excluding assistance and credit for ECMEN analysis 

Compute HHExp_ECMEN= HHExpFood_MN_1M+ HHExp_Food_Own_1M+ HHExpNFTotal_MN_1M.
Compute PCExp_ECMEN=HHExp_ECMEN/HHSize.



Variable labels PCExp_ECMEN 'Monthly total per capita exp for ECMEN exc assistance and credit'.
Variable labels HHExp_ECMEN 'Monthly total HH exp for ECMEN exc assistance and credit'.
Execute.

Frequencies HHExp_ECMEN /statistics /histogram.

/*In order to calculate ECMEN, please enter MEB manually as below
    /*MEB_PC: Minimum expenditure basket per capita 
    /*MEB_HH: Minimum expenditure basket per household 
    
/***Calculate ECMEN: Economic Capacity to Meet Essential Needs
    
If (PCExp_ECMEN <= MEB_PC) ECMEN=0.
If (PCExp_ECMEN > MEB_PC) ECMEN=1.

Variable labels ECMEN 'Percentage of HH with exp above MEB, excl. assistance, credit'.
Value labels ECMEN
0 'HH with no capacity' 
1 'HH with capacity'.
Execute.

Frequencies ECMEN /statistics. 

If (PCExp_ECMEN <= SMEB_PC) ECMEN_SMEB=0.
If (PCExp_ECMEN > SMEB_PC) ECMEN_SMEB=1.

Variable labels ECMEN_SMEB 'Percentage of HH with exp above SMEB, excl. assistance, credit'.
Value labels ECMEN_SMEB
0 'HH with no capacity'
1 'HH with capacity'.
Execute.

Frequencies ECMEN_SMEB /statistics. 

***recode ECMEN based on the MEB and SMEB cut-off points in the area/country for CARI calculation 

IF (ECMEN=1) ECMEN_MEB=1. 
IF (ECMEN=0 & ECMEN_SMEB=1) ECMEN_MEB=2. 
IF (ECMEN=0 & ECMEN_SMEB=0) ECMEN_MEB=3.

***recode the ‘ECMEN_MEB’ variable into a 4pt scale for CARI console.

Recode ECMEN_MEB (1=1) (2=3) (3=4) INTO ECMEN_class_4pt. 
Variable labels ECMEN_class_4pt 'ECMEN 4pt'.
EXECUTE.

Frequencies variables= ECMEN _class_4pt /ORDER=ANALYSIS. 
Value labels ECMEN _class_4pt 1.00 'Least vulnerable' 3.00 'Vulnerable' 4.00 'Highly vulnerable'. 
EXECUTE.

***CARI (WITH ECMEN) ***

Compute Mean_coping_capacity_ECMEN = MEAN (Max_coping_behaviour, ECMEN _class_4pt).  
Compute CARI_unrounded_ECMEN = MEAN (FCS_4pt, Mean_coping_capacity_ECMEN). 
Compute CARI_ECMEN = RND (CARI_unrounded_ECMEN).  
EXECUTE. 

Value labels CARI_ECMEN 1 'Food secure'   2 'Marginally food secure'   3 'Moderately food insecure'   4 'Severely food insecure'.
EXECUTE.

Frequencies CARI_ECMEN.

***create population distribution table, to to explore how the domains interact within the different food security categories 

CTABLES
  /VLABELS VARIABLES= ECMEN _class_4pt FCS_4pt Max_coping_behaviour DISPLAY=LABEL
  /TABLE ECMEN _class_4pt [C] BY FCS_4pt [C] > Max_coping_behaviour [C][ROWPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES= ECMEN _class_4pt ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=FCS_4pt Max_coping_behaviour ORDER=A KEY=VALUE EMPTY=INCLUDE.



