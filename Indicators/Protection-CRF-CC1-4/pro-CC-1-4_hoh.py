#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#                    Household Level Assistance (hoh)
#------------------------------------------------------------------------------#

# This script processes the indicators related to the receipt of different types 
# of assistance by households and the disability status of the head of the household.

import pandas as pd
import numpy as np

# Add sample data
#data = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/PRO_WG_Sample_Survey/HoHMethod/PRO_WG_HoH_Sample_Survey.csv")

# Assign variable and value labels
data = data.rename(columns={
    "HHAsstWFPRecCashYN1Y": "Did your household receive cash-based WFP assistance in the last 12 months?",
    "HHAsstWFPRecInKindYN1Y": "Did your household receive in-kind WFP assistance in the last 12 months?",
    "HHAsstWFPRecCapBuildYN1Y": "Did you household receive WFP capacity building assistance in the last 12 months?",
    "HHHSex": "What is the sex of the head of the household?",
    "HHHAge": "Age of the head of the household",
    "HHHDisabSee": "Does the head of household have difficulty seeing, even if wearing glasses? Would you say…",
    "HHHDisabHear": "Does the head of household have difficulty hearing, even if using a hearing aid(s)? Would you say…",
    "HHHDisabWalk": "Does the head of household have difficulty walking or climbing steps? Would you say…",
    "HHHDisabRemember": "Does the head of household have difficulty remembering or concentrating? Would you say…",
    "HHHDisabUnderstand": "Using his or her usual language, does the head of household have difficulty communicating, for example understanding or being understood? Would you say…",
    "HHHDisabWash": "Does the head of household have difficulty with self-care, such as washing all over or dressing? Would you say…"
})

data["HHAsstWFPRecCashYN1Y"] = data["HHAsstWFPRecCashYN1Y"].replace({0: "No", 1: "Yes"})
data["HHAsstWFPRecInKindYN1Y"] = data["HHAsstWFPRecInKindYN1Y"].replace({0: "No", 1: "Yes"})
data["HHAsstWFPRecCapBuildYN1Y"] = data["HHAsstWFPRecCapBuildYN1Y"].replace({0: "No", 1: "Yes"})
data["HHHSex"] = data["HHHSex"].replace({0: "Female", 1: "Male"})
difficulty_labels = {1: "No difficulty", 2: "Some difficulty", 3: "A lot of difficulty", 4: "Cannot do at all", 888: "Don't know", 999: "Refuse"}
data["HHHDisabSee"] = data["HHHDisabSee"].replace(difficulty_labels)
data["HHHDisabHear"] = data["HHHDisabHear"].replace(difficulty_labels)
data["HHHDisabWalk"] = data["HHHDisabWalk"].replace(difficulty_labels)
data["HHHDisabRemember"] = data["HHHDisabRemember"].replace(difficulty_labels)
data["HHHDisabUnderstand"] = data["HHHDisabUnderstand"].replace(difficulty_labels)
data["HHHDisabWash"] = data["HHHDisabWash"].replace(difficulty_labels)

# Calculate whether the respondent had "A lot of difficulty" or "Cannot do at all" for any of the 6 questions
data["HHHDisabCat3"] = np.where(data[["HHHDisabSee", "HHHDisabHear", "HHHDisabWalk", "HHHDisabRemember", "HHHDisabUnderstand", "HHHDisabWash"]].apply(lambda x: x.isin(["A lot of difficulty", "Cannot do at all"]).any(), axis=1), "with disability (category 3 criteria)", "without disability (category 3 criteria)")

# Create tables of the weighted percentage of type of assistance received by HHHDisabCat3
# Cash-based assistance
cash_table = pd.crosstab(data["HHAsstWFPRecCashYN1Y"], data["HHHDisabCat3"], normalize='columns') * 100

# In-kind assistance
inkind_table = pd.crosstab(data["HHAsstWFPRecInKindYN1Y"], data["HHHDisabCat3"], normalize='columns') * 100

# Capacity building assistance
capacity_building_table = pd.crosstab(data["HHAsstWFPRecCapBuildYN1Y"], data["HHHDisabCat3"], normalize='columns') * 100

# Display results
print("Cash-based assistance table:\n", cash_table)
print("\nIn-kind assistance table:\n", inkind_table)
print("\nCapacity building assistance table:\n", capacity_building_table)

# End of Scripts.