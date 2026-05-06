#------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#                Post-Harvest Loss Calculation (SAMS Indicator 30)
#------------------------------------------------------------------------------

# This script calculates the Post-Harvest Loss (PHL) based on SAMS Indicator 30 guidelines.
# Detailed guidelines can be found in the SAMS documentation.

# This syntax is based on SPSS download version from MoDA.
# More details can be found in the background document at: 
# https://wfp.sharepoint.com/sites/CRF2022-2025/CRF%20Outcome%20indicators/Forms/AllItems.aspx

import pandas as pd

# add sample data
data = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/SAMS_CRF_30_PHL_Sample_Survey/SAMS_module_Indicator30_submodule_RepeatSAMSPHL.csv")

# rename to remove group names
data.rename(columns={
    'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommName': 'PSAMSPHLCommName',
    'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommName_oth': 'PSAMSPHLCommName_oth',
    'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommClass': 'PSAMSPHLCommClass',
    'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommQntHand': 'PSAMSPHLCommQntHand',
    'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommQntHandUnit': 'PSAMSPHLCommQntHandUnit',
    'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommQntHandUnit_oth': 'PSAMSPHLCommQntHandUnit_oth',
    'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommQntLost': 'PSAMSPHLCommQntLost',
    '_parent_index': 'PSAMSPHLFarmerNum'
}, inplace=True)

# assign variable and value labels
data['PSAMSPHLCommName'].attrs['label'] = "What is the name of commodity?"
data['PSAMSPHLCommClass'].attrs['label'] = "Which of the following groups does this commodity belong to?"
data['PSAMSPHLCommQntHand'].attrs['label'] = "What is the amount of this commodity initially stored?"
data['PSAMSPHLCommQntHandUnit'].attrs['label'] = "Enter unit of measure."
data['PSAMSPHLCommQntLost'].attrs['label'] = "Of the total quantity you stored how much was lost?"

# Calculate % loss per row
data['perc_loss'] = (data['PSAMSPHLCommQntLost'] / data['PSAMSPHLCommQntHand']) * 100

# Average loss per farmer
avglossperfarmer_table = data.groupby('PSAMSPHLFarmerNum')['perc_loss'].mean().reset_index()

# Average across farmers
average_phl_loss = avglossperfarmer_table['perc_loss'].mean()

print(f"Average Post-Harvest Loss per Farmer: {average_phl_loss:.2f}%")

# End of Scripts