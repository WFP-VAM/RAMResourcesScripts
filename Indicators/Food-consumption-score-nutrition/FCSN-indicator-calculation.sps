*------------------------------------------------------------------------------*
*                           WFP APP Standardized Scripts
*              Calculating Food Consumption Score Nutrition (FCSN) in SPSS
*------------------------------------------------------------------------------*
* 1. Purpose:
* This script calculates the Food Consumption Score Nutrition (FCSN) by aggregating 
* food consumption data for different nutrients. It assumes that the required variables 
* are available in your dataset and correctly formatted for use in the calculation.
*
* 2. Assumptions:
* - The dataset contains standardized variables from Survey Designer.
* - The variables used for the FCSN calculation are properly named and cleaned.
* - The dataset is loaded into SPSS before executing the script.
*
* 3. Requirements:
* - Required variables in the dataset:
*   - FCSDairy      : Consumption of dairy (past 7 days)
*   - FCSPulse      : Consumption of pulse (past 7 days)
*   - FCSNPrMeatF   : Consumption of flesh meat (past 7 days)
*   - FCSNPrMeatO   : Consumption of organ meat (past 7 days)
*   - FCSNPrFish    : Consumption of fish/shellfish (past 7 days)
*   - FCSNPrEggs    : Consumption of eggs (past 7 days)
*   - FCSNVegOrg    : Consumption of orange vegetables (vitamin A-rich)
*   - FCSNVegGre    : Consumption of green leafy vegetables
*   - FCSNFruiOrg   : Consumption of orange fruits (vitamin A-rich)
*
*------------------------------------------------------------------------------*

*------------------------------------------------------------------------------*
* Step 1: Compute Nutrient Aggregates (Vitamin A, Protein, and Hem Iron)
*------------------------------------------------------------------------------*

* Use SUM() to sum the relevant columns and treat missing values as 0
* Compute Vitamin A-rich foods aggregate.
COMPUTE FGVitA = SUM(FCSDairy, FCSNPrMeatO, FCSNPrEggs, FCSNVegOrg, FCSNVegGre, FCSNFruiOrg).
VARIABLE LABELS FGVitA 'Consumption of vitamin A-rich foods'.
EXECUTE.

* Compute Protein-rich foods aggregate.
COMPUTE FGProtein = SUM(FCSPulse, FCSDairy, FCSNPrMeatF, FCSNPrMeatO, FCSNPrFish, FCSNPrEggs).
VARIABLE LABELS FGProtein 'Consumption of protein-rich foods'.
EXECUTE.

* Compute Hem Iron-rich foods aggregate.
COMPUTE FGHIron = SUM(FCSNPrMeatF, FCSNPrMeatO, FCSNPrFish).
VARIABLE LABELS FGHIron 'Consumption of hem iron-rich foods'.
EXECUTE.

*------------------------------------------------------------------------------*
* Step 2: Categorize Nutrient Consumption Groups Based on Thresholds
*------------------------------------------------------------------------------*

* Categorize Vitamin A-rich foods consumption.
RECODE FGVitA (0=1) (1 THRU 6=2) (7 THRU HI=3) INTO FGVitACat.
VARIABLE LABELS FGVitACat 'Consumption group of vitamin A-rich foods'.
VALUE LABELS FGVitACat 1 'Never consumed' 2 'Consumed sometimes' 3 'Consumed at least 7 times'.
EXECUTE.

* Categorize Protein-rich foods consumption.
RECODE FGProtein (0=1) (1 THRU 6=2) (7 THRU HI=3) INTO FGProteinCat.
VARIABLE LABELS FGProteinCat 'Consumption group of protein-rich foods'.
VALUE LABELS FGProteinCat 1 'Never consumed' 2 'Consumed sometimes' 3 'Consumed at least 7 times'.
EXECUTE.

* Categorize Hem Iron-rich foods consumption.
RECODE FGHIron (0=1) (1 THRU 6=2) (7 THRU HI=3) INTO FGHIronCat.
VARIABLE LABELS FGHIronCat 'Consumption group of hem iron-rich foods'.
VALUE LABELS FGHIronCat 1 'Never consumed' 2 'Consumed sometimes' 3 'Consumed at least 7 times'.
EXECUTE.
