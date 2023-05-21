* Encoding: UTF-8.

*assign variable and value labels 

Variable Labels HHAsstWFPRecCashYN1Y "Did your household receive cash-based WFP assistance in the last 12 months?".
Variable Labels HHAsstWFPRecInKindYN1Y "Did your household receive in-kind WFP assistance in the last 12 months?".
Variable Labels HHAsstWFPRecCapBuildYN1Y "Did you household receive WFP capacity building assistance in the last 12 months?".

Variable Labels HHHSex  "What is the sex of the head of the household?".
Variable Labels HHHAge "Age of the head of the household".

Variable Labels HHHDisabSee "Does the head of household have difficulty seeing, even if wearing glasses? Would you say…".
Variable Labels HHHDisabHear "Does the head of household have difficulty hearing, even if using a hearing aid(s)? Would you say…".
Variable Labels HHHDisabWalk  "Does the head of household have difficulty remembering or concentrating? Would you say…".
Variable Labels  HHHDisabRemember "Does the head of household have difficulty remembering or concentrating? Would you say…".
Variable Labels  HHHDisabUnderstand "Using his or her usual language, does the head of household have difficulty communicating, for example understanding or being understood? Would you say…".
Variable Labels  HHHDisabWash "Does the head of household have difficulty with self-care, such as washing all over or dressing? Would you say…".


Value labels HHAsstWFPRecCashYN1Y HHAsstWFPRecInKindYN1Y  HHAsstWFPRecCapBuildYN1Y 0 'No' 1 'Yes'.
Value labels HHHSex 0 'Female' 1 'Male'.
Value labels HHHDisabSee HHHDisabHear HHHDisabWalk HHHDisabRemember HHHDisabUnderstand HHHDisabWash 1 'No difficulty' 2 'Some difficulty' 3 'A lot of difficulty' 4 'Cannot do at all' 888 "Don't know" 999 'Refuse'.
    
 
*calculate whether the respondent had "A lot of difficulty" or "Cannot do at all" for any of the 6 questions.

Compute HHHDisabCat3   = 0.
if HHHDisabSee = 3 | HHHDisabSee = 4 | HHHDisabHear = 3 | HHHDisabHear = 4 | HHHDisabWalk = 3 | HHHDisabWalk = 4 | HHHDisabRemember = 3 | HHHDisabRemember = 4 | HHHDisabUnderstand = 3 | HHHDisabUnderstand = 4 |
HHHDisabWash = 3 | HHHDisabWash = 4 HHHDisabCat3 = 1.
    
Value labels HHHDisabCat3 0 "without disability (category 3 criteria)" 1 "with disability (category 3 criteria)".
    
    
*creates a table of the  percentage of type of assistance recieve by PDisabCat3


*cash

CROSSTABS
  /TABLES=HHAsstWFPRecCashYN1Y BY HHHDisabCat3
  /FORMAT=AVALUE TABLES
  /CELLS=COLUMN 
  /COUNT ROUND CELL.

*inkind

CROSSTABS
  /TABLES=HHAsstWFPRecInKindYN1Y BY HHHDisabCat3
  /FORMAT=AVALUE TABLES
  /CELLS=COLUMN 
  /COUNT ROUND CELL.

*capacity building

CROSSTABS
  /TABLES=HHAsstWFPRecCapBuildYN1Y BY HHHDisabCat3
  /FORMAT=AVALUE TABLES
  /CELLS=COLUMN 
  /COUNT ROUND CELL.


