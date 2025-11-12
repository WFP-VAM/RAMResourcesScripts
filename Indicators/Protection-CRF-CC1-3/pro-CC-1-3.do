*------------------------------------------------------------------------------*
*                          WFP Standardized Scripts
*                    Respect and Dignity in WFP Programmes
*------------------------------------------------------------------------------*

* This script processes the indicators related to whether households feel 
* respected and dignified while engaging in WFP programmes.

* Define variable and value labels.
label variable HHAsstRespect "Do you think WFP and/or partner staff have treated you and members of your household respectfully?"
label variable HHDTPDign     "Do you think the conditions of WFP programme sites are dignified?"

label define YesNo 1 "Yes" 0 "No"
label values HHAsstRespect HHDTPDign YesNo

* Cross tabulate to see how many are "Yes" in both questions.
tabulate HHAsstRespect HHDTPDign

* Calculate indicator.
gen HHAsstRespectDign = (HHAsstRespect == 1 & HHDTPDign == 1)
replace HHAsstRespectDign = 0 if HHAsstRespectDign == .

label variable HHAsstRespectDign "Treated with respect while engaging in WFP programs"
label define RespectDignity 0 "No" 1 "Yes"
label values HHAsstRespectDign RespectDignity

* Display frequency of HHAsstRespectDign.
tabulate HHAsstRespectDign

* End of Scripts.