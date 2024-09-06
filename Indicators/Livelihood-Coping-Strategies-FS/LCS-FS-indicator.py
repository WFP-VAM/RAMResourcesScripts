#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#          Calculating Livelihood Coping Strategy for Food Security (LCS-FS)
#------------------------------------------------------------------------------#

# This script calculates the Livelihood Coping Strategy for Food Security (LCS-FS) 
# indicator based on household responses to various coping strategies. The indicator 
# considers stress, crisis, and emergency strategies and summarizes coping behavior.

# Important note: this script is only an example. When calculating the indicator, 
# you will need to include the 10 strategies (4 stress, 3 crisis, 3 emergency) that 
# were selected for your specific case.

# Please find more guidance on the indicator at the LCS-FS VAM Resource Center page: 
# https://resources.vam.wfp.org/data-analysis/quantitative/food-security/livelihood-coping-strategies-food-security

import pandas as pd

# Load data
data = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/LCS_FS_Sample_Survey.csv")

# Assign variable labels
variable_labels = {
    'Lcs_stress_DomAsset': "Sold household assets/goods (radio, furniture, refrigerator, television, jewellery, etc.)",
    'Lcs_stress_Utilities': "Reduced or ceased payments on essential utilities and bills",
    'Lcs_stress_Saving': "Spent savings",
    'Lcs_stress_BorrowCash': "Borrowed cash",
    'Lcs_crisis_ProdAssets': "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.)",
    'Lcs_crisis_Health': "Reduced expenses on health (including drugs)",
    'Lcs_crisis_OutSchool': "Withdrew children from school",
    'Lcs_em_ResAsset': "Mortgaged/Sold house or land",
    'Lcs_em_Begged': "Begged and/or scavenged (asked strangers for money/food/other goods)",
    'Lcs_em_IllegalAct': "Had to engage in illegal income activities (theft, prostitution)"
}

# Assign value labels
value_labels = {
    10: "No, because we did not need to",
    20: "No, because we already sold those assets or have engaged in this activity within the last 12 months and cannot continue to do it",
    30: "Yes",
    9999: "Not applicable (don’t have access to this strategy)"
}

# Function to label values
def label_values(series, labels):
    return series.map(labels)

for col in variable_labels.keys():
    data[col] = label_values(data[col], value_labels)

# Check for missing values
missing_values = data.isnull().sum()
print(missing_values)

# Stress strategies
data['stress_coping_FS'] = data.apply(
    lambda row: 1 if any(row[col] in [20, 30] for col in ['Lcs_stress_DomAsset', 'Lcs_stress_Utilities', 'Lcs_stress_Saving', 'Lcs_stress_BorrowCash']) else 0,
    axis=1
)

# Crisis strategies
data['crisis_coping_FS'] = data.apply(
    lambda row: 1 if any(row[col] in [20, 30] for col in ['Lcs_crisis_ProdAssets', 'Lcs_crisis_Health', 'Lcs_crisis_OutSchool']) else 0,
    axis=1
)

# Emergency strategies
data['emergency_coping_FS'] = data.apply(
    lambda row: 1 if any(row[col] in [20, 30] for col in ['Lcs_em_ResAsset', 'Lcs_em_Begged', 'Lcs_em_IllegalAct']) else 0,
    axis=1
)

# Coping behavior
data['temp_nonmiss_number'] = data.apply(
    lambda row: row[['Lcs_stress_DomAsset', 'Lcs_stress_Utilities', 'Lcs_stress_Saving', 'Lcs_stress_BorrowCash', 
                     'Lcs_crisis_ProdAssets', 'Lcs_crisis_Health', 'Lcs_crisis_OutSchool', 
                     'Lcs_em_ResAsset', 'Lcs_em_Begged', 'Lcs_em_IllegalAct']].notnull().sum(), axis=1
)

data['Max_coping_behaviourFS'] = data.apply(
    lambda row: 4 if row['emergency_coping_FS'] == 1 else (
                3 if row['crisis_coping_FS'] == 1 else (
                2 if row['stress_coping_FS'] == 1 else (
                1 if row['temp_nonmiss_number'] > 0 else None))),
    axis=1
)

# Remove temporary variable
data.drop(columns=['temp_nonmiss_number'], inplace=True)

# Tabulate results
max_coping_behaviourFS_table = data['Max_coping_behaviourFS'].value_counts().sort_index()
print(max_coping_behaviourFS_table)

# End of Scripts