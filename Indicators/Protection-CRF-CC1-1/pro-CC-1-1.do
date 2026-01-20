*------------------------------------------------------------------------------*
*                          WFP Standardized Scripts
*                          Security Challenges Indicator
*------------------------------------------------------------------------------*

* This script processes the security challenges indicator by assessing 
* whether households have experienced any security challenge related to WFP assistance.

* Define variable and value labels.
label variable HHAsstSecurity "Have you or any of your household members experienced any security challenge related to WFP assistance?"
label define HHAsstSecurity_lbl 0 "No" 1 "Yes" 888 "Don't know"
label values HHAsstSecurity HHAsstSecurity_lbl

* Display frequency of HHAsstSecurity.
tabulate HHAsstSecurity

* Create a table of the weighted percentage of HHAsstSecurity.
cap gen WeightHH = 1
tabulate HHAsstSecurity [aw = WeightHH]

* End of Scripts.