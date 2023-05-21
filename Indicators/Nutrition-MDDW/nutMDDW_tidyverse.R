library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/Nut_MDDW/Nutrition_module_MDD_W_submodule_RepeatMDDW.csv")

#can only download repeat csv data as zip file from moda with group names - will update this code with more elegant solution to remove group names or if you download as SPSS you can skip this step
#rename to remove group names
data <- data %>% rename(PWMDDWStapCer = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWStapCer',
                        PWMDDWStapRoo = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWStapRoo',
                        PWMDDWPulse = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWPulse', 
                        PWMDDWNuts = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWNuts', 
                        PWMDDWMilk = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWMilk', 
                        PWMDDWDairy = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWDairy', 
                        PWMDDWPrMeatO = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWPrMeatO', 
                        PWMDDWPrMeatF = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWPrMeatF', 
                        PWMDDWPrMeatPro = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWPrMeatPro',
                        PWMDDWPrMeatWhite = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWPrMeatWhite',
                        PWMDDWPrFish = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWPrFish',
                        PWMDDWPrEgg = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWPrEgg',
                        PWMDDWVegGre = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWVegGre',
                        PWMDDWVegOrg = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWVegOrg',
                        PWMDDWFruitOrg = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFruitOrg',
                        PWMDDWVegOth = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWVegOth',
                        PWMDDWFruitOth = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFruitOth',
                        PWMDDWSnf = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWSnf',
                        PWMDDWFortFoodoil = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFortFoodoil',
                        PWMDDWFortFoodwflour = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFortFoodwflour',
                        PWMDDWFortFoodmflour = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFortFoodmflour',
                        PWMDDWFortFoodrice = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFortFoodrice',
                        PWMDDWFortFooddrink = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFortFooddrink',
                        PWMDDWFortFoodother = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFortFoodother',
                        PWMDDWFortFoodother_oth = 'Nutrition_module/MDD_W_submodule/RepeatMDDW/PWMDDWFortFoodother_oth',
                        )

#assign variable and value labels

var_label(data$PWMDDWStapCer) <- "Foods made from grains"
var_label(data$PWMDDWStapRoo) <- "White roots and tubers or plantains"
var_label(data$PWMDDWPulse) <- "Pulses (beans, peas and lentils) "
var_label(data$PWMDDWNuts) <- "Nuts and seeds "
var_label(data$PWMDDWMilk) <- "Milk"
var_label(data$PWMDDWDairy) <- "Milk products"
var_label(data$PWMDDWPrMeatO) <- "Organ meats"
var_label(data$PWMDDWPrMeatF) <- "Red flesh meat from mammals"
var_label(data$PWMDDWPrMeatPro) <- "Processed meat"
var_label(data$PWMDDWPrMeatWhite) <- "Poultry and other white meats"
var_label(data$PWMDDWPrFish) <- "Fish and Seafood"
var_label(data$PWMDDWPrEgg) <- "Eggs from poultry or any other bird"
var_label(data$PWMDDWVegGre) <- "Dark green leafy vegetable"
var_label(data$PWMDDWVegOrg) <- "Vitamin A-rich vegetables, roots and tubers"
var_label(data$PWMDDWFruitOrg) <- "Vitamin A-rich fruits"
var_label(data$PWMDDWVegOth) <- "Other vegetables"
var_label(data$PWMDDWFruitOth) <- "Other fruits"
var_label(data$PWMDDWSnf) <- "Specialized Nutritious Foods (SNF) for women"
var_label(data$PWMDDWFortFoodoil) <- "Fortified oil"
var_label(data$PWMDDWFortFoodwflour) <- "Fortified wheat flour"
var_label(data$PWMDDWFortFoodmflour) <- "Fortified maize flour"
var_label(data$PWMDDWFortFoodrice) <- "Fortified Rice"
var_label(data$PWMDDWFortFooddrink) <- "Fortified drink"
var_label(data$PWMDDWFortFoodother) <- "Other:"
var_label(data$PWMDDWFortFoodother_oth) <- "Other: please specify: ____________"

data <- data %>%
  mutate(across(c(PWMDDWStapCer,PWMDDWStapRoo,PWMDDWPulse,PWMDDWNuts,PWMDDWMilk,PWMDDWDairy,PWMDDWPrMeatO,PWMDDWPrMeatF,PWMDDWPrMeatPro,PWMDDWPrMeatWhite,PWMDDWPrFish,PWMDDWPrEgg,
                  PWMDDWVegGre,PWMDDWVegOrg,PWMDDWFruitOrg,PWMDDWVegOth,PWMDDWFruitOth,PWMDDWSnf,PWMDDWFortFoodoil,PWMDDWFortFoodwflour,PWMDDWFortFoodmflour,PWMDDWFortFoodrice,PWMDDWFortFooddrink,PWMDDWFortFoodother), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1
  ))))


#Calculate 2 MDDW indicators based on WFP guidelines https://docs.wfp.org/api/documents/WFP-0000140197/download/ pg.8
#Standard MDDW Indicator for population based surveys - counts SNF in home group (refer to https://docs.wfp.org/api/documents/WFP-0000139484/download/ for "home group")
#WFP Modified MDDW WFP programme monitoring - counts SNF in "Meat, poultry and fish" Category

#Standard MDDW method - in this example SNF home group will be grains
#in this example fortified foods PWMDDWFortFoodwflour,PWMDDWFortFoodmflour,PWMDDWFortFoodrice,PWMDDWFortFooddrink will also count in grains
#classifying PWMDDWFortFoodother_oth will likely involve classifying line by line 
data <- data %>% mutate(
                        MDDW_Staples = case_when(
                            PWMDDWStapCer == 1 |  PWMDDWStapRoo == 1 | PWMDDWSnf == 1 | PWMDDWFortFoodwflour == 1 | PWMDDWFortFoodmflour == 1 | PWMDDWFortFoodrice == 1 | PWMDDWFortFooddrink == 1 ~ 1, TRUE ~ 0),
                        MDDW_Pulses = case_when(
                            PWMDDWPulse == 1 ~ 1, TRUE ~ 0),
                        MDDW_NutsSeeds  = case_when(
                            PWMDDWNuts == 1 ~ 1, TRUE ~ 0),
                        MDDW_Dairy  = case_when(
                            PWMDDWDairy == 1 | PWMDDWMilk == 1 ~ 1, TRUE ~ 0),
                        MDDW_MeatFish  = case_when(
                            PWMDDWPrMeatO == 1 | PWMDDWPrMeatF == 1 | PWMDDWPrMeatPro == 1 | PWMDDWPrMeatWhite == 1 |  PWMDDWPrFish == 1 ~ 1, TRUE ~ 0),
                        MDDW_Eggs  = case_when(
                            PWMDDWPrEgg == 1 ~ 1, TRUE ~ 0),
                        MDDW_LeafGreenVeg  = case_when(
                            PWMDDWVegGre == 1 ~ 1, TRUE ~ 0),
                        MDDW_VitA  = case_when(
                            PWMDDWVegOrg == 1 | PWMDDWFruitOrg == 1 ~ 1, TRUE ~ 0),
                        MDDW_OtherVeg  = case_when(
                            PWMDDWVegOth == 1 ~ 1, TRUE ~ 0),
                        MDDW_OtherFruits  = case_when(
                            PWMDDWFruitOth == 1 ~ 1, TRUE ~ 0)
                        )

#WFP MDDW method for program monitoring - SNF will count in the meats group
#in this example fortified foods PWMDDWFortFoodwflour,PWMDDWFortFoodmflour,PWMDDWFortFoodrice,PWMDDWFortFooddrink will also count in grains
#classifying PWMDDWFortFoodother_oth will likely involve classifying line by line 
data <- data %>% mutate(
  MDDW_Staples_wfp = case_when(
    PWMDDWStapCer == 1 |  PWMDDWStapRoo == 1 | PWMDDWFortFoodwflour == 1 | PWMDDWFortFoodmflour == 1 | PWMDDWFortFoodrice == 1 | PWMDDWFortFooddrink == 1 ~ 1, TRUE ~ 0),
  MDDW_Pulses_wfp = case_when(
    PWMDDWPulse == 1 ~ 1, TRUE ~ 0),
  MDDW_NutsSeeds_wfp  = case_when(
    PWMDDWNuts == 1 ~ 1, TRUE ~ 0),
  MDDW_Dairy_wfp  = case_when(
    PWMDDWDairy == 1 | PWMDDWMilk == 1 ~ 1, TRUE ~ 0),
  MDDW_MeatFish_wfp  = case_when(
    PWMDDWPrMeatO == 1 | PWMDDWPrMeatF == 1 | PWMDDWPrMeatPro == 1 | PWMDDWPrMeatWhite == 1 |  PWMDDWPrFish == 1 | PWMDDWSnf == 1 ~ 1, TRUE ~ 0),
  MDDW_Eggs_wfp  = case_when(
    PWMDDWPrEgg == 1 ~ 1, TRUE ~ 0),
  MDDW_LeafGreenVeg_wfp  = case_when(
    PWMDDWVegGre == 1 ~ 1, TRUE ~ 0),
  MDDW_VitA_wfp  = case_when(
    PWMDDWVegOrg == 1 | PWMDDWFruitOrg == 1 ~ 1, TRUE ~ 0),
  MDDW_OtherVeg_wfp  = case_when(
    PWMDDWVegOth == 1 ~ 1, TRUE ~ 0),
  MDDW_OtherFruits_wfp  = case_when(
    PWMDDWFruitOth == 1 ~ 1, TRUE ~ 0)
)


#calculate MDDW variable for both methods by adding together food groups and classifying whether the woman consumed 5 or more food groups

#Standard MDDW method where SNF is counted in grains
data <- data %>% mutate(MDDW = MDDW_Staples +MDDW_Pulses +MDDW_NutsSeeds +MDDW_Dairy +MDDW_MeatFish +MDDW_Eggs +MDDW_LeafGreenVeg +MDDW_VitA +MDDW_OtherVeg +MDDW_OtherFruits)
#count how many women consumed 5 or more groups
data <- data %>% mutate(MDDW_5 = case_when(
                        MDDW >= 5 ~ ">=5", TRUE ~ "<5"
))
#WFP MDDW method for program monitoring - SNF will count in the meats group
data <- data %>% mutate(MDDW_wfp = MDDW_Staples_wfp +MDDW_Pulses_wfp +MDDW_NutsSeeds_wfp +MDDW_Dairy_wfp +MDDW_MeatFish_wfp +MDDW_Eggs_wfp +MDDW_LeafGreenVeg_wfp +MDDW_VitA_wfp +MDDW_OtherVeg_wfp +MDDW_OtherFruits_wfp)
#count how many women consumed 5 or more groups
data <- data %>% mutate(MDDW_5_wfp = case_when(
  MDDW_wfp >= 5 ~ ">=5", TRUE ~ "<5"
))

#creates a table of the weighted percentage of Standard MDDW Method - MDDW_5 
#and providing the option to use weights if needed

MDDW_5_table_wide <- data %>% 
  drop_na(MDDW_5) %>%
  count(MDDW_5) %>% # if weights are needed use instead the row below 
  #count(MDDW_5, wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = MDDW_5,
              values_from = Percentage,
              values_fill =  0) 

#creates a table of the weighted percentage of WFP MDDW method for program monitoring MDDW_5_wfp
#and providing the option to use weights if needed


MDDW_5_wfp_table_wide <- data %>% 
  drop_na(MDDW_5_wfp) %>%
  count(MDDW_5_wfp) %>% # if weights are needed use instead the row below 
  #count(MDDW_5_wfp, wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = MDDW_5_wfp,
              values_from = Percentage,
              values_fill =  0) 





