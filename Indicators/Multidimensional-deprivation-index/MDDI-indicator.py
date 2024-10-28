#------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#          Multidimensional Deprivation Index (MDDI) Calculation
#------------------------------------------------------------------------------

# Construction of the Multidimensional Deprivation Index (MDDI) is based on the 
# codebook questions prepared for the MDDI module available at:
# https://docs.wfp.org/api/documents/WFP-0000134356/download/

import pandas as pd
import numpy as np

# Load the data
data = pd.read_csv("path/to/your/data.csv")

#------------------------------------------------------------------------------
# 1. Creation of variables of deprivations for each dimension
#------------------------------------------------------------------------------

# FOOD DIMENSION

# Calculate FCS
data['FCS'] = (data['FCSStap'] * 2) + data['FCSVeg'] + data['FCSFruit'] + \
              (data['FCSPr'] * 4) + (data['FCSPulse'] * 3) + (data['FCSDairy'] * 4) + \
              (data['FCSFat'] * 0.5) + (data['FCSSugar'] * 0.5)

# Categorize FCS
data['FCSCat28'] = pd.cut(data['FCS'], bins=[-np.inf, 28, 42, np.inf], labels=[1, 2, 3])
data['FCSCat21'] = pd.cut(data['FCS'], bins=[-np.inf, 21, 35, np.inf], labels=[1, 2, 3])

# Turn into MDDI variable
data['MDDI_food1'] = data['FCSCat28'].isin([1, 2]).astype(int)

# rCSI (Reduced Consumption Strategies Index)
data['rCSI'] = (data['rCSILessQlty'] * 1) + (data['rCSIBorrow'] * 2) + (data['rCSIMealNb'] * 1) + \
               (data['rCSIMealSize'] * 1) + (data['rCSIMealAdult'] * 3)

data['MDDI_food2'] = (data['rCSI'] > 18).astype(int)

# EDUCATION DIMENSION
data['MDDI_edu1'] = (data['HHNoSchool'] == 1).astype(int)

# HEALTH DIMENSION
data['MDDI_health1'] = data['HHENHealthMed'].isin([0, 1]).astype(int)

data['HHSickNb'] = data[['HHDisabledNb', 'HHChronIllNb']].sum(axis=1, skipna=True)
data['HHSickShare'] = data['HHSickNb'] / data['HHSizeCalc']
data['MDDI_health2'] = ((data['HHSickNb'] > 1) | (data['HHSickShare'] > 0.5)).astype(int)

# SHELTER DIMENSION
data['MDDI_shelter1'] = data['HEnerCookSRC'].isin([0, 100, 102, 200, 500, 600, 900, 999]).astype(int)
data['MDDI_shelter2'] = ~data['HEnerLightSRC'].isin([401, 402]).astype(int)
data['crowding'] = data['HHSizeCalc'] / data['HHRoomUsed']
data['MDDI_shelter3'] = (data['crowding'] > 3).astype(int)

# WASH DIMENSION
data['MDDI_wash1'] = data['HToiletType'].isin([20100, 20200, 20300, 20400, 20500]).astype(int)
data['MDDI_wash2'] = data['HWaterSRC'].isin([500, 600, 700, 800]).astype(int)

# SAFETY DIMENSION
data['MDDI_safety1'] = ((data['HHPercSafe'] == 0) | (data['HHShInsec1Y'] == 1)).astype(int)

# Example of calculating months since arrival
data['interview_date'] = pd.to_datetime('2021-11-25')
data['HHHDisplArrive'] = pd.to_datetime(data['HHHDisplArrive'], origin='1970-01-01', errors='coerce')
data['Arrival_time'] = (data['interview_date'] - data['HHHDisplArrive']).dt.days / 30
data['MDDI_safety2'] = ((data['Arrival_time'] < 13) & (data['HHDisplChoice'] == 0)).astype(int)
data.loc[data['HHDispl'] == 0, 'MDDI_safety2'] = 0

#------------------------------------------------------------------------------
# 2. Calculate deprivation score of each dimension
#------------------------------------------------------------------------------

data['MDDI_food'] = (data['MDDI_food1'] * 1 / 2) + (data['MDDI_food2'] * 1 / 2)
data['MDDI_edu'] = data['MDDI_edu1'] * 1
data['MDDI_health'] = (data['MDDI_health1'] * 1 / 2) + (data['MDDI_health2'] * 1 / 2)
data['MDDI_shelter'] = (data['MDDI_shelter1'] * 1 / 3) + (data['MDDI_shelter2'] * 1 / 3) + (data['MDDI_shelter3'] * 1 / 3)
data['MDDI_wash'] = (data['MDDI_wash1'] * 1 / 2) + (data['MDDI_wash2'] * 1 / 2)
data['MDDI_safety'] = (data['MDDI_safety1'] * 1 / 2) + (data['MDDI_safety2'] * 1 / 2)

#------------------------------------------------------------------------------
# 3. Calculate MDDI-related measures
#------------------------------------------------------------------------------

# Calculate the overall MDDI Score
data['MDDI'] = (data['MDDI_food'] + data['MDDI_edu'] + data['MDDI_health'] + data['MDDI_shelter'] + data['MDDI_wash'] + data['MDDI_safety']) / 6

# Calculate MDDI Incidence (H)
data['MDDI_poor_severe'] = (data['MDDI'] >= 0.50).astype(int)
data['MDDI_poor'] = (data['MDDI'] >= 0.33).astype(int)

# Calculate the Average MDDI Intensity (A)
data['MDDI_intensity'] = data['MDDI'].where(data['MDDI_poor'] == 1)

# Calculate Combined MDDI (M = H x A)
data['MDDI_combined'] = data['MDDI_poor'] * data['MDDI_intensity']
data.loc[data['MDDI_poor'] == 0, 'MDDI_combined'] = 0

# Show results
results = data[['MDDI_poor', 'MDDI_poor_severe', 'MDDI_intensity', 'MDDI_combined']].mean()
print(results)

# End of Scripts