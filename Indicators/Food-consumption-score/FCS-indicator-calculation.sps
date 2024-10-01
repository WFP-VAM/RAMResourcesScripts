*------------------------------------------------------------------------------*
*                           WFP APP Standardized Scripts
*                Food Consumption Score (FCS) Calculation in SPSS
*------------------------------------------------------------------------------*
* 1. Purpose:
* This script calculates the Food Consumption Score (FCS) using standardized 
* food group variables. It assumes that the required variables are available in 
* your dataset and correctly formatted for use in the calculation.
*
* 2. Assumptions:
* - The dataset contains standardized variables from Survey Designer.
* - The variables used for the FCS calculation are properly named and cleaned.
* - The dataset is already loaded in SPSS.
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
* 4. SPSS Version:
* - SPSS 21 or higher is recommended.
*------------------------------------------------------------------------------*

*------------------------------------------------------------------------------
* Step 1: Calculate the Food Consumption Score (FCS)
*------------------------------------------------------------------------------

* The formula for FCS is:
* FCS = (FCSStap * 2) + (FCSPulse * 3) + (FCSDairy * 4) + (FCSPr * 4)
*     + FCSVeg + FCSFruit + (FCSFat * 0.5) + (FCSSugar * 0.5)

COMPUTE FCS = (FCSStap * 2) +
              (FCSPulse * 3) +
              (FCSDairy * 4) +
              (FCSPr * 4) +
              FCSVeg +
              FCSFruit +
              (FCSFat * 0.5) +
              (FCSSugar * 0.5).
EXECUTE.

*------------------------------------------------------------------------------
* Step 2: Categorize FCS into Groups Based on Thresholds
*------------------------------------------------------------------------------

* Create categorical variables based on thresholds for low and high consumption 
* of sugar and oil.

* Low consumption of sugar and oil:
DO IF (FCS < 21).
   COMPUTE FCSCat21 = 'Poor'.
ELSE IF (FCS >= 21 AND FCS <= 35).
   COMPUTE FCSCat21 = 'Borderline'.
ELSE IF (FCS > 35).
   COMPUTE FCSCat21 = 'Acceptable'.
END IF.
EXECUTE.

* High consumption of sugar and oil:
DO IF (FCS < 28).
   COMPUTE FCSCat28 = 'Poor'.
ELSE IF (FCS >= 28 AND FCS <= 42).
   COMPUTE FCSCat28 = 'Borderline'.
ELSE IF (FCS > 42).
   COMPUTE FCSCat28 = 'Acceptable'.
END IF.
EXECUTE.
