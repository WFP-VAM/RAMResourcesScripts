* Encoding: UTF-8.
* CC.8.1 Overall satisfaction with WFP assistance delivery.
* Survey Designer codes: 1 Very satisfied, 2 Satisfied, 3 Unsatisfied.
* Step 1 selects the bundled example or your open numeric survey dataset (f.
* Run all syntax. Results appear in the Viewer; saving is optional in Step 7.

* 1. Select the input and work on a copy.
* Set the working directory to the repository folder containing Static - example.
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

DATASET COPY CC81Results.
DATASET ACTIVATE CC81Results.
WEIGHT OFF.
FILTER OFF.
SPLIT FILE OFF.
MATCH FILES /FILE=*
 /KEEP=RESPConsent RESPSex HHAsstWFPSatisf HHAsstWFPSatisf_Rec
       HHAsstWFPSatisf_Resp HHAsstWFPSatisf_Time HHAsstWFPSatisf_Qual HHAsstWFPSatisf_Quan.

* 2. Assign Survey Designer variable and response labels.
VARIABLE LABELS
 RESPConsent 'Consent to interview'
 RESPSex 'Sex of the respondent'
 HHAsstWFPSatisf 'Overall satisfaction with WFP assistance'
 HHAsstWFPSatisf_Rec 'Satisfaction with safety when receiving assistance'
 HHAsstWFPSatisf_Resp 'Satisfaction with respect while receiving assistance'
 HHAsstWFPSatisf_Time 'Satisfaction with timeliness of assistance'
 HHAsstWFPSatisf_Qual 'Satisfaction with quality of assistance'
 HHAsstWFPSatisf_Quan 'Satisfaction with quantity of assistance'.
VALUE LABELS RESPConsent 0 'No' 1 'Yes' /RESPSex 0 'Female' 1 'Male'.
VALUE LABELS HHAsstWFPSatisf HHAsstWFPSatisf_Rec HHAsstWFPSatisf_Resp
 HHAsstWFPSatisf_Time HHAsstWFPSatisf_Qual HHAsstWFPSatisf_Quan
 1 'Very satisfied' 2 'Satisfied' 3 'Unsatisfied'.

* Retain numeric nonresponse codes as invalid; only system-missing is missing.
MISSING VALUES RESPConsent RESPSex HHAsstWFPSatisf HHAsstWFPSatisf_Rec
 HHAsstWFPSatisf_Resp HHAsstWFPSatisf_Time HHAsstWFPSatisf_Qual HHAsstWFPSatisf_Quan ().

* 3. Arrange the six questions and four respondent-sex groups for calculation.
* NULL=KEEP retains blank answers for the missing-answer count.
VARSTOCASES
 /MAKE response FROM HHAsstWFPSatisf HHAsstWFPSatisf_Rec HHAsstWFPSatisf_Resp
                     HHAsstWFPSatisf_Time HHAsstWFPSatisf_Qual HHAsstWFPSatisf_Quan
 /INDEX=question
 /KEEP=RESPConsent RESPSex
 /NULL=KEEP.

DO REPEAT eligible=eligible_all eligible_female eligible_male eligible_unknown.
 COMPUTE eligible=0.
END REPEAT.
IF (RESPConsent=1) eligible_all=1.
IF (RESPConsent=1 AND RESPSex=0) eligible_female=1.
IF (RESPConsent=1 AND RESPSex=1) eligible_male=1.
IF (RESPConsent=1 AND (SYSMIS(RESPSex) OR NOT ANY(RESPSex,0,1))) eligible_unknown=1.

* Each group is retained even when it contains no eligible respondents.
VARSTOCASES
 /MAKE eligible FROM eligible_all eligible_female eligible_male eligible_unknown
 /INDEX=sex_category
 /KEEP=question response
 /NULL=KEEP.

* 4. Identify valid responses and satisfaction categories for each question.
RECODE response (1,2=1) (3=0) (ELSE=SYSMIS) INTO satisfaction.
VARIABLE LABELS satisfaction 'Satisfied or very satisfied with this aspect of assistance'.
VALUE LABELS satisfaction 0 'Unsatisfied' 1 'Satisfied or very satisfied'.
DO REPEAT flag=valid_answer satisfied_answer unsatisfied_answer
               satisfied_only_answer very_satisfied_answer missing_answer.
 COMPUTE flag=0.
END REPEAT.
IF (eligible=1 AND ANY(response,1,2,3)) valid_answer=1.
IF (eligible=1 AND satisfaction=1) satisfied_answer=1.
IF (eligible=1 AND response=3) unsatisfied_answer=1.
IF (eligible=1 AND response=2) satisfied_only_answer=1.
IF (eligible=1 AND response=1) very_satisfied_answer=1.
IF (eligible=1 AND SYSMIS(response)) missing_answer=1.

* 5. Sum the counts and calculate percentages using each question's valid N.
AGGREGATE /OUTFILE=* /BREAK=sex_category question
 /n_eligible=SUM(eligible) /n_valid=SUM(valid_answer)
 /n_satisfied=SUM(satisfied_answer) /n_unsatisfied=SUM(unsatisfied_answer)
 /n_satisfied_only=SUM(satisfied_only_answer) /n_very_satisfied=SUM(very_satisfied_answer)
 /n_missing=SUM(missing_answer).
COMPUTE n_invalid=n_eligible-n_valid-n_missing.
DO REPEAT count=n_satisfied n_unsatisfied n_satisfied_only n_very_satisfied
 /percentage=pct_satisfied pct_unsatisfied pct_satisfied_only pct_very_satisfied.
 COMPUTE percentage=$SYSMIS.
 IF (n_valid>0) percentage=100*count/n_valid.
END REPEAT.

* 6. Label and display the final table. Overall / All is the overall indicator.
STRING variable (A32) domain (A16) sex_group (A8).
DO REPEAT code=1 2 3 4 5 6
 /field='HHAsstWFPSatisf' 'HHAsstWFPSatisf_Rec' 'HHAsstWFPSatisf_Resp'
        'HHAsstWFPSatisf_Time' 'HHAsstWFPSatisf_Qual' 'HHAsstWFPSatisf_Quan'
 /description='Overall' 'Safety' 'Respect' 'Timeliness' 'Quality' 'Quantity'.
 IF (question=code) variable=field.
 IF (question=code) domain=description.
END REPEAT.
DO REPEAT code=1 2 3 4 /description='All' 'Female' 'Male' 'Unknown'.
 IF (sex_category=code) sex_group=description.
END REPEAT.
VARIABLE LABELS
 n_eligible 'Consenting interviews in the group'
 n_valid 'Valid answers to this question'
 n_satisfied 'Satisfied or very satisfied answers'
 pct_satisfied 'Satisfied or very satisfied percentage'
 n_missing 'Missing answers' n_invalid 'Invalid answers'.
FORMATS n_eligible n_valid n_satisfied n_unsatisfied n_satisfied_only
 n_very_satisfied n_missing n_invalid (F12.0)
 pct_satisfied pct_unsatisfied pct_satisfied_only pct_very_satisfied (F20.10).
SORT CASES BY sex_category question.
MATCH FILES /FILE=* /KEEP=variable domain sex_group n_eligible n_valid n_satisfied
 n_unsatisfied n_satisfied_only n_very_satisfied n_missing n_invalid
 pct_satisfied pct_unsatisfied pct_satisfied_only pct_very_satisfied.
LIST VARIABLES=domain sex_group n_valid n_satisfied pct_satisfied.

* 7. Optional CSV export: remove the first asterisk and enter a NEW file path.
* SAVE TRANSLATE OUTFILE='C:/Monitoring/indicator_summary.csv' /TYPE=CSV /FIELDNAMES /CELLS=VALUES.
