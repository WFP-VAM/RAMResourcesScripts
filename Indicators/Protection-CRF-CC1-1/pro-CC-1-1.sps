********************************************************************************
*                          WFP Standardized Scripts
*                          Security Challenges Indicator
********************************************************************************

* This script processes the security challenges indicator by assessing 
* whether households have experienced any security challenge related to WFP assistance.

* Define variable and value labels.

VARIABLE LABELS HHAsstSecurity "Have you or any of your household members experienced any security challenge related to WFP assistance?".
VALUE LABELS HHAsstSecurity 1 'Yes' 0 'No' 888 'Don\'t know'.

* Display frequency of HHAsstSecurity.
FREQUENCIES VARIABLES = HHAsstSecurity.

* End of Scripts.