#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#                           Access Challenges Indicator
#------------------------------------------------------------------------------#

# This script processes the access challenges indicator by assessing 
# whether households have been unable to access WFP assistance one or more times.

import pandas as pd
import numpy as np

# Add sample data.
#data = pd.read_csv("Static/PROP_AAP_CRF_Sample_Survey.csv")

# Assign variable and value labels.
data['HHAsstAccess'] = data['HHAsstAccess'].astype('category')
data['HHAsstAccess'].cat.rename_categories({
    0: 'No',
    1: 'Yes',
    888: 'Don\'t know'
}, inplace=True)

# Create a table of the weighted percentage of HHAsstAccess.
HHAsstAccess_table = data['HHAsstAccess'].value_counts(normalize=True).reset_index()
HHAsstAccess_table.columns = ['HHAsstAccess', 'Percentage']
HHAsstAccess_table['Percentage'] *= 100

# Print the table.
print(HHAsstAccess_table)

# End of Scripts.