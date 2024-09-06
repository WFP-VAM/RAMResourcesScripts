# ------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#                  Minimum Acceptable Diet (MAD) Calculation
# ------------------------------------------------------------------------------

# Construction of the Minimum Acceptable Diet (MAD) is based on the 
# codebook questions prepared for the MAD module.

import pandas as pd
import numpy as np

# Load the dataset
data = pd.read_csv("path_to_your_file/MAD_submodule_RepeatMAD.csv")

#-------------------------------------------------------------------------------
# 1. Rename variables to remove group names
#-------------------------------------------------------------------------------

data.rename(columns={
    'MAD_submodule/RepeatMAD/PCMADChildAge_months': 'PCMADChildAge_months',
    'MAD_submodule/RepeatMAD/PCMADBreastfeed': 'PCMADBreastfeed',
    'MAD_submodule/RepeatMAD/PCMADInfFormula': 'PCMADInfFormula',
    'MAD_submodule/RepeatMAD/PCMADInfFormulaNum': 'PCMADInfFormulaNum',
    'MAD_submodule/RepeatMAD/PCMADMilk': 'PCMADMilk',
    'MAD_submodule/RepeatMAD/PCMADMilkNum': 'PCMADMilkNum',
    'MAD_submodule/RepeatMAD/PCMADYogurtDrink': 'PCMADYogurtDrink',
    'MAD_submodule/RepeatMAD/PCMADYogurtDrinkNum': 'PCMADYogurtDrinkNum',
    'MAD_submodule/RepeatMAD/PCMADYogurt': 'PCMADYogurt',
    'MAD_submodule/RepeatMAD/PCMADStapCer': 'PCMADStapCer',
    'MAD_submodule/RepeatMAD/PCMADVegOrg': 'PCMADVegOrg',
    'MAD_submodule/RepeatMAD/PCMADStapRoo': 'PCMADStapRoo',
    'MAD_submodule/RepeatMAD/PCMADVegGre': 'PCMADVegGre',
    'MAD_submodule/RepeatMAD/PCMADVegOth': 'PCMADVegOth',
    'MAD_submodule/RepeatMAD/PCMADFruitOrg': 'PCMADFruitOrg',
    'MAD_submodule/RepeatMAD/PCMADFruitOth': 'PCMADFruitOth',
    'MAD_submodule/RepeatMAD/PCMADPrMeatO': 'PCMADPrMeatO',
    'MAD_submodule/RepeatMAD/PCMADPrMeatPro': 'PCMADPrMeatPro',
    'MAD_submodule/RepeatMAD/PCMADPrMeatF': 'PCMADPrMeatF',
    'MAD_submodule/RepeatMAD/PCMADPrEgg': 'PCMADPrEgg',
    'MAD_submodule/RepeatMAD/PCMADPrFish': 'PCMADPrFish',
    'MAD_submodule/RepeatMAD/PCMADPulse': 'PCMADPulse',
    'MAD_submodule/RepeatMAD/PCMADCheese': 'PCMADCheese',
    'MAD_submodule/RepeatMAD/PCMADSnf': 'PCMADSnf',
    'MAD_submodule/RepeatMAD/PCMADMeals': 'PCMADMeals'
}, inplace=True)

#-------------------------------------------------------------------------------
# 2. Define variable and value labels
#-------------------------------------------------------------------------------

variable_labels = {
    'PCMADChildAge_months': 'What is the age in months of ${PCMADChildName}?',
    'PCMADBreastfeed': 'Was ${PCMADChildName} breastfed yesterday during the day or at night?',
    'PCMADInfFormula': 'Infant formula, such as [insert local names of common formula]?',
    'PCMADInfFormulaNum': 'How many times did ${PCMADChildName} drink formula?',
    'PCMADMilk': 'Milk from animals, such as fresh, tinned or powdered milk?',
    'PCMADMilkNum': 'How many times did ${PCMADChildName} drink milk from animals, such as fresh, tinned or powdered milk?',
    'PCMADYogurtDrink': 'Yogurt drinks such as [insert local names of common types of yogurt drinks]?',
    'PCMADYogurtDrinkNum': 'How many times did ${PCMADChildName} drink Yogurt drinks such as [insert local names of common types of yogurt drinks]?',
    'PCMADYogurt': 'Yogurt, other than yogurt drinks?',
    'PCMADStapCer': 'Porridge, bread, rice, noodles, pasta or [insert other commonly consumed grains, including foods made from grains like rice dishes, noodle dishes, etc.]?',
    'PCMADVegOrg': 'Pumpkin, carrots, sweet red peppers, squash or sweet potatoes that are yellow or orange inside?',
    'PCMADStapRoo': 'Plantains, white potatoes, white yams, manioc, cassava or [insert other commonly consumed starchy tubers or starchy tuberous roots that are white or pale inside]?',
    'PCMADVegGre': 'Dark green leafy vegetables, such as [insert commonly consumed vitamin A-rich dark green leafy vegetables]?',
    'PCMADVegOth': 'Any other vegetables, such as [insert commonly consumed vegetables]?',
    'PCMADFruitOrg': 'Ripe mangoes or ripe papayas or [insert other commonly consumed vitamin A-rich fruits]?',
    'PCMADFruitOth': 'Any other fruits, such as [insert commonly consumed fruits]?',
    'PCMADPrMeatO': 'Liver, kidney, heart or [insert other commonly consumed organ meats]?',
    'PCMADPrMeatPro': 'Sausages, hot dogs/frankfurters, ham, bacon, salami, canned meat or [insert other commonly consumed processed meats]?',
    'PCMADPrMeatF': 'Any other meat, such as beef, pork, lamb, goat, chicken, duck or [insert other commonly consumed meat]?',
    'PCMADPrEgg': 'Eggs',
    'PCMADPrFish': 'Fresh or dried fish, shellfish or seafood',
    'PCMADPulse': 'Beans, peas, lentils, nuts, seeds or [insert commonly consumed foods made from beans, peas, lentils, nuts, or seeds]?',
    'PCMADCheese': 'Hard or soft cheese such as [insert commonly consumed types of cheese]?',
    'PCMADSnf': 'Specialized Nutritious Foods (SNF) such as [insert the SNFs distributed by WFP]?',
    'PCMADMeals': 'How many times did ${PCMADChildName} eat any solid, semi-solid or soft foods yesterday during the day or night?'
}

value_labels = {
    0: "No",
    1: "Yes",
    888: "Don't know"
}

for col in data.columns:
    if col in variable_labels:
        data[col].attrs['label'] = variable_labels[col]
    if col in value_labels:
        data[col] = data[col].astype('category')
        data[col].cat.rename_categories(value_labels, inplace=True)

#-------------------------------------------------------------------------------
# 3. Create Minimum Dietary Diversity 6-23 months (MDD) for population assessments
#-------------------------------------------------------------------------------

data['MAD_BreastMilk'] = np.where(data['PCMADBreastfeed'] == 1, 1, 0)
data['MAD_PWMDDWStapCer'] = np.where((data['PCMADStapCer'] == 1) | (data['PCMADStapRoo'] == 1) | (data['PCMADSnf'] == 1), 1, 0)
data['MAD_PulsesNutsSeeds'] = np.where(data['PCMADPulse'] == 1, 1, 0)
data['MAD_Dairy'] = np.where((data['PCMADInfFormula'] == 1) | (data['PCMADMilk'] == 1) | (data['PCMADYogurtDrink'] == 1) | (data['PCMADYogurt'] == 1) | (data['PCMADCheese'] == 1), 1, 0)
data['MAD_MeatFish'] = np.where((data['PCMADPrMeatO'] == 1) | (data['PCMADPrMeatPro'] == 1) | (data['PCMADPrMeatF'] == 1) | (data['PCMADPrFish'] == 1), 1, 0)
data['MAD_Eggs'] = np.where(data['PCMADPrEgg'] == 1, 1, 0)
data['MAD_VitA'] = np.where((data['PCMADVegOrg'] == 1) | (data['PCMADVegGre'] == 1) | (data['PCMADFruitOrg'] == 1), 1, 0)
data['MAD_OtherVegFruits'] = np.where((data['PCMADFruitOth'] == 1) | (data['PCMADVegOth'] == 1), 1, 0)

# Add together food groups to see how many food groups consumed
data['MDD_score'] = data[['MAD_BreastMilk', 'MAD_PWMDDWStapCer', 'MAD_PulsesNutsSeeds', 'MAD_Dairy', 'MAD_MeatFish', 'MAD_Eggs', 'MAD_VitA', 'MAD_OtherVegFruits']].sum(axis=1)

# Create MDD variable which records whether child consumed five or more food groups
data['MDD'] = np.where(data['MDD_score'] >= 5, 1, 0)
data['MDD'].attrs['label'] = 'Minimum Dietary Diversity (MDD)'
data['MDD'] = data['MDD'].astype('category')
data['MDD'].cat.rename_categories({
    0: 'Does not meet MDD',
    1: 'Meets MDD'
}, inplace=True)

#-------------------------------------------------------------------------------
# 4. Create Minimum Dietary Diversity 6-23 months (MDD) for WFP programme monitoring
#-------------------------------------------------------------------------------

data['MAD_BreastMilk_wfp'] = np.where(data['PCMADBreastfeed'] == 1, 1, 0)
data['MAD_PWMDDWStapCer_wfp'] = np.where((data['PCMADStapCer'] == 1) | (data['PCMADStapRoo'] == 1), 1, 0)
data['MAD_PulsesNutsSeeds_wfp'] = np.where(data['PCMADPulse'] == 1, 1, 0)
data['MAD_Dairy_wfp'] = np.where((data['PCMADInfFormula'] == 1) | (data['PCMADMilk'] == 1) | (data['PCMADYogurtDrink'] == 1) | (data['PCMADYogurt'] == 1) | (data['PCMADCheese'] == 1), 1, 0)
data['MAD_MeatFish_wfp'] = np.where((data['PCMADPrMeatO'] == 1) | (data['PCMADPrMeatPro'] == 1) | (data['PCMADPrMeatF'] == 1) | (data['PCMADPrFish'] == 1) | (data['PCMADSnf'] == 1), 1, 0)
data['MAD_Eggs_wfp'] = np.where(data['PCMADPrEgg'] == 1, 1, 0)
data['MAD_VitA_wfp'] = np.where((data['PCMADVegOrg'] == 1) | (data['PCMADVegGre'] == 1) | (data['PCMADFruitOrg'] == 1), 1, 0)
data['MAD_OtherVegFruits_wfp'] = np.where((data['PCMADFruitOth'] == 1) | (data['PCMADVegOth'] == 1), 1, 0)

# Add together food groups to see how many food groups consumed
data['MDD_score_wfp'] = data[['MAD_BreastMilk_wfp', 'MAD_PWMDDWStapCer_wfp', 'MAD_PulsesNutsSeeds_wfp', 'MAD_Dairy_wfp', 'MAD_MeatFish_wfp', 'MAD_Eggs_wfp', 'MAD_VitA_wfp', 'MAD_OtherVegFruits_wfp']].sum(axis=1)

# Create MDD variable which records whether child consumed five or more food groups
data['MDD_wfp'] = np.where(data['MDD_score_wfp'] >= 5, 1, 0)
data['MDD_wfp'].attrs['label'] = 'Minimum Dietary Diversity for WFP program monitoring (MDD)'
data['MDD_wfp'] = data['MDD_wfp'].astype('category')
data['MDD_wfp'].cat.rename_categories({
    0: 'Does not meet MDD',
    1: 'Meets MDD'
}, inplace=True)

#-------------------------------------------------------------------------------
# 5. Calculate Minimum Meal Frequency 6-23 months (MMF)
#-------------------------------------------------------------------------------

# Recode into new variables turning don't know and missing values into 0 - this makes syntax for calculation simpler
data['PCMADBreastfeed_yn'] = np.where(data['PCMADBreastfeed'] == 1, 1, 0)
data['PCMADMeals_r'] = np.where(data['PCMADMeals'].between(1, 7), data['PCMADMeals'], 0)
data['PCMADInfFormulaNum_r'] = np.where(data['PCMADInfFormulaNum'].between(1, 7), data['PCMADInfFormulaNum'], 0)
data['PCMADMilkNum_r'] = np.where(data['PCMADMilkNum'].between(1, 7), data['PCMADMilkNum'], 0)
data['PCMADYogurtDrinkNum_r'] = np.where(data['PCMADYogurtDrinkNum'].between(1, 7), data['PCMADYogurtDrinkNum'], 0)

data['MMF'] = np.where(
    (data['PCMADBreastfeed_yn'] == 1) & (data['PCMADChildAge_months'].between(6, 8)) & (data['PCMADMeals_r'] >= 2), 1,
    np.where(
        (data['PCMADBreastfeed_yn'] == 1) & (data['PCMADChildAge_months'].between(9, 23)) & (data['PCMADMeals_r'] >= 3), 1,
        np.where(
            (data['PCMADBreastfeed_yn'] == 0) & (data['PCMADMeals_r'] >= 1) & (data['PCMADMeals_r'] + data['PCMADInfFormulaNum_r'] + data['PCMADMilkNum_r'] + data['PCMADYogurtDrinkNum_r'] >= 4), 1,
            0
        )
    )
)

data['MMF'].attrs['label'] = 'Minimum Meal Frequency (MMF)'
data['MMF'] = data['MMF'].astype('category')
data['MMF'].cat.rename_categories({
    0: 'Does not meet MMF',
    1: 'Meets MMF'
}, inplace=True)

#-------------------------------------------------------------------------------
# 6. Calculate Minimum Milk Feeding Frequency for non-breastfed children 6-23 months (MMFF)
#-------------------------------------------------------------------------------

data['MMFF'] = np.where(
    (data['PCMADBreastfeed_yn'] == 0) & (data['PCMADInfFormulaNum_r'] + data['PCMADMilkNum_r'] + data['PCMADYogurtDrinkNum_r'] >= 2), 1, 0
)

data['MMFF'].attrs['label'] = 'Minimum Milk Feeding Frequency for non-breastfed children (MMFF)'
data['MMFF'] = data['MMFF'].astype('category')
data['MMFF'].cat.rename_categories({
    0: 'Does not meet MMFF',
    1: 'Meets MMFF'
}, inplace=True)

#-------------------------------------------------------------------------------
# 7. Calculate Minimum Acceptable Diet (MAD)
#-------------------------------------------------------------------------------

# For breastfed infants: if MDD and MMF are both achieved, then MAD is achieved
# For non-breastfed infants: if MDD, MMF and MMFF are all achieved, then MAD is achieved

# Using MDD for population assessments
data['MAD'] = np.where(
    (data['PCMADBreastfeed_yn'] == 1) & (data['MDD'] == 1) & (data['MMF'] == 1), 1,
    np.where(
        (data['PCMADBreastfeed_yn'] == 0) & (data['MDD'] == 1) & (data['MMF'] == 1) & (data['MMFF'] == 1), 1, 0
    )
)

data['MAD'].attrs['label'] = 'Minimum Acceptable Diet (MAD)'
data['MAD'] = data['MAD'].astype('category')
data['MAD'].cat.rename_categories({
    0: 'Does not meet MAD',
    1: 'Meets MAD'
}, inplace=True)

# Using MDD for WFP program monitoring
data['MAD_wfp'] = np.where(
    (data['PCMADBreastfeed_yn'] == 1) & (data['MDD_wfp'] == 1) & (data['MMF'] == 1), 1,
    np.where(
        (data['PCMADBreastfeed_yn'] == 0) & (data['MDD_wfp'] == 1) & (data['MMF'] == 1) & (data['MMFF'] == 1), 1, 0
    )
)

data['MAD_wfp'].attrs['label'] = 'Minimum Acceptable Diet for WFP program monitoring (MAD)'
data['MAD_wfp'] = data['MAD_wfp'].astype('category')
data['MAD_wfp'].cat.rename_categories({
    0: 'Does not meet MAD',
    1: 'Meets MAD'
}, inplace=True)

#-------------------------------------------------------------------------------
# 8. Frequency of MAD
#-------------------------------------------------------------------------------

mad_freq = data['MAD'].value_counts(normalize=True) * 100
mad_wfp_freq = data['MAD_wfp'].value_counts(normalize=True) * 100

print("Frequency of MAD:")
print(mad_freq)
print("\nFrequency of MAD_wfp:")
print(mad_wfp_freq)

# End of Scripts