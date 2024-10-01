#------------------------------------------------------------------------------#
#                           WFP APP Standardized Scripts
#                Reduced Coping Strategies Index (rCSI) Calculation in R
#------------------------------------------------------------------------------#
# 1. Purpose:
# This script calculates the Reduced Coping Strategies Index (rCSI) using standardized 
# variables. It assumes that the required variables are available in your dataset and 
# correctly formatted for use in the calculation.
#
# 2. Assumptions:
# - The dataset contains standardized variables from Survey Designer.
# - The variables used for the rCSI calculation are properly named and cleaned.
# - The dataset is already loaded in a data frame in R.
#
# 3. Requirements:
# - Required variables in the dataset:
#   - rCSILessQlty : Reduced quality of meals
#   - rCSIBorrow   : Borrow food
#   - rCSIMealNb   : Reduce number of meals
#   - rCSIMealSize : Reduce meal size
#   - rCSIMealAdult: Restrict consumption of adults
#
# 4. R Version: 
# - R 3.x or higher is recommended.
#------------------------------------------------------------------------------#

# Function to calculate rCSI
calculate_rcsi <- function(df) {
    # Calculate the Reduced Coping Strategies Index (rCSI).
    
    # Parameters:
    # - df: pandas.DataFrame, the dataset containing the five rCSI variables
    
    # Returns:
    # - df: pandas.DataFrame, the dataset with the calculated 'rCSI' variable

  df$rCSI <- df$rCSILessQlty + 
             (df$rCSIBorrow * 2) + 
             df$rCSIMealNb + 
             df$rCSIMealSize + 
             (df$rCSIMealAdult * 3)
  
  return(df)
}

# Function to categorize rCSI into groups based on thresholds
categorize_rcsi <- function(df, rcsi_column = 'rCSI') {
    # Categorize rCSI into groups based on thresholds.
    
    # Parameters:
    # - df: pandas.DataFrame, the dataset containing the rCSI
    # - rcsi_column: str, the name of the column containing the calculated rCSI (default is 'rCSI')
    
    # Returns:
    # - df: pandas.DataFrame, the dataset with the calculated 'rCSICat' variable

  df <- df %>%
    mutate(rCSICat = cut(.data[[rcsi_column]], 
                         breaks = c(-Inf, 3.5, 18, Inf),
                         labels = c("Minimal", "Moderate", "Severe"),
                         right = TRUE))
  
  return(df)
}
