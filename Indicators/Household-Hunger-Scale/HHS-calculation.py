#------------------------------------------------------------------------------#
#                      WFP Standardized Scripts
#                Calculating the Household Hunger Scale (HHS)
#------------------------------------------------------------------------------#

# Load Packages --------------------------------------------------------------#
import pandas as pd

# Load Sample Data ------------------------------------------------------------#
# df = pd.read_csv("path_to_your_file.csv")

# Clean HHS variables --------------------------------------------------------#
df['HHSNoFood'] = df['HHSNoFood_FR'].apply(lambda x: 1 if x > 0 else 0)
df['HHSBedHung'] = df['HHSBedHung_FR'].apply(lambda x: 1 if x > 0 else 0)
df['HHSNotEat'] = df['HHSNotEat_FR'].apply(lambda x: 1 if x > 0 else 0)

# Recode frequency-of-occurrence questions -----------------------------------#
df['HHSQ1'] = df['HHSNoFood_FR'].map({1: 1, 2: 1, 3: 2}).fillna(0).astype(int)
df['HHSQ2'] = df['HHSBedHung_FR'].map({1: 1, 2: 1, 3: 2}).fillna(0).astype(int)
df['HHSQ3'] = df['HHSNotEat_FR'].map({1: 1, 2: 1, 3: 2}).fillna(0).astype(int)

# Compute Household Hunger Score ------------------------------------------------#
df['HHS'] = df['HHSQ1'] + df['HHSQ2'] + df['HHSQ3']

# Create categorical HHS indicators -------------------------------------------#
df['HHSCat']  = pd.cut(df['HHS'], bins=[-float('inf'), 1, 3, float('inf')], labels=[1, 2, 3])
df['HHSCatr'] = pd.cut(df['HHS'], bins=[-float('inf'), 0, 1, 3, 4, float('inf')], labels=[0, 1, 2, 3, 4])

# Display the results --------------------------------------------------------#
print(df[['HHS', 'HHSCat', 'HHSCatr']].head(10))

# End of Scripts