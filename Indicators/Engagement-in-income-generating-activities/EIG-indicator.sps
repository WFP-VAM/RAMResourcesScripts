*------------------------------------------------------------------------------
*                          WFP Standardized Scripts
*    Engagement in Income Generation Activities (EIG) Calculation
*------------------------------------------------------------------------------

* This script calculates the Engagement in Income Generation Activities (EIG)
* using standard variable names and sample data.
* Detailed guidelines can be found in the WFP documentation.

* Import dataset
PRESERVE.
SET DECIMAL DOT.

GET DATA /TYPE=TXT
  /FILE="C:\Users\b\Desktop\demo\EIG_Sample_Survey.csv"
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS=","
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /VARIABLES=
  v1 AUTO
  v2 AUTO
  v3 AUTO
  * Add additional variables as needed
  /MAP.
RESTORE.

CACHE.
EXECUTE.
DATASET NAME DataSet1 WINDOW=FRONT.

* Rearrange variable names and codes to ensure consistency in the dataset.
* In particular, variables within repeats are imported with progressive integer names (v1, v2, v3, ...).
* The loop below names variables as [VariableName]+[_number of option]+[_number of repetition].

* Get the maximum number of repeats.
FREQUENCIES VARIABLES=v1 /FORMAT=NOTABLE /STATISTICS=MAXIMUM.

* Rename variables to ensure consistency.
* This assumes variable labels follow a specific pattern and may need adjustment based on actual data.
DO REPEAT oldvar=v1 TO v9 /index=1 TO 9.
  RENAME VARIABLES (oldvar = Variable_!index).
END REPEAT.

* Convert "n/a" to missing values and destring variables.
DO REPEAT var=Variable_1 TO Variable_9.
  RECODE var ('n/a' = SYSMIS) INTO var. 
  EXECUTE.
END REPEAT.

* Calculate indicators for each repeat.
DO REPEAT i=1 TO 9.
  * Check participation in training activities.
  COMPUTE PTrainingPart_!i = MAX(PTrainingTypes1_!i, PTrainingTypes2_!i, PTrainingTypes3_!i, PTrainingTypes4_!i, PTrainingTypes5_!i, PTrainingTypes6_!i, PTrainingTypes7_!i, PTrainingTypes8_!i, PTrainingTypes9_!i).
  * Check engagement in income generating activities post-training.
  COMPUTE PostTrainingEngagement_!i = MAX(PPostTrainingEmpl_!i, PPostTrainingIncome_!i).
  EXECUTE.
END REPEAT.

* Aggregate indicators to the household level.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=
  /PostTrainingEngagement = SUM(PostTrainingEngagement_1 TO PostTrainingEngagement_9)
  /PTrainingPartNb = SUM(PTrainingPart_1 TO PTrainingPart_9).

* Calculate the EIG indicator.
COMPUTE EIG = PostTrainingEngagement / PTrainingPartNb.
VARIABLE LABELS EIG "Share of training participants who were able to engage in income generating activities post-training".
EXECUTE.

* Drop unnecessary variables.
DELETE VARIABLES PostTrainingEngagement_1 TO PostTrainingEngagement_9 PTrainingPart_1 TO PTrainingPart_9.
EXECUTE.

* Example of summary statistics for the full sample.
FREQUENCIES VARIABLES=EIG /STATISTICS=MEAN.
EXECUTE.

* End of Scripts