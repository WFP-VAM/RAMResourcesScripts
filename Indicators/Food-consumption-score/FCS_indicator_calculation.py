#------------------------------------------------------------------------------#
#	                        WFP APP Standardized Scripts
#                     Calculating Food Consumption Score (FCS)
#------------------------------------------------------------------------------#

# Load Packages --------------------------------------------------------------#

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Load Sample Data ------------------------------------------------------------#

#df = pd.read_csv("FCS_Sample_Survey.csv", na_values="n/a")
#print(df.columns) # Display var names for the entire data base

# Prepare FCS related variables -----------------------------------------------#

# 1. Re-coding missing values to zero
fcs_columns = ['FCSStap', 'FCSVeg', 'FCSFruit', 'FCSPr', 'FCSPulse', 'FCSDairy', 'FCSSugar', 'FCSFat', 'FCSCond']
df[fcs_columns] = df[fcs_columns].fillna(0)

# Test results
print(df['FCSStap']) # How data looks like?

# 2. Variables creation and statistics testing
# Var FCSStapCer FCSStapTub
# although deprecated, in case two staples are collected separately, then:
if 'FCSStap' not in df.columns:
    df['FCSStap'] = df[['FCSStapCer', 'FCSStapTub']].max(axis=1)

# Display summary statistics and plots for each FCS related variable
def summarize_and_plot(column):
    print(f"Summary statistics for {column}:")
    print(df[column].describe())
    sns.histplot(df[column], kde=True)
    plt.title(f"Density plot for {column}")
    plt.show()

for col in fcs_columns:
    summarize_and_plot(col)

# 2.1 Recode above 7 to 7 (only if necessary)
df[fcs_columns] = df[fcs_columns].applymap(lambda x: 7 if x > 7 else x)

# Calculate FCS ---------------------------------------------------------------#
df['FCS'] = (df['FCSStap'] * 2 +
                df['FCSPulse'] * 3 +
                 df['FCSDairy'] * 4 +
                  df['FCSPr'] * 4 +
                   df['FCSVeg'] +
                    df['FCSFruit'] +            
                     df['FCSFat'] * 0.5 +
                      df['FCSSugar'] * 0.5)

# Test FCS results
print(df['FCS'].head(10))
print(df['FCS'].describe())
sns.histplot(df['FCS'], kde=True)
plt.title("Density plot for FCS")
plt.show()

# Create FCG groups based on 21/35 or 28/42 thresholds ------------------------#
# Use this when analyzing a country with low consumption of sugar and oil - thresholds 21-35
df['FCSCat21'] = pd.cut(df['FCS'], bins=[0, 21.5, 35.5, float('inf')], 
                        labels=['Poor', 'Borderline', 'Acceptable'], 
                        right=False)

# Use this when analyzing a country with high consumption of sugar and oil - thresholds 28-42
df['FCSCat28'] = pd.cut(df['FCS'], bins=[0, 28.5, 42.5, float('inf')], 
                        labels=['Poor', 'Borderline', 'Acceptable'], 
                        right=False)

print(df[['FCS', 'FCSCat21', 'FCSCat28']].head(10))

# End of Scripts