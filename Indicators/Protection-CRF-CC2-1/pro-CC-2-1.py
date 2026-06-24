#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#                Access to Information in WFP Programmes (pro-CC-2-1)
#------------------------------------------------------------------------------#

# This script processes the indicators related to households' access to information 
# about their entitlements, selection criteria, information comprehension, and 
# reporting misconduct in WFP programmes.

import pandas as pd
import numpy as np

# Add sample data.
#data = pd.read_csv("Static/PROP_AAP_CRF_Sample_Survey.csv")

# Assign variable and value labels.
data['HHAsstKnowEnt'] = data['HHAsstKnowEnt'].astype('category')
data['HHAsstKnowEnt'].cat.rename_categories({
    0: 'No',
    1: 'Yes'
}, inplace=True)

data['HHAsstKnowPeople'] = data['HHAsstKnowPeople'].astype('category')
data['HHAsstKnowPeople'].cat.rename_categories({
    0: 'No',
    1: 'Yes'
}, inplace=True)

data['HHAsstRecInfo'] = data['HHAsstRecInfo'].astype('category')
data['HHAsstRecInfo'].cat.rename_categories({
    0: 'No',
    1: 'Yes',
    2: 'I never received information'
}, inplace=True)

data['HHAsstReportMisc'] = data['HHAsstReportMisc'].astype('category')
data['HHAsstReportMisc'].cat.rename_categories({
    0: 'No',
    1: 'Yes'
}, inplace=True)

# Calculate indicator.
data['HHAcessInfo'] = np.where(
    (data['HHAsstKnowEnt'] == 'Yes') & 
    (data['HHAsstKnowPeople'] == 'Yes') & 
    (data['HHAsstRecInfo'] == 'Yes') & 
    (data['HHAsstReportMisc'] == 'Yes'), 'Yes', 'No'
)

# Create a table of the weighted percentage of HHAcessInfo.
HHAcessInfo_table = data['HHAcessInfo'].value_counts(normalize=True).reset_index()
HHAcessInfo_table.columns = ['HHAcessInfo', 'Percentage']
HHAcessInfo_table['Percentage'] *= 100

# Print the table.
print(HHAcessInfo_table)

# End of Scripts.