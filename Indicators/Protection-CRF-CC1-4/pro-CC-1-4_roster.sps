*------------------------------------------------------------------------------*
*                          WFP Standardized Scripts
*             Disability Status and Assistance Received (Roster)
*------------------------------------------------------------------------------*

* Note: This script is based on the assumption that the dataset has already 
* been imported and includes variables related to disability status and 
* assistance received.

* The following variables should have been defined before running this script:
* - TechnicalAdd_submodule/HHAsstWFPRecCashYN1Y
* - TechnicalAdd_submodule/HHAsstWFPRecInKindYN1Y
* - TechnicalAdd_submodule/HHAsstWFPRecCapBuildYN1Y
* - Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers
*------------------------------------------------------------------------------.

* Import dataset 1.
PRESERVE.
SET DECIMAL DOT.
GET DATA  /TYPE=TXT
  /FILE="C:\Users\b\Desktop\demo\RosterMethod\data.csv"
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS=","
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
    TechnicalAdd_submoduleHHAsstWFPRecCashYN1Y AUTO
    TechnicalAdd_submoduleHHAsstWFPRecInKindYN1Y AUTO
    TechnicalAdd_submoduleHHAsstWFPRecCapBuildYN1Y AUTO
    @_index AUTO
  /MAP.
RESTORE.
CACHE.
EXECUTE.
DATASET NAME DataSet1.

* Import dataset 2.
PRESERVE.
SET DECIMAL DOT.
GET DATA  /TYPE=TXT
  /FILE=
    "C:\Users\b\Desktop\demo\RosterMethod\Demographic_module_DisabilityHHMemb_submodule_RepeatDisabHH"+
    "Members.csv"
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS=","
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
    Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_H AUTO
    Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_G AUTO
    Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_F AUTO
    Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_E AUTO
    Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_D AUTO
    Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_C AUTO
    Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_B AUTO
    Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_A AUTO
    Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe AUTO
    @_parent_index AUTO
  /MAP.
RESTORE.
CACHE.
EXECUTE.
DATASET NAME DataSet2.

* Join two datasets.
DATASET ACTIVATE DataSet2.
RENAME VARIABLES (@_parent_index = index).
DATASET ACTIVATE DataSet1.
RENAME VARIABLES (@_index = index).
SORT CASES BY index.
DATASET ACTIVATE DataSet2.
SORT CASES BY index.
DATASET ACTIVATE DataSet1.
MATCH FILES /TABLE=*
  /FILE='DataSet2'
  /BY index.
EXECUTE.

* Rename to remove group names - because of the variable length SPSS changes name slightly.
DATASET ACTIVATE DataSet1.
RENAME VARIABLES (TechnicalAdd_submoduleHHAsstWFPRecCashYN1Y = HHAsstWFPRecCashYN1Y).
RENAME VARIABLES (TechnicalAdd_submoduleHHAsstWFPRecInKindYN1Y = HHAsstWFPRecInKindYN1Y).
RENAME VARIABLES (TechnicalAdd_submoduleHHAsstWFPRecCapBuildYN1Y = HHAsstWFPRecCapBuildYN1Y).
RENAME VARIABLES (Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_G = PDisabAge).
RENAME VARIABLES (Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_F = PDisabSex).
RENAME VARIABLES (Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_E = PDisabSee).
RENAME VARIABLES (Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_D = PDisabHear).
RENAME VARIABLES (Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_C = PDisabWalk).
RENAME VARIABLES (Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_B = PDisabRemember).
RENAME VARIABLES (Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_A = PDisabUnderstand).
RENAME VARIABLES (Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe = PDisabWash).

* Assign variable and value labels.
Variable Labels 
  HHAsstWFPRecCashYN1Y    "Did your household receive cash-based WFP assistance in the last 12 months?".
Variable Labels 
  HHAsstWFPRecInKindYN1Y  "Did your household receive in-kind WFP assistance in the last 12 months?".
Variable Labels 
  HHAsstWFPRecCapBuildYN1Y "Did you household receive WFP capacity building assistance in the last 12 months?".

Variable Labels 
  PDisabAge         "What is the age of ${PDisabName}?".
Variable Labels 
  PDisabSex         "What is the sex of ${PDisabName}?".
Variable Labels 
  PDisabSee         "Does ${PDisabName} have difficulty seeing, even if wearing glasses? Would you say…".
Variable Labels 
  PDisabHear        "Does ${PDisabName} have difficulty hearing, even if using a hearing aid(s)? Would you say…".
Variable Labels 
  PDisabWalk        "Does ${PDisabName} have difficulty walking or climbing steps? Would you say…".
Variable Labels 
  PDisabRemember    "Does ${PDisabName} have difficulty remembering or concentrating? Would you say…".
Variable Labels 
  PDisabUnderstand  "Using your usual language, does ${PDisabName} have difficulty communicating, for example understanding or being understood? Would you say…".
Variable Labels 
  PDisabWash        "Does ${PDisabName} have difficulty with self-care, such as washing all over or dressing? Would you say…".

Value labels 
  HHAsstWFPRecCashYN1Y HHAsstWFPRecInKindYN1Y HHAsstWFPRecCapBuildYN1Y 
  0 'No' 
  1 'Yes'.

Value labels 
  PDisabSex 
  0 'Female' 
  1 'Male'.

Value labels 
  PDisabSee PDisabHear PDisabWalk PDisabRemember PDisabUnderstand PDisabWash 
  1 'No difficulty' 
  2 'Some difficulty' 
  3 'A lot of difficulty' 
  4 'Cannot do at all' 
  888 "Don't know" 
  999 'Refuse'.

* Calculate whether the respondent had "A lot of difficulty" or "Cannot do at all" for any of the 6 questions.
Compute PDisabCat3 = 0.
if PDisabSee = 3 | PDisabSee = 4 | PDisabHear = 3 | PDisabHear = 4 | PDisabWalk = 3 | PDisabWalk = 4 | PDisabRemember = 3 | PDisabRemember = 4 | PDisabUnderstand = 3 | PDisabUnderstand = 4 | PDisabWash = 3 | PDisabWash = 4 PDisabCat3 = 1.

Value labels 
  PDisabCat3 
  0 "without disability (category 3 criteria)" 
  1 "with disability (category 3 criteria)".

* Creates a table of the percentage of type of assistance received by PDisabCat3.

* Cash.
CROSSTABS
  /TABLES=HHAsstWFPRecCashYN1Y BY PDisabCat3
  /FORMAT=AVALUE TABLES
  /CELLS=COLUMN 
  /COUNT ROUND CELL.

* In-kind.
CROSSTABS
  /TABLES=HHAsstWFPRecInKindYN1Y BY PDisabCat3
  /FORMAT=AVALUE TABLES
  /CELLS=COLUMN 
  /COUNT ROUND CELL.

* Capacity building.
CROSSTABS
  /TABLES=HHAsstWFPRecCapBuildYN1Y BY PDisabCat3
  /FORMAT=AVALUE TABLES
  /CELLS=COLUMN 
  /COUNT ROUND CELL.

DATASET ACTIVATE DataSet1.