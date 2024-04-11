library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/SBP_CRF_63and93_Sample_Survey/SBPProcessM_module_SchoolAgeChildRoster_submodule_RepeatSchoolAgeChild.csv")

#background document on this indicator https://wfp.sharepoint.com/sites/CRF2022-2025/CRF%20Outcome%20indicators/Forms/AllItems.aspx?id=%2Fsites%2FCRF2022%2D2025%2FCRF%20Outcome%20indicators%2F2%2E%20Nutrition%2F63%2E%20Percentage%20of%20school%2Daged%20children%20meeting%20minimum%20dietary%20diversity%20score%20%5BNEW%5D%2Epdf&viewid=68ec615a%2D665b%2D4f2d%2Da495%2D9e5f10bc60b2&parent=%2Fsites%2FCRF2022%2D2025%2FCRF%20Outcome%20indicators%2F2%2E%20Nutrition


#unfortunately you can only download repeat csv data as zip file from moda with group names - will update this code with more elegant solution to remove group names or if you download as SPSS you can skip this step
#rename to remove group names
data <- data %>% rename(PSchoolAgeDDSStapCer = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSStapCer',
                        PSchoolAgeDDSStapRoo = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSStapRoo',
                        PSchoolAgeDDSPulse = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSPulse', 
                        PSchoolAgeDDSNuts = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSNuts', 
                        PSchoolAgeDDSMilk = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSMilk', 
                        PSchoolAgeDDSDairy = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSDairy', 
                        PSchoolAgeDDSPrMeatO = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSPrMeatO', 
                        PSchoolAgeDDSPrMeatF = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSPrMeatF', 
                        PSchoolAgeDDSPrMeatPro = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSPrMeatPro',
                        PSchoolAgeDDSPrMeatWhite = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSPrMeatWhite',
                        PSchoolAgeDDSPrFish = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSPrFish',
                        PSchoolAgeDDSPrEgg = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSPrEgg',
                        PSchoolAgeDDSVegGre = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSVegGre',
                        PSchoolAgeDDSVegOrg = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSVegOrg',
                        PSchoolAgeDDSFruitOrg = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSFruitOrg',
                        PSchoolAgeDDSVegOth = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSVegOth',
                        PSchoolAgeDDSFruitOth = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSFruitOth',
                        PSchoolAgeDDSSnf = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSSnf',
                        PSchoolAgeDDSFortFoodoil = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSFortFoodoil',
                        PSchoolAgeDDSFortFoodwflour = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSFortFoodwflour',
                        PSchoolAgeDDSFortFoodmflour = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSFortFoodmflour',
                        PSchoolAgeDDSFortFoodrice = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSFortFoodrice',
                        PSchoolAgeDDSFortFooddrink = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSFortFooddrink',
                        PSchoolAgeDDSFortFoodother = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSFortFoodother',
                        PSchoolAgeDDSFortFoodother_oth = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PSchoolAgeDDSFortFoodother_oth',
                        )

#assign variable and value labels

var_label(data$PSchoolAgeDDSStapCer) <- "Foods made from grains"
var_label(data$PSchoolAgeDDSStapRoo) <- "White roots and tubers or plantains"
var_label(data$PSchoolAgeDDSPulse) <- "Pulses (beans, peas and lentils) "
var_label(data$PSchoolAgeDDSNuts) <- "Nuts and seeds "
var_label(data$PSchoolAgeDDSMilk) <- "Milk"
var_label(data$PSchoolAgeDDSDairy) <- "Milk products"
var_label(data$PSchoolAgeDDSPrMeatO) <- "Organ meats"
var_label(data$PSchoolAgeDDSPrMeatF) <- "Red flesh meat from mammals"
var_label(data$PSchoolAgeDDSPrMeatPro) <- "Processed meat"
var_label(data$PSchoolAgeDDSPrMeatWhite) <- "Poultry and other white meats"
var_label(data$PSchoolAgeDDSPrFish) <- "Fish and Seafood"
var_label(data$PSchoolAgeDDSPrEgg) <- "Eggs from poultry or any other bird"
var_label(data$PSchoolAgeDDSVegGre) <- "Dark green leafy vegetable"
var_label(data$PSchoolAgeDDSVegOrg) <- "Vitamin A-rich vegetables, roots and tubers"
var_label(data$PSchoolAgeDDSFruitOrg) <- "Vitamin A-rich fruits"
var_label(data$PSchoolAgeDDSVegOth) <- "Other vegetables"
var_label(data$PSchoolAgeDDSFruitOth) <- "Other fruits"
var_label(data$PSchoolAgeDDSSnf) <- "Specialized Nutritious Foods (SNF) for women"
var_label(data$PSchoolAgeDDSFortFoodoil) <- "Fortified oil"
var_label(data$PSchoolAgeDDSFortFoodwflour) <- "Fortified wheat flour"
var_label(data$PSchoolAgeDDSFortFoodmflour) <- "Fortified maize flour"
var_label(data$PSchoolAgeDDSFortFoodrice) <- "Fortified Rice"
var_label(data$PSchoolAgeDDSFortFooddrink) <- "Fortified drink"
var_label(data$PSchoolAgeDDSFortFoodother) <- "Other:"
var_label(data$PSchoolAgeDDSFortFoodother_oth) <- "Other: please specify: ____________"

data <- data %>%
  mutate(across(c(PSchoolAgeDDSStapCer,PSchoolAgeDDSStapRoo,PSchoolAgeDDSPulse,PSchoolAgeDDSNuts,PSchoolAgeDDSMilk,PSchoolAgeDDSDairy,PSchoolAgeDDSPrMeatO,PSchoolAgeDDSPrMeatF,PSchoolAgeDDSPrMeatPro,PSchoolAgeDDSPrMeatWhite,PSchoolAgeDDSPrFish,PSchoolAgeDDSPrEgg,
                  PSchoolAgeDDSVegGre,PSchoolAgeDDSVegOrg,PSchoolAgeDDSFruitOrg,PSchoolAgeDDSVegOth,PSchoolAgeDDSFruitOth,PSchoolAgeDDSSnf,PSchoolAgeDDSFortFoodoil,PSchoolAgeDDSFortFoodwflour,PSchoolAgeDDSFortFoodmflour,PSchoolAgeDDSFortFoodrice,PSchoolAgeDDSFortFooddrink,PSchoolAgeDDSFortFoodother), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1
  ))))


#Calculate School Age Dietary Diversity Score based on WFP MDDW guidelines https://docs.wfp.org/api/documents/WFP-0000140197/download/ pg.8
#Following the WFP MDDW method for program monitoring - SNF will count in the meats group
#in this example fortified foods PSchoolAgeDDSFortFoodwflour,PSchoolAgeDDSFortFoodmflour,PSchoolAgeDDSFortFoodrice,PSchoolAgeDDSFortFooddrink will also count in grains
#classifying PSchoolAgeDDSFortFoodother_oth will likely involve classifying line by line 
data <- data %>% mutate(
  PSchoolAgeDDS_Staples_wfp = case_when(
    PSchoolAgeDDSStapCer == 1 |  PSchoolAgeDDSStapRoo == 1 | PSchoolAgeDDSFortFoodwflour == 1 | PSchoolAgeDDSFortFoodmflour == 1 | PSchoolAgeDDSFortFoodrice == 1 | PSchoolAgeDDSFortFooddrink == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_Pulses_wfp = case_when(
    PSchoolAgeDDSPulse == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_NutsSeeds_wfp  = case_when(
    PSchoolAgeDDSNuts == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_Dairy_wfp  = case_when(
    PSchoolAgeDDSDairy == 1 | PSchoolAgeDDSMilk == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_MeatFish_wfp  = case_when(
    PSchoolAgeDDSPrMeatO == 1 | PSchoolAgeDDSPrMeatF == 1 | PSchoolAgeDDSPrMeatPro == 1 | PSchoolAgeDDSPrMeatWhite == 1 |  PSchoolAgeDDSPrFish == 1 | PSchoolAgeDDSSnf == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_Eggs_wfp  = case_when(
    PSchoolAgeDDSPrEgg == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_LeafGreenVeg_wfp  = case_when(
    PSchoolAgeDDSVegGre == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_VitA_wfp  = case_when(
    PSchoolAgeDDSVegOrg == 1 | PSchoolAgeDDSFruitOrg == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_OtherVeg_wfp  = case_when(
    PSchoolAgeDDSVegOth == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_OtherFruits_wfp  = case_when(
    PSchoolAgeDDSFruitOth == 1 ~ 1, TRUE ~ 0)
)


#calculate SchoolAge Dietary Diversity Score variable for both methods by adding together food groups and classifying whether the child consumed 5 or more food groups


#WFP method for program monitoring - SNF will count in the meats group
data <- data %>% mutate(SchoolAgeDDS_wfp = PSchoolAgeDDS_Staples_wfp +PSchoolAgeDDS_Pulses_wfp +PSchoolAgeDDS_NutsSeeds_wfp +PSchoolAgeDDS_Dairy_wfp +PSchoolAgeDDS_MeatFish_wfp +PSchoolAgeDDS_Eggs_wfp +PSchoolAgeDDS_LeafGreenVeg_wfp +PSchoolAgeDDS_VitA_wfp +PSchoolAgeDDS_OtherVeg_wfp +PSchoolAgeDDS_OtherFruits_wfp)
#count how many women consumed 5 or more groups
data <- data %>% mutate(SchoolAgeDDS_5_wfp = case_when(
  SchoolAgeDDS_wfp >= 5 ~ ">=5", TRUE ~ "<5"
))


#creates a table of the weighted percentage of WFP MDDW method for program monitoring MDDW_5_wfp
#and providing the option to use weights if needed


SchoolAgeDDS_5_wfp_table_wide <- data %>% 
  drop_na(SchoolAgeDDS_5_wfp) %>%
  count(SchoolAgeDDS_5_wfp) %>% # if weights are needed use instead the row below 
  #count(SchoolAgeDDS_5_wfp, wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = SchoolAgeDDS_5_wfp,
              values_from = Percentage,
              values_fill =  0) 





