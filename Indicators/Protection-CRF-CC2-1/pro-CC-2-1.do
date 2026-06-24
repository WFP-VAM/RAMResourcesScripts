*------------------------------------------------------------------------------*
*                          WFP Standardized Scripts
*                Access to Information in WFP Programmes (pro-CC-2-1)
*------------------------------------------------------------------------------*

* This script processes the indicators related to households' access to information 
* about their entitlements, selection criteria, information comprehension, and 
* reporting misconduct in WFP programmes.

* Define variable and value labels.
label variable HHAsstKnowEnt    "Have you been told exactly what you are entitled to receive in terms of commodities/quantities or cash? Please describe your entitlements"
label variable HHAsstKnowPeople "Do you know how people were chosen to receive assistance? Please describe how they were chosen"
label variable HHAsstRecInfo    "Did you receive the information in a way that you could easily understand?"
label variable HHAsstReportMisc "Do you know how to report misconduct from WFP or partners, including asking for (sexual) favours or money in exchange of assistance?"

label define YesNo   1 "Yes" 0 "No"
label define RecInfo 1 "Yes" 0 "No" 2 "I never received information"

label values HHAsstKnowEnt HHAsstKnowPeople HHAsstReportMisc YesNo
label values HHAsstRecInfo RecInfo

* Display frequency tables.
tabulate HHAsstKnowEnt
tabulate HHAsstKnowPeople
tabulate HHAsstRecInfo
tabulate HHAsstReportMisc

* Compute the indicator for accessible information.
gen     HHAcessInfo = 0
replace HHAcessInfo = 1 if HHAsstKnowEnt == 1 & HHAsstKnowPeople == 1 & HHAsstRecInfo == 1 & HHAsstReportMisc == 1

label variable HHAcessInfo "Provided with accessible information about the programme"
label define AccessInfo 0 "No" 1 "Yes"
label values HHAcessInfo AccessInfo

* Display frequency table for the indicator.
tabulate HHAcessInfo

* End of Scripts.