#------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#                  Minimum Acceptable Diet (MAD) Calculation
#------------------------------------------------------------------------------

# Construction of the Minimum Acceptable Diet (MAD) is based on the 
# codebook questions prepared for the MAD module.

#-------------------------------------------------------------------------------*
# 1. Rename variables to remove group names
#-------------------------------------------------------------------------------*

library(tidyverse)
library(labelled)
library(expss)

data <- read_csv("~/GitHub/RAMResourcesScripts/Static/Nut_MAD_Sample_Survey/MAD_submodule_RepeatMAD.csv")

data <- data %>% rename(
  PCMADChildAge_months   = 'MAD_submodule/RepeatMAD/PCMADChildAge_months',
  PCMADBreastfeed        = 'MAD_submodule/RepeatMAD/PCMADBreastfeed',
  PCMADInfFormula        = 'MAD_submodule/RepeatMAD/PCMADInfFormula',
  PCMADInfFormulaNum     = 'MAD_submodule/RepeatMAD/PCMADInfFormulaNum',
  PCMADMilk              = 'MAD_submodule/RepeatMAD/PCMADMilk',
  PCMADMilkNum           = 'MAD_submodule/RepeatMAD/PCMADMilkNum',
  PCMADYogurtDrink       = 'MAD_submodule/RepeatMAD/PCMADYogurtDrink',
  PCMADYogurtDrinkNum    = 'MAD_submodule/RepeatMAD/PCMADYogurtDrinkNum',
  PCMADYogurt            = 'MAD_submodule/RepeatMAD/PCMADYogurt',
  PCMADStapCer           = 'MAD_submodule/RepeatMAD/PCMADStapCer',
  PCMADVegOrg            = 'MAD_submodule/RepeatMAD/PCMADVegOrg',
  PCMADStapRoo           = 'MAD_submodule/RepeatMAD/PCMADStapRoo',
  PCMADVegGre            = 'MAD_submodule/RepeatMAD/PCMADVegGre',
  PCMADVegOth            = 'MAD_submodule/RepeatMAD/PCMADVegOth',
  PCMADFruitOrg          = 'MAD_submodule/RepeatMAD/PCMADFruitOrg',
  PCMADFruitOth          = 'MAD_submodule/RepeatMAD/PCMADFruitOth',
  PCMADPrMeatO           = 'MAD_submodule/RepeatMAD/PCMADPrMeatO',
  PCMADPrMeatPro         = 'MAD_submodule/RepeatMAD/PCMADPrMeatPro',
  PCMADPrMeatF           = 'MAD_submodule/RepeatMAD/PCMADPrMeatF', 
  PCMADPrEgg             = 'MAD_submodule/RepeatMAD/PCMADPrEgg',
  PCMADPrFish            = 'MAD_submodule/RepeatMAD/PCMADPrFish',
  PCMADPulse             = 'MAD_submodule/RepeatMAD/PCMADPulse',
  PCMADCheese            = 'MAD_submodule/RepeatMAD/PCMADCheese',
  PCMADSnf               = 'MAD_submodule/RepeatMAD/PCMADSnf',
  PCMADMeals             = 'MAD_submodule/RepeatMAD/PCMADMeals'
)

#-------------------------------------------------------------------------------*
# 2. Define variable and value labels
#-------------------------------------------------------------------------------*

var_label(data$PCMADChildAge_months)  <- 'What is the age in months of ${PCMADChildName}?'
var_label(data$PCMADBreastfeed)       <- 'Was ${PCMADChildName} breastfed yesterday during the day or at night?'
var_label(data$PCMADInfFormula)       <- 'Infant formula, such as [insert local names of common formula]?'
var_label(data$PCMADInfFormulaNum)    <- 'How many times did ${PCMADChildName} drink formula?'
var_label(data$PCMADMilk)             <- 'Milk from animals, such as fresh, tinned or powdered milk?'
var_label(data$PCMADMilkNum)          <- 'How many times did ${PCMADChildName} drink milk from animals, such as fresh, tinned or powdered milk?'
var_label(data$PCMADYogurtDrink)      <- 'Yogurt drinks such as [insert local names of common types of yogurt drinks]?'
var_label(data$PCMADYogurtDrinkNum)   <- 'How many times did ${PCMADChildName} drink Yogurt drinks such as [insert local names of common types of yogurt drinks]?'
var_label(data$PCMADYogurt)           <- 'Yogurt, other than yogurt drinks?'
var_label(data$PCMADStapCer)          <- 'Porridge, bread, rice, noodles, pasta or [insert other commonly consumed grains, including foods made from grains like rice dishes, noodle dishes, etc.]?'
var_label(data$PCMADVegOrg)           <- 'Pumpkin, carrots, sweet red peppers, squash or sweet potatoes that are yellow or orange inside?'
var_label(data$PCMADStapRoo)          <- 'Plantains, white potatoes, white yams, manioc, cassava or [insert other commonly consumed starchy tubers or starchy tuberous roots that are white or pale inside]?'
var_label(data$PCMADVegGre)           <- 'Dark green leafy vegetables, such as [insert commonly consumed vitamin A-rich dark green leafy vegetables]?'
var_label(data$PCMADVegOth)           <- 'Any other vegetables, such as [insert commonly consumed vegetables]?'
var_label(data$PCMADFruitOrg)         <- 'Ripe mangoes or ripe papayas or [insert other commonly consumed vitamin A-rich fruits]?'
var_label(data$PCMADFruitOth)         <- 'Any other fruits, such as [insert commonly consumed fruits]?'
var_label(data$PCMADPrMeatO)          <- 'Liver, kidney, heart or [insert other commonly consumed organ meats]?'
var_label(data$PCMADPrMeatPro)        <- 'Sausages, hot dogs/frankfurters, ham, bacon, salami, canned meat or [insert other commonly consumed processed meats]?'
var_label(data$PCMADPrMeatF)          <- 'Any other meat, such as beef, pork, lamb, goat, chicken, duck or [insert other commonly consumed meat]?'
var_label(data$PCMADPrEgg)            <- 'Eggs'
var_label(data$PCMADPrFish)           <- 'Fresh or dried fish, shellfish or seafood'
var_label(data$PCMADPulse)            <- 'Beans, peas, lentils, nuts, seeds or [insert commonly consumed foods made from beans, peas, lentils, nuts, or seeds]?'
var_label(data$PCMADCheese)           <- 'Hard or soft cheese such as [insert commonly consumed types of cheese]?'
var_label(data$PCMADSnf)              <- 'Specialized Nutritious Foods (SNF) such as [insert the SNFs distributed by WFP]?'
var_label(data$PCMADMeals)            <- 'How many times did ${PCMADChildName} eat any solid, semi-solid or soft foods yesterday during the day or night?'

data <- data %>%
  mutate(across(c(PCMADBreastfeed, PCMADInfFormula, PCMADMilk, PCMADYogurtDrink, PCMADYogurt, PCMADStapCer, PCMADVegOrg, PCMADStapRoo, PCMADVegGre, PCMADVegOth, PCMADFruitOrg,
                  PCMADFruitOth, PCMADPrMeatO, PCMADPrMeatPro, PCMADPrMeatF, PCMADPrEgg, PCMADPrFish, PCMADPulse, PCMADCheese, PCMADSnf), 
                ~labelled(., labels = c(
                  "No" = 0,
                  "Yes" = 1,
                  "Don't know" = 888
                ))))

#-------------------------------------------------------------------------------*
# 3. Create Minimum Dietary Diversity 6-23 months (MDD) for population assessments
#-------------------------------------------------------------------------------*

data <- data %>% mutate(
  MAD_BreastMilk        = if_else(PCMADBreastfeed == 1, 1, 0),
  MAD_PWMDDWStapCer     = if_else(PCMADStapCer == 1 | PCMADStapRoo == 1 | PCMADSnf == 1, 1, 0),
  MAD_PulsesNutsSeeds   = if_else(PCMADPulse == 1, 1, 0),
  MAD_Dairy             = if_else(PCMADInfFormula == 1 | PCMADMilk == 1 | PCMADYogurtDrink == 1 | PCMADYogurt == 1 | PCMADCheese == 1, 1, 0),
  MAD_MeatFish          = if_else(PCMADPrMeatO == 1 | PCMADPrMeatPro == 1 | PCMADPrMeatF == 1 | PCMADPrFish == 1, 1, 0),
  MAD_Eggs              = if_else(PCMADPrEgg == 1, 1, 0),
  MAD_VitA              = if_else(PCMADVegOrg == 1 | PCMADVegGre == 1 | PCMADFruitOrg == 1, 1, 0),
  MAD_OtherVegFruits    = if_else(PCMADFruitOth == 1 | PCMADVegOth == 1, 1, 0)
)

# Add together food groups to see how many food groups consumed
data <- data %>% mutate(MDD_score = MAD_BreastMilk + MAD_PWMDDWStapCer + MAD_PulsesNutsSeeds + MAD_Dairy + MAD_MeatFish + MAD_Eggs + MAD_VitA + MAD_OtherVegFruits)

# Create MDD variable which records whether child consumed five or more food groups
data <- data %>% mutate(MDD = if_else(MDD_score >= 5, 1, 0))

var_label(data$MDD) <- 'Minimum Dietary Diversity (MDD)'
val_lab(data$MDD) = num_lab("
             0 'Does not meet MDD'
             1 'Meets MDD'
")

#-------------------------------------------------------------------------------*
# 4. Create Minimum Dietary Diversity 6-23 months (MDD) for WFP programme monitoring
#-------------------------------------------------------------------------------*

data <- data %>% mutate(
  MAD_BreastMilk_wfp        = if_else(PCMADBreastfeed == 1, 1, 0),
  MAD_PWMDDWStapCer_wfp     = if_else(PCMADStapCer == 1 | PCMADStapRoo == 1, 1, 0),
  MAD_PulsesNutsSeeds_wfp   = if_else(PCMADPulse == 1, 1, 0),
  MAD_Dairy_wfp             = if_else(PCMADInfFormula == 1 | PCMADMilk == 1 | PCMADYogurtDrink == 1 | PCMADYogurt == 1 | PCMADCheese == 1, 1, 0),
  MAD_MeatFish_wfp          = if_else(PCMADPrMeatO == 1 | PCMADPrMeatPro == 1 | PCMADPrMeatF == 1 | PCMADPrFish == 1 | PCMADSnf == 1, 1, 0),
  MAD_Eggs_wfp              = if_else(PCMADPrEgg == 1, 1, 0),
  MAD_VitA_wfp              = if_else(PCMADVegOrg == 1 | PCMADVegGre == 1 | PCMADFruitOrg == 1, 1, 0),
  MAD_OtherVegFruits_wfp    = if_else(PCMADFruitOth == 1 | PCMADVegOth == 1, 1, 0)
)

# Add together food groups to see how many food groups consumed
data <- data %>% mutate(MDD_score_wfp = MAD_BreastMilk_wfp + MAD_PWMDDWStapCer_wfp + MAD_PulsesNutsSeeds_wfp + MAD_Dairy_wfp + MAD_MeatFish_wfp + MAD_Eggs_wfp + MAD_VitA_wfp + MAD_OtherVegFruits_wfp)

# Create MDD variable which records whether child consumed five or more food groups
data <- data %>% mutate(MDD_wfp = if_else(MDD_score_wfp >= 5, 1, 0))

var_label(data$MDD_wfp) <- 'Minimum Dietary Diversity for WFP program monitoring (MDD)'
val_lab(data$MDD_wfp) = num_lab("
             0 'Does not meet MDD'
             1 'Meets MDD'
")

#-------------------------------------------------------------------------------*
# 5. Calculate Minimum Meal Frequency 6-23 months (MMF)
#-------------------------------------------------------------------------------*

# Recode into new variables turning don't know and missing values into 0 - this makes syntax for calculation simpler
data <- data %>% mutate(
  PCMADBreastfeed_yn    = if_else(PCMADBreastfeed == 1, 1, 0),
  PCMADMeals_r          = if_else(between(PCMADMeals, 1, 7), PCMADMeals, 0),
  PCMADInfFormulaNum_r  = if_else(between(PCMADInfFormulaNum, 1, 7), PCMADInfFormulaNum, 0),
  PCMADMilkNum_r        = if_else(between(PCMADMilkNum, 1, 7), PCMADMilkNum, 0),
  PCMADYogurtDrinkNum_r = if_else(between(PCMADYogurtDrinkNum, 1, 7), PCMADYogurtDrinkNum, 0)
)

data <- data %>% mutate(MMF = case_when(
  PCMADBreastfeed_yn == 1 & between(PCMADChildAge_months, 6, 8) & PCMADMeals_r >= 2 ~ 1, 
  PCMADBreastfeed_yn == 1 & between(PCMADChildAge_months, 9, 23) & PCMADMeals_r >= 3 ~ 1, 
  PCMADBreastfeed_yn == 0 & PCMADMeals_r >= 1 & (PCMADMeals_r + PCMADInfFormulaNum_r + PCMADMilkNum_r + PCMADYogurtDrinkNum_r >= 4) ~ 1,
  TRUE ~ 0
))

var_label(data$MMF) <- 'Minimum Meal Frequency (MMF)'
val_lab(data$MMF) = num_lab("
             0 'Does not meet MMF'
             1 'Meets MMF'
")

#-------------------------------------------------------------------------------*
# 6. Calculate Minimum Milk Feeding Frequency for non-breastfed children 6-23 months (MMFF)
#-------------------------------------------------------------------------------*

data <- data %>% mutate(MMFF = case_when(
  PCMADBreastfeed_yn == 0 & (PCMADInfFormulaNum_r + PCMADMilkNum_r + PCMADYogurtDrinkNum_r >= 2) ~ 1,
  TRUE ~ 0
))

var_label(data$MMFF) <- 'Minimum Milk Feeding Frequency for non-breastfed children (MMFF)'
val_lab(data$MMFF) = num_lab("
             0 'Does not meet MMFF'
             1 'Meets MMFF'
")

#-------------------------------------------------------------------------------*
# 7. Calculate Minimum Acceptable Diet (MAD)
#-------------------------------------------------------------------------------*

# For breastfed infants: if MDD and MMF are both achieved, then MAD is achieved
# For non-breastfed infants: if MDD, MMF and MMFF are all achieved, then MAD is achieved

# Using MDD for population assessments
data <- data %>% mutate(MAD = case_when(
  PCMADBreastfeed_yn == 1 & MDD == 1 & MMF == 1 ~ 1,
  PCMADBreastfeed_yn == 0 & MDD == 1 & MMF == 1 & MMFF == 1 ~ 1,
  TRUE ~ 0
))

# Using MDD for WFP program monitoring
data <- data %>% mutate(MAD_wfp = case_when(
  PCMADBreastfeed_yn == 1 & MDD_wfp == 1 & MMF == 1 ~ 1,
  PCMADBreastfeed_yn == 0 & MDD_wfp == 1 & MMF == 1 & MMFF == 1 ~ 1,
  TRUE ~ 0
))

var_label(data$MAD) <- 'Minimum Acceptable Diet (MAD)'
val_lab(data$MAD) = num_lab("
             0 'Does not meet MAD'
             1 'Meets MAD'
")

#-------------------------------------------------------------------------------*
# 8. Frequency of MAD
#-------------------------------------------------------------------------------*

table(data$MAD)
table(data$MAD_wfp)

# End of Scripts