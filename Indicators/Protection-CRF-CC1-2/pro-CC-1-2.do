*------------------------------------------------------------------------------*
*                          WFP Standardized Scripts
*                        Access Challenges Indicator
*------------------------------------------------------------------------------*

* This script processes the access challenges indicator by assessing 
* whether households have been unable to access WFP assistance one or more times.

* Define variable and value labels.
label variable HHAsstAccess "Have you or any member of your household been unable to access WFP assistance one or more times?"
label define HHAsstAccess_lbl 0 "No" 1 "Yes" 888 "Don't know"
label values HHAsstAccess HHAsstAccess_lbl

* Display frequency of HHAsstAccess.
tabulate HHAsstAccess

* Create a table of the weighted percentage of HHAsstAccess.
cap gen WeightHH = 1
tabulate HHAsstAccess [aw = WeightHH]

* End of Scripts.