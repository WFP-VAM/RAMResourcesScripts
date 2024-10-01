*------------------------------------------------------------------------------*
*                           WFP APP Standardized Scripts
*              Calculating Food Consumption Score Nutrition (FCSN) in Stata
*------------------------------------------------------------------------------*
* 1. Purpose:
* This script calculates the Food Consumption Score Nutrition (FCSN) by aggregating 
* food consumption data for different nutrients. It assumes that the required variables 
* are available in your dataset and correctly formatted for use in the calculation.
*
* 2. Assumptions:
* - The dataset contains standardized variables from Survey Designer.
* - The variables used for the FCSN calculation are properly named and cleaned.
* - The dataset is loaded into Stata before executing the script.
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
* 4. Stata Version:
* - Stata 13 or higher is recommended for compatibility with modern syntax.
*------------------------------------------------------------------------------*

*------------------------------------------------------------------------------*
* Step 1: Compute Nutrient Aggregates (Vitamin A, Protein, and Hem Iron)
*------------------------------------------------------------------------------*

* Use rowtotal() to sum the relevant columns and treat missing values as 0
* Compute Vitamin A-rich foods aggregate
gen FGVitA = rowtotal(FCSDairy FCSNPrMeatO FCSNPrEggs FCSNVegOrg FCSNVegGre FCSNFruiOrg)
label variable FGVitA "Consumption of vitamin A-rich foods"

* Compute Protein-rich foods aggregate
gen FGProtein = rowtotal(FCSPulse FCSDairy FCSNPrMeatF FCSNPrMeatO FCSNPrFish FCSNPrEggs)
label variable FGProtein "Consumption of protein-rich foods"

* Compute Hem Iron-rich foods aggregate
gen FGHIron = rowtotal(FCSNPrMeatF FCSNPrMeatO FCSNPrFish)
label variable FGHIron "Consumption of hem iron-rich foods"

*------------------------------------------------------------------------------*
* Step 2: Categorize Nutrient Consumption Groups Based on Thresholds
*------------------------------------------------------------------------------*

* Categorize consumption of Vitamin A-rich foods
gen FGVitACat = .
replace FGVitACat = 1 if FGVitA == 0
replace FGVitACat = 2 if FGVitA > 0 & FGVitA <= 6
replace FGVitACat = 3 if FGVitA > 6
label define FGVitACat_lbl 1 "Never consumed" 2 "Consumed sometimes" 3 "Consumed at least 7 times"
label values FGVitACat FGVitACat_lbl
label variable FGVitACat "Consumption group of vitamin A-rich foods"

* Categorize consumption of Protein-rich foods
gen FGProteinCat = .
replace FGProteinCat = 1 if FGProtein == 0
replace FGProteinCat = 2 if FGProtein > 0 & FGProtein <= 6
replace FGProteinCat = 3 if FGProtein > 6
label define FGProteinCat_lbl 1 "Never consumed" 2 "Consumed sometimes" 3 "Consumed at least 7 times"
label values FGProteinCat FGProteinCat_lbl
label variable FGProteinCat "Consumption group of protein-rich foods"

* Categorize consumption of Hem Iron-rich foods
gen FGHIronCat = .
replace FGHIronCat = 1 if FGHIron == 0
replace FGHIronCat = 2 if FGHIron > 0 & FGHIron <= 6
replace FGHIronCat = 3 if FGHIron > 6
label define FGHIronCat_lbl 1 "Never consumed" 2 "Consumed sometimes" 3 "Consumed at least 7 times"
label values FGHIronCat FGHIronCat_lbl
label variable FGHIronCat "Consumption group of hem iron-rich foods"
