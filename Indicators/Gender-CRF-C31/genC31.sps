* Encoding: UTF-8.
* define variable and value labels

Variable labels HHAsstWFPRecCashYN1Y 'Did your household receive cash-based WFP assistance in the last 12 months?'.
Variable labels HHAsstWFPRecCashYN1Y 'Did your household receive in-kind WFP assistance in the last 12 months?'.
Variable labels HHAsstCashDescWho 'Who in your household decides what to do with the cash/voucher given by WFP, such as when, where and what to buy, is it women, men or both?'.
Variable labels HHAsstInKindDescWho 'Who in your household decides what to do with the food given by WFP, such as when, where and what to buy, is it women, men or both?'.

Value labels HHAsstWFPRecCashYN1Y HHAsstWFPRecCashYN1Y 1 'Yes' 0  'No'.
Value labels HHAsstCashDescWho HHAsstInKindDescWho 10 'Men' 20  'Women' 30 'Both together'.



* set n/a value to missing 

missing values HHAsstCashDescWho HHAsstInKindDescWho("n/a").


*Frequency of 2 questions to determine who makes decisions per type of assistance

Freq HHAsstCashDescWho.
    
Freq HHAsstInKindDescWho.
