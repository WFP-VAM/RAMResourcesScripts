library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("LHCS_FS_Sample_Survey.csv")


#assign variable and value labels
#variable labels
var_label(data$Lcs_stress_DomAsset) <- "Sold household assets/goods (radio, furniture, refrigerator, television, jewellery etc.) due to lack of food"
var_label(data$Lcs_stress_Saving) <- "Spent savings due to lack of food"
var_label(data$Lcs_stress_EatOut) <- "Sent household members to eat elsewhere/live with family or friends due to lack of food"
var_label(data$Lcs_stress_CrdtFood) <- "Purchased food/non-food on credit (incur debts) due to lack of food"
var_label(data$Lcs_crisis_ProdAssets) <- "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.)  due to lack of food"
var_label(data$Lcs_crisis_HealthEdu) <- "Reduced expenses on health (including drugs) or education due to lack of food"
var_label(data$Lcs_crisis_OutSchool) <- "Withdrew children from school due to lack of food"
var_label(data$Lcs_em_ResAsset) <- "Mortgaged/Sold house or land due to lack of food"
var_label(data$Lcs_em_Begged) <- "Begged and/or scavenged (asked strangers for money/food) due to lack of food"
var_label(data$Lcs_em_IllegalAct) <- "Engaged in illegal income activities (theft, prostitution) due to lack of food"
#value labels
data <- data %>%
  mutate(across(c(Lcs_stress_DomAsset,Lcs_stress_Saving,Lcs_stress_EatOut,Lcs_stress_CrdtFood,Lcs_crisis_ProdAssets,Lcs_crisis_HealthEdu,Lcs_crisis_OutSchool,Lcs_em_ResAsset,Lcs_em_Begged,Lcs_em_IllegalAct), ~labelled(., labels = c(
    "No, because I did not need to" = 10,
    "No, because I already sold those assets or have engaged in this activity within the last 12 months and cannot continue to do it" = 20,
    "Yes" = 30,
    "Not applicable (don’t have children/ these assets)" = 9999
  ))))

#create a variable to specify if the household used any of the strategies by severity
#stress
data <- data %>% mutate(stress_coping_FS = case_when(
  Lcs_stress_DomAsset == 20 |  Lcs_stress_DomAsset == 30 ~ 1,
  Lcs_stress_Saving == 20 | Lcs_stress_Saving == 30 ~ 1,
  Lcs_stress_EatOut == 20 | Lcs_stress_EatOut == 30 ~ 1,
  Lcs_stress_CrdtFood == 20 | Lcs_stress_CrdtFood == 30 ~1,
  TRUE ~ 0))
var_label(data$stress_coping_FS) <- "Did the HH engage in stress coping strategies"
#Crisis
data <- data %>% mutate(crisis_coping_FS = case_when(
  Lcs_crisis_ProdAssets == 20 |  Lcs_crisis_ProdAssets == 30 ~ 1,
  Lcs_crisis_HealthEdu == 20 | Lcs_crisis_HealthEdu == 30 ~ 1,
  Lcs_crisis_OutSchool == 20 | Lcs_crisis_OutSchool == 30 ~ 1,
  TRUE ~ 0))
var_label(data$crisis_coping_FS) <- "Did the HH engage in crisis coping strategies"
#Emergency
data <- data %>% mutate(emergency_coping_FS = case_when(
  Lcs_em_ResAsset == 20 |  Lcs_em_ResAsset == 30 ~ 1,
  Lcs_em_Begged == 20 | Lcs_em_Begged == 30 ~ 1,
  Lcs_em_IllegalAct == 20 | Lcs_em_IllegalAct == 30 ~ 1,
  TRUE ~ 0))
var_label(data$emergency_coping_FS) <- "Did the HH engage in emergency coping strategies"

#calculate Max_coping_behaviour
data <- data %>% mutate(Max_coping_behaviourFS = case_when(
  emergency_coping_FS == 1 ~ 4,
  crisis_coping_FS == 1 ~ 3,
  stress_coping_FS == 1 ~ 2,
  TRUE ~ 1))
var_label(data$Max_coping_behaviourFS) <- "Summary of asset depletion"
val_lab(data$Max_coping_behaviourFS) = num_lab("
             1 HH not adopting coping strategies
             2 Stress coping strategies
             3 Crisis coping strategies
             4 Emergencies coping strategies
")


#creates a table of the weighted percentage of Max_coping_behaviourFS by
#creating a temporary variable to display value labels 
#and providing the option to use weights if needed


Max_coping_behaviourFS_table_wide <- data %>% 
  drop_na(Max_coping_behaviourFS) %>%
  count(Max_coping_behaviourFS_lab = as.character(Max_coping_behaviourFS)) %>% # if weights are needed use instead the row below 
  #count(Max_coping_behaviourFS_lab = as.character(Max_coping_behaviourFS), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = Max_coping_behaviourFS_lab,
              values_from = Percentage,
              values_fill =  0) 
