#------------------------------------------------------------------------------#
#	                          WFP Standardized Scripts
#                    Calculating Asset-Based Indicator (ABI) 25
#------------------------------------------------------------------------------#

# This script calculates the Asset-Based Indicator (ABI) based on various 
# asset-related questions. It recodes the responses, sums the scores, and 
# calculates the percentage ABI for each respondent.

# Load Packages
import pandas as pd

# Import dataset
#data = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/ABI_Sample_Survey.csv")

# Assign variable and value labels
data = data.rename(columns={
    'HHFFAPart': 'Have you or any of your household member participated in the asset creation activities and received a food assistance transfer?',
    'HHAssetProtect': 'Do you think that the assets that were built or rehabilitated in your community are better protecting your household from floods / drought / landslides / mudslides?',
    'HHAssetProduct': 'Do you think that the assets that were built or rehabilitated in your community have allowed your household to increase or diversify its production (agriculture / livestock / other)?',
    'HHAssetDecHardship': 'Do you think that the assets that were built or rehabilitated in your community have decreased the day-to-day hardship and released time for any of your family members (including women and children)?',
    'HHAssetAccess': 'Do you think that the assets that were built or rehabilitated in your community have improved the ability of any of your household member to access markets and/or basic services (water, sanitation, health, education, etc)?',
    'HHTrainingAsset': 'Do you think that the trainings and other support provided in your community have improved your household’s ability to manage and maintain assets?',
    'HHAssetEnv': 'Do you think that the assets that were built or rehabilitated in your community have improved your natural environment (for example more vegetal cover, water table increased, less erosion, etc.)?',
    'HHWorkAsset': 'Do you think that the works undertaken in your community have restored your ability to access and/or use basic asset functionalities?'
})

# Define value labels
value_labels = {
    0: "No",
    1: "Yes",
    9999: "Not applicable"
}
for column in ['HHAssetProtect', 'HHAssetProduct', 'HHAssetDecHardship', 'HHAssetAccess', 'HHTrainingAsset', 'HHAssetEnv', 'HHWorkAsset']:
    data[column] = data[column].map(value_labels)

# Recode 9999 to 0
for column in ['HHAssetProtect', 'HHAssetProduct', 'HHAssetDecHardship', 'HHAssetAccess', 'HHTrainingAsset', 'HHAssetEnv', 'HHWorkAsset']:
    data[column] = data[column].replace(9999, 0)

# Create denominator of questions asked for each community
data['ABIdenom'] = data['ADMIN5Name'].apply(lambda x: 5 if x == 'Community A' else 6)

# Create ABI score and ABI percent
data['ABIScore'] = data[['HHAssetProtect', 'HHAssetProduct', 'HHAssetDecHardship', 'HHAssetAccess', 'HHTrainingAsset', 'HHAssetEnv', 'HHWorkAsset']].sum(axis=1)
data['ABIPerc'] = (data['ABIScore'] / data['ABIdenom']) * 100

# Create table of values - participants vs non-participants
ABIperc_particp = data.groupby('HHFFAPart')['ABIPerc'].mean().reset_index(name='ABIPerc_mean')

# Calculate ABI using weight value of 2 for non-participants
ABIperc_particp['ABIperc_wtd'] = ABIperc_particp.apply(lambda x: x['ABIPerc_mean'] * 2 if x['HHFFAPart'] == 0 else x['ABIPerc_mean'], axis=1)

# Add weight for non-participant and compute average
ABIperc_total = ABIperc_particp['ABIperc_wtd'].sum() / 3

# End of Scripts