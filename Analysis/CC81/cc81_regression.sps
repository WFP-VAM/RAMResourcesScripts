* Encoding: UTF-8.
* CC.8.1 Factors associated with overall satisfaction.
* (Optional unweighted) ordinal logistic regression using Survey Designer codes.
* Step 1 selects the bundled example or your open numeric survey dataset.
* Run all syntax. Results appear in the Viewer; saving is optional in Step 6.

* 1. Select the input and work on a copy.
* Set the working directory to the repository folder containing Static.
* Leave INPUT='' below to load the bundled example.
* For your survey, activate the original numeric dataset and use INPUT='CC81Survey'.
* Naming the open dataset preserves it when the example is loaded.
DATASET NAME CC81Survey.
DEFINE !CC81Input (INPUT=!DEFAULT('') !TOKENS(1)).
 !IF (!INPUT = '') !THEN
  INSERT FILE='Static/CC81/cc81_sample_30.sps' ERROR=STOP.
  ECHO 'Input: bundled example dataset (30 records).'.
 !ELSE
  DATASET ACTIVATE !UNQUOTE(!INPUT).
 !IFEND
!ENDDEFINE.
!CC81Input INPUT=''.

DATASET COPY CC81Regression.
DATASET ACTIVATE CC81Regression.
WEIGHT OFF.
FILTER OFF.
SPLIT FILE OFF.
MATCH FILES /FILE=*
 /KEEP=RESPConsent RESPSex HHAsstWFPSatisf HHAsstWFPSatisf_Rec
       HHAsstWFPSatisf_Resp HHAsstWFPSatisf_Time HHAsstWFPSatisf_Qual HHAsstWFPSatisf_Quan.
MISSING VALUES RESPConsent RESPSex HHAsstWFPSatisf HHAsstWFPSatisf_Rec
 HHAsstWFPSatisf_Resp HHAsstWFPSatisf_Time HHAsstWFPSatisf_Qual HHAsstWFPSatisf_Quan ().

* 2. Recode for analysis: 1 Unsatisfied, 2 Satisfied, 3 Very satisfied.
* Survey Designer input codes are 1 Very satisfied, 2 Satisfied, 3 Unsatisfied.
DO REPEAT raw=HHAsstWFPSatisf HHAsstWFPSatisf_Rec HHAsstWFPSatisf_Resp
               HHAsstWFPSatisf_Time HHAsstWFPSatisf_Qual HHAsstWFPSatisf_Quan
 /rating=overall_ord safety_ord respect_ord timeliness_ord quality_ord quantity_ord.
 RECODE raw (1=3) (2=2) (3=1) (ELSE=SYSMIS) INTO rating.
END REPEAT.
VARIABLE LABELS
 overall_ord 'Overall satisfaction'
 safety_ord 'Safety' respect_ord 'Respect' timeliness_ord 'Timeliness'
 quality_ord 'Quality' quantity_ord 'Quantity'.
VALUE LABELS overall_ord safety_ord respect_ord timeliness_ord quality_ord quantity_ord
 1 'Unsatisfied' 2 'Satisfied' 3 'Very satisfied'.
VARIABLE LEVEL overall_ord (ORDINAL).

* 3. Keep consenting respondents with valid answers to all six questions.
SELECT IF (RESPConsent=1 AND NMISS(overall_ord,safety_ord,respect_ord,
                                  timeliness_ord,quality_ord,quantity_ord)=0).
FREQUENCIES VARIABLES=overall_ord /ORDER=ANALYSIS.

* 4. Check model requirements. These are execution safeguards, not sampling standards.
COUNT category1=overall_ord (1) /category2=overall_ord (2) /category3=overall_ord (3).
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES /BREAK=
 /complete_cases=N /category1_cases=SUM(category1)
 /category2_cases=SUM(category2) /category3_cases=SUM(category3)
 /min_safety=MIN(safety_ord) /max_safety=MAX(safety_ord)
 /min_respect=MIN(respect_ord) /max_respect=MAX(respect_ord)
 /min_timeliness=MIN(timeliness_ord) /max_timeliness=MAX(timeliness_ord)
 /min_quality=MIN(quality_ord) /max_quality=MAX(quality_ord)
 /min_quantity=MIN(quantity_ord) /max_quantity=MAX(quantity_ord).
COMPUTE model_ready=(complete_cases>=100 AND
 MIN(category1_cases,category2_cases,category3_cases)>=10 AND
 max_safety>min_safety AND max_respect>min_respect AND
 max_timeliness>min_timeliness AND max_quality>min_quality AND max_quantity>min_quantity).
VALUE LABELS model_ready 0 'Insufficient complete cases or predictor variation' 1 'Data checks met'.
TEMPORARY.
SELECT IF ($CASENUM=1).
LIST VARIABLES=complete_cases category1_cases category2_cases category3_cases model_ready.

* 5. Fit the ordinal logistic model and display the results.
* No model is estimated if model_ready=0; the procedure will report no cases.
* The bundled example has 28 complete cases; supply survey data to fit the model.
* WITH treats the five domains as numeric predictors with equal increments.
TEMPORARY.
SELECT IF (model_ready=1).
PLUM overall_ord WITH safety_ord respect_ord timeliness_ord quality_ord quantity_ord
 /LINK=LOGIT
 /CRITERIA=CIN(95) MXITER(1000)
 /PRINT=FIT PARAMETER SUMMARY TPARALLEL.

* Read convergence and parallel-lines diagnostics before interpreting coefficients.
* An odds ratio is EXP(beta); confidence limits are EXP(lower) and EXP(upper).
* Results are adjusted associations, not causal effects or percentage contributions.

* 6. Optional Viewer export: remove the first asterisk and enter a new file path.
* OUTPUT SAVE OUTFILE='C:/Monitoring/cc81_regression.spv'.
