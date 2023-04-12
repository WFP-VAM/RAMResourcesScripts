library(tidyverse)
library(labelled)
library(expss)

#import dataset
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/EBI_Sample_Survey.csv")

#assign variable and value labels 
var_label(data$EBIFFAPart) <- "Have you or any of your household member participated in the asset creation activities and received a food assistance transfer?"
var_label(data$EBISoilFertility) <- "Do you think that the assets that were built or rehabilitated in your community have allowed to increase agricultural potential due to greater water availability and/or soil fertility (e.g. increased or diversified production not requiring expanded irrigation)?"
var_label(data$EBIStabilization) <- "Do you think that the assets that were built or rehabilitated in your community have improved natural environment due to land stabilization and restoration (e.g. more natural vegetal cover, increase in indigenous flora/fauna, less erosion or siltation, etc.)?"
var_label(data$EBISanitation) <- "Do you think that the assets that were built or rehabilitated in your community have improved environmental surroundings due to enhanced water and sanitation measures (i.e., greater availability/longer duration of water for domestic non-human consumption, improved hygiene practices – less open defecation)?"

val_lab(data$EBIFFAPart) = num_lab("
             0 No
             1 Yes
")

data <- data %>%
  mutate(across(c(EBISoilFertility,EBIStabilization,EBISanitation), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1,
    "Not applicable" = 999
  ))))

#recode 999 to 0
data <- data %>%
  mutate(across(EBISoilFertility:EBISanitation, ~ dplyr::recode(.x, "0" = 0, "1" = 1, "9999" = 0)))


#create 3 tables with the % of yes responses to each of the 3 questions by ADMIN5Name

table_perc_soilfert <- data %>% group_by(ADMIN5Name) %>% 
  summarize(n = n(), EBISoilFertility_tot = sum(EBISoilFertility)) %>% mutate(EBISoilFertility_perc = round(((EBISoilFertility_tot / n) * 100),1)) %>% select(ADMIN5Name,EBISoilFertility_perc)

table_perc_stab <- data %>% group_by(ADMIN5Name) %>% 
  summarize(n = n(), EBIStabilization_tot = sum(EBIStabilization)) %>% mutate(EBIStabilization_perc = round(((EBIStabilization_tot / n) * 100),1)) %>% select(ADMIN5Name,EBIStabilization_perc)

table_perc_san <- data %>% group_by(ADMIN5Name) %>% 
  summarize(n = n(), EBISanitation_tot = sum(EBISanitation)) %>% mutate(EBISanitation_perc = round(((EBISanitation_tot / n) * 100),1)) %>% select(ADMIN5Name,EBISanitation_perc)

#join together the perc values of each of the three tables
table_allperc <- table_perc_soilfert %>% left_join(table_perc_stab, by='ADMIN5Name') %>% left_join(table_perc_san, by='ADMIN5Name')



#create table with the denominator of questions asked for each community - should scan through the data and values from tables above to generate these values
num_quest_table <-  data %>% count(ADMIN5Name) %>% mutate(EBIdenom = case_when(
  ADMIN5Name == "Community A" ~ 2,
  ADMIN5Name == "Community B" ~ 3
)) %>% select(-n)

#join table with percentages of each question with the table with count of number of questions (EBIdenom)
perc_denom_table <- table_allperc %>% left_join(num_quest_table, by='ADMIN5Name')
#then calculate EBI by community
EBI_ADMIN5Name <- perc_denom_table %>% mutate(EBI_ADMIN5Name = ((EBISoilFertility_perc + EBIStabilization_perc + EBISanitation_perc) / EBIdenom))

#finally calculate total EBI combining all communities
EBI_overall <- EBI_ADMIN5Name %>% summarize(EBI_overall = round(mean(EBI_ADMIN5Name),1))



