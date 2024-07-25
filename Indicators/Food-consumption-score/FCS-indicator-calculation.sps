*** --------------------------------------------------------------------------

***	                        WFP APP Standardized Scripts
***                     Calculating Food Consumption Score (FCS)

*** --------------------------------------------------------------------------

* Encoding: UTF-8.

*** Define labels

Variable labels
FCSStap  'Consumption over the past 7 days: cereals, grains and tubers'
FCSPulse 'Consumption over the past 7 days: pulses'
FCSDairy 'Consumption over the past 7 days: dairy products'
FCSPr    'Consumption over the past 7 days: meat, fish and eggs'
FCSVeg   'Consumption over the past 7 days: vegetables and leaves'
FCSFruit 'Consumption over the past 7 days: fruit'
FCSFat   'Consumption over the past 7 days: fat and oil'
FCSSugar 'Consumption over the past 7 days: sugar or sweets'
FCSCond  'Consumption over the past 7 days: condiments or spices'.

*** Calculate FCS 
Compute FCS = sum(FCSStap*2, FCSPulse*3, FCSDairy*4, FCSPr*4, FCSVeg*1, FCSFruit*1, FCSFat*0.5, FCSSugar*0.5).
Variable labels FCS "Food Consumption Score".
EXECUTE.

*** Use this when analyzing a country with low consumption of sugar and oil - thresholds 21-35

Recode FCS (lowest thru 21 = 1) (21.5 thru 35 = 2) (35.5 thru highest = 3) into FCSCat21.
Variable labels FCSCat21 "FCS Categories: 21/35 thresholds".
EXECUTE.

*** Define value labels and properties for "FCS Categories".

Value labels FCSCat21 1.00 "Poor" 2.00 "Borderline" 3.00 "Acceptable".
EXECUTE.

*** Important note: pay attention to the threshold used by your CO when selecting the syntax (21 cat. vs 28 cat.)
*** Use this when analyzing a country with high consumption of sugar and oil – thresholds 28-42

Recode FCS (lowest thru 28 = 1) (28.5 thru 42 = 2) (42.5 thru highest = 3) into FCSCat28.
Variable labels FCSCat28 "FCS Categories: 28/42 thresholds".
EXECUTE.

*** Define value labels and properties for "FCS Categories"

Value labels FCSCat28 1.00 "Poor" 2.00 "Borderline" 3.00 "Acceptable".
EXECUTE.

*** End of scripts