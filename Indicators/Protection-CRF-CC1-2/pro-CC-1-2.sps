********************************************************************************
*                          WFP Standardized Scripts
*                           Access Challenges Indicator
********************************************************************************

* This script processes the access challenges indicator by assessing 
* whether households have been unable to access WFP assistance one or more times.

* Define variable and value labels.

VARIABLE LABELS HHAsstAccess "Have you or any member of your household been unable to access WFP assistance one or more times?".
VALUE LABELS HHAsstAccess 1 'Yes' 0 'No' 888 'Don\'t know'.

* Display frequency of HHAsstAccess.
FREQUENCIES VARIABLES = HHAsstAccess.

* End of Scripts.