#------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#    Engagement in Income Generation Activities (EIG) Calculation
#------------------------------------------------------------------------------

# This script calculates the Engagement in Income Generation Activities (EIG)
# using standard variable names and sample data.
# Detailed guidelines can be found in the WFP documentation.

import pandas as pd

# Add sample data
data = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/EIG_Sample_Survey.csv")

# Rearrange variable names to ensure consistency in the dataset
data.columns = [col.replace("/", "") for col in data.columns]

# Loop to account for up to 9 training types
for i in range(1, 10):
    training_col = f'PTrainingTypes{i}'
    if training_col in data.columns:
        data[training_col] = data[training_col].replace('n/a', pd.NA).astype(float)

# Calculate engagement in income generation activities
data['PostTrainingEngagement'] = data[['PPostTrainingEmpl', 'PPostTrainingIncome']].max(axis=1)
data['PTrainingPart'] = data[[col for col in data.columns if 'PTrainingTypes' in col]].sum(axis=1)

# Calculate household level variables
household_data = data.groupby('household_id').agg(
    PostTrainingEngagement=('PostTrainingEngagement', 'sum'),
    PTrainingPartNb=('PTrainingPart', 'sum')
).reset_index()

household_data['EIG'] = household_data['PostTrainingEngagement'] / household_data['PTrainingPartNb']

# Summary statistics for full sample
print(household_data['EIG'].describe())

# End of Scripts