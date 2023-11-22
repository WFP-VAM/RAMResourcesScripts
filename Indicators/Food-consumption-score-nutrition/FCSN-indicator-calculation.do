*------------------------------------------------------------------------------*

*	                        WFP RAM Standardized Scripts
*                 Calculating Food Consumption Score - Nutrition (FCSN)

* -----------------------------------------------------------------------------*	
*
* Load data
* ---------
	import delim using "../GitHub/RAMResourcesScripts/Static/FCSN_Sample_Survey.csv", ///
		   clear case(preserve)
	
** check and recode missing values as 0
	sum	   FCS*
	sum	   FCSN*
	recode FCS* (. = 0)

** assign variable labels
	label var FCSNPrMeatF	"Consumption in past 7 days: Flesh meat"
	label var FCSNPrMeatO	"Consumption in past 7 days: Organ meat"
	label var FCSNPrFish	"Consumption in past 7 days: Fish/shellfish"
	label var FCSNPrEggs	"Consumption in past 7 days: Eggs"
	label var FCSNVegOrg	"Consumption in past 7 days: Orange vegetables (vegetables rich in Vitamin A)"
	label var FCSNVegGre	"Consumption in past 7 days: Green leafy vegetables"
	label var FCSNFruiOrg	"Consumption in past 7 days: Orange fruits (Fruits rich in Vitamin A)"
	
** create aggregates of key micronutrient consumption of vitamin, iron and protein 	
	gen FGVitA 	  = FCSDairy + FCSNPrMeatO + FCSNPrEggs + FCSNVegOrg + FCSNVegGre + FCSNFruiOrg
	gen FGProtein = FCSPulse + FCSDairy + FCSNPrMeatF + FCSNPrMeatO + FCSNPrFish + FCSNPrEggs
	gen FGHIron   = FCSNPrMeatF + FCSNPrMeatO + FCSNPrFish
	
	label var FGVitA 		"Consumption of vitamin A-rich foods"
	label var FGProtein 	"Consumption of protein-rich foods"
	label var FGHIron		"Consumption of hem iron-rich foods"

** recode into nutritious groups  
	gen FGVitACat 	 = cond(FGVitA 	  < 1,1,cond(FGVitA	   <= 6,2,3))
	gen FGProteinCat = cond(FGProtein < 1,1,cond(FGProtein <= 6,2,3))
	gen FGHIronCat 	 = cond(FGHIron   < 1,1,cond(FGHIron   <= 6,2,3))

** define variables labels and properties for FGVitACat FGProteinCat FGHIronCat
	label def FGN_l 1 "Never consumed" 		///
					2 "Consumed sometimes" 	///
					3 "Consumed at least 7 times"
	label val FGVitACat FGProteinCat FGHIron_Cat FGHIronCat

	label var FGVitACat 	"Consumption group of vitamin A-rich foods"
	label var FGProteinCat 	"Consumption group of protein-rich foods"
	label var FGHIronCat	"Consumption group of heme iron-rich foods"
	
* End of scripts
