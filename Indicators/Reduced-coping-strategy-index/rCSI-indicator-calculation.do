*------------------------------------------------------------------------------*
*                           WFP RAM Standardized Scripts
*                Reduced Coping Strategies Index (rCSI) Calculation in STATA
*------------------------------------------------------------------------------*
* 1. Purpose:
* This script calculates the Reduced Coping Strategies Index (rCSI) using standardized 
* variables. It assumes that the required variables are available in your dataset and 
* correctly formatted for use in the calculation.
*
* 2. Assumptions:
* - The dataset contains standardized variables from Survey Designer.
* - The variables used for the rCSI calculation are properly named and cleaned.
* - The dataset is already loaded in STATA.
*
* 3. Requirements:
* - Required variables in the dataset:
*   - rCSILessQlty : Reduced quality of meals
*   - rCSIBorrow   : Borrow food
*   - rCSIMealNb   : Reduce number of meals
*   - rCSIMealSize : Reduce meal size
*   - rCSIMealAdult: Restrict consumption of adults
*
* 4. STATA Version:
* - STATA 14 or higher is recommended.
*------------------------------------------------------------------------------*

*------------------------------------------------------------------------------
* Step 1: Calculate the Reduced Coping Strategies Index (rCSI)
*------------------------------------------------------------------------------

* The formula for rCSI is:
* rCSI = rCSILessQlty + (rCSIBorrow * 2) + rCSIMealNb + rCSIMealSize + (rCSIMealAdult * 3)

gen rCSI = rCSILessQlty + 
           (rCSIBorrow * 2) + 
           rCSIMealNb + 
           rCSIMealSize + 
           (rCSIMealAdult * 3)

*------------------------------------------------------------------------------
* Step 2: Categorize rCSI into Groups Based on Thresholds
*------------------------------------------------------------------------------

* Categorize rCSI into "Minimal", "Moderate", and "Severe" based on thresholds.
gen rCSICat = ""

replace rCSICat = "Minimal" if rCSI <= 3.5
replace rCSICat = "Moderate" if rCSI > 3.5 & rCSI <= 18
replace rCSICat = "Severe" if rCSI > 18
