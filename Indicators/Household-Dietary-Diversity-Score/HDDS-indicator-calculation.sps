*------------------------------------------------------------------------------*
*                           WFP APP Standardized Scripts
*              Calculating Household Dietary Diversity Score (HDDS) in SPSS
*------------------------------------------------------------------------------*
* 1. Purpose:
* This script calculates the Household Dietary Diversity Score (HDDS) using standardized 
* food group variables based on a 24-hour recall. It assumes that the required variables 
* are available in your dataset and correctly formatted for use in the calculation.
*
* 2. Assumptions:
* - The dataset contains standardized variables from Survey Designer.
* - The variables used for the HDDS calculation are properly named and cleaned.
* - The dataset is already loaded in SPSS.
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
* 4. SPSS Version:
* - SPSS 21 or higher is recommended.
*------------------------------------------------------------------------------*

*------------------------------------------------------------------------------
* Step 1: Calculate the Household Dietary Diversity Score (HDDS)
*------------------------------------------------------------------------------

* Use SUM() function to sum the 12 food group variables, treating missing values as 0.
COMPUTE HDDS = SUM(HDDSStapCer, HDDSStapRoot, HDDSVeg, HDDSFruit, 
                   HDDSPrMeat, HDDSPrEggs, HDDSPrFish, HDDSPulse, 
                   HDDSDairy, HDDSFat, HDDSSugar, HDDSCond).
EXECUTE.

*------------------------------------------------------------------------------
* Step 2: Categorize HDDS into Groups Based on IPC Thresholds
*------------------------------------------------------------------------------

* Recode HDDS into categories using IPC thresholds.
DO IF (HDDS <= 2).
   COMPUTE HDDSCat_IPC = 1.
ELSE IF (HDDS > 2 AND HDDS <= 4).
   COMPUTE HDDSCat_IPC = 2.
ELSE IF (HDDS > 4).
   COMPUTE HDDSCat_IPC = 3.
END IF.
EXECUTE.

* Label the HDDS categories based on IPC.
VALUE LABELS HDDSCat_IPC
    1 '0-2 food groups (phase 4 to 5)'
    2 '3-4 food groups (phase 3)'
    3 '5-12 food groups (phase 1 to 2)'.
VARIABLE LABELS HDDSCat_IPC 'HDDS categories using IPC severity scale'.
EXECUTE.
