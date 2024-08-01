*------------------------------------------------------------------------------
*                          WFP Standardized Scripts
*         Nutritious Crop Production Increase Calculation (SAMS Indicator 31)
*------------------------------------------------------------------------------

* This script calculates the proportion of farmers reporting an increase in 
* nutritious crop production based on SAMS Indicator 31 guidelines.
* Detailed guidelines can be found in the SAMS documentation.

* This syntax is based on SPSS download version from MoDA.
* More details can be found in the background document at: 
* https://wfp.sharepoint.com/sites/CRF2022-2025/CRF%20Outcome%20indicators/Forms/AllItems.aspx

*------------------------------------------------------------------------------
* Import Dataset 1
*------------------------------------------------------------------------------

PRESERVE.
SET DECIMAL DOT.

GET DATA  /TYPE=TXT
  /FILE="C:\Users\b\Desktop\demo\SAMS31\data.csv"
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS=","
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  Demographic_moduleDemographicBasic_submoduleRespSex AUTO
  SAMS_moduleIndicator31_submoduleSAMSNutCropNb AUTO
  @_index AUTO
  /MAP.
RESTORE.

CACHE.
EXECUTE.
DATASET NAME DataSet1 WINDOW=FRONT.

*------------------------------------------------------------------------------
* Import Dataset 2
*------------------------------------------------------------------------------

GET DATA  /TYPE=TXT
  /FILE="C:\Users\b\Desktop\demo\SAMS31\SAMS_module_Indicator31_submodule_RepeatNutCrop.csv"
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS=","
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  SAMS_moduleIndicator31_submoduleRepeatNutCropPSAMSNutCropName_A AUTO
  SAMS_moduleIndicator31_submoduleRepeatNutCropPSAMSNutCropName AUTO
  SAMS_moduleIndicator31_submoduleRepeatNutCropPSAMSNutCropQuan_B AUTO
  SAMS_moduleIndicator31_submoduleRepeatNutCropPSAMSNutCropQuan_A AUTO
  SAMS_moduleIndicator31_submoduleRepeatNutCropPSAMSNutCropQuan AUTO
  SAMS_moduleIndicator31_submoduleRepeatNutCropPSAMSNutCropIncr AUTO
  @_parent_index AUTO
  /MAP.
RESTORE.

CACHE.
EXECUTE.
DATASET NAME DataSet2 WINDOW=FRONT.

*------------------------------------------------------------------------------
* Join Two Datasets
*------------------------------------------------------------------------------

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

*------------------------------------------------------------------------------
* Rename Variables
*------------------------------------------------------------------------------

RENAME VARIABLES (SAMS_moduleIndicator31_submoduleRepeatNutCropPSAMSNutCropName_A = PSAMSNutCropName).
RENAME VARIABLES (SAMS_moduleIndicator31_submoduleRepeatNutCropPSAMSNutCropIncr   = PSAMSNutCropIncr).
RENAME VARIABLES (Demographic_moduleDemographicBasic_submoduleRespSex             = RespSex).

*------------------------------------------------------------------------------
* Define Variable and Value Labels
*------------------------------------------------------------------------------

Variable labels PSAMSNutCropName "What is the name of crop?".
Variable labels PSAMSNutCropIncr "Did you produce more, less or the same amount of this nutritious crop in the last 12 months compared to the 12 months before that?".
Variable labels RespSex          "Sex of the Respondent".

Value labels PSAMSNutCropName 1 'Crop 1' 2 'Crop 2' 3 'Crop 3' 4 'Crop 4' 5 'Crop 5' 999 'Other'.
Value labels PSAMSNutCropIncr 1 'More' 2 'Less' 3 'The same' 9999 'Not applicable'.
Value labels RespSex 0 'Female' 1 'Male'.

*------------------------------------------------------------------------------
* Select Farmers that Grew "Crop 1" and Show Proportion Reporting Increase, Decrease, or Same Production
*------------------------------------------------------------------------------

SELECT IF (PSAMSNutCropIncr ~= 9999 & PSAMSNutCropName = 1).

CROSSTABS
  /TABLES=RespSex BY PSAMSNutCropIncr
  /FORMAT=AVALUE TABLES
  /CELLS=ROW
  /COUNT ROUND CELL.

* End of Scripts