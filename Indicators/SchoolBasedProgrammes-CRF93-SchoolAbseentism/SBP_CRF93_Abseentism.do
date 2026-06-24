*******************************************************************************
*                          WFP Standardized Scripts
*           Calculating Percentage of School Absence Due to Ill Health
*******************************************************************************

* Load Data --------------------------------------------------------------------
* import delimited "SBPProcessM_module_SchoolAgeChildRoster_submodule_RepeatSchoolAgeChild.csv", clear

* Rename Variables -------------------------------------------------------------
rename (SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildRegisterSchool) PChildRegisterSchool
rename (SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAttendSchool) PChildDayAttendSchool
rename (SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAbsSchool) PChildDayAbsSchool
rename (SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAbsSchoolWhy/1) PChildDayAbsSchoolWhy_IllHealth
rename (SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAbsIllHealth) PChildDayAbsIllHealth
rename (SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildAbsIllHealth) PChildAbsIllHealth

* Assign Variable Labels --------------------------------------------------------
label variable PChildRegisterSchool                 "Is ${PChildName} registered in school?"
label variable PChildDayAttendSchool                "In the last 30 school days, how many days did ${PChildName} go to school?"
label variable PChildDayAbsSchool                   "In the last 30 school days, how many days was ${PChildName} absent from school?"
label variable PChildDayAbsSchoolWhy_IllHealth      "What was the reason they missed school: Ill-health/sick"
label variable PChildDayAbsIllHealth                "How many days was your child absent from school because of ill-health"
label variable PChildAbsIllHealth                   "Please, specify the type of illness"

* Convert Variables -------------------------------------------------------------
* Ensure variables are in the correct format
recode PChildDayAbsSchoolWhy_IllHealth (0/1 = 0 1 = 1), generate(PChildDayAbsSchoolWhy_IllHealth_bool)
recode PChildRegisterSchool (1/1 = 1), generate(PChildRegisterSchool_num)

* Calculate Percentages (Without Weights) --------------------------------------
* Filter for registered children
gen Total_Registered = cond(PChildRegisterSchool == 1, 1, 0)
egen Total_Registered_count = total(Total_Registered)

gen Absent_Due_To_Ill_Health = cond(PChildDayAbsSchoolWhy_IllHealth == 1, 1, 0)
egen Absent_Due_To_Ill_Health_count = total(Absent_Due_To_Ill_Health)

gen Percentage = (Absent_Due_To_Ill_Health_count / Total_Registered_count) * 100
list Percentage in 1/10

* Calculate Percentages (With Weights) -----------------------------------------
* Note: Replace WeightVariable with the actual weight variable name.
gen Total_Registered_Weighted = cond(PChildRegisterSchool == 1, WeightVariable, 0)
egen Total_Registered_Weighted_sum = total(Total_Registered_Weighted)

gen Absent_Due_To_Ill_Health_Weighted = cond(PChildDayAbsSchoolWhy_IllHealth == 1, WeightVariable, 0)
egen Absent_Due_To_Ill_Health_Weighted_sum = total(Absent_Due_To_Ill_Health_Weighted)

gen Percentage_Wt = (Absent_Due_To_Ill_Health_Weighted_sum / Total_Registered_Weighted_sum) * 100
list Percentage_Wt in 1/10

* End of Scripts