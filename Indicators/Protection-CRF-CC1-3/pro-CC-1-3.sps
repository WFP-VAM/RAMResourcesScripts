* Encoding: UTF-8.

Variable labels HHAsstRespect ‘Do you think WFPandor partner staff have treated you and members of your household respectfully? ’.

Variable labels HHDTPDign ‘Do you think the conditions of WFP programme sites are dignified?’.

Value labels HHAsstRespect HHDTPDign 1 'Yes' 0  'No'.

* cross tab first to see how many are "Yes" in both questions

CROSSTABS
  /TABLES=HHAsstRespect BY HHDTPDign
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.


do if (HHAsstRespect = 1) & (HHDTPDign = 1). 
compute HHAsstRespectDign = 1.
Else.
Compute HHAsstRespectDign = 0.
End if.

variable labels HHAsstRespectDign "Treated with respect while engaging in WFP programs".
value labels HHAsstRespectDign
0 "No"
1 "Yes".

freq HHAsstRespectDign.
