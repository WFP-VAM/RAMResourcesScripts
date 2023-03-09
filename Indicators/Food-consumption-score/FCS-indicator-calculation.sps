* Encoding: UTF-8.
***Food Consumption Score***
***define labels

Variable labels
FCSStap          ‘How many days over the last 7 days, did members of your household eat cereals, rains, roots and tubers?’
FCSPulse         ‘How many days over the last 7 days, did members of your household eat legumes or nuts?’
FCSDairy         ‘How many days over the last 7 days, did members of your household drink eat milk and other dairy products?’
FCSPr              ‘How many days over the last 7 days, did members of your household eat meat, fish and eggs?’
FCSVeg           ‘How many days over the last 7 days, did members of your household eat vegetables and leaves?’
FCSFruit          ‘How many days over the last 7 days, did members of your household eat fruits?’
FCSFat             ‘How many days over the last 7 days, did members of your household consume oil?’
FCSSugar        ‘How many days over the last 7 days, did members of your household eat sugar, or sweets?’
FCSCond	       ‘How many days over the last 7 days, did members of your household eat condiments or spices?’.

Compute FCS = sum(FCSStap*2, FCSPulse*3, FCSDairy*4, FCSPr*4, FCSVeg*1, FCSFruit*1, FCSFat*0.5, FCSSugar*0.5).
Variable labels FCS "Food Consumption Score".
EXECUTE.

***Use this when analyzing a country with low consumption of sugar and oil - thresholds 21-35

Recode FCS (lowest thru 21 =1) (21.5 thru 35 =2) (35.5 thru highest =3) into FCSCat21.
Variable labels FCSCat21 "FCS Categories".
EXECUTE.

*** define value labels and properties for "FCS Categories".
Value labels FCSCat21 1.00 "Poor" 2.00 "Borderline" 3.00 "Acceptable".
EXECUTE.

*** Important note: pay attention to the threshold used by your CO when selecting the syntax (21 cat. vs 28 cat.)
*** Use this when analyzing a country with high consumption of sugar and oil – thresholds 28-42

Recode FCS (lowest thru 28 =1) (28.5 thru 42 =2) (42.5 thru highest =3) into FCSCat28.
Variable labels FCSCat28 "FCS Categories".
EXECUTE.



*** define value labels and properties for "FCS Categories".
Value labels FCSCat28 1.00 "Poor" 2.00 "Borderline" 3.00 "Acceptable".
EXECUTE.

freq FCSCat21 FCSCat28.
