#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#                          Security Challenges Indicator
#------------------------------------------------------------------------------#

# This script processes the security challenges indicator by assessing 
# whether households have experienced any security challenge related to WFP assistance.

import pandas as pd
import numpy as np

# Add sample data.
#data = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/PROP_AAP_CRF_Sample_Survey.csv")

# Assign variable and value labels.
data['HHAsstSecurity'] = data['HHAsstSecurity'].astype('category')
data['HHAsstSecurity'].cat.rename_categories({
    0: 'No',
    1: 'Yes',
    888: 'Don\'t know'
}, inplace=True)

# Create a table of the weighted percentage of HHAsstSecurity.
HHAsstSecurity_table = data['HHAsstSecurity'].value_counts(normalize=True).reset_index()
HHAsstSecurity_table.columns = ['HHAsstSecurity', 'Percentage']
HHAsstSecurity_table['Percentage'] *= 100

# Print the table.
print(HHAsstSecurity_table)

# End of Scripts