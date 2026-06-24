#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#                    Respect and Dignity in WFP Programmes
#------------------------------------------------------------------------------#

# This script processes the indicators related to whether households feel 
# respected and dignified while engaging in WFP programmes.

import pandas as pd
import numpy as np

# Add sample data.
#data = pd.read_csv("Static/PROP_AAP_CRF_Sample_Survey.csv")

# Assign variable and value labels.
data['HHAsstRespect'] = data['HHAsstRespect'].astype('category')
data['HHAsstRespect'].cat.rename_categories({
    0: 'No',
    1: 'Yes'
}, inplace=True)

data['HHDTPDign'] = data['HHDTPDign'].astype('category')
data['HHDTPDign'].cat.rename_categories({
    0: 'No',
    1: 'Yes'
}, inplace=True)

# Calculate indicator.
data['HHAsstRespectDign'] = np.where((data['HHAsstRespect'] == 'Yes') & (data['HHDTPDign'] == 'Yes'), 'Yes', 'No')

# Create a table of the weighted percentage of HHAsstRespectDign.
HHAsstRespectDign_table = data['HHAsstRespectDign'].value_counts(normalize=True).reset_index()
HHAsstRespectDign_table.columns = ['HHAsstRespectDign', 'Percentage']
HHAsstRespectDign_table['Percentage'] *= 100

# Print the table.
print(HHAsstRespectDign_table)

# End of Scripts.