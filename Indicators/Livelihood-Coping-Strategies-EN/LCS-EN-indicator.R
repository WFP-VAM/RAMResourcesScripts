library(tidyverse)
library(labelled)
library(expss)


#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/LCS_Sample_Survey/LHCS_EN_Sample_Survey.csv")


#assign variable and value labels
#variable labels
var_label(data$LcsEN_stress_DomAsset) <- "Sold household assets/goods (radio, furniture, television, jewellery etc.) to meet essential needs"
var_label(data$LcsEN_stress_Saving) <- "Spent savings to meet essential needs"
var_label(data$LcsEN_stress_CrdtFood) <- "Purchased food or other essential items on credit"
var_label(data$LcsEN_stress_BorrowCash) <- "Borrowed money to meet essential needs"
var_label(data$LcsEN_crisis_ProdAssets) <- "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.) to meet essential needs"
var_label(data$LcsEN_crisis_Health) <- "Reduced expenses on health (including drugs) to meet other essential needs"
var_label(data$LcsEN_crisis_OutSchool) <- "Withdrew children from school to meet essential needs"
var_label(data$LcsEN_em_ResAsset) <- "Mortgaged/Sold house that the household was permanently living in or sold land to meet essential needs"
var_label(data$LcsEN_em_Begged) <- "Begged and/or scavenged (asked strangers for money/food) to meet essential needs"
var_label(data$LcsEN_em_IllegalAct) <- "Engaged in socially degrading, high risk, or exploitive jobs, or life-threatening income activities (e.g., smuggling, theft, join armed groups, prostitution) to meet essential needs"
#value labels
data <- data %>%
  mutate(across(c(LcsEN_stress_DomAsset,LcsEN_stress_Saving,LcsEN_stress_CrdtFood,LcsEN_stress_BorrowCash,LcsEN_crisis_ProdAssets,LcsEN_crisis_Health,LcsEN_crisis_OutSchool,LcsEN_em_ResAsset,LcsEN_em_Begged,LcsEN_em_IllegalAct), ~labelled(., labels = c(
    "No, because I did not need to" = 10,
    "No, because I already sold those assets or have engaged in this activity within the last 12 months and cannot continue to do it" = 20,
    "Yes" = 30,
    "Not applicable (don’t have access to this strategy)" = 9999
  ))))

#create a variable to specify if the household used any of the strategies by severity
#stress
data <- data %>% mutate(stress_coping_EN = case_when(
  LcsEN_stress_DomAsset == 20 |  LcsEN_stress_DomAsset == 30 ~ 1,
  LcsEN_stress_Saving == 20 | LcsEN_stress_Saving == 30 ~ 1,
  LcsEN_stress_CrdtFood == 20 | LcsEN_stress_CrdtFood == 30 ~1,
  LcsEN_stress_BorrowCash == 20 | LcsEN_stress_BorrowCash == 30 ~ 1,
  TRUE ~ 0))
var_label(data$stress_coping_EN) <- "Did the HH engage in stress coping strategies"
#Crisis
data <- data %>% mutate(crisis_coping_EN = case_when(
  LcsEN_crisis_ProdAssets == 20 |  LcsEN_crisis_ProdAssets == 30 ~ 1,
  LcsEN_crisis_Health == 20 | LcsEN_crisis_Health == 30 ~ 1,
  LcsEN_crisis_OutSchool == 20 | LcsEN_crisis_OutSchool == 30 ~ 1,
  TRUE ~ 0))
var_label(data$crisis_coping_EN) <- "Did the HH engage in crisis coping strategies"
#Emergency
data <- data %>% mutate(emergency_coping_EN = case_when(
  LcsEN_em_ResAsset == 20 |  LcsEN_em_ResAsset == 30 ~ 1,
  LcsEN_em_Begged == 20 | LcsEN_em_Begged == 30 ~ 1,
  LcsEN_em_IllegalAct == 20 | LcsEN_em_IllegalAct == 30 ~ 1,
  TRUE ~ 0))
var_label(data$emergency_coping_EN) <- "Did the HH engage in emergency coping strategies"

#calculate Max_coping_behaviour
data <- data %>% mutate(Max_coping_behaviourEN = case_when(
  emergency_coping_EN == 1 ~ 4,
  crisis_coping_EN == 1 ~ 3,
  stress_coping_EN == 1 ~ 2,
  TRUE ~ 1))
var_label(data$Max_coping_behaviourEN) <- "Summary of asset depletion"
val_lab(data$Max_coping_behaviourEN) = num_lab("
             1 HH not adopting coping strategies
             2 Stress coping strategies
             3 Crisis coping strategies
             4 Emergencies coping strategies
")


#creates a table of the weighted percentage of Max_coping_behaviourFS by
#creating a temporary variable to display value labels 
#and providing the option to use weights if needed


Max_coping_behaviourEN_table_wide <- data %>% 
  drop_na(Max_coping_behaviourEN) %>%
  count(Max_coping_behaviourEN_lab = as.character(Max_coping_behaviourEN)) %>% # if weights are needed use instead the row below 
  #count(Max_coping_behaviourEN_lab = as.character(Max_coping_behaviourEN), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = Max_coping_behaviourEN_lab,
              values_from = Percentage,
              values_fill =  0) 

#calculate LCS-FS indicator using the LCS-EN module to be able to calculate CARI 

#depending on the format you download the data sets and the import options you select the format of the variable could be different - in general, recommend downloading with the multiple response split into seperate columns with 1/0 

#define value labels

var_label(data$`LhCSIEnAccess/1`) <- "To buy food"
var_label(data$`LhCSIEnAccess/2`) <- "To pay for rent or access adequate shelter"
var_label(data$`LhCSIEnAccess/3`) <- "To pay for school fees and other education costs"
var_label(data$`LhCSIEnAccess/4`) <- "To cover health expenses"
var_label(data$`LhCSIEnAccess/5`) <- "To buy essential non-food items (clothes, small furniture...)"
var_label(data$`LhCSIEnAccess/6`) <- "To access water or sanitation facilities"
var_label(data$`LhCSIEnAccess/7`) <- "To access essential dwelling services (electricity, energy, waste disposal…)"
var_label(data$`LhCSIEnAccess/8`) <- "To pay for existing debts"
var_label(data$`LhCSIEnAccess/999`) <- "Other"

#multiple response tables - get % of each reason for coping 

data %>% 
  select(`LhCSIEnAccess/1`:`LhCSIEnAccess/999`) %>% 
  map(., ~tabyl(.))

#Calculating LCS-FS using the LCS-EN module
  
#Important note: If "To buy food" is not among the reasons selected for applying livelihood coping strategies then these case/households should be considered under  'HH not adopting coping strategies' when computing CARI. 

#If the design of this question provides responses in a single cell then the analyst should  split the responses in excel prior to running this syntax

#annoyingly its hard to recode because its labelled - removing labels then will add back afterwards - this code should be improved later
data$Max_coping_behaviourEN <-  unlab(data$Max_coping_behaviourEN)

data <- data %>% mutate(Max_coping_behaviour = case_when(
  `LhCSIEnAccess/1` == 0 ~ 1,
  TRUE ~ Max_coping_behaviourEN))

#value labels
data <- data %>%
  mutate(across(c(Max_coping_behaviourEN, Max_coping_behaviour), ~labelled(., labels = c(
    "HH not adopting coping strategies" = 1,
    "Stress coping strategies" = 2,
    "Crisis coping strategies" = 3,
    "Emergencies coping strategies" =4
  ))))

data %>% 
  select(Max_coping_behaviourEN, Max_coping_behaviour) %>% 
  map(., ~tabyl(.))


