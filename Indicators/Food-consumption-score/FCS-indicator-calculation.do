*------------------------------------------------------------------------------*
*	                          WFP Standardized Scripts
*                     Calculating Food Consumption Score (FCS)
*-----------------------------------------------------------------------------

** Load data
* ---------
*	import delim using "../../Static/FCS_Sample_Survey.csv", clear 	///
*		   case(preserve) bindquotes(strict) varn(1)

** Label FCS relevant variables
	label var FCSStap		"Consumption over the past 7 days: cereals, grains and tubers"
	label var FCSPulse		"Consumption over the past 7 days: pulses"
	label var FCSDairy		"Consumption over the past 7 days: dairy products"
	label var FCSPr			"Consumption over the past 7 days: meat, fish and eggs"
	label var FCSVeg		"Consumption over the past 7 days: vegetables"
	label var FCSFruit		"Consumption over the past 7 days: fruit"
	label var FCSFat		"Consumption over the past 7 days: fat and oil"
	label var FCSSugar		"Consumption over the past 7 days: sugaror sweets"
	label var FCSCond		"Consumption over the past 7 days: condiments or spices"

** Clean and recode missing values
	recode FCSStap FCSVeg FCSFruit FCSPr FCSPulse FCSDairy FCSFat FCSSugar (. = 0)

** Create FCS 
	gen FCS = (FCSStap * 2) + (FCSPulse * 3) + (FCSDairy * 4) + (FCSPr * 4) + 	///
			  (FCSVeg  * 1) + (FCSFruit * 1) + (FCSFat * 0.5) + (FCSSugar * 0.5)	  

	label var FCS "Food Consumption Score"

** Create FCG groups based on 21/35 or 28/42 thresholds
*** Use this when analyzing a country with low consumption of sugar and oil

*** thresholds 21-35
	gen FCSCat21 = cond(FCS <= 21, 1, cond(FCS <= 35, 2, 3))
	label var FCSCat21 "FCS Categories, thresholds 21-35"

*** thresholds 28-42
	gen FCSCat28 = cond(FCS <= 28, 1, cond(FCS <= 42, 2, 3))
	label var FCSCat28 "FCS Categories, thresholds 28-42"


*** define variables labels and properties for "FCS Categories"
	label def FCSCat 1 "Poor" 2 "Borderline" 3 "Acceptable"
	label val FCSCat21 FCSCat28 FCSCat
	
* ---------
** End of Scripts