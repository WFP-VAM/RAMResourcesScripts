/*******************************************************************************
*	                      	  WFP Standardized Scripts					       *
*				Calculating Food Consumption Groups and Food Sources  		   * 
*******************************************************************************/
*					PART 1: Label Relevant Variables and Values
********************************************************************************
	
	label var FCSStap		"Consumption over the past 7 days: cereals, grains and tubers"
	label var FCSPulse		"Consumption over the past 7 days: pulses"
	label var FCSDairy		"Consumption over the past 7 days: dairy products"
	label var FCSPr			"Consumption over the past 7 days: protein-rich foods"
	label var FCSVeg		"Consumption over the past 7 days: vegetables"
	label var FCSFruit		"Consumption over the past 7 days: fruit"
	label var FCSFat		"Consumption over the past 7 days: oil"
	label var FCSSugar		"Consumption over the past 7 days: sugar"
	label var FCSCond		"Consumption over the past 7 days: condiments"
	
	label var FCSStap_SRf	"Main source: cereals, grains and tubers"
	label var FCSPulse_SRf	"Main source: pulses"
	label var FCSDairy_SRf	"Main source: dairy products"
	label var FCSPr_SRf		"Main source: protein-rich foods"
	label var FCSVeg_SRf	"Main source: vegetables"
	label var FCSFruit_SRf	"Main source: fruit"
	label var FCSFat_SRf	"Main source: oil"
	label var FCSSugar_SRf	"Main source: sugar"
	label var FCSCond_SRf	"Main source: condiments"

	label def FCS_SRf_l		100 	"Own production"				///
							200 	"Fishing or hunting"			///
							300 	"Gathering"						///
							400 	"Loaned or borrowed"			///
							500 	"Purchased"						///
							600 	"Credit"						///
							700 	"Begging"						///
							800 	"Exchange for labour or items"	///
							900 	"Gifts from family or friends"	///
							1000 	"Food aid"
							
	label val FCSStap_SRf FCSPulse_SRf FCSDairy_SRf FCSPr_SRf FCSVeg_SRf 	///
			  FCSFruit_SRf FCSFat_SRf FCSSugar_SRf FCSCond_SRf FCS_SRf_l

*******************************************************************************/
*				PART 2: Create Food Consumption Variable by Source
********************************************************************************
	
** Step 0 - Rename existing variables
local SRf Ownprod HuntFish Gather Borrow Cash Credit Beg Exchange Gift Assistance 

foreach var of local SRf {
	cap rename `var'* 	OLD_`var'*
}
	
** Step 1 - Calculate unique variable for each source
local SRf_var Stap Pulse Dairy Pr Veg Fruit Fat Sugar Cond

foreach var of local SRf_var {
	gen Ownprod_`var' 	= FCS`var' if FCS`var'_SRf == 100 
	gen HuntFish_`var' 	= FCS`var' if FCS`var'_SRf == 200
	gen Gather_`var'  	= FCS`var' if FCS`var'_SRf == 300
	gen Borrow_`var'	= FCS`var' if FCS`var'_SRf == 400 
	gen Cash_`var'		= FCS`var' if FCS`var'_SRf == 500
	gen Credit_`var'	= FCS`var' if FCS`var'_SRf == 600
	gen Beg_`var'		= FCS`var' if FCS`var'_SRf == 700
	gen Exchange_`var'	= FCS`var' if FCS`var'_SRf == 800
	gen Gift_`var'		= FCS`var' if FCS`var'_SRf == 900
	gen Assistance_`var'= FCS`var' if FCS`var'_SRf == 1000
}
	
** Step 2 - Aggregate by source
	egen Ownprod	= rowtotal(Ownprod_*)
	egen HuntFish	= rowtotal(HuntFish_*)
	egen Gather		= rowtotal(Gather_*)
	egen Borrow		= rowtotal(Borrow_*)
	egen Cash		= rowtotal(Cash_*)
	egen Credit		= rowtotal(Credit_*)
	egen Beg		= rowtotal(Beg_*)
	egen Exchange	= rowtotal(Exchange_*)
	egen Gift		= rowtotal(Gift_*)
	egen Assistance = rowtotal(Assistance_*)
	
** Step 3 - Compute the total sources of food 
	egen Total_source = rowtotal(Ownprod HuntFish Gather Borrow Cash Credit Beg ///
								 Exchange Gift Assistance)

** Step 4 - Calculate % of each food source 

foreach var of local SRf {
	gen Percent_`var' = (`var'/Total_source) * 100
}

** Step 5 - Label new variables
	label var Percent_Ownprod	 "Percent of main source: Own production"
	label var Percent_HuntFish	 "Percent of main source: Hunted or fished"
	label var Percent_Gather	 "Percent of main source: Gathered"
	label var Percent_Borrow	 "Percent of main source: Borrowed from family or friends"
	label var Percent_Cash		 "Percent of main source: Purchased with cash"
	label var Percent_Credit	 "Percent of main source: Purchased with credit"
	label var Percent_Beg		 "Percent of main source: Begging"
	label var Percent_Exchange	 "Percent of main source: Barter or exchange"
	label var Percent_Gift		 "Percent of main source: Gifts from family or friends"
	label var Percent_Assistance "Percent of main source: Assistance"

** Step 6 - Drop intermediate variables
	
	drop Ownprod_* HuntFish_* Gather_* Borrow_* Cash_* Credit_* Beg_* Exchange_* ///
		 Gift_* Assistance_*
	 
* ---------
** End of Scripts