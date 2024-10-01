#------------------------------------------------------------------------------#
#                           WFP APP Standardized Scripts
#              Calculating Food Consumption Score Nutrition (FCSN) in Python
#------------------------------------------------------------------------------#
# 1. Purpose:
# This script calculates the Food Consumption Score Nutrition (FCSN) by aggregating 
# food consumption data for different nutrients. It assumes that the required variables 
# are available in your dataset and correctly formatted for use in the calculation.
#
# 2. Assumptions:
# - The dataset contains standardized variables from Survey Designer.
# - The variables used for the FCSN calculation are properly named and cleaned.
# - The dataset is loaded into a pandas DataFrame before executing the script.
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
#   - pandas (Install with `pip install pandas`)
#
# 4. Python Version: 
# - Python 3.x is recommended for compatibility with the pandas package.
#------------------------------------------------------------------------------#

# Load necessary libraries
import pandas as pd

# Function to compute key nutrient aggregates (vitamin A, protein, and iron)
def compute_nutrient_aggregates(df):
    """
    Compute aggregates of key micronutrient consumption (Vitamin A, Protein, Hem Iron).
    
    Parameters:
    - df: pandas.DataFrame, the dataset containing the FCS and FCSN variables
    
    Returns:
    - df: pandas.DataFrame, the dataset with calculated micronutrient aggregates
    """
    # Sum the columns and treat NaN as 0 for vitamin A-rich foods
    df['FGVitA'] = df[['FCSDairy', 'FCSNPrMeatO', 'FCSNPrEggs', 'FCSNVegOrg', 
                       'FCSNVegGre', 'FCSNFruiOrg']].sum(axis=1, skipna=True)
    
    # Sum the columns and treat NaN as 0 for protein-rich foods
    df['FGProtein'] = df[['FCSPulse', 'FCSDairy', 'FCSNPrMeatF', 
                          'FCSNPrMeatO', 'FCSNPrFish', 'FCSNPrEggs']].sum(axis=1, skipna=True)
    
    # Sum the columns and treat NaN as 0 for hem iron-rich foods
    df['FGHIron'] = df[['FCSNPrMeatF', 'FCSNPrMeatO', 'FCSNPrFish']].sum(axis=1, skipna=True)
    
    return df

# Function to categorize nutrient consumption groups based on thresholds
def categorize_nutrient_consumption(df, vita_column='FGVitA', fgprotein_column='FGProtein', fghiron_column='FGHIron'):
    """
    Categorize nutrient consumption into groups (Never, Sometimes, At least 7 times).
    
    Parameters:
    - df: pandas.DataFrame, the dataset containing the nutrient data
    - vita_column: str, the name of vitamin A-rich nutrient column
    - fgprotein_column: str, the name of the protein-rich nutrient column
    - fghiron_column: str, the name of the iron-rich nutrient column
    
    Returns:
    - df: pandas.DataFrame, the dataset with categorized nutrient groups
    """
    for column in [vita_column, fgprotein_column, fghiron_column]:
        df[column + 'Cat'] = pd.cut(
            df[column],
            bins=[-float('inf'), 0, 6, 42],
            labels=["Never consumed", "Consumed sometimes", "Consumed at least 7 times"],
            right=True
        )
        
    return df

# Example usage of the functions:
df = pd.DataFrame({'FCSDairy': [5, 0, 1], 'FCSNPrMeatF': [1, 0, 1], 'FCSNPrMeatO': [0, 0, 1],
                   'FCSNPrFish': [5, 0, 0], 'FCSNPrEggs': [1, 0, 0], 'FCSNVegOrg': [0, 0, 1],
                   'FCSNVegGre': [5, 0, 1], 'FCSNFruiOrg': [1, 0, 1], 'FCSPulse': [1, 0, 0]})
