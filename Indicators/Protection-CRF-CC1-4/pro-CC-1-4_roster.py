#------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#       Disability Status and Assistance Received (Roster Method)
#------------------------------------------------------------------------------
#
# Note: This script is based on the assumption that the dataset has already 
# been imported and includes variables related to disability status and 
# assistance received.
#
# The following variables should have been defined before running this script:
# - TechnicalAdd_submodule/HHAsstWFPRecCashYN1Y
# - TechnicalAdd_submodule/HHAsstWFPRecInKindYN1Y
# - TechnicalAdd_submodule/HHAsstWFPRecCapBuildYN1Y
# - Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers
#------------------------------------------------------------------------------

import pandas as pd

# Add sample data
data  = pd.read_csv("GitHub/RAMResourcesScripts/Static/PRO_WG_Sample_Survey/RosterMethod/Demographic_module_DisabilityHHMemb_submodule_RepeatDisabHHMembers.csv")
data2 = pd.read_csv("GitHub/RAMResourcesScripts/Static/PRO_WG_Sample_Survey/RosterMethod/data.csv")

# Rename to remove group names
data2 = data2.rename(columns={
    'TechnicalAdd_submodule/HHAsstWFPRecCashYN1Y': 'HHAsstWFPRecCashYN1Y',
    'TechnicalAdd_submodule/HHAsstWFPRecInKindYN1Y': 'HHAsstWFPRecInKindYN1Y',
    'TechnicalAdd_submodule/HHAsstWFPRecCapBuildYN1Y': 'HHAsstWFPRecCapBuildYN1Y',
    '_index': 'index'
})

data = data.rename(columns={
    'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabAge': 'PDisabAge',
    'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabSex': 'PDisabSex',
    'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabSee': 'PDisabSee',
    'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabHear': 'PDisabHear',
    'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabWalk': 'PDisabWalk',
    'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabRemember': 'PDisabRemember',
    'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabUnderstand': 'PDisabUnderstand',
    'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabWash': 'PDisabWash',
    '_parent_index': 'index'
})

# Join dataset "data" & "data2"
data = data.merge(data2, on='index')

# Assign variable and value labels (metadata)
var_labels = {
    'HHAsstWFPRecCashYN1Y': "Did your household receive cash-based WFP assistance in the last 12 months?",
    'HHAsstWFPRecInKindYN1Y': "Did your household receive in-kind WFP assistance in the last 12 months?",
    'HHAsstWFPRecCapBuildYN1Y': "Did you household receive WFP capacity building assistance in the last 12 months?",
    'PDisabAge': "What is the age of ${PDisabName}?",
    'PDisabSex': "What is the sex of ${PDisabName}?",
    'PDisabSee': "Does ${PDisabName} have difficulty seeing, even if wearing glasses? Would you say…",
    'PDisabHear': "Does ${PDisabName} have difficulty hearing, even if using a hearing aid(s)? Would you say…",
    'PDisabWalk': "Does ${PDisabName} have difficulty walking or climbing steps? Would you say…",
    'PDisabRemember': "Does ${PDisabName} have difficulty remembering or concentrating? Would you say…",
    'PDisabUnderstand': "Using your usual language, does ${PDisabName} have difficulty communicating, for example understanding or being understood? Would you say…",
    'PDisabWash': "Does ${PDisabName} have difficulty with self-care, such as washing all over or dressing? Would you say…"
}

value_labels = {
    'HHAsstWFPRecCashYN1Y': {0: 'No', 1: 'Yes'},
    'HHAsstWFPRecInKindYN1Y': {0: 'No', 1: 'Yes'},
    'HHAsstWFPRecCapBuildYN1Y': {0: 'No', 1: 'Yes'},
    'PDisabSex': {0: 'Female', 1: 'Male'},
    'PDisabSee': {1: 'No difficulty', 2: 'Some difficulty', 3: 'A lot of difficulty', 4: 'Cannot do at all', 888: "Don't know", 999: 'Refuse'},
    'PDisabHear': {1: 'No difficulty', 2: 'Some difficulty', 3: 'A lot of difficulty', 4: 'Cannot do at all', 888: "Don't know", 999: 'Refuse'},
    'PDisabWalk': {1: 'No difficulty', 2: 'Some difficulty', 3: 'A lot of difficulty', 4: 'Cannot do at all', 888: "Don't know", 999: 'Refuse'},
    'PDisabRemember': {1: 'No difficulty', 2: 'Some difficulty', 3: 'A lot of difficulty', 4: 'Cannot do at all', 888: "Don't know", 999: 'Refuse'},
    'PDisabUnderstand': {1: 'No difficulty', 2: 'Some difficulty', 3: 'A lot of difficulty', 4: 'Cannot do at all', 888: "Don't know", 999: 'Refuse'},
    'PDisabWash': {1: 'No difficulty', 2: 'Some difficulty', 3: 'A lot of difficulty', 4: 'Cannot do at all', 888: "Don't know", 999: 'Refuse'}
}

# Apply variable labels
data = data.rename(columns=var_labels)

# Apply value labels
for column, labels in value_labels.items():
    data[column] = data[column].map(labels)

# Calculate whether the respondent had "A lot of difficulty" or "Cannot do at all" for any of the 6 questions
data['PDisabCat3'] = data[['PDisabSee', 'PDisabHear', 'PDisabWalk', 'PDisabRemember', 'PDisabUnderstand', 'PDisabWash']].apply(lambda x: any(i in [3, 4] for i in x), axis=1).astype(int)

data['PDisabCat3'] = data['PDisabCat3'].map({0: 'without disability (category 3 criteria)', 1: 'with disability (category 3 criteria)'})

# Create tables of the percentage of type of assistance received by PDisabCat3

# Cash
HHAsstWFPRecCashYN1Y_table_wide = data.groupby('PDisabCat3')['HHAsstWFPRecCashYN1Y'].value_counts(normalize=True).unstack().fillna(0) * 100

# In-kind
HHAsstWFPRecInKindYN1Y_table_wide = data.groupby('PDisabCat3')['HHAsstWFPRecInKindYN1Y'].value_counts(normalize=True).unstack().fillna(0) * 100

# Capacity building
HHAsstWFPRecCapBuildYN1Y_table_wide = data.groupby('PDisabCat3')['HHAsstWFPRecCapBuildYN1Y'].value_counts(normalize=True).unstack().fillna(0) * 100

print("Cash assistance table:\n", HHAsstWFPRecCashYN1Y_table_wide)
print("\nIn-kind assistance table:\n", HHAsstWFPRecInKindYN1Y_table_wide)
print("\nCapacity building assistance table:\n", HHAsstWFPRecCapBuildYN1Y_table_wide)

# Eng of Scripts