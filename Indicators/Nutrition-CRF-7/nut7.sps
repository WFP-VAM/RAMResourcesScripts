* Encoding: UTF-8.

*can only download repeat csv data as zip file from moda with group names - will update this code to remove group names
*rename to remove group names - because of the variable length SPSS changes name slightly

RENAME VARIABLES (Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgPartic = PNutProgPartic_yn).

* define variable and value labels

Variable labels PNutProgPartic_yn ‘Is participant enrolled in the ((insert name/description  of program, to be adapted locally)) programme?’.

Value labels PNutProgPartic_ynNutProgPartic_yn 1 'Yes' 0  'No '.

freq PNutProgPartic_yn.

