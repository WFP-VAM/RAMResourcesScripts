#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#     Consolidated Approach for Reporting Indicators of Food Security (CARI)
#                CALCULATE CARI using FCS, rCSI, LCS and FES
#------------------------------------------------------------------------------#

# Note that there are two ways to calculate CARI - using ECMEN or FES. This script 
# is for calculating CARI using FES. However, please navigate to the script 
# for CARI using ECMEN as relevant. 
# Guidance on CARI can be found here: 
# https://www.wfp.org/publications/consolidated-approach-reporting-indicators-food-security-cari-guidelines.

# Note: this script is based on the assumption that the scripts of the various 
# indicators that compose this version of the CARI (FCS, rCSI, LCS-FS, FES) have 
# already been run. You can find these scripts here: 
# https://github.com/WFP-VAM/RAMResourcesScripts/tree/main/Indicators.
# The following variables should have been defined before running this file:
#   FCSCat21 and/or FCSCat28 
#   rCSI
#   Max_coping_behaviourFS	
#   FES
#   Foodexp_4pt.		

import pandas as pd
import numpy as np

# Create FCS_4pt for CARI calculation
data['FCS_4pt'] = data['FCSCat21'].replace({1: 4, 2: 3, 3: 1})
data['FCS_4pt'].replace({1: 'Acceptable', 3: 'Borderline', 4: 'Poor'}, inplace=True)

# Combine rCSI with FCS_4pt for CARI calculation (current consumption)
data.loc[data['rCSI'] >= 4, 'FCS_4pt'] = data['FCS_4pt'].replace({'Acceptable': 'Acceptable and rCSI>4'})

data['FCS_4pt'].replace({'Acceptable': 1, 'Acceptable and rCSI>4': 2, 'Borderline': 3, 'Poor': 4}, inplace=True)

# Computation of CARI
data['Mean_coping_capacity_FES'] = data[['Max_coping_behaviourFS', 'Foodexp_4pt']].mean(axis=1)
data['CARI_unrounded_FES'] = data[['FCS_4pt', 'Mean_coping_capacity_FES']].mean(axis=1)
data['CARI_FES'] = data['CARI_unrounded_FES'].round().astype(int)

data['CARI_FES'].replace({1: 'Food secure', 2: 'Marginally food secure', 3: 'Moderately food insecure', 4: 'Severely food insecure'}, inplace=True)

# Frequency table of CARI_FES
print(data['CARI_FES'].value_counts())

# Create population distribution table to explore how the domains interact within the different food security categories
distribution_table = pd.crosstab(index=[data['Foodexp_4pt']], columns=[data['FCS_4pt'], data['Max_coping_behaviourFS']], normalize='index')

# Drop variables that are not needed
data.drop(columns=['Mean_coping_capacity_FES', 'CARI_unrounded_FES'], inplace=True)

# End of Scripts