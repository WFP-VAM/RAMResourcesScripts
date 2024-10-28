#------------------------------------------------------------------------------#
#	                         WFP Standardized Scripts
#             Calculating Food Consumption Score - Nutrition (FCSN)
#------------------------------------------------------------------------------#

# Load Packages --------------------------------------------------------------#

import pandas as pd
import numpy as np

# Load Sample Data ------------------------------------------------------------#

# df = pd.read_csv("FCSN_Sample_Survey.csv", na_values="n/a")

# Label FCSN relevant variables -----------------------------------------------#

fcsn_columns = [
    'FCSNPrMeatF', 'FCSNPrMeatO', 'FCSNPrFish', 'FCSNPrEggs', 
    'FCSNVegOrg', 'FCSNVegGre', 'FCSNFruiOrg'
]

# Recode "n/a" values to 0 and change to numeric
df[fcsn_columns] = df[fcsn_columns].replace("n/a", 0).apply(pd.to_numeric)

# Compute aggregates of key micronutrient consumption -------------------------#

# Vitamin A-Rich Foods
df['FGVitA'] = (df['FCSDairy'] + df['FCSNPrMeatO'] + df['FCSNPrEggs'] + 
                df['FCSNVegOrg'] + df['FCSNVegGre'] + df['FCSNFruiOrg'])

# Protein-Rich Foods
df['FGProtein'] = (df['FCSPulse'] + df['FCSDairy'] + df['FCSNPrMeatF'] + 
                   df['FCSNPrMeatO'] + df['FCSNPrFish'] + df['FCSNPrEggs'])

# Iron-Rich Foods
df['FGHIron'] = df['FCSNPrMeatF'] + df['FCSNPrMeatO'] + df['FCSNPrFish']

# Recode into nutritious groups  ---------------------------------------------#

df['FGVitACat'] = pd.cut(df['FGVitA'], bins=[-np.inf, 0, 6, np.inf], 
                         labels=['Never consumed', 'Consumed sometimes', 'Consumed at least 7 times'])

df['FGProteinCat'] = pd.cut(df['FGProtein'], bins=[-np.inf, 0, 6, np.inf], 
                            labels=['Never consumed', 'Consumed sometimes', 'Consumed at least 7 times'])

df['FGHIronCat'] = pd.cut(df['FGHIron'], bins=[-np.inf, 0, 6, np.inf], 
                          labels=['Never consumed', 'Consumed sometimes', 'Consumed at least 7 times'])

# Define variables labels and properties
# In pandas, we generally don't label data like in R, but you can create a dictionary for descriptions if needed

labels = {
    'FGVitACat': "Consumption group of vitamin A-rich foods",
    'FGProteinCat': "Consumption group of protein-rich foods",
    'FGHIronCat': "Consumption group of heme iron-rich foods"
}

# Print summary to check the results
print(df[['FGVitA', 'FGVitACat', 'FGProtein', 'FGProteinCat', 'FGHIron', 'FGHIronCat']].head())
print(df['FGVitA'].describe())
print(df['FGProtein'].describe())
print(df['FGHIron'].describe())

# End of Scripts