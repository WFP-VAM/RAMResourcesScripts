#------------------------------------------------------------------------------#
#                           WFP APP Standardized Scripts
#                Food Consumption Score (FCS) Calculation in Python
#------------------------------------------------------------------------------#
# 1. Purpose:
# This script calculates the Food Consumption Score (FCS) using standardized 
# food group variables. It assumes that the required variables are available in 
# your dataset and correctly formatted for use in the calculation.
#
# 2. Assumptions:
# - The dataset contains standardized variables from Survey Designer.
# - The variables used for the FCS calculation are properly named and cleaned.
# - The dataset is loaded into a pandas DataFrame before executing the script.
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
# - Required Packages:
#   - pandas (Install with `pip install pandas`)
#
# 4. Python Version: 
# - Python 3.x is recommended for compatibility with the pandas package.
#------------------------------------------------------------------------------#

# Load necessary libraries
import pandas as pd

# Function to calculate FCS
def calculate_fcs(df):
    """
    Calculate the Food Consumption Score (FCS).
    
    Parameters:
    - df: pandas.DataFrame, the dataset containing the eight FCS variables
    
    Returns:
    - df: pandas.DataFrame, the dataset with the calculated 'FCS' variable
    """
    df['FCS'] = (df['FCSStap'] * 2 +
                 df['FCSPulse'] * 3 +
                 df['FCSDairy'] * 4 +
                 df['FCSPr'] * 4 +
                 df['FCSVeg'] +
                 df['FCSFruit'] +
                 df['FCSFat'] * 0.5 +
                 df['FCSSugar'] * 0.5)
    return df

# Function to categorize FCS into groups based on thresholds
def categorize_fcs(df, fcs_column='FCS'):
    """
    Categorize FCS into groups based on thresholds.
    
    Parameters:
    - df: pandas.DataFrame, the dataset containing the FCS
    - fcs_column: str, the name of the column containing the calculated food consumption score (default is 'FCS')
    
    Returns:
    - df: pandas.DataFrame, the dataset with the calculated 'FCSCat21' and 'FCSCat28' variables
    """
    # Low consumption of sugar and oil
    df['FCSCat21'] = pd.cut(
        df[fcs_column], 
        bins=[-float('inf'), 21, 35, float('inf')],
        labels=["Poor", "Borderline", "Acceptable"],
        right=True
    )
    
    # High consumption of sugar and oil
    df['FCSCat28'] = pd.cut(
        df[fcs_column], 
        bins=[-float('inf'), 28, 42, float('inf')],
        labels=["Poor", "Borderline", "Acceptable"],
        right=True
    )

    return df
