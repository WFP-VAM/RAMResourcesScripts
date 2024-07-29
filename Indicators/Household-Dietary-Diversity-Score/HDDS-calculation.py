#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#          Calculating Household Dietary Diversity Score (HDDS)
#------------------------------------------------------------------------------#

# Load Packages --------------------------------------------------------------#
import pandas as pd

# Load Sample Data ------------------------------------------------------------#
#df = pd.read_csv("~/GitHub/RAMResourcesScripts/Static/HDDS_Sample_Survey.csv")

# Rename variables to match the script ----------------------------------------#
df.rename(columns={
    'HDDSStapCer':  'HDDSStapCer',
    'HDDSStapRoot': 'HDDSStapRoot',
    'HDDSVeg':      'HDDSVeg',
    'HDDSFruit':    'HDDSFruit',
    'HDDSPrMeat':   'HDDSPrMeat',
    'HDDSPrEggs':   'HDDSPrEggs',
    'HDDSPrFish':   'HDDSPrFish',
    'HDDSPulse':    'HDDSPulse',
    'HDDSDairy':    'HDDSDairy',
    'HDDSFat':      'HDDSFat',
    'HDDSSugar':    'HDDSSugar',
    'HDDSCond':     'HDDSCond'
}, inplace=True)

# Compute HDDS ---------------------------------------------------------------#
df['HDDS'] = (df['HDDSStapCer'] + df['HDDSStapRoot'] + df['HDDSVeg'] +
              df['HDDSFruit']   + df['HDDSPrMeat']   + df['HDDSPrEggs'] +
              df['HDDSPrFish']  + df['HDDSPulse']    + df['HDDSDairy'] +
              df['HDDSFat']     + df['HDDSSugar']    + df['HDDSCond'])

# Recode HDDS into categories -----------------------------------------------#
df['HDDSCat_IPC'] = pd.cut(df['HDDS'], bins=[-float('inf'), 2, 4, float('inf')],
                           labels=['0-2 food groups (phase 4 to 5)',
                                   '3-4 food groups (phase 3)',
                                   '5-12 food groups (phase 1 to 2)'])

# View the result -----------------------------------------------------------#
print(df[['HDDS', 'HDDSCat_IPC']].head(10))

# End of Scripts