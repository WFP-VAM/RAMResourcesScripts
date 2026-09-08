#------------------------------------------------------------------------------#
#	                          WFP Standardized Scripts
#                     Calculating Environmental Benefit Indicator (EBI) 26
#------------------------------------------------------------------------------#

# This script calculates the Environmental Benefit Indicator (EBI) based on various 
# environmental-related questions. It recodes the responses, calculates percentages, 
# and computes the EBI for each community and overall.

# Load Packages
import pandas as pd

# Import dataset
#data = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/EBI_Sample_Survey.csv")

# Assign variable and value labels
data = data.rename(columns={
    'EBIFFAPart': 'Have you or any of your household member participated in the asset creation activities and received a food assistance transfer?',
    'EBISoilFertility': 'Do you think that the assets that were built or rehabilitated in your community have allowed to increase agricultural potential due to greater water availability and/or soil fertility (e.g. increased or diversified production not requiring expanded irrigation)?',
    'EBIStabilization': 'Do you think that the assets that were built or rehabilitated in your community have improved natural environment due to land stabilization and restoration (e.g. more natural vegetal cover, increase in indigenous flora/fauna, less erosion or siltation, etc.)?',
    'EBISanitation': 'Do you think that the assets that were built or rehabilitated in your community have improved environmental surroundings due to enhanced water and sanitation measures (i.e., greater availability/longer duration of water for domestic non-human consumption, improved hygiene practices – less open defecation)?'
})

# Define value labels
value_labels = {
    0: "No",
    1: "Yes",
    9999: "Not applicable"
}
for column in ['EBISoilFertility', 'EBIStabilization', 'EBISanitation']:
    data[column] = data[column].map(value_labels)

# Recode 9999 to 0
for column in ['EBISoilFertility', 'EBIStabilization', 'EBISanitation']:
    data[column] = data[column].replace(9999, 0)

# Create 3 tables with the % of yes responses to each of the 3 questions by ADMIN5Name
table_perc_soilfert = data.groupby('ADMIN5Name').apply(lambda x: x['EBISoilFertility'].mean() * 100).reset_index(name='EBISoilFertility_perc')
table_perc_stab = data.groupby('ADMIN5Name').apply(lambda x: x['EBIStabilization'].mean() * 100).reset_index(name='EBIStabilization_perc')
table_perc_san = data.groupby('ADMIN5Name').apply(lambda x: x['EBISanitation'].mean() * 100).reset_index(name='EBISanitation_perc')

# Join together the perc values of each of the three tables
table_allperc = table_perc_soilfert.merge(table_perc_stab, on='ADMIN5Name').merge(table_perc_san, on='ADMIN5Name')

# Create table with the denominator of questions asked for each community
table_allperc['EBIdenom'] = table_allperc['ADMIN5Name'].apply(lambda x: 2 if x == 'Community A' else 3)

# Calculate EBI by community
table_allperc['EBI_ADMIN5Name'] = (table_allperc['EBISoilFertility_perc'] + table_allperc['EBIStabilization_perc'] + table_allperc['EBISanitation_perc']) / table_allperc['EBIdenom']

# Calculate total EBI combining all communities
EBI_overall = table_allperc['EBI_ADMIN5Name'].mean()

# End of Scripts