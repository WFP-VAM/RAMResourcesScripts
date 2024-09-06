#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#     Consolidated Approach for Reporting Indicators of Food Security (CARI)
#                CALCULATE CARI using FCS, rCSI, LCS and ECMEN
#------------------------------------------------------------------------------#

# Note that there are two ways to calculate CARI - using ECMEN or FES. This syntax 
# file is for calculating CARI using ECMEN (version excluding assistance). However, 
# please navigate to the script for CARI using FES as relevant. 
# Guidance on CARI can be found here: 
# https://www.wfp.org/publications/consolidated-approach-reporting-indicators-food-security-cari-guidelines.

# Note: this syntax file is based on the assumption that the scripts of the various 
# indicators that compose this version of the CARI (FCS, rCSI, LCS-FS, ECMEN) have 
# already been run. You can find these scripts here: 
# https://github.com/WFP-VAM/RAMResourcesScripts/tree/main/Indicators.
# The following variables should have been defined before running this file:
#   FCSCat21 and/or FCSCat28 
#   rCSI
#   Max_coping_behaviourFS	
#   ECMEN_exclAsst 
#   ECMEN_exclAsst_SMEB.	

import pandas as pd
import numpy as np

# Load data
data = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/CARI_FS_Sample_Survey.csv")

# Process FCS for CARI computation
data['FCS_4pt'] = data['FCSCat21'].replace({1: 4, 2: 3, 3: 1})
data.loc[data['rCSI'] >= 4, 'FCS_4pt'] = 2

# Process ECMEN for CARI computation
data['ECMEN_MEB'] = np.where(data['ECMEN_exclAsst'] == 1, 1, 
                     np.where((data['ECMEN_exclAsst'] == 0) & (data['ECMEN_exclAsst_SMEB'] == 1), 2, 
                     np.where((data['ECMEN_exclAsst'] == 0) & (data['ECMEN_exclAsst_SMEB'] == 0), 3, np.nan)))

data['ECMEN_class_4pt'] = data['ECMEN_MEB'].replace({1: 1, 2: 3, 3: 4})

# Computation of CARI
data['Mean_coping_capacity_ECMEN'] = data[['Max_coping_behaviourFS', 'ECMEN_class_4pt']].mean(axis=1, skipna=True)
data['CARI_unrounded_ECMEN'] = data[['FCS_4pt', 'Mean_coping_capacity_ECMEN']].mean(axis=1, skipna=True)
data['CARI_ECMEN'] = data['CARI_unrounded_ECMEN'].round().astype(int)

# Label mappings
fcs_4pt_labels = {1: "Acceptable", 2: "Acceptable and rCSI>4", 3: "Borderline", 4: "Poor"}
ecmen_class_4pt_labels = {1: "Least vulnerable", 3: "Vulnerable", 4: "Highly vulnerable"}
cari_ecmen_labels = {1: "Food secure", 2: "Marginally food secure", 3: "Moderately food insecure", 4: "Severely food insecure"}

data['FCS_4pt'] = data['FCS_4pt'].map(fcs_4pt_labels)
data['ECMEN_class_4pt'] = data['ECMEN_class_4pt'].map(ecmen_class_4pt_labels)
data['CARI_ECMEN'] = data['CARI_ECMEN'].map(cari_ecmen_labels)

# Frequencies of CARI_ECMEN
cari_ecmen_freq = data['CARI_ECMEN'].value_counts(normalize=True).reset_index()
cari_ecmen_freq.columns = ['CARI_ECMEN', 'percentage']
cari_ecmen_freq['percentage'] *= 100
print(cari_ecmen_freq)

# Create population distribution table
pop_distribution_table = data.pivot_table(index=['ECMEN_class_4pt', 'FCS_4pt'], columns='Max_coping_behaviourFS', aggfunc='size', fill_value=0)
pop_distribution_table = pop_distribution_table.div(pop_distribution_table.sum(axis=1), axis=0) * 100
print(pop_distribution_table)

# Drop variables that are not needed
data.drop(columns=['ECMEN_MEB', 'Mean_coping_capacity_ECMEN', 'CARI_unrounded_ECMEN'], inplace=True)

# End of Scripts