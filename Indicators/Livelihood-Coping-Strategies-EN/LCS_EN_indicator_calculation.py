#------------------------------------------------------------------------------#
#	                          WFP Standardized Scripts
#              Calculating Livelihood Coping Strategy for Food Security (LCS-EN)
#------------------------------------------------------------------------------#

# This script calculates the Livelihood Coping Strategy for Food Security (LCS-EN) 
# indicator based on household responses to various coping strategies. The indicator 
# considers stress, crisis, and emergency strategies and summarizes coping behavior.

# Important note: this script is only an example. When calculating the indicator, 
# you will need to include the 10 strategies (4 stress, 3 crisis, 3 emergency) that 
# were selected for your specific case.

# Please find more guidance on the indicator at the LCS-EN VAM Resource Center page: 
# https://resources.vam.wfp.org/data-analysis/quantitative/essential-needs/livelihood-coping-strategies-essential-needs

import pandas as pd

# Load data
#data = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/LCS_EN_Sample_Survey.csv")

# Assign variable and value labels
var_labels = {
    'LcsEN_stress_DomAsset': "Sold household assets/goods (radio, furniture, refrigerator, television, jewellery, etc.)",
    'LcsEN_stress_Utilities': "Reduced or ceased payments on essential utilities and bills",
    'LcsEN_stress_Saving': "Spent savings",
    'LcsEN_stress_BorrowCash': "Borrowed cash",
    'LcsEN_crisis_ProdAssets': "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.)",
    'LcsEN_crisis_Health': "Reduced expenses on health (including drugs)",
    'LcsEN_crisis_OutSchool': "Withdrew children from school",
    'LcsEN_em_ResAsset': "Mortgaged/Sold house or land",
    'LcsEN_em_Begged': "Begged and/or scavenged (asked strangers for money/food/other goods)",
    'LcsEN_em_IllegalAct': "Had to engage in illegal income activities (theft, prostitution)"
}

for var, label in var_labels.items():
    data[var] = data[var].astype('category')
    data[var].cat.rename_categories({
        10: "No, because we did not need to",
        20: "No, because we already sold those assets or have engaged in this activity within the last 12 months and cannot continue to do it",
        30: "Yes",
        9999: "Not applicable (don’t have access to this strategy)"
    }, inplace=True)
    data[var].cat.rename_categories(label, inplace=True)

# Treatment of missing values
missing_values = data.isna().sum()
print(missing_values)

# Custom handling for missing values can be added here if required

# Stress strategies
data['stress_coping_EN'] = ((data['LcsEN_stress_DomAsset'].isin([20, 30])) |
                            (data['LcsEN_stress_Utilities'].isin([20, 30])) |
                            (data['LcsEN_stress_Saving'].isin([20, 30])) |
                            (data['LcsEN_stress_BorrowCash'].isin([20, 30]))).astype(int)

data['stress_coping_EN'].cat.rename_categories("Did the HH engage in stress coping strategies?", inplace=True)

# Crisis strategies
data['crisis_coping_EN'] = ((data['LcsEN_crisis_ProdAssets'].isin([20, 30])) |
                            (data['LcsEN_crisis_Health'].isin([20, 30])) |
                            (data['LcsEN_crisis_OutSchool'].isin([20, 30]))).astype(int)

data['crisis_coping_EN'].cat.rename_categories("Did the HH engage in crisis coping strategies?", inplace=True)

# Emergency strategies
data['emergency_coping_EN'] = ((data['LcsEN_em_ResAsset'].isin([20, 30])) |
                               (data['LcsEN_em_Begged'].isin([20, 30])) |
                               (data['LcsEN_em_IllegalAct'].isin([20, 30]))).astype(int)

data['emergency_coping_EN'].cat.rename_categories("Did the HH engage in emergency coping strategies?", inplace=True)

# Coping behavior
data['temp_nonmiss_number'] = data[['LcsEN_stress_DomAsset', 'LcsEN_stress_Utilities', 'LcsEN_stress_Saving', 
                                    'LcsEN_stress_BorrowCash', 'LcsEN_crisis_ProdAssets', 'LcsEN_crisis_Health', 
                                    'LcsEN_crisis_OutSchool', 'LcsEN_em_ResAsset', 'LcsEN_em_Begged', 'LcsEN_em_IllegalAct']].notna().sum(axis=1)

data['max_coping_behaviourEN'] = 1
data.loc[data['stress_coping_EN'] == 1, 'max_coping_behaviourEN'] = 2
data.loc[data['crisis_coping_EN'] == 1, 'max_coping_behaviourEN'] = 3
data.loc[data['emergency_coping_EN'] == 1, 'max_coping_behaviourEN'] = 4

data['max_coping_behaviourEN'] = data['max_coping_behaviourEN'].astype('category')
data['max_coping_behaviourEN'].cat.rename_categories({
    1: "HH not adopting coping strategies",
    2: "Stress coping strategies",
    3: "Crisis coping strategies",
    4: "Emergency coping strategies"
}, inplace=True)

# Remove temporary variables
data.drop(columns=['temp_nonmiss_number'], inplace=True)

# Analyze reasons for adopting strategies
data.rename(columns={
    'LhCSIEnAccess.1': 'LhCSIEnAccess1',
    'LhCSIEnAccess.2': 'LhCSIEnAccess2',
    'LhCSIEnAccess.3': 'LhCSIEnAccess3',
    'LhCSIEnAccess.4': 'LhCSIEnAccess4',
    'LhCSIEnAccess.5': 'LhCSIEnAccess5',
    'LhCSIEnAccess.6': 'LhCSIEnAccess6',
    'LhCSIEnAccess.7': 'LhCSIEnAccess7',
    'LhCSIEnAccess.8': 'LhCSIEnAccess8',
    'LhCSIEnAccess.999': 'LhCSIEnAccess999'
}, inplace=True)

reason_labels = {
    'LhCSIEnAccess1': "Adopted strategies to buy food",
    'LhCSIEnAccess2': "Adopted strategies to pay for rent",
    'LhCSIEnAccess3': "Adopted strategies to pay school, education costs",
    'LhCSIEnAccess4': "Adopted strategies to cover health expenses",
    'LhCSIEnAccess5': "Adopted strategies to buy essential non-food items (clothes, small furniture)",
    'LhCSIEnAccess6': "Adopted strategies to access water or sanitation facilities",
    'LhCSIEnAccess7': "Adopted strategies to access essential dwelling services (electricity, energy, waste disposal...)",
    'LhCSIEnAccess8': "Adopted strategies to pay for existing debts",
    'LhCSIEnAccess999': "Adopted strategies for other reasons"
}

for var, label in reason_labels.items():
    data[var] = data[var].astype('category')
    data[var].cat.rename_categories(label, inplace=True)

desc_stats = data[[
    'LhCSIEnAccess1', 'LhCSIEnAccess2', 'LhCSIEnAccess3', 'LhCSIEnAccess4', 
    'LhCSIEnAccess5', 'LhCSIEnAccess6', 'LhCSIEnAccess7', 'LhCSIEnAccess8', 
    'LhCSIEnAccess999'
]].mean()

print(desc_stats)

# Calculating LCS-FS using the LCS-EN module
data['max_coping_behaviourFS'] = data['max_coping_behaviourEN']
data.loc[data['LhCSIEnAccess1'] == 0, 'max_coping_behaviourFS'] = 1

data['max_coping_behaviourFS'] = data['max_coping_behaviourFS'].astype('category')
data['max_coping_behaviourFS'].cat.rename_categories({
    1: "Summary of asset depletion (converted from EN to FS)"
}, inplace=True)

# End of Scripts