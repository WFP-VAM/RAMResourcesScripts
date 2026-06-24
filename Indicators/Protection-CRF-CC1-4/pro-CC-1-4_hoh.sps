*------------------------------------------------------------------------------*
*                          WFP Standardized Scripts
*                    Household Level Assistance (hoh)
*------------------------------------------------------------------------------*

* This script processes the indicators related to the receipt of different types 
* of assistance by households and the disability status of the head of the household.

* Define variable and value labels.
VARIABLE LABELS 
    HHAsstWFPRecCashYN1Y "Did your household receive cash-based WFP assistance in the last 12 months?".
VARIABLE LABELS 
    HHAsstWFPRecInKindYN1Y "Did your household receive in-kind WFP assistance in the last 12 months?".
VARIABLE LABELS 
    HHAsstWFPRecCapBuildYN1Y "Did you household receive WFP capacity building assistance in the last 12 months?".

VARIABLE LABELS 
    HHHSex "What is the sex of the head of the household?".
VARIABLE LABELS 
    HHHAge "Age of the head of the household".

VARIABLE LABELS 
    HHHDisabSee "Does the head of household have difficulty seeing, even if wearing glasses? Would you say…".
VARIABLE LABELS 
    HHHDisabHear "Does the head of household have difficulty hearing, even if using a hearing aid(s)? Would you say…".
VARIABLE LABELS 
    HHHDisabWalk "Does the head of household have difficulty walking or climbing steps? Would you say…".
VARIABLE LABELS 
    HHHDisabRemember "Does the head of household have difficulty remembering or concentrating? Would you say…".
VARIABLE LABELS 
    HHHDisabUnderstand "Using his or her usual language, does the head of household have difficulty communicating, for example understanding or being understood? Would you say…".
VARIABLE LABELS 
    HHHDisabWash "Does the head of household have difficulty with self-care, such as washing all over or dressing? Would you say…".

VALUE LABELS 
    HHAsstWFPRecCashYN1Y 
    HHAsstWFPRecInKindYN1Y 
    HHAsstWFPRecCapBuildYN1Y 
    0 'No' 
    1 'Yes'.
VALUE LABELS 
    HHHSex 
    0 'Female' 
    1 'Male'.
VALUE LABELS 
    HHHDisabSee 
    HHHDisabHear 
    HHHDisabWalk 
    HHHDisabRemember 
    HHHDisabUnderstand 
    HHHDisabWash 
    1 'No difficulty' 
    2 'Some difficulty' 
    3 'A lot of difficulty' 
    4 'Cannot do at all' 
    888 "Don't know" 
    999 'Refuse'.

* Calculate whether the respondent had "A lot of difficulty" or "Cannot do at all" for any of the 6 questions.
COMPUTE HHHDisabCat3 = 0.
IF HHHDisabSee = 3 | HHHDisabSee = 4 | HHHDisabHear = 3 | HHHDisabHear = 4 | HHHDisabWalk = 3 | HHHDisabWalk = 4 | HHHDisabRemember = 3 | HHHDisabRemember = 4 | HHHDisabUnderstand = 3 | HHHDisabUnderstand = 4 | HHHDisabWash = 3 | HHHDisabWash = 4 HHHDisabCat3 = 1.
VALUE LABELS HHHDisabCat3 
    0 "without disability (category 3 criteria)" 
    1 "with disability (category 3 criteria)".

* Create tables of the percentage of type of assistance received by HHHDisabCat3.

* Cash-based assistance.
CROSSTABS
  /TABLES=HHAsstWFPRecCashYN1Y BY HHHDisabCat3
  /FORMAT=AVALUE TABLES
  /CELLS=COLUMN 
  /COUNT ROUND CELL.

* In-kind assistance.
CROSSTABS
  /TABLES=HHAsstWFPRecInKindYN1Y BY HHHDisabCat3
  /FORMAT=AVALUE TABLES
  /CELLS=COLUMN 
  /COUNT ROUND CELL.

* Capacity building assistance.
CROSSTABS
  /TABLES=HHAsstWFPRecCapBuildYN1Y BY HHHDisabCat3
  /FORMAT=AVALUE TABLES
  /CELLS=COLUMN 
  /COUNT ROUND CELL.

* End of Scripts.