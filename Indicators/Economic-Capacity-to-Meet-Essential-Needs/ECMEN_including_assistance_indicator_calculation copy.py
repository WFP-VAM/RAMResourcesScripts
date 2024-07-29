#------------------------------------------------------------------------------#
#	                        WFP RAM Standardized Scripts
#                         Calculating and Summarising ECMEN 
#                    (Including Assistance Version - Monitoring)
#------------------------------------------------------------------------------#

# Load Packages --------------------------------------------------------------#

import pandas as pd
import numpy as np

# Load Sample Data ------------------------------------------------------------#

df = pd.read_csv("ECMEN_Sample_Survey.csv")

print(df.columns) # Display var names for the entire data base

# Initialize columns with their respective labels
columns_food = {
    'HHExpFCer_Purch_MN_7D': 'Expenditures on cereals',
    'HHExpFCer_GiftAid_MN_7D': 'Value of consumed in-kind assistance and gifts - cereals',
    'HHExpFCer_Own_MN_7D': 'Value of consumed own production - cereals',
    'HHExpFTub_Purch_MN_7D': 'Expenditures on tubers',
    'HHExpFTub_GiftAid_MN_7D': 'Value of consumed in-kind assistance and gifts - tubers',
    'HHExpFTub_Own_MN_7D': 'Value of consumed own production - tubers',
    'HHExpFPuls_Purch_MN_7D': 'Expenditures on pulses & nuts',
    'HHExpFPuls_GiftAid_MN_7D': 'Value of consumed in-kind assistance and gifts - pulses and nuts',
    'HHExpFPuls_Own_MN_7D': 'Value of consumed own production - pulses & nuts',
    'HHExpFVeg_Purch_MN_7D': 'Expenditures on vegetables',
    'HHExpFVeg_GiftAid_MN_7D': 'Value of consumed in-kind assistance and gifts - vegetables',
    'HHExpFVeg_Own_MN_7D': 'Value of consumed own production - vegetables',
    'HHExpFFrt_Purch_MN_7D': 'Expenditures on fruits',
    'HHExpFFrt_GiftAid_MN_7D': 'Value of consumed in-kind assistance and gifts - fruits',
    'HHExpFFrt_Own_MN_7D': 'Value of consumed own production - fruits',
    'HHExpFAnimMeat_Purch_MN_7D': 'Expenditures on meat',
    'HHExpFAnimMeat_GiftAid_MN_7D': 'Value of consumed in-kind assistance and gifts - meat',
    'HHExpFAnimMeat_Own_MN_7D': 'Value of consumed own production - meat',
    'HHExpFAnimFish_Purch_MN_7D': 'Expenditures on fish',
    'HHExpFAnimFish_GiftAid_MN_7D': 'Value of consumed in-kind assistance and gifts - fish',
    'HHExpFAnimFish_Own_MN_7D': 'Value of consumed own production - fish',
    'HHExpFFats_Purch_MN_7D': 'Expenditures on fats',
    'HHExpFFats_GiftAid_MN_7D': 'Value of consumed in-kind assistance and gifts - fats',
    'HHExpFFats_Own_MN_7D': 'Value of consumed own production - fats',
    'HHExpFDairy_Purch_MN_7D': 'Expenditures on milk/dairy products',
    'HHExpFDairy_GiftAid_MN_7D': 'Value of consumed in-kind assistance and gifts - milk/dairy products',
    'HHExpFDairy_Own_MN_7D': 'Value of consumed own production - milk/dairy products',
    'HHExpFEgg_Purch_MN_7D': 'Expenditures on eggs',
    'HHExpFEgg_GiftAid_MN_7D': 'Value of consumed in-kind assistance and gifts - eggs',
    'HHExpFEgg_Own_MN_7D': 'Value of consumed own production - eggs',
    'HHExpFSgr_Purch_MN_7D': 'Expenditures on sugar/confectionery/desserts',
    'HHExpFSgr_GiftAid_MN_7D': 'Value of consumed in-kind assistance and gifts - sugar/confectionery/desserts',
    'HHExpFSgr_Own_MN_7D': 'Value of consumed own production - sugar/confectionery/desserts',
    'HHExpFCond_Purch_MN_7D': 'Expenditures on condiments',
    'HHExpFCond_GiftAid_MN_7D': 'Value of consumed in-kind assistance and gifts - condiments',
    'HHExpFCond_Own_MN_7D': 'Value of consumed own production - condiments',
    'HHExpFBev_Purch_MN_7D': 'Expenditures on beverages',
    'HHExpFBev_GiftAid_MN_7D': 'Value of consumed in-kind assistance and gifts - beverages',
    'HHExpFBev_Own_MN_7D': 'Value of consumed own production - beverages',
    'HHExpFOut_Purch_MN_7D': 'Expenditures on snacks/meals prepared outside',
    'HHExpFOut_GiftAid_MN_7D': 'Value of consumed in-kind assistance and gifts - snacks/meals prepared outside',
    'HHExpFOut_Own_MN_7D': 'Value of consumed own production - snacks/meals prepared outside'
}

columns_non_food_1m = {
    'HHExpNFHyg_Purch_MN_1M': 'Expenditures on hygiene',
    'HHExpNFHyg_GiftAid_MN_1M': 'Value of consumed in-kind assistance-gifts - hygiene',
    'HHExpNFTransp_Purch_MN_1M': 'Expenditures on transport',
    'HHExpNFTransp_GiftAid_MN_1M': 'Value of consumed in-kind assistance-gifts - transport',
    'HHExpNFFuel_Purch_MN_1M': 'Expenditures on fuel',
    'HHExpNFFuel_GiftAid_MN_1M': 'Value of consumed in-kind assistance-gifts - fuel',
    'HHExpNFWat_Purch_MN_1M': 'Expenditures on water',
    'HHExpNFWat_GiftAid_MN_1M': 'Value of consumed in-kind assistance-gifts - water',
    'HHExpNFElec_Purch_MN_1M': 'Expenditures on electricity',
    'HHExpNFElec_GiftAid_MN_1M': 'Value of consumed in-kind assistance-gifts - electricity',
    'HHExpNFEnerg_Purch_MN_1M': 'Expenditures on energy (not electricity)',
    'HHExpNFEnerg_GiftAid_MN_1M': 'Value of consumed in-kind assistance-gifts - energy (not electricity)',
    'HHExpNFDwelSer_Purch_MN_1M': 'Expenditures on services related to dwelling',
    'HHExpNFDwelSer_GiftAid_MN_1M': 'Value of consumed in-kind assistance-gifts - services related to dwelling',
    'HHExpNFPhone_Purch_MN_1M': 'Expenditures on communication',
    'HHExpNFPhone_GiftAid_MN_1M': 'Value of consumed in-kind assistance-gifts - communication',
    'HHExpNFRecr_Purch_MN_1M': 'Expenditures on recreation',
    'HHExpNFRecr_GiftAid_MN_1M': 'Value of consumed in-kind assistance-gifts - recreation',
    'HHExpNFAlcTobac_Purch_MN_1M': 'Expenditures on alcohol/tobacco',
    'HHExpNFAlcTobac_GiftAid_MN_1M': 'Value of consumed in-kind assistance-gifts - alcohol/tobacco'
}

columns_non_food_6m = {
    'HHExpNFMedServ_Purch_MN_6M': 'Expenditures on health services',
    'HHExpNFMedServ_GiftAid_MN_6M': 'Value of consumed in-kind assistance-gifts - health services',
    'HHExpNFMedGood_Purch_MN_6M': 'Expenditures on medicines and health products',
    'HHExpNFMedGood_GiftAid_MN_6M': 'Value of consumed in-kind assistance-gifts - medicines and health products',
    'HHExpNFCloth_Purch_MN_6M': 'Expenditures on clothing and footwear',
    'HHExpNFCloth_GiftAid_MN_6M': 'Value of consumed in-kind assistance-gifts - clothing and footwear',
    'HHExpNFEduFee_Purch_MN_6M': 'Expenditures on education services',
    'HHExpNFEduFee_GiftAid_MN_6M': 'Value of consumed in-kind assistance-gifts - education services',
    'HHExpNFEduGood_Purch_MN_6M': 'Expenditures on education goods',
    'HHExpNFEduGood_GiftAid_MN_6M': 'Value of consumed in-kind assistance-gifts - education goods',
    'HHExpNFRent_Purch_MN_6M': 'Expenditures on rent',
    'HHExpNFRent_GiftAid_MN_6M': 'Value of consumed in-kind assistance-gifts - rent',
    'HHExpNFHHSoft_Purch_MN_6M': 'Expenditures on household supplies',
    'HHExpNFHHSoft_GiftAid_MN_6M': 'Value of consumed in-kind assistance-gifts - household supplies',
    'HHExpNFHHDur_Purch_MN_6M': 'Expenditures on durable household goods',
    'HHExpNFHHDur_GiftAid_MN_6M': 'Value of consumed in-kind assistance-gifts - durable household goods',
    'HHExpNFHHTrans_Purch_MN_6M': 'Expenditures on household transport',
    'HHExpNFHHTrans_GiftAid_MN_6M': 'Value of consumed in-kind assistance-gifts - household transport',
    'HHExpNFHHComP_Purch_MN_6M': 'Expenditures on household communications and postal services',
    'HHExpNFHHComP_GiftAid_MN_6M': 'Value of consumed in-kind assistance-gifts - household communications and postal services',
    'HHExpNFOthDom_Purch_MN_6M': 'Expenditures on other domestic services',
    'HHExpNFOthDom_GiftAid_MN_6M': 'Value of consumed in-kind assistance-gifts - other domestic services',
    'HHExpNFOthOcc_Purch_MN_6M': 'Expenditures on other occasional expenses',
    'HHExpNFOthOcc_GiftAid_MN_6M': 'Value of consumed in-kind assistance-gifts - other occasional expenses'
}

# Define columns for food and non-food expenditures and consumption by source
columns_f_purch_7d = [
    'HHExpFCer_Purch_MN_7D',
    'HHExpFTub_Purch_MN_7D',
    'HHExpFPuls_Purch_MN_7D',
    'HHExpFVeg_Purch_MN_7D',
    'HHExpFFrt_Purch_MN_7D',
    'HHExpFAnimMeat_Purch_MN_7D',
    'HHExpFAnimFish_Purch_MN_7D',
    'HHExpFFats_Purch_MN_7D',
    'HHExpFDairy_Purch_MN_7D',
    'HHExpFEgg_Purch_MN_7D',
    'HHExpFSgr_Purch_MN_7D',
    'HHExpFCond_Purch_MN_7D',
    'HHExpFBev_Purch_MN_7D',
    'HHExpFOut_Purch_MN_7D',
]

columns_f_giftaid_7d = [
    'HHExpFCer_GiftAid_MN_7D',
    'HHExpFTub_GiftAid_MN_7D',
    'HHExpFPuls_GiftAid_MN_7D',
    'HHExpFVeg_GiftAid_MN_7D',
    'HHExpFFrt_GiftAid_MN_7D',
    'HHExpFAnimMeat_GiftAid_MN_7D',
    'HHExpFAnimFish_GiftAid_MN_7D',
    'HHExpFFats_GiftAid_MN_7D',
    'HHExpFDairy_GiftAid_MN_7D',
    'HHExpFEgg_GiftAid_MN_7D',
    'HHExpFSgr_GiftAid_MN_7D',
    'HHExpFCond_GiftAid_MN_7D',
    'HHExpFBev_GiftAid_MN_7D',
    'HHExpFOut_GiftAid_MN_7D',
]

columns_f_own_7d = [
    'HHExpFCer_Own_MN_7D',
    'HHExpFTub_Own_MN_7D',
    'HHExpFPuls_Own_MN_7D',
    'HHExpFVeg_Own_MN_7D',
    'HHExpFFrt_Own_MN_7D',
    'HHExpFAnimMeat_Own_MN_7D',
    'HHExpFAnimFish_Own_MN_7D',
    'HHExpFFats_Own_MN_7D',
    'HHExpFDairy_Own_MN_7D',
    'HHExpFEgg_Own_MN_7D',
    'HHExpFSgr_Own_MN_7D',
    'HHExpFCond_Own_MN_7D',
    'HHExpFBev_Own_MN_7D',
    'HHExpFOut_Own_MN_7D',
]

columns_nf_purch_30d = [
    'HHExpNFHyg_Purch_MN_1M',
    'HHExpNFTransp_Purch_MN_1M',
    'HHExpNFFuel_Purch_MN_1M',
    'HHExpNFWat_Purch_MN_1M',
    'HHExpNFElec_Purch_MN_1M',
    'HHExpNFEnerg_Purch_MN_1M',
    'HHExpNFDwelSer_Purch_MN_1M',
    'HHExpNFPhone_Purch_MN_1M',
    'HHExpNFRecr_Purch_MN_1M',
    'HHExpNFAlcTobac_Purch_MN_1M'
]

columns_nf_purch_6m = [
    'HHExpNFMedServ_Purch_MN_6M',
    'HHExpNFMedGood_Purch_MN_6M',
    'HHExpNFCloth_Purch_MN_6M',
    'HHExpNFEduFee_Purch_MN_6M',
    'HHExpNFEduGood_Purch_MN_6M',
    'HHExpNFRent_Purch_MN_6M',
    'HHExpNFHHSoft_Purch_MN_6M', 
    'HHExpNFHHMaint_Purch_MN_6M'
]

columns_nf_giftaid_30d = [
    'HHExpNFHyg_GiftAid_MN_1M', 
    'HHExpNFTransp_GiftAid_MN_1M',
    'HHExpNFFuel_GiftAid_MN_1M',
    'HHExpNFWat_GiftAid_MN_1M',
    'HHExpNFElec_GiftAid_MN_1M',
    'HHExpNFEnerg_GiftAid_MN_1M',
    'HHExpNFDwelSer_GiftAid_MN_1M',
    'HHExpNFPhone_GiftAid_MN_1M',
    'HHExpNFRecr_GiftAid_MN_1M',
    'HHExpNFAlcTobac_GiftAid_MN_1M'
]

columns_nf_giftaid_6m = [
    'HHExpNFMedServ_GiftAid_MN_6M',
    'HHExpNFMedGood_GiftAid_MN_6M',
    'HHExpNFCloth_GiftAid_MN_6M',
    'HHExpNFEduFee_GiftAid_MN_6M',
    'HHExpNFEduGood_GiftAid_MN_6M',
    'HHExpNFRent_GiftAid_MN_6M',
    'HHExpNFHHSoft_GiftAid_MN_6M',
    'HHExpNFHHMaint_GiftAid_MN_6M'
]

# _____________________________ FOOD - Last 7 days ______________________________________

# _______ FOOD (cash/credit) _______
# Calculate monthly food expenditure (cash/credit)
df['HHExp_Food_Purch_MN_1M'] = df[columns_f_purch_7d].sum(axis=1) # Sum purchases of all food groups in the last 7 days
df['HHExp_Food_Purch_MN_1M'] = df['HHExp_Food_Purch_MN_1M'] / 7 * 30 # Express 30 days in monthly terms

# _______ FOOD (gift/aid) _______
# Calculate monthly food expenditure (gift/aid)
df['HHExp_Food_GiftAid_MN_1M'] = df[columns_f_giftaid_7d].sum(axis=1) # Sum consumption of gift/aid for all food groups in the last 7 days
df['HHExp_Food_GiftAid_MN_1M'] = df['HHExp_Food_GiftAid_MN_1M'] / 7 * 30 # Express 30 days in monthly terms

# _______ FOOD (own-production) _______
# Calculate monthly food expenditure (onw-production)
df['HHExp_Food_Own_MN_1M'] = df[columns_f_own_7d].sum(axis=1) # Sum consumption of own-production for all food groups in the last 7 days
df['HHExp_Food_Own_MN_1M'] = df['HHExp_Food_Own_MN_1M'] / 7 * 30 # Express 30 days in monthly terms

# _______ FOOD (all sources) _______
# Calculate total monthly food expenditure (cash/credit & gift/aid & own-production)
df['HHExpF_1M'] = df[['HHExp_Food_Purch_MN_1M', 'HHExp_Food_GiftAid_MN_1M', 'HHExp_Food_Own_MN_1M']].sum(axis=1)

# _____________________________ NON FOOD - Last 30 days & Last 6 months ______________________________________

# _______ NON-FOOD (cash/credit) _______
# Calculate monthly non-food expenditure (cash/credit)
df['HHExpNFTotal_Purch_MN_30D'] = df[columns_nf_purch_30d].sum(axis=1) # Sum purchases of all food groups in the last 30 days
df['HHExpNFTotal_Purch_MN_6M'] = df[columns_nf_purch_6m].sum(axis=1) # Sum purchases of all food groups in the last 6 months
df['HHExpNFTotal_Purch_MN_6M'] = df['HHExpNFTotal_Purch_MN_6M'] / 6  # Express 6 months in monthly terms
df['HHExpNFTotal_Purch_MN_1M'] = df['HHExpNFTotal_Purch_MN_30D'] + df['HHExpNFTotal_Purch_MN_6M'] # Sum purchases of all non-food groups

# _______ NON-FOOD (gift/aid) _______
# Calculate monthly non-food expenditure (gift/aid)
# Note: Remember that for the version of ECMEN used for monitoring (including assistance),
# the value of consumed in-kind assistance and gifts should be included in the household economic capacity aggregate.
df['HHExpNFTotal_GiftAid_MN_30D'] = df[columns_nf_giftaid_30d].sum(axis=1) # Sum consumption of gift/aid of all food groups in the last 30 days
df['HHExpNFTotal_GiftAid_MN_6M'] = df[columns_nf_giftaid_6m].sum(axis=1) # Sum consumption of gift/aid of all food groups in the last 6 months
df['HHExpNFTotal_GiftAid_MN_6M'] = df['HHExpNFTotal_GiftAid_MN_6M'] / 6  # Express 6 months in monthly terms
df['HHExpNFTotal_GiftAid_MN_1M'] = df['HHExpNFTotal_GiftAid_MN_30D'] + df['HHExpNFTotal_GiftAid_MN_6M'] # Sum consumption of gift/aid of all non-food groups

# _______ NON-FOOD (all sources) _______
# Calculate total monthly non-food expenditure (cash/credit & gift/aid)
df['HHExpNF_1M'] = df['HHExpNFTotal_Purch_MN_1M'] + df['HHExpNFTotal_GiftAid_MN_1M']

# _____________________________ ECONOMIC CAPACITY ______________________________________
# Aggregate food expenditures, value of consumed food from gift/aid, and value of consumed food from own production
df['HHExpF_ECMEN'] = df[['HHExp_Food_Purch_MN_1M', 'HHExpNFTotal_GiftAid_MN_1M', 'HHExp_Food_Own_MN_1M']].sum(axis=1)

# Aggregate non-food expenditures and value of consumed non-food from gift/aid
df['HHExpNF_ECMEN'] = df['HHExpNFTotal_Purch_MN_1M'] + df['HHExpNFTotal_GiftAid_MN_1M']

# Aggregate food and non-food
df['HHExp_ECMEN'] = df[['HHExpF_ECMEN', 'HHExpNF_ECMEN']].sum(axis=1)

# 5. Express household economic capacity in per capita terms
df['PCExp_ECMEN'] = df['HHExp_ECMEN'] / df['HHSize']

# _____________________________ CALCULATE ECMEN ______________________________________
# Using MEB
# Define Dummy MEB
df['MEB'] = 3000

# Define variable indicating if PC Household Economic Capacity is equal or greater than MEB
df['ECMEN_inclAsst'] = df['PCExp_ECMEN'] > df['MEB']

# Using SMEB (when applicable)
# Define Dummy SMEB
df['SMEB'] = 1200

# Define variable indicating if PC Household Economic Capacity is equal or greater than SMEB
df['ECMEN_inclAsst_SMEB'] = df['PCExp_ECMEN'] > df['SMEB']

# _____________________________ LABEL VARIABLES (IF NEEDED) ______________________________________
df['ECMEN_inclAsst'] = df['ECMEN_inclAsst'].map({True: 'Above MEB', False: 'Below MEB'})
df['ECMEN_inclAsst_SMEB'] = df['ECMEN_inclAsst_SMEB'].map({True: 'Above SMEB', False: 'Below SMEB'})
df['HHExp_ECMEN'].rename("Household Economic Capacity - monthly", inplace=True)
df['PCExp_ECMEN'].rename("Household Economic Capacity per capita - monthly", inplace=True)
df['ECMEN_inclAsst'].rename("Economic capacity to meet essential needs - including assistance", inplace=True)
df['ECMEN_inclAsst_SMEB'].rename("Economic capacity to meet essential needs (Usin SMEB) - including assistance", inplace=True)