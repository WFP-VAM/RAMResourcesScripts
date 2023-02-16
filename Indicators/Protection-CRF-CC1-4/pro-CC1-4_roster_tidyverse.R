library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("GitHub/RAMResourcesScripts/Static/PRO_WG_Sample_Survey/RosterMethod/Demographic_module_DisabilityHHMemb_submodule_RepeatDisabHHMembers.csv")
data2 <- read_csv("GitHub/RAMResourcesScripts/Static/PRO_WG_Sample_Survey/RosterMethod/data.csv")

#can only download repeat csv data as zip file from moda with group names - will update this code to remove group names
#rename to remove group names
data2 <- data2 %>% rename(HHAsstWFPRecCashYN1Y = 'TechnicalAdd_submodule/HHAsstWFPRecCashYN1Y')
data2 <- data2 %>% rename(HHAsstWFPRecInKindYN1Y = 'TechnicalAdd_submodule/HHAsstWFPRecInKindYN1Y')
data2 <- data2 %>% rename(HHAsstWFPRecCapBuildYN1Y = 'TechnicalAdd_submodule/HHAsstWFPRecCapBuildYN1Y')
data2 <- data2 %>% rename(index = '_index')

data <- data %>% rename(PDisabAge = 'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabAge')
data <- data %>% rename(PDisabSex = 'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabSex')
data <- data %>% rename(PDisabSee = 'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabSee')
data <- data %>% rename(PDisabHear = 'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabHear')
data <- data %>% rename(PDisabWalk = 'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabWalk')
data <- data %>% rename(PDisabRemember = 'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabRemember')
data <- data %>% rename(PDisabUnderstand = 'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabUnderstand')
data <- data %>% rename(PDisabWash = 'Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers/PDisabWash')
data <- data %>% rename(index = '_parent_index')

#join dataset "data" & "data2"
data <- data %>% left_join(data2, by = "index")

#assign variable and value labels 
var_label(data$HHAsstWFPRecCashYN1Y) <- "Did your household receive cash-based WFP assistance in the last 12 months?"
var_label(data$HHAsstWFPRecInKindYN1Y) <- "Did your household receive in-kind WFP assistance in the last 12 months?"
var_label(data$HHAsstWFPRecCapBuildYN1Y) <- "Did you household receive WFP capacity building assistance in the last 12 months?"

var_label(data$PDisabAge) <- "What is the age of ${PDisabName}?"
var_label(data$PDisabSex) <- "What is the sex of ${PDisabName}?"
var_label(data$PDisabSee) <- "Does ${PDisabName} have difficulty seeing, even if wearing glasses? Would you say…"
var_label(data$PDisabHear) <- "Does ${PDisabName} have difficulty hearing, even if using a hearing aid(s)? Would you say…"
var_label(data$PDisabWalk) <- "Does ${PDisabName} have difficulty walking or climbing steps? Would you say…"
var_label(data$PDisabRemember) <- "Does ${PDisabName} have difficulty remembering or concentrating? Would you say…"
var_label(data$PDisabUnderstand) <- "Using your usual language, does ${PDisabName} have difficulty communicating, for example understanding or being understood? Would you say…"
var_label(data$PDisabWash) <- "Does ${PDisabName} have difficulty with self-care, such as washing all over or dressing? Would you say…"


data <- data %>%
  mutate(across(c(HHAsstWFPRecCashYN1Y, HHAsstWFPRecInKindYN1Y, HHAsstWFPRecCapBuildYN1Y), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1
  ))))

val_lab(data$PDisabSex) = num_lab("
             0 Female
             1 Male
")

data <- data %>%
  mutate(across(c(PDisabSee,PDisabHear,PDisabWalk,PDisabRemember,PDisabUnderstand,PDisabWash), ~labelled(., labels = c(
    "No difficulty" = 1,
    "Some difficulty" = 2,
    "A lot of difficulty" = 3,
    "Cannot do at all" = 4,
    "Don't know" = 888,
    "Refuse" = 999
  ))))  

#calculate whether the respondent had "A lot of difficulty" or "Cannot do at all" for any of the 6 questions.
data <- data %>% mutate(PDisabCat3 = case_when(
  between(PDisabSee,3,4) | between(PDisabHear,3,4) | between(PDisabWalk,3,4) | between(PDisabRemember,3,4) | between(PDisabUnderstand,3,4)| between(PDisabWash,3,4) ~ 1,
 TRUE ~ 0
))

val_lab(data$PDisabCat3) = num_lab("
             0 without disability (category 3 criteria)
             1 with disability (category 3 criteria)
")


#creates a table of the weighted percentage of type of assistance recieve by PDisabCat3
#creating a temporary variable to display value labels 
#and providing the option to use weights if needed

#cash
HHAsstWFPRecCashYN1Y_table_wide <- data %>% group_by(PDisabCat3_lab = as_factor(PDisabCat3)) %>% 
  drop_na(HHAsstWFPRecCashYN1Y) %>%
  count(HHAsstWFPRecCashYN1Y_lab = as_factor(HHAsstWFPRecCashYN1Y)) %>% # if weights are needed use instead the row below 
  #count(HHAsstWFPRecCashYN1Y_lab = as.character(HHAsstWFPRecCashYN1Y), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = HHAsstWFPRecCashYN1Y_lab,
              values_from = Percentage,
              values_fill =  0) 

#inkind
HHAsstWFPRecInKindYN1Y_table_wide <- data %>% group_by(PDisabCat3_lab = as_factor(PDisabCat3)) %>% 
  drop_na(HHAsstWFPRecInKindYN1Y) %>%
  count(HHAsstWFPRecInKindYN1Y_lab = as_factor(HHAsstWFPRecInKindYN1Y)) %>% # if weights are needed use instead the row below 
  #count(HHAsstWFPRecInKindYN1Y_lab = as.character(HHAsstWFPRecInKindYN1Y), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = HHAsstWFPRecInKindYN1Y_lab,
              values_from = Percentage,
              values_fill =  0) 

#capacity building
HHAsstWFPRecCapBuildYN1Y_table_wide <- data %>% group_by(PDisabCat3_lab = as_factor(PDisabCat3)) %>% 
  drop_na(HHAsstWFPRecCapBuildYN1Y) %>%
  count(HHAsstWFPRecCapBuildYN1Y_lab = as_factor(HHAsstWFPRecCapBuildYN1Y)) %>% # if weights are needed use instead the row below 
  #count(HHAsstWFPRecCapBuildYN1Y_lab = as.character(HHAsstWFPRecCapBuildYN1Y), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from =HHAsstWFPRecCapBuildYN1Y_lab,
              values_from = Percentage,
              values_fill =  0) 

