#------------------------------------------------------------------------------#
#                           WFP RAM Standardized Scripts
#                Reduced Coping Strategies Index (rCSI) Calculation in Python
#------------------------------------------------------------------------------#
# 1. Purpose:
# This script calculates the Reduced Coping Strategies Index (rCSI) using standardized 
# variables. It assumes that the required variables are available in your dataset and 
# correctly formatted for use in the calculation.
#
# 2. Assumptions:
# - The dataset contains standardized variables from Survey Designer.
# - The variables used for the rCSI calculation are properly named and cleaned.
# - The dataset is loaded into a pandas DataFrame before executing the script.
#
# 3. Requirements:
# - Required variables in the dataset:
#   - rCSILessQlty : Reduced quality of meals
#   - rCSIBorrow   : Borrow food
#   - rCSIMealNb   : Reduce number of meals
#   - rCSIMealSize : Reduce meal size
#   - rCSIMealAdult: Restrict consumption of adults
#
# - Required Packages:
#   - pandas (Install with `pip install pandas`)
#
# 4. Python Version: 
# - Python 3.x is recommended for compatibility with the pandas package.
#------------------------------------------------------------------------------#

# Load necessary libraries
import pandas as pd

# Function to calculate rCSI
def calculate_rcsi(df):
    """
    Calculate the Reduced Coping Strategies Index (rCSI).
    
    Parameters:
    - df: pandas.DataFrame, the dataset containing the five rCSI variables
    
    Returns:
    - df: pandas.DataFrame, the dataset with the calculated 'rCSI' variable
    """
    df['rCSI'] = (df['rCSILessQlty'] +
                  (df['rCSIBorrow'] * 2) +
                  df['rCSIMealNb'] +
                  df['rCSIMealSize'] +
                  (df['rCSIMealAdult'] * 3))
    return df

# Function to categorize rCSI into groups based on thresholds
def categorize_rcsi(df, rcsi_column='rCSI'):
    """
    Categorize rCSI into groups based on thresholds.
    
    Parameters:
    - df: pandas.DataFrame, the dataset containing the rCSI
    - rcsi_column: str, the name of the column containing the calculated rCSI (default is 'rCSI')
    
    Returns:
    - df: pandas.DataFrame, the dataset with the calculated 'rCSICat' variable
    """
    df['rCSICat'] = pd.cut(
        df[rcsi_column], 
        bins=[-float('inf'), 3.5, 18, float('inf')],
        labels=["Minimal", "Moderate", "Severe"],
        right=True
    )
    return df
