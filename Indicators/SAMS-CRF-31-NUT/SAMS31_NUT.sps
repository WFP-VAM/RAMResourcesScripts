* Encoding: UTF-8.

* import dataset 1

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

* import dataset 2

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

*join two datasets

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


*can only download repeat csv data as zip file from moda with group names - will update this code to remove group names
*rename to remove group names - because of the variable length SPSS changes name slightly

DATASET ACTIVATE DataSet1.

RENAME VARIABLES (SAMS_moduleIndicator31_submoduleRepeatNutCropPSAMSNutCropName_A = PSAMSNutCropName).
RENAME VARIABLES (SAMS_moduleIndicator31_submoduleRepeatNutCropPSAMSNutCropIncr = PSAMSNutCropIncr).
RENAME VARIABLES (Demographic_moduleDemographicBasic_submoduleRespSex = RespSex).

Value labels PSAMSNutCropName 1 'Crop 1' 2 'Crop 2' 3 'Crop 3' 4 'Crop 4' 5 'Crop 5' 999 'Other'.
Value labels PSAMSNutCropIncr 1 'More' 2  'Less '  3  'The same '  9999 'Not applicable'.
Value labels RespSex 0 'Female' 1 'Male'.

*#selecting farmers that grew "Crop 1" show proportion reporting an increase, decrease or the same amount of production as the year before

select if(PSAMSNutCropIncr ~= 9999 & PSAMSNutCropName = 1).

CROSSTABS
  /TABLES=RespSex BY PSAMSNutCropIncr
  /FORMAT=AVALUE TABLES
  /CELLS=ROW
  /COUNT ROUND CELL.

