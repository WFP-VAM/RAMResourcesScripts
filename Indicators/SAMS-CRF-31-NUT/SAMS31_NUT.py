#------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#         Nutritious Crop Production Increase Calculation (SAMS Indicator 31)
#------------------------------------------------------------------------------

# This script calculates the proportion of farmers reporting an increase in 
# nutritious crop production based on SAMS Indicator 31 guidelines.
# Detailed guidelines can be found in the SAMS documentation.

# This syntax is based on SPSS download version from MoDA.
# More details can be found in the background document at: 
# https://wfp.sharepoint.com/sites/CRF2022-2025/CRF%20Outcome%20indicators/Forms/AllItems.aspx

import pandas as pd

# Add sample data
data  = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/SAMS_CRF_31_NUT_Sample_Survey/SAMS_module_Indicator31_submodule_RepeatNutCrop.csv")
data2 = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/SAMS_CRF_31_NUT_Sample_Survey/data.csv")

# Rename to remove group names
data = data.rename(columns={
    'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropName': 'PSAMSNutCropName',
    'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropName_oth': 'PSAMSNutCropName_oth',
    'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropQuant': 'PSAMSNutCropQuant',
    'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropQuantUnit': 'PSAMSNutCropQuantUnit',
    'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropIncr': 'PSAMSNutCropIncr',
    '_parent_index': 'index'
})

data2 = data2.rename(columns={
    'Demographic_module/DemographicBasic_submodule/RespSex': 'RespSex',
    '_index': 'index'
})

# Assign variable and value labels
data2['RespSex'] = data2['RespSex'].astype('category')
data2['RespSex'].cat.rename_categories({
    0: 'Female',
    1: 'Male'
}, inplace=True)

data['PSAMSNutCropName'] = data['PSAMSNutCropName'].astype('category')
data['PSAMSNutCropName'].cat.rename_categories({
    1: 'Crop 1',
    2: 'Crop 2',
    3: 'Crop 3',
    4: 'Crop 4',
    5: 'Crop 5',
    999: 'Other'
}, inplace=True)

data['PSAMSNutCropIncr'] = data['PSAMSNutCropIncr'].astype('category')
data['PSAMSNutCropIncr'].cat.rename_categories({
    1: 'More',
    2: 'Less',
    3: 'The same',
    9999: 'Not applicable'
}, inplace=True)

# Join dataset "data" & "data2"
data = data.merge(data2, on="index")

# Selecting farmers that grew "Crop 1" show proportion reporting an increase, decrease or the same amount of production as the year before
SAMS31_table_total_wide = data[data['PSAMSNutCropName'] == 'Crop 1']
SAMS31_table_total_wide = SAMS31_table_total_wide[SAMS31_table_total_wide['PSAMSNutCropIncr'] != 'Not applicable']
SAMS31_table_total_wide = SAMS31_table_total_wide.dropna(subset=['PSAMSNutCropIncr'])
SAMS31_table_total_wide = SAMS31_table_total_wide.groupby('PSAMSNutCropIncr').size().reset_index(name='counts')
SAMS31_table_total_wide['Percentage'] = 100 * SAMS31_table_total_wide['counts'] / SAMS31_table_total_wide['counts'].sum()
SAMS31_table_total_wide = SAMS31_table_total_wide.pivot(index=None, columns='PSAMSNutCropIncr', values='Percentage').fillna(0)

SAMS31_table_bysex_wide = data[data['PSAMSNutCropName'] == 'Crop 1']
SAMS31_table_bysex_wide = SAMS31_table_bysex_wide[SAMS31_table_bysex_wide['PSAMSNutCropIncr'] != 'Not applicable']
SAMS31_table_bysex_wide = SAMS31_table_bysex_wide.dropna(subset=['PSAMSNutCropIncr'])
SAMS31_table_bysex_wide = SAMS31_table_bysex_wide.groupby(['RespSex', 'PSAMSNutCropIncr']).size().reset_index(name='counts')
SAMS31_table_bysex_wide['Percentage'] = 100 * SAMS31_table_bysex_wide['counts'] / SAMS31_table_bysex_wide.groupby('RespSex')['counts'].transform('sum')
SAMS31_table_bysex_wide = SAMS31_table_bysex_wide.pivot(index='RespSex', columns='PSAMSNutCropIncr', values='Percentage').fillna(0)

# Print results
print(SAMS31_table_total_wide)
print(SAMS31_table_bysex_wide)

# End of Scripts