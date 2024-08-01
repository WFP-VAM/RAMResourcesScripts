#------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#          School Age Dietary Diversity Score (SADD) Calculation
#------------------------------------------------------------------------------

# This script calculates the School Age Dietary Diversity Score (SADD) based on 
# WFP MDDW guidelines. Specialized Nutritious Foods (SNF) will count in the 
# meats group, and fortified foods will also count in grains.
# Detailed guidelines can be found at:
# https://docs.wfp.org/api/documents/WFP-0000140197/download/

# This syntax is based on SPSS download version from MoDA.
# Following the WFP MDDW method for program monitoring - SNF will count in the meats group.
# In this example, fortified foods (PSchoolAgeDDSFortFoodwflour, PSchoolAgeDDSFortFoodmflour, PSchoolAgeDDSFortFoodrice, PSchoolAgeDDSFortFooddrink)
# will also count in grains. Classifying PSchoolAgeDDSFortFoodother_oth will likely involve classifying line by line.
# More details can be found in the background document at: 
# https://wfp.sharepoint.com/sites/CRF2022-2025/CRF%20Outcome%20indicators/Forms/AllItems.aspx?id=%2Fsites%2FCRF2022%2D2025%2FCRF%20Outcome%20indicators%2F2%2E%20Nutrition%2F63%2E%20Percentage%20of%20school%2Daged%20children%20meeting%20minimum%20dietary%20diversity%20score%20%5BNEW%5D%2Epdf&viewid=68ec615a%2D665b%2D4f2d%2Da495%2D9e5f10bc60b2&parent=%2Fsites%2FCRF2022%2D2025%2FCRF%20Outcome%20indicators%2F2%2E%20Nutrition

library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("~/github/ramresourcesscripts/static/sbp_crf_63and93_sample_survey/sbpprocessm_module_schoolagechildroster_submodule_repeatschoolagechild.csv")

#background document on this indicator https://wfp.sharepoint.com/sites/crf2022-2025/crf%20outcome%20indicators/forms/allitems.aspx?id=%2fsites%2fcrf2022%2d2025%2fcrf%20outcome%20indicators%2f2%2e%20nutrition%2f63%2e%20percentage%20of%20school%2daged%20children%20meeting%20minimum%20dietary%20diversity%20score%20%5bnew%5d%2epdf&viewid=68ec615a%2d665b%2d4f2d%2da495%2d9e5f10bc60b2&parent=%2fsites%2fcrf2022%2d2025%2fcrf%20outcome%20indicators%2f2%2e%20nutrition


#unfortunately you can only download repeat csv data as zip file from moda with group names - will update this code with more elegant solution to remove group names or if you download as spss you can skip this step
#rename to remove group names
data <- data %>% rename(pschoolageddsstapcer = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsstapcer',
                        pschoolageddsstaproo = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsstaproo',
                        pschoolageddspulse = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddspulse', 
                        pschoolageddsnuts = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsnuts', 
                        pschoolageddsmilk = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsmilk', 
                        pschoolageddsdairy = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsdairy', 
                        pschoolageddsprmeato = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsprmeato', 
                        pschoolageddsprmeatf = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsprmeatf', 
                        pschoolageddsprmeatpro = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsprmeatpro',
                        pschoolageddsprmeatwhite = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsprmeatwhite',
                        pschoolageddsprfish = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsprfish',
                        pschoolageddspregg = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddspregg',
                        pschoolageddsveggre = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsveggre',
                        pschoolageddsvegorg = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsvegorg',
                        pschoolageddsfruitorg = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfruitorg',
                        pschoolageddsvegoth = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsvegoth',
                        pschoolageddsfruitoth = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfruitoth',
                        pschoolageddssnf = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddssnf',
                        pschoolageddsfortfoodoil = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfortfoodoil',
                        pschoolageddsfortfoodwflour = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfortfoodwflour',
                        pschoolageddsfortfoodmflour = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfortfoodmflour',
                        pschoolageddsfortfoodrice = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfortfoodrice',
                        pschoolageddsfortfooddrink = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfortfooddrink',
                        pschoolageddsfortfoodother = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfortfoodother',
                        pschoolageddsfortfoodother_oth = 'sbpprocessm_module/schoolagechildroster_submodule/repeatschoolagechild/pschoolageddsfortfoodother_oth',
                        )

#assign variable and value labels

var_label(data$pschoolageddsstapcer) <- "foods made from grains"
var_label(data$pschoolageddsstaproo) <- "white roots and tubers or plantains"
var_label(data$pschoolageddspulse) <- "pulses (beans, peas and lentils) "
var_label(data$pschoolageddsnuts) <- "nuts and seeds "
var_label(data$pschoolageddsmilk) <- "milk"
var_label(data$pschoolageddsdairy) <- "milk products"
var_label(data$pschoolageddsprmeato) <- "organ meats"
var_label(data$pschoolageddsprmeatf) <- "red flesh meat from mammals"
var_label(data$pschoolageddsprmeatpro) <- "processed meat"
var_label(data$pschoolageddsprmeatwhite) <- "poultry and other white meats"
var_label(data$pschoolageddsprfish) <- "fish and seafood"
var_label(data$pschoolageddspregg) <- "eggs from poultry or any other bird"
var_label(data$pschoolageddsveggre) <- "dark green leafy vegetable"
var_label(data$pschoolageddsvegorg) <- "vitamin a-rich vegetables, roots and tubers"
var_label(data$pschoolageddsfruitorg) <- "vitamin a-rich fruits"
var_label(data$pschoolageddsvegoth) <- "other vegetables"
var_label(data$pschoolageddsfruitoth) <- "other fruits"
var_label(data$pschoolageddssnf) <- "specialized nutritious foods (snf) for women"
var_label(data$pschoolageddsfortfoodoil) <- "fortified oil"
var_label(data$pschoolageddsfortfoodwflour) <- "fortified wheat flour"
var_label(data$pschoolageddsfortfoodmflour) <- "fortified maize flour"
var_label(data$pschoolageddsfortfoodrice) <- "fortified rice"
var_label(data$pschoolageddsfortfooddrink) <- "fortified drink"
var_label(data$pschoolageddsfortfoodother) <- "other:"
var_label(data$pschoolageddsfortfoodother_oth) <- "other: please specify: ____________"

data <- data %>%
  mutate(across(c(PSchoolAgeDDSStapCer,PSchoolAgeDDSStapRoo,PSchoolAgeDDSPulse,PSchoolAgeDDSNuts,PSchoolAgeDDSMilk,PSchoolAgeDDSDairy,PSchoolAgeDDSPrMeatO,PSchoolAgeDDSPrMeatF,PSchoolAgeDDSPrMeatPro,PSchoolAgeDDSPrMeatWhite,PSchoolAgeDDSPrFish,PSchoolAgeDDSPrEgg,
                  PSchoolAgeDDSVegGre,PSchoolAgeDDSVegOrg,PSchoolAgeDDSFruitOrg,PSchoolAgeDDSVegOth,PSchoolAgeDDSFruitOth,PSchoolAgeDDSSnf,PSchoolAgeDDSFortFoodoil,PSchoolAgeDDSFortFoodwflour,PSchoolAgeDDSFortFoodmflour,PSchoolAgeDDSFortFoodrice,PSchoolAgeDDSFortFooddrink,PSchoolAgeDDSFortFoodother), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1
  ))))

# Calculate School Age Dietary Diversity Score based on WFP MDDW guidelines
# Following the WFP MDDW method for program monitoring - SNF will count in the meats group
# In this example fortified foods PSchoolAgeDDSFortFoodwflour, PSchoolAgeDDSFortFoodmflour, PSchoolAgeDDSFortFoodrice, PSchoolAgeDDSFortFooddrink will also count in grains
# Classifying PSchoolAgeDDSFortFoodother_oth will likely involve classifying line by line 
data <- data %>% mutate(
  PSchoolAgeDDS_Staples_wfp = case_when(
    PSchoolAgeDDSStapCer == 1 | PSchoolAgeDDSStapRoo == 1 | PSchoolAgeDDSFortFoodwflour == 1 | PSchoolAgeDDSFortFoodmflour == 1 | PSchoolAgeDDSFortFoodrice == 1 | PSchoolAgeDDSFortFooddrink == 1 ~ 1, 
    TRUE ~ 0),
  PSchoolAgeDDS_Pulses_wfp = case_when(
    PSchoolAgeDDSPulse == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_NutsSeeds_wfp = case_when(
    PSchoolAgeDDSNuts == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_Dairy_wfp = case_when(
    PSchoolAgeDDSDairy == 1 | PSchoolAgeDDSMilk == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_MeatFish_wfp = case_when(
    PSchoolAgeDDSPrMeatO == 1 | PSchoolAgeDDSPrMeatF == 1 | PSchoolAgeDDSPrMeatPro == 1 | PSchoolAgeDDSPrMeatWhite == 1 | PSchoolAgeDDSPrFish == 1 | PSchoolAgeDDSSnf == 1 ~ 1, 
    TRUE ~ 0),
  PSchoolAgeDDS_Eggs_wfp = case_when(
    PSchoolAgeDDSPrEgg == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_LeafGreenVeg_wfp = case_when(
    PSchoolAgeDDSVegGre == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_VitA_wfp = case_when(
    PSchoolAgeDDSVegOrg == 1 | PSchoolAgeDDSFruitOrg == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_OtherVeg_wfp = case_when(
    PSchoolAgeDDSVegOth == 1 ~ 1, TRUE ~ 0),
  PSchoolAgeDDS_OtherFruits_wfp = case_when(
    PSchoolAgeDDSFruitOth == 1 ~ 1, TRUE ~ 0)
)

# Calculate SchoolAge Dietary Diversity Score variable for both methods by adding together food groups and classifying whether the child consumed 5 or more food groups

# WFP method for program monitoring - SNF will count in the meats group
data <- data %>% mutate(SchoolAgeDDS_wfp = PSchoolAgeDDS_Staples_wfp + PSchoolAgeDDS_Pulses_wfp + PSchoolAgeDDS_NutsSeeds_wfp + PSchoolAgeDDS_Dairy_wfp + PSchoolAgeDDS_MeatFish_wfp + PSchoolAgeDDS_Eggs_wfp + PSchoolAgeDDS_LeafGreenVeg_wfp + PSchoolAgeDDS_VitA_wfp + PSchoolAgeDDS_OtherVeg_wfp + PSchoolAgeDDS_OtherFruits_wfp)

# Count how many women consumed 5 or more groups
data <- data %>% mutate(SchoolAgeDDS_5_wfp = case_when(
  SchoolAgeDDS_wfp >= 5 ~ ">=5", TRUE ~ "<5"
))

# Create a table of the weighted percentage of WFP MDDW method for program monitoring MDDW_5_wfp
# Providing the option to use weights if needed
SchoolAgeDDS_5_wfp_table_wide <- data %>% 
  drop_na(SchoolAgeDDS_5_wfp) %>%
  count(SchoolAgeDDS_5_wfp) %>% # If weights are needed use instead the row below 
  # count(SchoolAgeDDS_5_wfp, wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = SchoolAgeDDS_5_wfp,
              values_from = Percentage,
              values_fill = 0)

# End of Scripts