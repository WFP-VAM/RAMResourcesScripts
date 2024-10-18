#------------------------------------------------------------------------------#
#                           WFP APP Standardized Scripts
#                   Food Consumption Score (FCS) Calculation in R
#------------------------------------------------------------------------------#
# 1. Purpose:
# This script calculates the Food Consumption Score (FCS) using standardized 
# food group variables. It assumes that the required variables are available in 
# your dataset and correctly formatted for use in the calculation.
#
# 2. Assumptions:
# - The dataset contains standardized variables from Survey Designer.
# - The variables used for the FCS calculation are properly named and cleaned.
# - The dataset is loaded into a data frame before executing the script.
#
# 3. Requirements:
# - Required variables in the dataset:
#   - FCSStap  : Consumption of starchy staples
#   - FCSPulse : Consumption of pulses/legumes
#   - FCSDairy : Consumption of dairy products
#   - FCSPr    : Consumption of meat/fish/protein
#   - FCSVeg   : Consumption of vegetables
#   - FCSFruit : Consumption of fruits
#   - FCSFat   : Consumption of fats/oils
#   - FCSSugar : Consumption of sugar
#
# 4. R Version: 
# - R version 3.x or higher is recommended for compatibility with modern libraries.
#------------------------------------------------------------------------------#

# Function to calculate FCS
calculate_fcs <- function(df) {
  # Calculate the Food Consumption Score (FCS)
  
  # Parameters:
  # - df: DataFrame, the dataset containing the eight FCS variables
  
  # Returns:
  # - df: DataFrame, the dataset with the calculated 'FCS' variable

  df <- df %>%
    mutate(FCS = (FCSStap * 2 +
                  FCSPulse * 3 +
                  FCSDairy * 4 +
                  FCSPr * 4 +
                  FCSVeg +
                  FCSFruit +
                  FCSFat * 0.5 +
                  FCSSugar * 0.5))
  
  return(df)
}

# Function to categorize FCS into groups based on thresholds
categorize_fcs <- function(df, fcs_column = 'FCS') {
  # Categorize FCS into groups based on thresholds
  
  # Parameters:
  # - df: DataFrame, the dataset containing the FCS
  # - fcs_column: str, the name of the column containing the calculated food consumption score (default is 'FCS')
  
  # Returns:
  # - df: DataFrame, the dataset with the calculated 'FCSCat21' and 'FCSCat28' variables

  # Low consumption of sugar and oil
  df$FCSCat21 <- cut(
    df[[fcs_column]],
    breaks = c(-Inf, 21, 35, Inf),
    labels = c("Poor", "Borderline", "Acceptable"),
    right = TRUE
  )
  
  # High consumption of sugar and oil
  df$FCSCat28 <- cut(
    df[[fcs_column]],
    breaks = c(-Inf, 28, 42, Inf),
    labels = c("Poor", "Borderline", "Acceptable"),
    right = TRUE
  )
  
  return(df)
}
