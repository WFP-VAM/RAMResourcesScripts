* Encoding: UTF-8.

*this syntax is based on SPSS download version from MoDA 

* Filter dataset for children registered to attend school.
SELECT IF (PChildRegisterSchool = 1).

* Compute a variable for absence due to ill health as a binary indicator.
COMPUTE AbsentDueToIllHealth = (PChildDayAbsSchoolWhy.1 = 1).

* Aggregate data to calculate total registered and total absent due to ill health.
DATASET DECLARE AggregatedData.
AGGREGATE OUTFILE='AggregatedData'
  /BREAK=
  /TotalRegistered = N
  /TotalAbsentDueToIllHealth = SUM(AbsentDueToIllHealth).

* Compute the percentage of absences due to ill health.
DATASET ACTIVATE AggregatedData.
COMPUTE PercentAbsentDueToIllHealth = (TotalAbsentDueToIllHealth / TotalRegistered) * 100.

* Assign a label to the new percentage variable.
VARIABLE LABELS PercentAbsentDueToIllHealth '% Children Missing School Due to Ill Health'.

* Display the result.
FORMATS PercentAbsentDueToIllHealth (F2.2).
LIST.