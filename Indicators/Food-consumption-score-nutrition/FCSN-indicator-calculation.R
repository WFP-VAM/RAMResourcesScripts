#------------------------------------------------------------------------------#
#                           WFP APP Standardized Scripts
#              Calculating Food Consumption Score Nutrition (FCSN) in R
#------------------------------------------------------------------------------#
# 1. Purpose:
# This script calculates the Food Consumption Score Nutrition (FCSN) by aggregating 
# food consumption data for different nutrients. It assumes that the required variables 
# are available in your dataset and correctly formatted for use in the calculation.
#
# 2. Assumptions:
# - The dataset contains standardized variables from Survey Designer.
# - The variables used for the FCSN calculation are properly named and cleaned.
# - The dataset is loaded into a data frame before executing the script.
#
# 3. Requirements:
# - Required variables in the dataset:
#   - FCSDairy      : Consumption of dairy (past 7 days)
#   - FCSPulse      : Consumption of pulse (past 7 days)
#   - FCSNPrMeatF   : Consumption of flesh meat (past 7 days)
#   - FCSNPrMeatO   : Consumption of organ meat (past 7 days)
#   - FCSNPrFish    : Consumption of fish/shellfish (past 7 days)
#   - FCSNPrEggs    : Consumption of eggs (past 7 days)
#   - FCSNVegOrg    : Consumption of orange vegetables (vitamin A-rich)
#   - FCSNVegGre    : Consumption of green leafy vegetables
#   - FCSNFruiOrg   : Consumption of orange fruits (vitamin A-rich)
#
# - Required Packages:
#   - No specific packages needed.
#
# 4. R Version: 
# - R 3.x or higher is recommended for compatibility with modern libraries.
#------------------------------------------------------------------------------#

# Function to compute key nutrient aggregates (vitamin A, protein, and iron)
compute_nutrient_aggregates <- function(df) {
  # Compute aggregates of key micronutrient consumption (Vitamin A, Protein, Hem Iron)
  
  # Parameters:
  # - df: DataFrame, the dataset containing the FCS and FCSN variables
  
  # Returns:
  # - df: DataFrame, the dataset with calculated micronutrient aggregates

  # Sum the columns and treat NA as 0 for vitamin A-rich foods
  df$FGVitA <- rowSums(df[, c('FCSDairy', 'FCSNPrMeatO', 'FCSNPrEggs', 
                              'FCSNVegOrg', 'FCSNVegGre', 'FCSNFruiOrg')], na.rm = TRUE)
  
  # Sum the columns and treat NA as 0 for protein-rich foods
  df$FGProtein <- rowSums(df[, c('FCSPulse', 'FCSDairy', 'FCSNPrMeatF', 
                                 'FCSNPrMeatO', 'FCSNPrFish', 'FCSNPrEggs')], na.rm = TRUE)
  
  # Sum the columns and treat NA as 0 for hem iron-rich foods
  df$FGHIron <- rowSums(df[, c('FCSNPrMeatF', 'FCSNPrMeatO', 'FCSNPrFish')], na.rm = TRUE)
  
  return(df)
}

# Function to categorize nutrient consumption groups based on thresholds
categorize_nutrient_consumption <- function(df, vita_column = 'FGVitA', fgprotein_column = 'FGProtein', fghiron_column = 'FGHIron') {
  # Categorize nutrient consumption into groups (Never, Sometimes, At least 7 times)
  
  # Parameters:
  # - df: DataFrame, the dataset containing the nutrient data
  # - vita_column: str, the name of vitamin A-rich nutrient column
  # - fgprotein_column: str, the name of the protein-rich nutrient column
  # - fghiron_column: str, the name of the iron-rich nutrient column
  
  # Returns:
  # - df: DataFrame, the dataset with categorized nutrient groups

  # Define categories for vitamin A-rich foods
  df$FGVitACat <- cut(df[[vita_column]], 
                      breaks = c(-Inf, 0, 6, Inf), 
                      labels = c("Never consumed", "Consumed sometimes", "Consumed at least 7 times"),
                      right = TRUE)

  # Define categories for protein-rich foods
  df$FGProteinCat <- cut(df[[fgprotein_column]], 
                         breaks = c(-Inf, 0, 6, Inf), 
                         labels = c("Never consumed", "Consumed sometimes", "Consumed at least 7 times"),
                         right = TRUE)

  # Define categories for iron-rich foods
  df$FGHIronCat <- cut(df[[fghiron_column]], 
                       breaks = c(-Inf, 0, 6, Inf), 
                       labels = c("Never consumed", "Consumed sometimes", "Consumed at least 7 times"),
                       right = TRUE)
  
  return(df)
}
