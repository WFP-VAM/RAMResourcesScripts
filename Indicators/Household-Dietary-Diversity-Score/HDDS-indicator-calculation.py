#------------------------------------------------------------------------------#
#                           WFP APP Standardized Scripts
#              Calculating Household Dietary Diversity Score (HDDS) in Python
#------------------------------------------------------------------------------#
# 1. Purpose:
# This script calculates the Household Dietary Diversity Score (HDDS) using standardized 
# food group variables based on a 24-hour recall. It assumes that the required variables 
# are available in your dataset and correctly formatted for use in the calculation.
#
# 2. Assumptions:
# - The dataset contains standardized variables from Survey Designer.
# - The variables used for the HDDS calculation are properly named and cleaned.
# - The dataset is loaded into a pandas DataFrame before executing the script.
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
# - Required Packages:
#   - pandas (Install with `pip install pandas`)
#
# 4. Python Version: 
# - Python 3.x is recommended for compatibility with the pandas package.
#------------------------------------------------------------------------------#

# Load necessary libraries
import pandas as pd

# Function to calculate HDDS
def calculate_hdds(df):
    """
    Calculate the Household Dietary Diversity Score (HDDS).
    
    Parameters:
    - df: pandas.DataFrame, the dataset containing the twelve HDDS variables
    
    Returns:
    - df: pandas.DataFrame, the dataset with the calculated 'HDDS' variable
    """
    # Sum the 12 food group variables, treating NaN as 0
    df['HDDS'] = df[['HDDSStapCer', 'HDDSStapRoot', 'HDDSVeg', 'HDDSFruit',
                     'HDDSPrMeat', 'HDDSPrEggs', 'HDDSPrFish', 'HDDSPulse',
                     'HDDSDairy', 'HDDSFat', 'HDDSSugar', 'HDDSCond']].sum(axis=1, skipna=True)
    
    return df

# Function to categorize HDDS into groups based on IPC thresholds
def categorize_hdds(df, hdds_column='HDDS'):
    """
    Categorize HDDS into groups based on IPC severity scale.
    
    Parameters:
    - df: pandas.DataFrame, the dataset containing the HDDS
    - hdds_column: str, the name of the column containing the calculated HDDS (default is 'HDDS')
    
    Returns:
    - df: pandas.DataFrame, the dataset with the calculated 'HDDSCat_IPC' variable
    """
    # Recode HDDS into categories using IPC thresholds
    df['HDDSCat_IPC'] = pd.cut(
        df[hdds_column], 
        bins=[-float('inf'), 2, 4, float('inf')],
        labels=["0-2 food groups (phase 4 to 5)", 
                "3-4 food groups (phase 3)", 
                "5-12 food groups (phase 1 to 2)"],
        right=True
    )
    
    return df
