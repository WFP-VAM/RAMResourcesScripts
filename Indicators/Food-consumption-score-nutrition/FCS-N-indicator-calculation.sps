* Encoding: UTF-8.
***Create Food Consumption Score  Nutrition*** 

Variable labels 
FCSNPrMeatF "Flesh meat, such as:"
FCSNPrMeatO "Organ meat, such as:"
FCSNPrFish "Fish/shellfish, such as:"
FCSNPrEggs "Eggs:"
FCSNVegOrg "Orange vegetables (vegetables rich in Vitamin A), such as:"
FCSNVegGre "Green leafy vegetables, such as:"
FCSNFruiOrg "Orange fruits (Fruits rich in Vitamin A), such as:".


***recode "n/a" values to 0 and change variable type to numeric
 
ALTER TYPE FCSNPrMeatF FCSNPrMeatO FCSNPrFish FCSNPrEggs FCSNVegOrg FCSNVegGre FCSNFruiOrg (a5).
  
RECODE FCSNPrMeatF FCSNPrMeatO FCSNPrFish FCSNPrEggs FCSNVegOrg FCSNVegGre FCSNFruiOrg 
    ('n/a'='0').
EXECUTE.

ALTER TYPE FCSNPrMeatF FCSNPrMeatO FCSNPrFish FCSNPrEggs FCSNVegOrg FCSNVegGre FCSNFruiOrg (F1).


***compute aggregates of key micronutrient consumption – vitamin, iron and protein 

Compute FGVitA = sum(FCSDairy, FCSNPrMeatO, FCSNPrEggs, FCSNVegOrg, FCSNVegGre, FCSNFruiOrg). 
Variable labels FGVitA 'Consumption of vitamin A-rich foods'. 
EXECUTE. 

Compute FGProtein = sum(FCSPulse, FCSDairy, FCSNPrMeatF, FCSNPrMeatO, FCSNPrFish, FCSNPrEggs). 
Variable labels FGProtein 'Consumption of protein-rich foods'. 
EXECUTE. 

Compute FGHIron = sum(FCSNPrMeatF, FCSNPrMeatO, FCSNPrFish). 
Variable labels FGHIron 'Consumption of hem iron-rich foods'. 
EXECUTE. 
 
*** recode into nutritious groups  

Recode FGVitA (0=1) (1 thru 6=2) (7 thru 42=3) into FGVitACat. 
Variable labels FGVitACat 'Consumption of vitamin A-rich foods'. 
EXECUTE. 

Recode FGProtein (0=1) (1 thru 6=2) (7 thru 42=3) into FGProteinCat. 
Variable labels FGProteinCat 'Consumption of protein-rich foods'. 
EXECUTE. 

Recode FGHIron (0=1) (1 thru 6=2) (7 thru 42=3) into FGHIronCat. 
Variable labels FGHIronCat 'Consumption of hem iron-rich foods'. 
EXECUTE. 

 *** define variables labels and properties for " FGVitACat FGProteinCat FGHIronCat ". 

 Value labels FGVitACat FGProteinCat FGHIronCat 
1.00 'Never consumed' 2.00 'Consumed sometimes' 3.00 'Consumed at least 7 times'. 

EXECUTE. 





