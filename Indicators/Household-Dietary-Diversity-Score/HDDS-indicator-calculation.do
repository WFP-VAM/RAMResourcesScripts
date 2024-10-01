*------------------------------------------------------------------------------*
*                           WFP RAM Standardized Scripts
*              Calculating Household Dietary Diversity Score (HDDS) in STATA
*------------------------------------------------------------------------------*
* 1. Purpose:
* This script calculates the Household Dietary Diversity Score (HDDS) using standardized 
* food group variables based on a 24-hour recall. It assumes that the required variables 
* are available in your dataset and correctly formatted for use in the calculation.
*
* 2. Assumptions:
* - The dataset contains standardized variables from Survey Designer.
* - The variables used for the HDDS calculation are properly named and cleaned.
* - The dataset is already loaded in STATA.
*
* 3. Requirements:
* - Required variables in the dataset:
*   - HDDSStapCer  : Consumption of cereals
*   - HDDSStapRoot : Consumption of roots/tubers
*   - HDDSVeg      : Consumption of vegetables
*   - HDDSFruit    : Consumption of fruits
*   - HDDSPrMeat   : Consumption of meat/poultry
*   - HDDSPrEggs   : Consumption of eggs
*   - HDDSPrFish   : Consumption of fish
*   - HDDSPulse    : Consumption of pulses/legumes
*   - HDDSDairy    : Consumption of milk and dairy products
*   - HDDSFat      : Consumption of oils/fats
*   - HDDSSugar    : Consumption of sugar/honey
*   - HDDSCond     : Consumption of miscellaneous/condiments
*
* 4. STATA Version:
* - STATA 14 or higher is recommended.
*------------------------------------------------------------------------------*

*------------------------------------------------------------------------------
* Step 1: Calculate the Household Dietary Diversity Score (HDDS)
*------------------------------------------------------------------------------

* The formula for HDDS is a sum of the 12 food group variables
gen HDDS = HDDSStapCer + 
           HDDSStapRoot + 
           HDDSVeg + 
           HDDSFruit + 
           HDDSPrMeat + 
           HDDSPrEggs + 
           HDDSPrFish + 
           HDDSPulse + 
           HDDSDairy + 
           HDDSFat + 
           HDDSSugar + 
           HDDSCond

*------------------------------------------------------------------------------
* Step 2: Categorize HDDS into Groups Based on IPC Thresholds
*------------------------------------------------------------------------------

* Categorize HDDS into "0-2", "3-4", and "5-12" food groups based on IPC thresholds.
gen HDDSCat_IPC = ""
replace HDDSCat_IPC = "0-2 food groups (phase 4 to 5)" if HDDS <= 2
replace HDDSCat_IPC = "3-4 food groups (phase 3)" if HDDS > 2 & HDDS <= 4
replace HDDSCat_IPC = "5-12 food groups (phase 1 to 2)" if HDDS > 4
