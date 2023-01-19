library(tidyverse)
library(labelled)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/rCSI_Sample_Survey.csv")

#assign variable and value labels
var_label(data$rCSILessQlty) <-  "Rely on less preferred and less expensive food in the past 7 days"
var_label(data$rCSIBorrow) <- "Borrow food or rely on help from a relative or friend in the past 7 days"
var_label(data$rCSIMealNb) <-  "Reduce number of meals eaten in a day in the past 7 days"
var_label(data$rCSIMealSize) <- "Limit portion size of meals at meal times in the past 7 days"
var_label(data$rCSIMealAdult) <-  "Restrict consumption by adults in order for small children to eat in the past 7 days"

#calculate reduced Coping Strategy Index (rCSI)
data <- data %>% mutate(rCSI = rCSILessQlty + (2 * rCSIBorrow) + rCSIMealNb + rCSIMealSize + (3 * rCSIMealAdult))
var_label(data$rCSI) <- "Reduced coping strategies index (rCSI)"


#creates a table of the mean of rCSI
#providing two options - weighted and unweighted

#unweighted
rCSI_table_mean <- data %>% 
  drop_na(rCSI) %>% 
  summarise(meanrCSI = mean(rCSI))
  
  
#with weights 
rCSI_table_mean <- data %>% 
  drop_na(rCSI) %>% 
  summarise(meanrCSI = weighted.mean(rCSI,nameofweightvariable)) #insert name of weight variable 

