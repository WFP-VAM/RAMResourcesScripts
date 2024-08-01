#------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#          School Age Dietary Diversity Score (SADD) Calculation
#------------------------------------------------------------------------------

# This script calculates the School Age Dietary Diversity Score (SADD) based on 
# WFP MDDW guidelines. Specialized Nutritious Foods (SNF) will count in the 
# meats group, and fortified foods will also count in grains.
# Detailed guidelines can be found at:
# https://docs.wfp.org/api/documents/WFP-0000140197/download/

# This syntax is based on SPSS download version from MoDA.
# Following the WFP MDDW method for program monitoring - SNF will count in the meats group.
# In this example, fortified foods (PSchoolAgeDDSFortFoodwflour, PSchoolAgeDDSFortFoodmflour, PSchoolAgeDDSFortFoodrice, PSchoolAgeDDSFortFooddrink)
# will also count in grains. Classifying PSchoolAgeDDSFortFoodother_oth will likely involve classifying line by line.
# More details can be found in the background document at: 
# https://wfp.sharepoint.com/sites/CRF2022-2025/CRF%20Outcome%20indicators/Forms/AllItems.aspx?id=%2Fsites%2FCRF2022%2D2025%2FCRF%20Outcome%20indicators%2F2%2E%20Nutrition%2F63%2E%20Percentage%20of%20school%2Daged%20children%20meeting%20minimum%20dietary%20diversity%20score%20%5BNEW%5D%2Epdf&viewid=68ec615a%2D665b%2D4f2d%2Da495%2D9e5f10bc60b2&parent=%2Fsites%2FCRF2022%2D2025%2FCRF%20Outcome%20indicators%2F2%2E%20Nutrition

import pandas as pd
import numpy as np

# Load sample data
data = pd.read_csv("path_to_your_data.csv")

# Rename variables to remove group names
data = data.rename(columns={
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsstapcer': 'PSchoolAgeDDSStapCer',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsstaproo': 'PSchoolAgeDDSStapRoo',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddspulse': 'PSchoolAgeDDSPulse',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsnuts': 'PSchoolAgeDDSNuts',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsmilk': 'PSchoolAgeDDSMilk',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsdairy': 'PSchoolAgeDDSDairy',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsprmeato': 'PSchoolAgeDDSPrMeatO',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsprmeatf': 'PSchoolAgeDDSPrMeatF',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsprmeatpro': 'PSchoolAgeDDSPrMeatPro',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsprmeatwhite': 'PSchoolAgeDDSPrMeatWhite',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsprfish': 'PSchoolAgeDDSPrFish',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddspregg': 'PSchoolAgeDDSPrEgg',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsveggre': 'PSchoolAgeDDSVegGre',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsvegorg': 'PSchoolAgeDDSVegOrg',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfruitorg': 'PSchoolAgeDDSFruitOrg',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsvegoth': 'PSchoolAgeDDSVegOth',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfruitoth': 'PSchoolAgeDDSFruitOth',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddssnf': 'PSchoolAgeDDSSnf',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfortfoodoil': 'PSchoolAgeDDSFortFoodoil',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfortfoodwflour': 'PSchoolAgeDDSFortFoodwflour',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfortfoodmflour': 'PSchoolAgeDDSFortFoodmflour',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfortfoodrice': 'PSchoolAgeDDSFortFoodrice',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfortfooddrink': 'PSchoolAgeDDSFortFooddrink',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfortfoodother': 'PSchoolAgeDDSFortFoodother',
    'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfortfoodother_oth': 'PSchoolAgeDDSFortFoodother_oth'
})

# Calculate food groups
data['PSchoolAgeDDS_Staples_wfp'] = np.where(
    (data['PSchoolAgeDDSStapCer'] == 1) | 
    (data['PSchoolAgeDDSStapRoo'] == 1) | 
    (data['PSchoolAgeDDSFortFoodwflour'] == 1) | 
    (data['PSchoolAgeDDSFortFoodmflour'] == 1) | 
    (data['PSchoolAgeDDSFortFoodrice'] == 1) | 
    (data['PSchoolAgeDDSFortFooddrink'] == 1), 1, 0)

data['PSchoolAgeDDS_Pulses_wfp'] = np.where(data['PSchoolAgeDDSPulse'] == 1, 1, 0)
data['PSchoolAgeDDS_NutsSeeds_wfp'] = np.where(data['PSchoolAgeDDSNuts'] == 1, 1, 0)
data['PSchoolAgeDDS_Dairy_wfp'] = np.where((data['PSchoolAgeDDSDairy'] == 1) | (data['PSchoolAgeDDSMilk'] == 1), 1, 0)
data['PSchoolAgeDDS_MeatFish_wfp'] = np.where(
    (data['PSchoolAgeDDSPrMeatO'] == 1) | 
    (data['PSchoolAgeDDSPrMeatF'] == 1) | 
    (data['PSchoolAgeDDSPrMeatPro'] == 1) | 
    (data['PSchoolAgeDDSPrMeatWhite'] == 1) | 
    (data['PSchoolAgeDDSPrFish'] == 1) | 
    (data['PSchoolAgeDDSSnf'] == 1), 1, 0)

data['PSchoolAgeDDS_Eggs_wfp'] = np.where(data['PSchoolAgeDDSPrEgg'] == 1, 1, 0)
data['PSchoolAgeDDS_LeafGreenVeg_wfp'] = np.where(data['PSchoolAgeDDSVegGre'] == 1, 1, 0)
data['PSchoolAgeDDS_VitA_wfp'] = np.where((data['PSchoolAgeDDSVegOrg'] == 1) | (data['PSchoolAgeDDSFruitOrg'] == 1), 1, 0)
data['PSchoolAgeDDS_OtherVeg_wfp'] = np.where(data['PSchoolAgeDDSVegOth'] == 1, 1, 0)
data['PSchoolAgeDDS_OtherFruits_wfp'] = np.where(data['PSchoolAgeDDSFruitOth'] == 1, 1, 0)

# Calculate food groups
data['PSchoolAgeDDS_Staples_wfp'] = np.where(
    (data['PSchoolAgeDDSStapCer'] == 1) | 
    (data['PSchoolAgeDDSStapRoo'] == 1) | 
    (data['PSchoolAgeDDSFortFoodwflour'] == 1) | 
    (data['PSchoolAgeDDSFortFoodmflour'] == 1) | 
    (data['PSchoolAgeDDSFortFoodrice'] == 1) | 
    (data['PSchoolAgeDDSFortFooddrink'] == 1), 1, 0)

data['PSchoolAgeDDS_Pulses_wfp'] = np.where(data['PSchoolAgeDDSPulse'] == 1, 1, 0)
data['PSchoolAgeDDS_NutsSeeds_wfp'] = np.where(data['PSchoolAgeDDSNuts'] == 1, 1, 0)
data['PSchoolAgeDDS_Dairy_wfp'] = np.where((data['PSchoolAgeDDSDairy'] == 1) | (data['PSchoolAgeDDSMilk'] == 1), 1, 0)
data['PSchoolAgeDDS_MeatFish_wfp'] = np.where(
    (data['PSchoolAgeDDSPrMeatO'] == 1) | 
    (data['PSchoolAgeDDSPrMeatF'] == 1) | 
    (data['PSchoolAgeDDSPrMeatPro'] == 1) | 
    (data['PSchoolAgeDDSPrMeatWhite'] == 1) | 
    (data['PSchoolAgeDDSPrFish'] == 1) | 
    (data['PSchoolAgeDDSSnf'] == 1), 1, 0)

data['PSchoolAgeDDS_Eggs_wfp'] = np.where(data['PSchoolAgeDDSPrEgg'] == 1, 1, 0)
data['PSchoolAgeDDS_LeafGreenVeg_wfp'] = np.where(data['PSchoolAgeDDSVegGre'] == 1, 1, 0)
data['PSchoolAgeDDS_VitA_wfp'] = np.where((data['PSchoolAgeDDSVegOrg'] == 1) | (data['PSchoolAgeDDSFruitOrg'] == 1), 1, 0)
data['PSchoolAgeDDS_OtherVeg_wfp'] = np.where(data['PSchoolAgeDDSVegOth'] == 1, 1, 0)
data['PSchoolAgeDDS_OtherFruits_wfp'] = np.where(data['PSchoolAgeDDSFruitOth'] == 1, 1, 0)

# Calculate Dietary Diversity Score
data['SchoolAgeDDS_wfp'] = data[['PSchoolAgeDDS_Staples_wfp', 'PSchoolAgeDDS_Pulses_wfp', 'PSchoolAgeDDS_NutsSeeds_wfp', 'PSchoolAgeDDS_Dairy_wfp',
                                 'PSchoolAgeDDS_MeatFish_wfp', 'PSchoolAgeDDS_Eggs_wfp', 'PSchoolAgeDDS_LeafGreenVeg_wfp', 'PSchoolAgeDDS_VitA_wfp',
                                 'PSchoolAgeDDS_OtherVeg_wfp', 'PSchoolAgeDDS_OtherFruits_wfp']].sum(axis=1)

# Classify Dietary Diversity Score
data['SchoolAgeDDS_5_wfp'] = np.where(data['SchoolAgeDDS_wfp'] >= 5, '>=5', '<5')

# Create a table of the weighted percentage of WFP MDDW method for program monitoring
SchoolAgeDDS_5_wfp_table_wide = (data['SchoolAgeDDS_5_wfp']
    .value_counts(normalize=True)
    .mul(100)
    .rename_axis('SchoolAgeDDS_5_wfp')
    .reset_index(name='Percentage')
    .pivot(index=None, columns='SchoolAgeDDS_5_wfp', values='Percentage')
    .fillna(0)
)

print(SchoolAgeDDS_5_wfp_table_wide)

# End of Scripts