*------------------------------------------------------------------------------*
*                          WFP Standardized Scripts
*                         NUT7 Coverage Indicator
*------------------------------------------------------------------------------*

* Note: This syntax file processes the NUT7 coverage indicator by assessing 
* participant enrollment in a specified nutrition program.

* Can only download repeat CSV data as a zip file from MODA with group names.
* Will update this code to remove group names.

* Rename to remove group names.
rename Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgPartic PNutProgPartic_yn

* Define variable and value labels.
label variable PNutProgPartic_yn "Is participant enrolled in the ((insert name/description of program, to be adapted locally)) programme?"
label define PNutProgPartic_yn_label 0 "No" 1 "Yes"
label values PNutProgPartic_yn PNutProgPartic_yn_label

* Frequency table for PNutProgPartic_yn.
tabulate PNutProgPartic_yn

* End of Scripts.