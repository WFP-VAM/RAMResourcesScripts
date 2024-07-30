#------------------------------------------------------------------------------#
#	                          WFP Standardized Scripts
#                     Calculating Gender Decision Making Indicator (genC31)
#------------------------------------------------------------------------------#

# This script calculates the Gender Decision Making Indicator (genC31) based on 
# household responses about who decides what to do with cash/voucher and in-kind 
# assistance provided by WFP. It sets missing values, labels variables, and generates 
# frequency tables.

# Load Packages
import pandas as pd

# Import dataset
#data = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/Gender_CRF_C31_Sample_Survey.csv")

# Assign variable and value labels
data = data.rename(columns={
    'HHAsstWFPRecCashYN1Y': 'Did your household receive cash-based WFP assistance in the last 12 months?',
    'HHAsstWFPRecInKindYN1Y': 'Did your household receive in-kind WFP assistance in the last 12 months?',
    'HHAsstCashDescWho': 'Who in your household decides what to do with the cash/voucher given by WFP, such as when, where and what to buy, is it women, men or both?',
    'HHAsstInKindDescWho': 'Who in your household decides what to do with the food given by WFP, such as when, where and what to buy, is it women, men or both?'
})

# Define value labels
value_labels_yesno = {
    0: "No",
    1: "Yes"
}

value_labels_who = {
    10: "Men",
    20: "Women",
    30: "Both together",
    "n/a": "Not Applicable"
}

data['Did your household receive cash-based WFP assistance in the last 12 months?'] = data['Did your household receive cash-based WFP assistance in the last 12 months?'].map(value_labels_yesno)
data['Did your household receive in-kind WFP assistance in the last 12 months?'] = data['Did your household receive in-kind WFP assistance in the last 12 months?'].map(value_labels_yesno)
data['Who in your household decides what to do with the cash/voucher given by WFP, such as when, where and what to buy, is it women, men or both?'] = data['Who in your household decides what to do with the cash/voucher given by WFP, such as when, where and what to buy, is it women, men or both?'].map(value_labels_who)
data['Who in your household decides what to do with the food given by WFP, such as when, where and what to buy, is it women, men or both?'] = data['Who in your household decides what to do with the food given by WFP, such as when, where and what to buy, is it women, men or both?'].map(value_labels_who)

# Set n/a value to missing
data = data.replace("n/a", pd.NA)

# Frequency of 2 questions to determine who makes decisions per type of assistance
decision_cash = data['Who in your household decides what to do with the cash/voucher given by WFP, such as when, where and what to buy, is it women, men or both?'].value_counts(normalize=True) * 100
decision_inkind = data['Who in your household decides what to do with the food given by WFP, such as when, where and what to buy, is it women, men or both?'].value_counts(normalize=True) * 100

print(decision_cash)
print(decision_inkind)

# End of Scripts