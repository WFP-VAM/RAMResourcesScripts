#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#                         NUT7 Coverage Indicator
#------------------------------------------------------------------------------#

# Note: This script processes the NUT7 coverage indicator by assessing participant 
# enrollment in a specified nutrition program.

import pandas as pd
import numpy as np

# Add sample data.
#data = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/Nut_CRF_7_coverage_Sample_Survey/Nutrition_module_NutProg_submodule_RepeatNutProg.csv")

# Can only download repeat CSV data as a zip file from MODA with group names.
# Rename to remove group names.
data = data.rename(columns={'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgPartic_yn': 'PNutProgPartic_yn'})

# Assign variable and value labels.
data['PNutProgPartic_yn'] = data['PNutProgPartic_yn'].astype('category')
data['PNutProgPartic_yn'].cat.categories = ["No", "Yes"]
data['PNutProgPartic_yn'].cat.set_categories([0, 1], rename=True, inplace=True)

# Create a table of the weighted percentage of NutProgPartic_yn.
nut_prog_partic_yn_table = data['PNutProgPartic_yn'].value_counts(normalize=True).reset_index()
nut_prog_partic_yn_table.columns = ['PNutProgPartic_yn', 'Percentage']
nut_prog_partic_yn_table['Percentage'] = nut_prog_partic_yn_table['Percentage'] * 100

# End of Scripts.