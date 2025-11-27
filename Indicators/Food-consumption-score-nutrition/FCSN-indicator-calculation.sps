* Encoding: UTF-8.
*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                             Food Consumption Score - Nutrition (FCS-N) 


*** Last Update: Oct 2025
*** Purpose: This script calculates the Food Consumption Score - Nutrition (FCS-N) 

***   Data Quality Guidance References:
***   - Recommended high frequency checks: Page 30
***   - Recommended cleaning steps: Page 37

*** ----------------------------------------------------------------------------------------------------

*** Define group labels-  these should match Survey Designer naming conventions

VARIABLE LABELS
FCSNPrMeatF          "Consumption in past 7 days: Flesh meat"
FCSNPrMeatO         "Consumption in past 7 days: Organ meat"
FCSNPrFish             "Consumption in past 7 days: Fish/shellfish"
FCSNPrEggs           "Consumption in past 7 days: Eggs"
FCSNVegOrg           "Consumption in past 7 days: Orange vegetables (vegetables rich in Vitamin A)"
FCSNVegGre           "Consumption in past 7 days: Green leafy vegetables"
FCSNFruiOrg           "Consumption in past 7 days: Orange fruits (fruits rich in Vitamin A)".

*** Check individual food groups

FREQUENCIES VARIABLES = FCSNPrMeatF FCSNPrMeatO FCSNPrFish FCSNPrEggs FCSNVegOrg FCSNVegGre FCSNFruiOrg
  /STATISTICS = MINIMUM MAXIMUM MEAN
  /ORDER = ANALYSIS.

*** In cases where 0 consumption of main group automatically codes subgroup values as missing, recoding to 0 consumption

RECODE FCSNPrMeatO FCSNPrMeatF FCSNPrFish FCSNPrEggs FCSNVegOrg FCSNVegGre FCSNFruiOrg (SYSMIS = 0).
EXECUTE.

*** Harmonize Data Quality Guidance measures
*** Clean impossible values 

RECODE FCSNPrMeatF FCSNPrMeatO FCSNPrFish FCSNPrEggs FCSNVegOrg FCSNVegGre FCSNFruiOrg (LOWEST THRU -1 = SYSMIS).
RECODE FCSNPrMeatF FCSNPrMeatO FCSNPrFish FCSNPrEggs FCSNVegOrg FCSNVegGre FCSNFruiOrg (8 THRU HIGHEST = SYSMIS).
EXECUTE.

*** Flagging potential Data Quality issues. If any cases reflected here, refer to the Data Quality Guidance note page 37. This can be found on the VAM Ressource Centre

COMPUTE FCSN_flag_protein = 0.    
IF (FCSNPrMeatF > FCSPr OR FCSNPrMeatO > FCSPr OR FCSNPrFish > FCSPr OR FCSNPrEggs > FCSPr) FCSN_flag_protein = 1.
VARIABLE LABELS FCSN_flag_protein "Subgroup exceeds main group. Flag issue to team leader during high frequency check. During cleaning, recode value to be capped at value for main group".
VALUE LABELS FCSN_flag_protein
    0 "No"
    1 "Yes".

COMPUTE FCSN_flag_veg = 0.    
IF (FCSNVegOrg > FCSVeg OR FCSNVegGre > FCSVeg) FCSN_flag_veg = 1.
VARIABLE LABELS FCSN_flag_veg "Subgroup exceeds main group. Flag issue to team leader during high frequency check. During cleaning, recode value to be capped at value for main group".
VALUE LABELS FCSN_flag_veg
    0 "No"
    1 "Yes".

COMPUTE FCSN_flag_fruit = 0.    
IF (FCSNFruiOrg > FCSFruit) FCSN_flag_fruit = 1.
VARIABLE LABELS FCSN_flag_fruit "Subgroup exceeds main group. Flag issue to team leader during high frequency check. During cleaning, recode value to be capped at value for main group".
VALUE LABELS FCSN_flag_fruit
    0 "No"
    1 "Yes".

*** Check flagged cases

FREQUENCIES VARIABLES = FCSN_flag_protein FCSN_flag_veg FCSN_flag_fruit
  /ORDER = ANALYSIS.    

*** Calculate Vitamin A, protein and haem iron intake

COMPUTE FGVitA = FCSDairy + FCSNPrMeatO + FCSNPrEggs + FCSNVegOrg + FCSNVegGre + FCSNFruiOrg.
COMPUTE FGProtein = FCSPulse + FCSDairy + FCSNPrMeatF+ FCSNPrMeatO+ FCSNPrFish+ FCSNPrEggs.
COMPUTE FGHIron = FCSNPrMeatF+ FCSNPrMeatO + FCSNPrFish.

RECODE FGVitA (0 = 1) (1 THRU 6 = 2) (7 THRU 42 = 3) INTO VitA_Cat. 
VARIABLE LABELS VitA_Cat 'Household consumption of vitamin A'.
VALUE LABELS VitA_Cat
   1 '0 time (never consumed)'
   2 '1-6 times (consumed sometimes)'
   3 '7 times or more (consumed at least daily)'.

RECODE FGProtein (0 = 1) (1 THRU 6 = 2) (7 THRU 42 = 3) INTO Protein_Cat. 
VARIABLE LABELS Protein_Cat 'Household consumption of protein'.
VALUE LABELS Protein_Cat
   1 '0 time (never consumed)'
   2 '1-6 times (consumed sometimes)'
   3 '7 times or more (consumed at least daily)'.

RECODE FGHIron (0 = 1) (1 THRU 6 = 2) (7 THRU 42 = 3) INTO Haem_iron_Cat. 
VARIABLE LABELS Haem_iron_Cat 'Household consumption of haem iron'.
VALUE LABELS Haem_iron_Cat
   1 '0 time (never consumed)'
   2 '1-6 times (consumed sometimes)'
   3 '7 times or more (consumed at least daily)'.

*** Check results

FREQUENCIES VARIABLES=VitA_Cat Protein_Cat Haem_iron_Cat
  /ORDER=ANALYSIS.

*** END OF SCRIPT









