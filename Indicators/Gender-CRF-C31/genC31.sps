*------------------------------------------------------------------------------*
*	                          WFP Standardized Scripts
*                  Calculating Gender-Related Indicator (genC31)
*------------------------------------------------------------------------------*

* This script calculates the gender-related indicator (genC31) based on 
* household decision-making regarding WFP assistance received.

* Define variable and value labels
Variable labels
  HHAsstWFPRecCashYN1Y  'Did your household receive cash-based WFP assistance in the last 12 months?'
  HHAsstWFPRecInKindYN1Y 'Did your household receive in-kind WFP assistance in the last 12 months?'
  HHAsstCashDescWho     'Who in your household decides what to do with the cash/voucher given by WFP, such as when, where and what to buy, is it women, men or both?'
  HHAsstInKindDescWho   'Who in your household decides what to do with the food given by WFP, such as when, where and what to buy, is it women, men or both?'

Value labels
  HHAsstWFPRecCashYN1Y  1 'Yes' 0 'No'
  HHAsstWFPRecInKindYN1Y 1 'Yes' 0 'No'
  HHAsstCashDescWho     10 'Men' 20 'Women' 30 'Both together'
  HHAsstInKindDescWho   10 'Men' 20 'Women' 30 'Both together'

* Set n/a value to missing
missing values HHAsstCashDescWho HHAsstInKindDescWho ("n/a").

* Frequency of 2 questions to determine who makes decisions per type of assistance
FREQ HHAsstCashDescWho.
FREQ HHAsstInKindDescWho.

* End of Scripts