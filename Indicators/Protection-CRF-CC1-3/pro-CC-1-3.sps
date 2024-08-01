********************************************************************************
*                          WFP Standardized Scripts
*                    Respect and Dignity in WFP Programmes
********************************************************************************

* This script processes the indicators related to whether households feel 
* respected and dignified while engaging in WFP programmes.

* Define variable and value labels.
VARIABLE LABELS 
    HHAsstRespect "Do you think WFP and/or partner staff have treated you and members of your household respectfully?".
VARIABLE LABELS 
    HHDTPDign     "Do you think the conditions of WFP programme sites are dignified?".

VALUE LABELS HHAsstRespect HHDTPDign 
    1 'Yes' 
    0 'No'.

* Cross tabulate to see how many are "Yes" in both questions.
CROSSTABS
  /TABLES=HHAsstRespect BY HHDTPDign
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.

DO IF (HHAsstRespect = 1) & (HHDTPDign = 1).
  COMPUTE HHAsstRespectDign = 1.
ELSE.
  COMPUTE HHAsstRespectDign = 0.
END IF.

VARIABLE LABELS 
    HHAsstRespectDign "Treated with respect while engaging in WFP programs".
VALUE LABELS 
    HHAsstRespectDign 
    0 'No' 
    1 'Yes'.

* Display frequency of HHAsstRespectDign.
FREQUENCIES VARIABLES = HHAsstRespectDign.

* End of Scripts.