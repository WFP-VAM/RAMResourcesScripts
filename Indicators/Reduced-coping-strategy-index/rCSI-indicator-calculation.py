#------------------------------------------------------------------------------#
#	                            WFP Standardized Scripts
#                Calculating Reduced Coping Strategy Index (rCSI)
#------------------------------------------------------------------------------#

# Load Packages --------------------------------------------------------------#

import pandas as pd
import numpy as np

# Load Sample Data ------------------------------------------------------------#

#df = pd.read_csv("RCSI_Sample_Survey.csv")

# Calculate rCSI --------------------------------------------------------------# 

df['rCSI'] = (df['rCSILessQlty'] + 
             (df['rCSIBorrow'] * 2) + 
              df['rCSIMealNb'] + 
              df['rCSIMealSize'] + 
             (df['rCSIMealAdult'] * 3))

# Creating unweighted summary of rCSI ----------------------------# 

# Unweighted mean
mean_rCSI_unweighted = df['rCSI'].dropna().mean()
print("Unweighted mean rCSI:", mean_rCSI_unweighted)

# End of Scripts