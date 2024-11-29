********************************************************************************
*                          WFP Standardized Scripts
*                         NUT7 Coverage Indicator
********************************************************************************

* Note: This syntax file processes the NUT7 coverage indicator by assessing 
* participant enrollment in a specified nutrition program. 

* Define variable and value labels.

* Can only download repeat CSV data as a zip file from MODA with group names.
* Will update this code to remove group names.

RENAME VARIABLES (Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgPartic = PNutProgPartic_yn).

* Define variable and value labels.

VARIABLE LABELS PNutProgPartic_yn 'Is participant enrolled in the ((insert name/description of program, to be adapted locally)) programme?'.

VALUE LABELS PNutProgPartic_yn 1 'Yes' 0 'No'.

* Frequency table for PNutProgPartic_yn.
FREQUENCIES VARIABLES=PNutProgPartic_yn.

* End of Scripts.