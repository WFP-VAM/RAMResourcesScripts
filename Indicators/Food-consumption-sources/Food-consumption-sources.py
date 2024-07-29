#------------------------------------------------------------------------------#
#	                          WFP Standardized Scripts
#                   Calculating Food Consumption Sources (FCS Source)
#------------------------------------------------------------------------------#

# Load Packages --------------------------------------------------------------#

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Load Sample Data ------------------------------------------------------------#

# df = pd.read_csv("FCS_Source_Sample_Survey.csv", na_values="n/a")
# print(df.columns) # Display var names for the entire data base

# Prepare FCS Source related variables ----------------------------------------#

# 1. Re-coding missing values to zero for FCS Source variables
fcs_source_columns = ['FCSStap_SRf', 'FCSPulse_SRf', 'FCSDairy_SRf', 'FCSPr_SRf', 
                      'FCSVeg_SRf', 'FCSFruit_SRf', 'FCSFat_SRf', 'FCSSugar_SRf', 
                      'FCSCond_SRf']
df[fcs_source_columns] = df[fcs_source_columns].fillna(0)

# 2. Create source-related variables
sources = {
    'Ownprod': 100,
    'HuntFish': 200,
    'Gather': 300,
    'Borrow': 400,
    'Cash': 500,
    'Credit': 600,
    'Beg': 700,
    'Exchange': 800,
    'Gift': 900,
    'Assistance': 1000
}

for food in ['Stap', 'Pulse', 'Dairy', 'Pr', 'Veg', 'Fruit', 'Fat', 'Sugar', 'Cond']:
    for source, code in sources.items():
        df[f'{source}_{food}'] = np.where(df[f'FCS{food}_SRf'] == code, df[f'FCS{food}'], 0)

# Aggregate by source
source_vars = {source: [f'{source}_{food}' for food in ['Stap', 'Pulse', 'Dairy', 'Pr', 'Veg', 'Fruit', 'Fat', 'Sugar', 'Cond']] for source in sources.keys()}
for source, vars in source_vars.items():
    df[source] = df[vars].sum(axis=1)

# Compute total sources of food
df['Total_source'] = df[list(source_vars.keys())].sum(axis=1)

# Calculate percentage of each food source
for source in sources.keys():
    df[f'Percent_{source}'] = (df[source] / df['Total_source']) * 100

# Plot percentage distributions
def plot_percentage(column):
    sns.histplot(df[column], kde=True)
    plt.title(f"Density plot for {column}")
    plt.show()

for column in [f'Percent_{source}' for source in sources.keys()]:
    plot_percentage(column)

# Display summary statistics
print(df[[f'Percent_{source}' for source in sources.keys()]].describe())

# Drop intermediate variables
drop_vars = [var for sublist in source_vars.values() for var in sublist]
df = df.drop(columns=drop_vars)

print(df.head(10))

# End of Scripts