library(tidyverse)
library(gt)
library(foreign)
## if needed install.packages("remotes") 
remotes::install_github("WFP-VAM/FoodSecRammer")
library(FoodSecRammer)


#1 - import sample SPSS data - put in a link to sample data
data <- read.spss("./RamResourcesScripts/Static/Gender-CRF-C31.sav", to.data.frame = T)

#2 - calculate percent households that responded decisions about the use of food/cash/vouchers is made by women, men or both 
#to do this first you have to exclude households that are single/widowed/divorced 

# data_notsingle <- data %>% 
  filter(HHHStatus == "Married monogamous" | HHHStatus == "Polygamous married" | HHHStatus_single == "No")  #select only households that are Married monogamous, Polygamous married, or other status but not single
#then exclude households that did not receive cash/voucher 
data_notsingle_cash <- data_notsingle %>% 
  filter(HHAsstWFPReceivedCashYN_1yr == "Yes") #select only households who received cash/Voucher in the last 12 months
#And exclude households that did not receive inkind
data_notsingle_inkind <- data_notsingle %>% 
  filter(HHAsstWFPReceivedInKindYN_1yr == "Yes") #select only households who received cash/Voucher in the last 12 months

#Cash/Voucher Tables
#long tables are good for graphing  
table_HHAsstCashDescWho_long <- data_notsingle_cash %>% 
  wtd_table_perc_long(col = HHAsstCashDescWho) %>%
  mutate_if(is.numeric, round, 0) %>% #rounds to whole numbers
  mutate(Modality = "Cash/voucher") #add the modality 

#wide tables are good for reporting i.e presenting as tables
table_HHAsstCashDescWho_wide <- data_notsingle_cash %>% 
  wtd_table_perc_wide(col = HHAsstCashDescWho) %>% 
  mutate_if(is.numeric, round, 0) %>% #rounds to whole numbers
  mutate(Modality = "Cash/voucher") %>% #add the modality 
  select("Modality", "Women", "Men", "Both together")
  
  
#In kind Tables
table_HHAsstInKindDescWho_long <- data_notsingle_inkind %>% 
  wtd_table_perc_long(col = HHAsstInKindDescWho) %>%
  mutate_if(is.numeric, round, 0) %>% #rounds to whole numbers
  mutate(Modality = "Food") #add the modality 
  
table_HHAsstInKindDescWho_wide <- data_notsingle_inkind %>% 
  wtd_table_perc_wide(col = HHAsstInKindDescWho) %>% 
  mutate_if(is.numeric, round, 0) %>% #rounds to whole numbers
  mutate(Modality = "Food") %>% #add the modality 
  select("Modality", "Women", "Men", "Both together")

#combine long tables and make reporting graph
table_HHAsstCashDescWho_long <- table_HHAsstCashDescWho_long %>% rename(HHAsstDescWho = HHAsstCashDescWho)
table_HHAsstInKindDescWho_long <- table_HHAsstInKindDescWho_long %>% rename(HHAsstDescWho = HHAsstInKindDescWho)
  
combined_HHAsstDescWho_long <- bind_rows(table_HHAsstCashDescWho_long, table_HHAsstInKindDescWho_long)

combined_HHAsstDescWho_barplot <- combined_HHAsstDescWho_long  %>% 
  ggplot(aes(fill=Modality, y=Percentage, x=HHAsstDescWho)) +geom_bar(stat = "identity", position = "dodge") +theme_vamgraphs()
combined_HHAsstDescWho_barplot <- combined_HHAsstDescWho_barplot + labs(title = "Percentage of Household Members Making Decisions by Modality")
 
#combine wide tables and make reporting table
combined_HHAsstDescWho_wide <- bind_rows(table_HHAsstCashDescWho_wide, table_HHAsstInKindDescWho_wide)

combined_HHAsstDescWho_report <- combined_HHAsstDescWho_wide %>% gt() %>% 
  tab_style(
    style = cell_borders(color = "transparent"),
    locations = cells_body()
  )

combined_HHAsstDescWho_report <- combined_HHAsstDescWho_report %>% tab_header(
  title = "Percentage of Household Members Making Decisions by Modality") 

  
