#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#                         NUT8 Adherence Indicator
#------------------------------------------------------------------------------#

# Note: This script processes the NUT8 adherence indicator by assessing 
# whether participants received an adequate number of distributions as per 
# program requirements.

import pandas as pd
import numpy as np

# Add sample data
#data = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/Nut_CRF_8_adherence_Sample_Survey/Nutrition_module_NutProg_submodule_RepeatNutProg.csv")

# Can only download repeat CSV data as a zip file from MODA with group names.
# Rename to remove group names.
data = data.rename(columns={
    'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgCard': 'PNutProgCard',
    'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgShouldNbrCard': 'PNutProgShouldNbrCard',
    'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgDidNbrCard': 'PNutProgDidNbrCard',
    'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgShouldNbrNoCard': 'PNutProgShouldNbrNoCard',
    'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgDidNbrNoCard': 'PNutProgDidNbrNoCard'
})

# Assign variable and value labels.
data['PNutProgCard'] = data['PNutProgCard'].astype('category')
data['PNutProgCard'].cat.rename_categories({0: 'No', 1: 'Yes'}, inplace=True)

# Create variable which classifies if participant received 66% or more of planned distributions.
data['NutProgRecAdequate'] = np.where(
    (data['PNutProgCard'] == 'Yes') & ((data['PNutProgDidNbrCard'] / data['PNutProgShouldNbrCard']) >= 0.66) |
    (data['PNutProgCard'] == 'No') & ((data['PNutProgDidNbrNoCard'] / data['PNutProgShouldNbrNoCard']) >= 0.66),
    1, 0
)
data['NutProgRecAdequate'] = data['NutProgRecAdequate'].astype('category')
data['NutProgRecAdequate'].cat.rename_categories({0: 'No', 1: 'Yes'}, inplace=True)

# Create a table of the weighted percentage of NutProgRecAdequate.
nutprog_table = data['NutProgRecAdequate'].value_counts(normalize=True).reset_index()
nutprog_table.columns = ['NutProgRecAdequate', 'Percentage']
nutprog_table['Percentage'] *= 100

# Print the table.
print(nutprog_table)

# End of Scripts.