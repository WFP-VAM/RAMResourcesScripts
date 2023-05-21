* Encoding: UTF-8.

* Encoding: UTF-8.

Variable labels HHAsstKnowEnt 'Have you been told exactly what you are entitled to receive in terms of commodities/quantities or cash? Please describe your entitlements'.
Variable labels HHAsstKnowPeople 'Do you know how people were chosen to receive assistance? Please describe how they were chosen'.
Variable labels HHAsstRecInfo 'Did you receive the information in a way that you could easily understand?'.
Variable labels HHAsstReportMisc 'Do you know how to report misconduct from WFP or partners, including asking for (sexual) favours or money in exchange of assistance?'.


Value labels HHAsstKnowEnt HHAsstKnowPeople HHAsstReportMisc 1 'Yes' 0  'No'.
Value labels HHAsstRecInfo 1 'Yes' 0  'No' 2 'I never received information'.


freq HHAsstKnowEnt HHAsstKnowPeople HHAsstRecInfo HHAsstReportMisc.

do if (HHAsstKnowEnt = 1) & (HHAsstKnowPeople = 1) & (HHAsstRecInfo = 1) & (HHAsstReportMisc = 1). 
compute HHAcessInfo = 1.
Else.
Compute HHAcessInfo = 0.
End if.

variable labels HHAcessInfo "Provided with accessible information about the programme ".
value labels HHAcessInfo
0 "No"
1 "Yes".

freq HHAcessInfo.

