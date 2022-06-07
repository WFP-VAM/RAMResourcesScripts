***Create Food Consumption Score – Nutrition*** 

Variable labels 
FCSPrMeatF	‘Flesh meats consumption over the past 7 days’. 
FCSPrMeatO	‘Organ meats consumption over the past 7 days’. 
FCSPrFish       	‘Fish/shellfish Consumption over the past 7 days’. 
FCSPrEgg        	‘Eggs consumption over the past 7 days’. 
FCSVegOrg      	‘Orange vegetables consumption over the past 7 days’. 
FCSVegGre     	  ‘Dark green leafy vegetables consumption over the past 7 days’. 
FCSFruitOrg     	‘Orange fruits consumption over the past 7 days’. 

***compute aggregates of key micronutrient consumption – vitamin, iron and protein 
Compute FGVitA = sum(FCSDairy, FCSPrMeatO, FCSPrEgg, FCSVegOrg, FCSVegGre, FCSFruitOrg). 
Variable labels FGVitA 'Consumption of vitamin A-rich foods'. 
EXECUTE. 

Compute FGProtein = sum(FCSPulse, FCSDairy, FCSPrMeatF, FCSPrMeatO, FCSPrFish, FCSPrEgg). 
Variable labels FGProtein 'Consumption of protein-rich foods'. 
EXECUTE. 

Compute FGHIron = sum(FCSPrMeatF, FCSPrMeatO, FCSPrFish). 
Variable labels FGHIron 'Consumption of hem iron-rich foods'. 
EXECUTE. 
 
*** recode into nutritious groups  
Recode FGVitA (0=1) (1 thru 6=2) (7 thru 42=3) into FGVitACat. 
Variable labels FGVitACat 'Consumption of vitamin A-rich foods’. 
EXECUTE. 

Recode FGProtein (0=1) (1 thru 6=2) (7 thru 42=3) into FGProteinCat. 
Variable labels FGProteinCat 'Consumption of protein-rich foods'. 
EXECUTE. 

Recode FGHIron (0=1) (1 thru 6=2) (7 thru 42=3) into FGHIronCat. 
Variable labels FGHIronCat 'Consumption of hem iron-rich foods'. 
EXECUTE. 

 

*** define variables labels and properties for " FGVitACat FGProteinCat FGHIronCat ". 

 

Value labels FGVitACat FGProteinCat FGHIronCat 

1.00 '0 days' 2.00 '1-6 days' 3.00 '7 days'. 

EXECUTE. 

 