library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/SBP_CRF_63and93_Sample_Survey/SBPProcessM_module_SchoolAgeChildRoster_submodule_RepeatSchoolAgeChild.csv")

#unfortunately you can only download repeat csv data as zip file from moda with group names - will update this code with more elegant solution to remove group names or if you download as SPSS you can skip this step
#rename to remove group names

#assign variable and value labels

data <- data %>% rename(PChildRegisterSchool = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildRegisterSchool',
                        PChildDayAttendSchool = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAttendSchool',
                        PChildDayAbsSchool = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAbsSchool',
                        PChildDayAbsSchoolWhy_IllHealth = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAbsSchoolWhy/1',
                        PChildDayAbsIllHealth = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAbsIllHealth',
                        PChildAbsIllHealth = 'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildAbsIllHealth'
                        )

var_label(data$PChildRegisterSchool) <- "Is ${PChildName} registered in school?"
var_label(data$PChildDayAttendSchool) <- "In the last 30 school days, how many days did ${PChildName} go to school?"
var_label(data$PChildDayAbsSchool) <- "In the last 30 school days, how many days was ${PChildName} absent from school?"
var_label(data$PChildDayAbsSchoolWhy_IllHealth) <- "What was the reason they missed school: Ill-health/sick"
var_label(data$PChildDayAbsIllHealth) <- "How many days was your child absent from school because of ill-health"
var_label(data$PChildAbsIllHealth) <- "Please, specify the type of illness"

# If PChildDayAbsSchoolWhy_IllHealth and PChildRegisterSchool are not already boolean or numeric,
# you might need to convert them depending on their original format.

data$PChildDayAbsSchoolWhy_IllHealth <- as.logical(data$PChildDayAbsSchoolWhy_IllHealth)
data$PChildRegisterSchool <- as.numeric(data$PChildRegisterSchool)

#The percentage required for the indicator is PChildDayAbsSchoolWhy_IllHealth = TRUE / PChildRegisterSchool = 1

# Calculate the percentage (without weights)
# Calculate the total  count of registered children and 
# the count of those absent due to ill health
percentage_absent_due_to_ill_health <- data %>%
  filter(PChildRegisterSchool == 1) %>%
  summarise(
    Total_Registered = n(),
    Absent_Due_To_Ill_Health = sum(PChildDayAbsSchoolWhy_IllHealth, na.rm = TRUE),
    Percentage = (Absent_Due_To_Ill_Health / Total_Registered) * 100
  )
# View the result
print(percentage_absent_due_to_ill_health)

# Calculate the percentage (with weights)
# Calculate the total weighted count of registered children and 
# the weighted count of those absent due to ill health
percentage_absent_due_to_ill_health_wt <- data %>%
  filter(PChildRegisterSchool == 1) %>%
  summarise(
    Total_Registered_Weighted = sum(WeightVariable, na.rm = TRUE),
    Absent_Due_To_Ill_Health_Weighted = sum(WeightVariable[PChildDayAbsSchoolWhy_IllHealth], na.rm = TRUE),
    Percentage = (Absent_Due_To_Ill_Health_Weighted / Total_Registered_Weighted) * 100
  )
# View the result
print(percentage_absent_due_to_ill_health_wt)