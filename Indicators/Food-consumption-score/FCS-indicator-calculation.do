*------------------------------------------------------------------------------*
*                           WFP APP Standardized Scripts
*                Food Consumption Score (FCS) Calculation in STATA
*------------------------------------------------------------------------------*
* 1. Purpose:
* This script calculates the Food Consumption Score (FCS) using standardized 
* food group variables. It assumes that the required variables are available in 
* your dataset and correctly formatted for use in the calculation.
*
* 2. Assumptions:
* - The dataset contains standardized variables from Survey Designer.
* - The variables used for the FCS calculation are properly named and cleaned.
* - The dataset is already loaded in STATA.
*
* 3. Requirements:
* - Required variables in the dataset:
*   - FCSStap  : Consumption of starchy staples
*   - FCSPulse : Consumption of pulses/legumes
*   - FCSDairy : Consumption of dairy products
*   - FCSPr    : Consumption of meat/fish/protein
*   - FCSVeg   : Consumption of vegetables
*   - FCSFruit : Consumption of fruits
*   - FCSFat   : Consumption of fats/oils
*   - FCSSugar : Consumption of sugar
*
* 4. STATA Version:
* - STATA 14 or higher is recommended.
*------------------------------------------------------------------------------*

*------------------------------------------------------------------------------
* Step 1: Calculate the Food Consumption Score (FCS)
*------------------------------------------------------------------------------

* The formula for FCS is:
* FCS = (FCSStap * 2) + (FCSPulse * 3) + (FCSDairy * 4) + (FCSPr * 4)
*     + FCSVeg + FCSFruit + (FCSFat * 0.5) + (FCSSugar * 0.5)

gen FCS = (FCSStap * 2) +
          (FCSPulse * 3) +
          (FCSDairy * 4) +
          (FCSPr * 4) +
          FCSVeg +
          FCSFruit +
          (FCSFat * 0.5) +
          (FCSSugar * 0.5)

*------------------------------------------------------------------------------
* Step 2: Categorize FCS into Groups Based on Thresholds
*------------------------------------------------------------------------------

* Create categorical variables based on thresholds for low and high consumption 
* of sugar and oil.

* Low consumption of sugar and oil:
gen FCSCat21 = ""
replace FCSCat21 = "Poor" if FCS < 21
replace FCSCat21 = "Borderline" if FCS >= 21 & FCS <= 35
replace FCSCat21 = "Acceptable" if FCS > 35

* High consumption of sugar and oil:
gen FCSCat28 = ""
replace FCSCat28 = "Poor" if FCS < 28
replace FCSCat28 = "Borderline" if FCS >= 28 & FCS <= 42
replace FCSCat28 = "Acceptable" if FCS > 42

