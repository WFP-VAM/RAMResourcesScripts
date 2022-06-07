Syntax for the Economic Capacity to Meet Essential Needs Indicator
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
execute.


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

variable labels 
HHExp_Food_MN_1M    'Total food expenditure on cash'
HHExp_Food_CRD_1M    'Total food expenditure on credit'
HHExp_Food_GiftAid_1M    'Total food expenditure value from assistance'
HHExp_Food_Own_1M    'Total food expenditure value from own production'.
execute.

***Non-food expenditure (30 days)***

Variable labels
HHExpNFHyg_MN_1M		‘Cash expenditure on soap, hygiene & personal care items’
HHExpNFHyg_CRD_1M		‘Credit expenditure on soap, hygiene & personal care items’ 
HHExpNFHyg_GiftAid_1M		‘Assistance expenditure value  on soap, hygiene & personal care items’
HHExpNFTransp_MN_1M		‘Cash expenditure on transport’
HHExpNFTransp_CRD_1M		‘Credit expenditure on transport’
HHExpNFTransp_GiftAid_1M		‘Assistance expenditure value  on transport’
HHExpNFWat_MN_1M		‘Cash expenditure on water supply for domestic consumption’
HHExpNFWat_CRD_1M		‘Credit expenditure on water supply for domestic consumption’
HHExpNFWat_GiftAid_1M		‘Assistance expenditure value  on water supply for domestic consumption’
HHExpNFElec_MN_1M		‘Cash expenditure on electricity’
HHExpNFElec_CRD_1M		‘Credit expenditure on electricity’
HHExpNFElec_GiftAid_1M		‘Assistance expenditure value  on electricity’
HHExpNFEnerg_MN_1M		‘Cash expenditure on energy (cooking, heating, lighting) from other sources (not electricity)’
HHExpNFEnerg_CRD_1M		‘Credit expenditure on energy (cooking, heating, lighting) from other sources (not electricity)'
HHExpNFEnerg_GiftAid_1M		‘Assistance expenditure value  on energy (cooking, heating, lighting) from other sources (not electricity)’
HHExpNFDwelServ_MN_1M		‘Cash expenditure on miscellaneous services relating to the dwelling’
HHExpNFDwelServ_CRD_1M		‘Credit expenditure on miscellaneous services relating to the dwelling’
HHExpNFDwelServ_GiftAid_1M		‘Assistance expenditure value  on miscellaneous services relating to the dwelling’
HHExpNFPhone_MN_1M		‘Cash expenditure on information and communication’
HHExpNFPhone_CRD_1M		‘Credit expenditure on information and communication’
HHExpNFPhone_GiftAid_1M		‘Assistance expenditure value  on information and communication’
HHExpNFAlcTobac_MN_1M		‘Cash expenditure on alcoholic beverages and tobacco’
HHExpNFAlcTobac_CRD_1M		‘Credit expenditure on alcoholic beverages and tobacco’
HHExpNFAlcTobac_GiftAid_1M		‘Assistance expenditure value  on alcoholic beverages and tobacco’. 
HHExpNFSpec1_MN_1M		‘Cash expenditure on [specific to country]’
HHExpNFSpec1_CRD_1M		‘Credit expenditure on [Specific to country]’
HHExpNFSpec1_GiftAid_1M		‘Assistance expenditure value  on [Specific to country]’. 

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
HHExpNFInsurance_GiftAid_6M		‘Assistance expenditure value  on insurance’

***Calculate the overall monthly non-food expenditure per household
    /*Make sure to calculate separately for cash, credit, aid/gift and own production, calculate the overall by summing them up
    /*If the expenditure recall period is 7 days or 6 months; make sure to transform it to 30 days
    

compute HHExpNFTotal_MN_6M=sum(HHExpNFRent_MN_6M,HHExpNFMedServ_MN_6M, 
    HHExpNFMedGood_MN_6M, HHExpNFCloth_MN_6M, HHExpNFEduFee_MN_6M, HHExpNFEduGood_MN_6M,
    HHExpNFSoft_MN_6M, HHExpNFSav_MN_6M, HHExpNFInsurance_MN_6M, HHExpNFDebt_MN_6M).
compute HHExpNFTotal_MN_30D=sum(HHExpNFAlcTobac_MN_1M,HHExpNFHyg_MN_1M,
    HHExpNFTransp_MN_1M, HHExpNFWat_MN_1M, HHExpNFDwelServ_MN_1M, HHExpNFElec_MN_1M, HHExpNFEnerg_MN_1M,
    HHExpNFPhone_MN_1M, HHExpNFSpec1_MN_1M).
compute HHExpNFTotal_MN_1M=(HHExpNFTotal_MN_30D+HHExpNFTotal_MN_6M/6).
    
delete variables HHExpNFTotal_MN_6M HHExpNFTotal_MN_30D.

compute HHExpNFTotal_CRD_6M=sum(HHExpNFRent_CRD_6M, HHExpNFMedServ_CRD_6M,
    HHExpNFMedGood_CRD_6M, HHExpNFCloth_CRD_6M, HHExpNFEduFee_CRD_6M, HHExpNFEduGood_CRD_6M,
    HHExpNFSoft_CRD_6M, HHExpNFInsurance_CRD_6M, HHExpNFDebt_CRD_6M).
compute HHExpNFTotal_CRD_30D = sum(HHExpNFAlcTobac_CRD_1M,HHExpNFHyg_CRD_1M,
    HHExpNFTransp_CRD_1M, HHExpNFWat_CRD_1M, HHExpNFDwelServ_CRD_1M, HHExpNFElec_CRD_1M, HHExpNFEnerg_CRD_1M,
    HHExpNFPhone_CRD_1M, HHExpNFSpec1_CRD_1M).
compute HHExpNFTotal_CRD_1M=(HHExpNFTotal_CRD_30D+HHExpNFTotal_CRD_6M/6).

delete variables HHExpNFTotal_CRD_6M HHExpNFTotal_CRD_30D.
    

compute HHExpNFTotal_GiftAid_6M=sum(HHExpNFRent_GiftAid_6M,HHExpNFMedServ_GiftAid_6M,
    HHExpNFMedGood_GiftAid_6M, HHExpNFCloth_GiftAid_6M, HHExpNFEduFee_GiftAid_6M, HHExpNFEduGood_GiftAid_6M,
    HHExpNFSoft_GiftAid_6M, HHExpNFSav_GiftAid_6M, HHExpNFInsurance_GiftAid_6M, HHExpNFDebt_GiftAid_6M).
compute HHExpNFTotal_GiftAid_30D = sum(HHExpNFAlcTobac_GiftAid_1M, HHExpNFHyg_GiftAid_1M,
    HHExpNFTransp_GiftAid_1M, HHExpNFWat_GiftAid_1M, HHExpNFDwelServ_GiftAid_1M, HHExpNFElec_GiftAid_1M,HHExpNFEnerg_GiftAid_1M,
    HHExpNFPhone_GiftAid_1M, HHExpNFSpec1_GiftAid_1M).
compute HHExpNFTotal_GiftAid_1M=(HHExpNFTotal_GiftAid_30D+HHExpNFTotal_GiftAid_6M/6).
    
delete variables HHExpNFTotal_GiftAid_6M HHExpNFTotal_GiftAid_30D.

Variable labels HHExpNFTotal_MN_1M 'Total non-food exp on cash'.
Variable labels HHExpNFTotal_CRD_1M 'Total non-food exp on credit'.
Variable labels HHExpNFTotal_GiftAid_1M 'Total non-food exp from gift aid'.
execute.
    
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
Variable labels HHExpTotal 'Monthly total HH exp incl all food and non-food exp in cash, credit, assistance''.
Execute.

Frequencies HHExpTotal /statistics /histogram.

***Calculate total expenditure excluding assistance and credit for ECMEN analysis 

compute HHExp_ECMEN= HHExpFood_MN_1M+ HHExp_Food_Own_1M+ HHExpNFTotal_MN_1M.
compute PCExp_ECMEN=HHExp_ECMEN/HHSize.
variable labels PCExp_ECMEN 'Monthly total per capita exp for ECMEN exc assistance and credit'.
variable labels HHExp_ECMEN 'Monthly total HH exp for ECMEN exc assistance and credit'.
execute.

Frequencies HHExp_ECMEN /statistics /histogram.


/*In order to calculate ECMEN, please enter MEB manually as below
    /*MEB_PC: Minimum expenditure basket per capita 
    /*MEB_HH: Minimum expenditure basket per household 
    

/***Calculate ECMEN : Economic Capacity to Meet Essential Needs
    

if ( PCExp_ECMEN < MEB_PC) ECMEN=0.
variable labels ECMEN 'Percentage of HH with exp above MEB, excl. assistance, credit'.
value labels ECMEN
1 'HH with capacity'
0 'HH with no capacity'.
execute.

frequencies ECMEN /statistics. 

/*Calculation of ECMEN with SMEB ( Survival Minimum Expenditure Basket
    /*SMEB_PC: Suvival  minimum expenditure basket per capita 
    /*SMEB_HH: Survival minimum expenditure basket per household 

if ( PCExp_ECMEN < SMEB_PC) ECMEN_SMEB=0.
variable labels ECMEN_SMEB 'Percentage of HH with exp above SMEB, excl. assistance, credit'.
value labels ECMEN_SMEB
1 'HH with capacity '
0 'HH with no capacity'.
execute.

frequencies ECMEN_SMEB /statistics. 




