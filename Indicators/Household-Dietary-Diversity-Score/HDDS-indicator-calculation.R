#------------------------------------------------------------------------------#
#                           WFP APP Standardized Scripts
#              Calculating Household Dietary Diversity Score (HDDS) in R
#------------------------------------------------------------------------------#
# 1. Purpose:
# This script calculates the Household Dietary Diversity Score (HDDS) using standardized 
# food group variables based on a 24-hour recall. It assumes that the required variables 
# are available in your dataset and correctly formatted for use in the calculation.
#
# 2. Assumptions:
# - The dataset contains standardized variables from Survey Designer.
# - The variables used for the HDDS calculation are properly named and cleaned.
# - The dataset is loaded into a data frame before executing the script.
#
# 3. Requirements:
# - Required variables in the dataset:
#   - HDDSStapCer  : Consumption of cereals
#   - HDDSStapRoot : Consumption of roots/tubers
#   - HDDSVeg      : Consumption of vegetables
#   - HDDSFruit    : Consumption of fruits
#   - HDDSPrMeat   : Consumption of meat/poultry
#   - HDDSPrEggs   : Consumption of eggs
#   - HDDSPrFish   : Consumption of fish
#   - HDDSPulse    : Consumption of pulses/legumes
#   - HDDSDairy    : Consumption of milk and dairy products
#   - HDDSFat      : Consumption of oils/fats
#   - HDDSSugar    : Consumption of sugar/honey
#   - HDDSCond     : Consumption of miscellaneous/condiments
#
# 4. R Version: 
# - R version 3.x or higher is recommended.
#------------------------------------------------------------------------------#

# Function to calculate HDDS
calculate_hdds <- function(df) {
  # Calculate the Household Dietary Diversity Score (HDDS)
  
  # Parameters:
  # - df: DataFrame, the dataset containing the twelve HDDS variables
  
  # Returns:
  # - df: DataFrame, the dataset with the calculated 'HDDS' variable
  
  # Sum the columns and treat NA as 0
  df$HDDS <- rowSums(df[, c('HDDSStapCer', 'HDDSStapRoot', 'HDDSVeg', 'HDDSFruit',
                            'HDDSPrMeat', 'HDDSPrEggs', 'HDDSPrFish', 'HDDSPulse',
                            'HDDSDairy', 'HDDSFat', 'HDDSSugar', 'HDDSCond')], na.rm = TRUE)
  
  return(df)
}

# Function to categorize HDDS into groups based on IPC thresholds
categorize_hdds <- function(df, hdds_column = 'HDDS') {
  # Categorize HDDS into groups based on IPC thresholds
  
  # Parameters:
  # - df: DataFrame, the dataset containing the HDDS
  # - hdds_column: str, the name of the column containing the calculated HDDS (default is 'HDDS')
  
  # Returns:
  # - df: DataFrame, the dataset with the calculated 'HDDSCat_IPC' variable
  
  df$HDDSCat_IPC <- cut(df[[hdds_column]], 
                        breaks = c(-Inf, 2, 4, Inf),
                        labels = c("0-2 food groups (phase 4 to 5)", 
                                   "3-4 food groups (phase 3)", 
                                   "5-12 food groups (phase 1 to 2)"),
                        right = TRUE)
                        
  return(df)
}
