*------------------------------------------------------------------------------*
*	                          WFP Standardized Scripts
*                  Calculating Gender-Related Indicator (genC31)
*------------------------------------------------------------------------------*

* This script calculates the gender-related indicator (genC31) based on 
* household decision-making regarding WFP assistance received.

* Label genC31 relevant variables
label var HHAsstWFPRecCashYN1Y    "Did your household receive cash-based WFP assistance in the last 12 months?"
label var HHAsstWFPRecInKindYN1Y  "Did your household receive in-kind WFP assistance in the last 12 months?"
label var HHAsstCashDescWho       "Who in your household decides what to do with the cash/voucher given by WFP, such as when, where and what to buy, is it women, men or both?"
label var HHAsstInKindDescWho     "Who in your household decides what to do with the food given by WFP, such as when, where and what to buy, is it women, men or both?"

* Define value labels
label define HHAsstYN_lbl          0 "No" 1 "Yes"
label values HHAsstWFPRecCashYN1Y  HHAsstYN_lbl
label values HHAsstWFPRecInKindYN1Y HHAsstYN_lbl

label define HHAsstWho_lbl         10 "Men" 20 "Women" 30 "Both together" 
label values HHAsstCashDescWho     HHAsstWho_lbl
label values HHAsstInKindDescWho   HHAsstWho_lbl

* Set n/a value to missing
mvdecode HHAsstCashDescWho HHAsstInKindDescWho, mv(9999)

* Frequency of 2 questions to determine who makes decisions per type of assistance
tab HHAsstCashDescWho
tab HHAsstInKindDescWho

* End of Scripts