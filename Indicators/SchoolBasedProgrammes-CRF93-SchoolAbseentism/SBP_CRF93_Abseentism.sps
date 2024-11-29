***------------------------------------------------------------------------------*
***                          WFP Standardized Scripts
***            Calculating Percentage of School Absence Due to Ill Health
***------------------------------------------------------------------------------*

* Encoding: UTF-8.

* Rename Variables -------------------------------------------------------------* 
RENAME VARIABLES (SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildRegisterSchool = PChildRegisterSchool
                  SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAttendSchool = PChildDayAttendSchool
                  SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAbsSchool = PChildDayAbsSchool
                  SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAbsSchoolWhy/1 = PChildDayAbsSchoolWhy_IllHealth
                  SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAbsIllHealth = PChildDayAbsIllHealth
                  SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildAbsIllHealth = PChildAbsIllHealth).

* Assign Variable Labels --------------------------------------------------------* 
VARIABLE LABELS PChildRegisterSchool "Is ${PChildName} registered in school?"
                PChildDayAttendSchool "In the last 30 school days, how many days did ${PChildName} go to school?"
                PChildDayAbsSchool "In the last 30 school days, how many days was ${PChildName} absent from school?"
                PChildDayAbsSchoolWhy_IllHealth "What was the reason they missed school: Ill-health/sick"
                PChildDayAbsIllHealth "How many days was your child absent from school because of ill-health"
                PChildAbsIllHealth "Please, specify the type of illness".

* Convert Variables ------------------------------------------------------------* 
* Ensure the relevant variables are in the correct format.
COMPUTE PChildDayAbsSchoolWhy_IllHealth = (PChildDayAbsSchoolWhy_IllHealth = 1).

* Filter dataset for children registered to attend school -----------------------* 
SELECT IF (PChildRegisterSchool = 1).

* Aggregate data to calculate total registered and total absent due to ill health.* 
DATASET DECLARE AggregatedData.
AGGREGATE OUTFILE='AggregatedData'
  /BREAK=
  /TotalRegistered = N
  /TotalAbsentDueToIllHealth = SUM(PChildDayAbsSchoolWhy_IllHealth).

* Compute the percentage of absences due to ill health ---------------------------* 
DATASET ACTIVATE AggregatedData.
COMPUTE PercentAbsentDueToIllHealth = (TotalAbsentDueToIllHealth / TotalRegistered) * 100.

* Assign a label to the new percentage variable --------------------------------* 
VARIABLE LABELS PercentAbsentDueToIllHealth '% Children Missing School Due to Ill Health'.

* Display the result -----------------------------------------------------------* 
FORMATS PercentAbsentDueToIllHealth (F2.2).
LIST.

* End of Scripts