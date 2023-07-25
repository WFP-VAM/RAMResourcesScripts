********************************************************************************
*					 Minimum Dietary Diversity for Women (MDDW)
*******************************************************************************/
	
** Load data
* ---------
	import delim using "../Nutrition_module_MDD_W_submodule_RepeatMDDW.csv", ///
		     clear case(preserve)
	   
** rename varuavke to remove group names
	ren Nutrition_moduleMDD_W_submoduleRepeatMDDW* *
	
** check and recode missing values as 0
	sum	   PWMDDW*
	recode PWMDDW* (. = 0)

** assign variable and value labels
	label def yesno   1 "Yes" 0 "No"
	label val PWMDDW* yesno

	label var PWMDDWStapCer				      "Foods made from grains"
	label var PWMDDWStapRoo				      "White roots and tubers or plantains"
	label var PWMDDWPulse				        "Pulses (beans, peas and lentils)"
	label var PWMDDWNuts				        "Nuts and seeds"
	label var PWMDDWMilk				        "Milk"
	label var PWMDDWDairy				        "Milk products"
	label var PWMDDWPrMeatO				      "Organ meats"
	label var PWMDDWPrMeatF				      "Red flesh meat from mammals"
	label var PWMDDWPrMeatPro			      "Processed meat"
	label var PWMDDWPrMeatWhite         "Poultry and other white meats"
	label var PWMDDWPrFish				      "Fish and Seafood"
	label var PWMDDWPrEgg				        "Eggs from poultry or any other bird"
	label var PWMDDWVegGre 				      "Dark green leafy vegetable"
	label var PWMDDWVegOrg				      "Vitamin A-rich vegetables, roots and tubers"
	label var PWMDDWFruitOrg			      "Vitamin A-rich fruits"
	label var PWMDDWVegOth				      "Other vegetables"
	label var PWMDDWFruitOth			      "Other fruits"
	label var PWMDDWSnf					        "Specialized Nutritious Foods (SNF) for women"
	label var PWMDDWFortFoodoil 	      "Fortified oil"
	label var PWMDDWFortFoodwflour      "Fortified wheat flour"
	label var PWMDDWFortFoodmflour	    "Fortified maize flour"
	label var PWMDDWFortFoodrice  	    "Fortified Rice"
	label var PWMDDWFortFooddrink  		  "Fortified drink"
	label var PWMDDWFortFoodother  		  "Other:"
	label var PWMDDWFortFoodother_oth  	"Other specify: ______"
	

/*  		Calculate 2 MDDW indicators based on WFP guidelines 
	https://docs.wfp.org/api/documents/WFP-0000140197/download/ Page.8 

	1. Standard MDDW Indicator for population based surveys counts SNF in home 
	   group (refer to https://docs.wfp.org/api/documents/WFP-0000139484/download/ 
	   for "home group")
	2. WFP Modified MDDW WFP programme monitoring counts SNF in "Meat, poultry 
	   and fish" Category
*/

**************************** Standard MDDW method ******************************
	
/*  In this example SNF home group will be grains; fortified foods 
	(PWMDDWFortFoodwflour, PWMDDWFortFoodmflour, PWMDDWFortFoodrice, 
	PWMDDWFortFooddrink) will also count in grains. Classifying 
	PWMDDWFortFoodother_oth will likely involve classifying line by line. 	  */

	gen MDDW_Staples 	 = (PWMDDWStapCer == 1 | PWMDDWStapRoo == 1 | PWMDDWSnf == 1 | ///
							          PWMDDWFortFoodwflour == 1 | PWMDDWFortFoodmflour == 1 	 | ///
							          PWMDDWFortFoodrice 	 == 1 | PWMDDWFortFooddrink  == 1)
	gen MDDW_Pulses		 = (PWMDDWPulse   == 1)
	gen MDDW_NutsSeeds = (PWMDDWNutsR   == 1)
	gen MDDW_Dairy		 = (PWMDDWDairy   == 1 | PWMDDWMilk == 1)
	gen MDDW_MeatFish	 = (PWMDDWPrMeatO == 1 | PWMDDWPrMeatF == 1 | PWMDDWPrMeatPro == 1 | ///
							          PWMDDWPrMeatWhite == 1 | PWMDDWPrFish == 1)
	gen MDDW_Eggs		   = (PWMDDWPrEgg   == 1)
	gen MDDW_LeafGVeg	 = (PWMDDWVegGre  == 1)
	gen MDDW_VitA  		 = (PWMDDWVegOrg  == 1 | PWMDDWFruitOrg == 1)
  gen MDDW_OtherVeg  = (PWMDDWVegOth  == 1)
  gen MDDW_OtherFruits = (PWMDDWFruitOth == 1)
	
	* calculate MDDW variable for both methods by adding together food groups and 
	* classifying whether the woman consumed 5 or more food groups
	gen MDDW = MDDW_Staples + MDDW_Pulses + MDDW_NutsSeeds + MDDW_Dairies + MDDW_MeatFish + ///
			       MDDW_Eggs + MDDW_LeafGVeg + MDDW_VitA + MDDW_OtherVeg + MDDW_OtherFruits
	gen MDDW_5 = (MDDW >= 5)
	
	tab MDDW_5, d
	
*********************** WFP MDDW method for program monitoring *****************

/*  In this example SNF will count in the meats group; fortified foods 
	(PWMDDWFortFoodwflour, PWMDDWFortFoodmflour, PWMDDWFortFoodrice, 
	PWMDDWFortFooddrink) will count in grains. Classifying 
	PWMDDWFortFoodother_oth will likely involve classifying line by line. 	  */	
	
	gen MDDW_Staples_wfp   = (PWMDDWStapCer == 1 		| PWMDDWStapRoo == 1 	    | ///
							  PWMDDWFortFoodwflour == 1 | PWMDDWFortFoodmflour == 1 | ///
							  PWMDDWFortFoodrice   == 1 | PWMDDWFortFooddrink  == 1)
	gen MDDW_Pulses_wfp	   = (PWMDDWPulse   == 1)
	gen MDDW_NutsSeeds_wfp = (PWMDDWNutsR   == 1)
	gen MDDW_Dairy_wfp	   = (PWMDDWDairy   == 1 | PWMDDWMilk == 1)
	gen MDDW_MeatFish_wfp  = (PWMDDWPrMeatO == 1 | PWMDDWPrMeatF == 1 	  | PWMDDWPrMeatPro == 1 | ///
							  PWMDDWPrMeatWhite == 1 | PWMDDWPrFish  == 1 | PWMDDWSnf == 1)
	gen MDDW_Eggs_wfp 	   = (PWMDDWPrEgg   == 1)
	gen MDDW_LeafGVeg_wfp  = (PWMDDWVegGre  == 1)
	gen MDDW_VitA_wfp      = (PWMDDWVegOrg  == 1 | PWMDDWFruitOrg == 1)
	gen MDDW_OtherVeg_wfp  = (PWMDDWVegOth  == 1)
	gen MDDW_OtherFruits_wfp = (PWMDDWFruitOth == 1)
	
	gen MDDW_wfp = MDDW_Staples_wfp  + MDDW_Pulses_wfp + MDDW_NutsSeeds_wfp + MDDW_Dairies_wfp + ///
				   MDDW_MeatFish_wfp + MDDW_Eggs_wfp   + MDDW_LeafGVeg_wfp  + MDDW_VitA_wfp +    ///
			       MDDW_OtherVeg_wfp + MDDW_OtherFruits_wfp
	gen MDDW_5_wfp = (MDDW_wfp >= 5)
	
	tab MDDW_5_wfp, d
	
* End of dofile
