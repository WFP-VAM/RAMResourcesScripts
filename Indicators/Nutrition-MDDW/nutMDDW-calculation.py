#------------------------------------------------------------------------------#
#                        WFP RAM Standardized Scripts
#                      Calculating and Summarising MDDW
#------------------------------------------------------------------------------#

# Load Packages --------------------------------------------------------------#

import pandas as pd
import numpy as np

# Load Sample Data ------------------------------------------------------------#

# Replace with the path to your CSV file
#df = pd.read_csv("Nutrition_module_MDD_W_submodule_RepeatMDDW.csv")

# Rename MDDW relevant variables ----------------------------------------------#

df = df.rename(columns={
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWStapCer': 'PWMDDWStapCer',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWStapRoo': 'PWMDDWStapRoo',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWPulse': 'PWMDDWPulse',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWNuts': 'PWMDDWNuts',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWMilk': 'PWMDDWMilk',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWDairy': 'PWMDDWDairy',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWPrMeatO': 'PWMDDWPrMeatO',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWPrMeatF': 'PWMDDWPrMeatF',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWPrMeatPro': 'PWMDDWPrMeatPro',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWPrMeatWhite': 'PWMDDWPrMeatWhite',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWPrFish': 'PWMDDWPrFish',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWPrEgg': 'PWMDDWPrEgg',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWVegGre': 'PWMDDWVegGre',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWVegOrg': 'PWMDDWVegOrg',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFruitOrg': 'PWMDDWFruitOrg',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWVegOth': 'PWMDDWVegOth',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFruitOth': 'PWMDDWFruitOth',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWSnf': 'PWMDDWSnf',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFortFoodoil': 'PWMDDWFortFoodoil',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFortFoodwflour': 'PWMDDWFortFoodwflour',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFortFoodmflour': 'PWMDDWFortFoodmflour',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFortFoodrice': 'PWMDDWFortFoodrice',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFortFooddrink': 'PWMDDWFortFooddrink',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFortFoodother': 'PWMDDWFortFoodother',
    'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFortFoodother_oth': 'PWMDDWFortFoodother_oth'
})

# Label MDDW relevant variables -----------------------------------------------#

labels = {
    'PWMDDWStapCer': "Foods made from grains",
    'PWMDDWStapRoo': "White roots and tubers or plantains",
    'PWMDDWPulse': "Pulses (beans, peas and lentils)",
    'PWMDDWNuts': "Nuts and seeds",
    'PWMDDWMilk': "Milk",
    'PWMDDWDairy': "Milk products",
    'PWMDDWPrMeatO': "Organ meats",
    'PWMDDWPrMeatF': "Red flesh meat from mammals",
    'PWMDDWPrMeatPro': "Processed meat",
    'PWMDDWPrMeatWhite': "Poultry and other white meats",
    'PWMDDWPrFish': "Fish and Seafood",
    'PWMDDWPrEgg': "Eggs from poultry or any other bird",
    'PWMDDWVegGre': "Dark green leafy vegetable",
    'PWMDDWVegOrg': "Vitamin A-rich vegetables, roots and tubers",
    'PWMDDWFruitOrg': "Vitamin A-rich fruits",
    'PWMDDWVegOth': "Other vegetables",
    'PWMDDWFruitOth': "Other fruits",
    'PWMDDWSnf': "Specialized Nutritious Foods (SNF) for women",
    'PWMDDWFortFoodoil': "Fortified oil",
    'PWMDDWFortFoodwflour': "Fortified wheat flour",
    'PWMDDWFortFoodmflour': "Fortified maize flour",
    'PWMDDWFortFoodrice': "Fortified Rice",
    'PWMDDWFortFooddrink': "Fortified drink",
    'PWMDDWFortFoodother': "Other:",
    'PWMDDWFortFoodother_oth': "Other: please specify: ____________"
}

# Convert to binary (0/1) based on "Yes"/"No" responses
binary_columns = [
    'PWMDDWStapCer', 'PWMDDWStapRoo', 'PWMDDWPulse', 'PWMDDWNuts',
    'PWMDDWMilk', 'PWMDDWDairy', 'PWMDDWPrMeatO', 'PWMDDWPrMeatF',
    'PWMDDWPrMeatPro', 'PWMDDWPrMeatWhite', 'PWMDDWPrFish', 'PWMDDWPrEgg',
    'PWMDDWVegGre', 'PWMDDWVegOrg', 'PWMDDWFruitOrg', 'PWMDDWVegOth',
    'PWMDDWFruitOth', 'PWMDDWSnf', 'PWMDDWFortFoodoil', 'PWMDDWFortFoodwflour',
    'PWMDDWFortFoodmflour', 'PWMDDWFortFoodrice', 'PWMDDWFortFooddrink',
    'PWMDDWFortFoodother'
]

df[binary_columns] = df[binary_columns].apply(lambda x: pd.to_numeric(x.replace({"No": 0, "Yes": 1})))

# Calculate MDDW indicators -------------------------------------------------#

# Standard MDDW method - SNF in grains
df['MDDW_Staples'] = ((df['PWMDDWStapCer'] == 1) | (df['PWMDDWStapRoo'] == 1) | 
                      (df['PWMDDWSnf'] == 1) | (df['PWMDDWFortFoodwflour'] == 1) |
                      (df['PWMDDWFortFoodmflour'] == 1) | (df['PWMDDWFortFoodrice'] == 1) |
                      (df['PWMDDWFortFooddrink'] == 1)).astype(int)

df['MDDW_Pulses'] = (df['PWMDDWPulse'] == 1).astype(int)
df['MDDW_NutsSeeds'] = (df['PWMDDWNuts'] == 1).astype(int)
df['MDDW_Dairy'] = ((df['PWMDDWDairy'] == 1) | (df['PWMDDWMilk'] == 1)).astype(int)
df['MDDW_MeatFish'] = ((df['PWMDDWPrMeatO'] == 1) | (df['PWMDDWPrMeatF'] == 1) |
                       (df['PWMDDWPrMeatPro'] == 1) | (df['PWMDDWPrMeatWhite'] == 1) |
                       (df['PWMDDWPrFish'] == 1)).astype(int)
df['MDDW_Eggs'] = (df['PWMDDWPrEgg'] == 1).astype(int)
df['MDDW_LeafGreenVeg'] = (df['PWMDDWVegGre'] == 1).astype(int)
df['MDDW_VitA'] = ((df['PWMDDWVegOrg'] == 1) | (df['PWMDDWFruitOrg'] == 1)).astype(int)
df['MDDW_OtherVeg'] = (df['PWMDDWVegOth'] == 1).astype(int)
df['MDDW_OtherFruits'] = (df['PWMDDWFruitOth'] == 1).astype(int)

# WFP MDDW method - SNF in meats group
df['MDDW_Pulses_wfp'] = (df['PWMDDWPulse'] == 1).astype(int)
df['MDDW_NutsSeeds_wfp'] = (df['PWMDDWNuts'] == 1).astype(int)
df['MDDW_Dairy_wfp'] = ((df['PWMDDWDairy'] == 1) | (df['PWMDDWMilk'] == 1)).astype(int)
df['MDDW_MeatFish_wfp'] = ((df['PWMDDWPrMeatO'] == 1) | (df['PWMDDWPrMeatF'] == 1) |
                           (df['PWMDDWPrMeatPro'] == 1) | (df['PWMDDWPrMeatWhite'] == 1) |
                           (df['PWMDDWPrFish'] == 1) | (df['PWMDDWSnf'] == 1)).astype(int)
df['MDDW_Eggs_wfp'] = (df['PWMDDWPrEgg'] == 1).astype(int)
df['MDDW_LeafGreenVeg_wfp'] = (df['PWMDDWVegGre'] == 1).astype(int)
df['MDDW_VitA_wfp'] = ((df['PWMDDWVegOrg'] == 1) | (df['PWMDDWFruitOrg'] == 1)).astype(int)
df['MDDW_OtherVeg_wfp'] = (df['PWMDDWVegOth'] == 1).astype(int)
df['MDDW_OtherFruits_wfp'] = (df['PWMDDWFruitOth'] == 1).astype(int)

# Calculate MDDW Index ------------------------------------------------------#

df['MDDW'] = (df['MDDW_Staples'] + df['MDDW_Pulses'] + df['MDDW_NutsSeeds'] +
              df['MDDW_Dairy'] + df['MDDW_MeatFish'] + df['MDDW_Eggs'] +
              df['MDDW_LeafGreenVeg'] + df['MDDW_VitA'] + df['MDDW_OtherVeg'] +
              df['MDDW_OtherFruits'])

df['MDDW_5'] = np.where(df['MDDW'] >= 5, '>=5', '<5')

df['MDDW_wfp'] = (df['MDDW_Staples_wfp'] + df['MDDW_Pulses_wfp'] +
                  df['MDDW_NutsSeeds_wfp'] + df['MDDW_Dairy_wfp'] +
                  df['MDDW_MeatFish_wfp'] + df['MDDW_Eggs_wfp'] +
                  df['MDDW_LeafGreenVeg_wfp'] + df['MDDW_VitA_wfp'] +
                  df['MDDW_OtherVeg_wfp'] + df['MDDW_OtherFruits_wfp'])

df['MDDW_5_wfp'] = np.where(df['MDDW_wfp'] >= 5, '>=5', '<5')

# Summarize 2 MDDW Index -----------------------------------------------------#

# Standard MDDW Method - MDDW_5
MDDW_5_table_wide = (df.dropna(subset=['MDDW_5'])
                     .groupby('MDDW_5').size()
                     .reset_index(name='n')
                     .assign(Percentage=lambda x: 100 * x['n'] / x['n'].sum())
                     .pivot(index=None, columns='MDDW_5', values='Percentage')
                     .fillna(0))

# WFP MDDW Method - MDDW_5_wfp
MDDW_5_wfp_table_wide = (df.dropna(subset=['MDDW_5_wfp'])
                         .groupby('MDDW_5_wfp').size()
                         .reset_index(name='n')
                         .assign(Percentage=lambda x: 100 * x['n'] / x['n'].sum())
                         .pivot(index=None, columns='MDDW_5_wfp', values='Percentage')
                         .fillna(0))

# Print tables for review
print("Standard MDDW Method Summary:")
print(MDDW_5_table_wide)

print("\nWFP MDDW Method Summary:")
print(MDDW_5_wfp_table_wide)

# End of Scripts 