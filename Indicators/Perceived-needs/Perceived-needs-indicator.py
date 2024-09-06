# ------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#                     Perceived Needs Indicators Calculation
# ------------------------------------------------------------------------------

# NOTE: This script assumes the use of all the questions included in the standard module.
# If any question is dropped, the corresponding variable names should be deleted from the script.

# Import sample dataset
# The sample data on which this script is based can be found here: 
# https://github.com/WFP-VAM/RAMResourcesScripts/tree/main/Static

# For more information on the Perceived Needs Indicators (including module), 
# see the VAM Resource Center: https://resources.vam.wfp.org/data-analysis/quantitative/essential-needs/perceived-needs-indicators

# ------------------------------------------------------------------------------#
# Open dataset
# ------------------------------------------------------------------------------#

import pandas as pd
import numpy as np

# Import dataset
data = pd.read_csv("path/to/Perceived_Needs.csv")

# ------------------------------------------------------------------------------#
# Labels
# ------------------------------------------------------------------------------#

# Assign variable labels
variable_labels = {
    'HHPercNeedWater': "Not enough water that is safe for drinking or cooking",
    'HHPercNeedFood': "Not enough food, or good enough food, or not able to cook food",
    'HHPercNeedHousing': "No suitable place to live in",
    'HHPercNeedToilet': "No easy and safe access to a clean toilet",
    'HHPercNeedHygiene': "Not enough soap, sanitary materials, water or a suitable place to wash",
    'HHPercNeedClothTex': "Not enough or good enough, clothes, shoes, bedding or blankets",
    'HHPercNeedLivelihood': "Not enough income, money or resources to live",
    'HHPercNeedDisabIll': "Serious problem with physical health",
    'HHPercNeedHealth': "Not able to get adequate health care (including during pregnancy or childbirth - for women)",
    'HHPercNeedSafety': "Not safe or protected where you live now",
    'HHPercNeedEducation': "Children not in school, or not getting a good enough education",
    'HHPercNeedCaregive': "Difficult to care for family members who live with you",
    'HHPercNeedInfo': "Not have enough information (including on situation at home - for displaced)",
    'HHPercNeedAsstInfo': "Inadequate aid",
    'CMPercNeedJustice': "Inadequate system for law and justice in community",
    'CMPercNeedGBViolence': "Physical or sexual violence towards women in community",
    'CMPercNeedSubstAbuse': "People drink a lot of alcohol or use harmful drugs in community",
    'CMPercNeedMentalCare': "Mental illness in community",
    'CMPercNeedCaregiving': "Not enough care for people who are on their own in community"
}

data = data.rename(columns=variable_labels)

# Assign value labels
value_labels_list = {
    0: "No serious problem",
    1: "Serious problem",
    8888: "Don't know, not applicable, declines to answer"
}

for column in data.columns:
    if 'HHPercNeed' in column or 'CMPercNeed' in column:
        data[column] = data[column].map(value_labels_list).fillna(data[column])

problem_labels = {
    1: "Drinking water", 2: "Food", 3: "Place to live in", 4: "Toilets", 5: "Keeping clean",
    6: "Clothes, shoes, bedding or blankets", 7: "Income or livelihood", 8: "Physical health",
    9: "Health care", 10: "Safety", 11: "Education for your children", 12: "Care for family members",
    13: "Information", 14: "The way aid is provided", 15: "Law and injustice in your community",
    16: "Safety or protection from violence for women in your community", 17: "Alcohol or drug use in your community",
    18: "Mental illness in your community", 19: "Care for people in your community who are on their own",
    20: "Other problem"
}

data['CMPercNeedRFirst'] = data['CMPercNeedRFirst'].map(problem_labels).fillna(data['CMPercNeedRFirst'])
data['CMPercNeedRSec'] = data['CMPercNeedRSec'].map(problem_labels).fillna(data['CMPercNeedRSec'])
data['CMPercNeedRThird'] = data['CMPercNeedRThird'].map(problem_labels).fillna(data['CMPercNeedRThird'])

# ------------------------------------------------------------------------------#
# For each aspect/question, report the share of households who indicated it as a "serious problem"
# ------------------------------------------------------------------------------#

# Frequencies
perc_need_summary = data.filter(like='HHPercNeed').apply(lambda x: np.mean(x == "Serious problem") * 100)
print(perc_need_summary)

# Show only the share of households that reported an aspect as serious problem out of the total population (including those that did not answer)
data = data.apply(lambda x: x.replace("Don't know, not applicable, declines to answer", "No serious problem"))
perc_need_summary = data.filter(like='HHPercNeed').apply(lambda x: np.mean(x == "Serious problem") * 100)
print(perc_need_summary)

# ------------------------------------------------------------------------------#
# For each aspect/question, report the share of households who indicated it among their top three problems
# ------------------------------------------------------------------------------#

# Generate variables indicating if the respondent mentioned it among their top three problems
data['Top3_Water']      = (data['CMPercNeedRFirst'] == "Drinking water") | (data['CMPercNeedRSec'] == "Drinking water") | (data['CMPercNeedRThird'] == "Drinking water")
data['Top3_Food']       = (data['CMPercNeedRFirst'] == "Food") | (data['CMPercNeedRSec'] == "Food") | (data['CMPercNeedRThird'] == "Food")
data['Top3_Housing']    = (data['CMPercNeedRFirst'] == "Place to live in") | (data['CMPercNeedRSec'] == "Place to live in") | (data['CMPercNeedRThird'] == "Place to live in")
data['Top3_Toilet']     = (data['CMPercNeedRFirst'] == "Toilets") | (data['CMPercNeedRSec'] == "Toilets") | (data['CMPercNeedRThird'] == "Toilets")
data['Top3_Hygiene']    = (data['CMPercNeedRFirst'] == "Keeping clean") | (data['CMPercNeedRSec'] == "Keeping clean") | (data['CMPercNeedRThird'] == "Keeping clean")
data['Top3_ClothTex']   = (data['CMPercNeedRFirst'] == "Clothes, shoes, bedding or blankets") | (data['CMPercNeedRSec'] == "Clothes, shoes, bedding or blankets") | (data['CMPercNeedRThird'] == "Clothes, shoes, bedding or blankets")
data['Top3_Livelihood'] = (data['CMPercNeedRFirst'] == "Income or livelihood") | (data['CMPercNeedRSec'] == "Income or livelihood") | (data['CMPercNeedRThird'] == "Income or livelihood")
data['Top3_Disabil']    = (data['CMPercNeedRFirst'] == "Physical health") | (data['CMPercNeedRSec'] == "Physical health") | (data['CMPercNeedRThird'] == "Physical health")
data['Top3_Health']     = (data['CMPercNeedRFirst'] == "Health care") | (data['CMPercNeedRSec'] == "Health care") | (data['CMPercNeedRThird'] == "Health care")
data['Top3_Safety']     = (data['CMPercNeedRFirst'] == "Safety") | (data['CMPercNeedRSec'] == "Safety") | (data['CMPercNeedRThird'] == "Safety")
data['Top3_Education']  = (data['CMPercNeedRFirst'] == "Education for your children") | (data['CMPercNeedRSec'] == "Education for your children") | (data['CMPercNeedRThird'] == "Education for your children")
data['Top3_Caregive']   = (data['CMPercNeedRFirst'] == "Care for family members") | (data['CMPercNeedRSec'] == "Care for family members") | (data['CMPercNeedRThird'] == "Care for family members")
data['Top3_Info']       = (data['CMPercNeedRFirst'] == "Information") | (data['CMPercNeedRSec'] == "Information") | (data['CMPercNeedRThird'] == "Information")
data['Top3_AsstInfo']   = (data['CMPercNeedRFirst'] == "The way aid is provided") | (data['CMPercNeedRSec'] == "The way aid is provided") | (data['CMPercNeedRThird'] == "The way aid is provided")
data['Top3_Justice']    = (data['CMPercNeedRFirst'] == "Law and injustice in your community") | (data['CMPercNeedRSec'] == "Law and injustice in your community") | (data['CMPercNeedRThird'] == "Law and injustice in your community")
data['Top3_GBViolence'] = (data['CMPercNeedRFirst'] == "Safety or protection from violence for women in your community") | (data['CMPercNeedRSec'] == "Safety or protection from violence for women in your community") | (data['CMPercNeedRThird'] == "Safety or protection from violence for women in your community")
data['Top3_SubstAbuse'] = (data['CMPercNeedRFirst'] == "Alcohol or drug use in your community") | (data['CMPercNeedRSec'] == "Alcohol or drug use in your community") | (data['CMPercNeedRThird'] == "Alcohol or drug use in your community")
data['Top3_MentalCare'] = (data['CMPercNeedRFirst'] == "Mental illness in your community") | (data['CMPercNeedRSec'] == "Mental illness in your community") | (data['CMPercNeedRThird'] == "Mental illness in your community")
data['Top3_Caregiving'] = (data['CMPercNeedRFirst'] == "Care for people in your community who are on their own") | (data['CMPercNeedRSec'] == "Care for people in your community who are on their own") | (data['CMPercNeedRThird'] == "Care for people in your community who are on their own")
data['Top3_Other']      = (data['CMPercNeedRFirst'] == "Other problem") | (data['CMPercNeedRSec'] == "Other problem") | (data['CMPercNeedRThird'] == "Other problem")

# Recode missings to zero
top3_columns = [col for col in data.columns if col.startswith('Top3_')]
data[top3_columns] = data[top3_columns].fillna(0).astype(int)

# Report share of households who indicated an area among their top three problems
top3_summary = data[top3_columns].mean() * 100
print(top3_summary)

# ------------------------------------------------------------------------------#
# Mean/median number of aspects indicated as "serious problems"
# ------------------------------------------------------------------------------#

# Create a variable that counts the number of aspects perceived as serious problems
perc_need_columns = [col for col in data.columns if col.startswith('HHPercNeed') or col.startswith('CMPercNeed')]
data['Perceived_total'] = (data[perc_need_columns] == "Serious problem").sum(axis=1)

# Report mean and median number of aspects indicated as "serious problems"
mean_perceived_total = data['Perceived_total'].mean()
median_perceived_total = data['Perceived_total'].median()

print(f"Mean number of perceived serious problems: {mean_perceived_total}")
print(f"Median number of perceived serious problems: {median_perceived_total}")

# End of Scripts