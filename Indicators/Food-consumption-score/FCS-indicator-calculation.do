***Create Food Consumption Score and food consumption groups using standard variables names 
import delim using "../../Static/FCS_Sample_Survey.csv", clear case(preserve) bindquotes(strict) varn(1)
qui foreach var of varlist * {
	cap destring `var', replace i("n/a")
}
***Food Consumption Score***
*(in case you used the deprecated split between staples, run also the line below)

capture confirm variable FCSStap
if !_rc {

}
else {
egen FCSStap=rowmax(FCSStapCer FCSStapRoo)
}
*
label var FCSStap          "Consumption over the past 7 days (cereals and tubers)"
label var FCSVeg           "Consumption over the past 7 days (vegetables)"
label var FCSFruit         "Consumption over the past 7 days (fruit)"
label var FCSPr            "Consumption over the past 7 days (protein-rich foods)"
label var FCSPulse         "Consumption over the past 7 days (pulses)"
label var FCSDairy         "Consumption over the past 7 days (dairy products)"
label var FCSFat           "Consumption over the past 7 days (oil)"
label var FCSSugar         "Consumption over the past 7 days (sugar)"

recode FCSStap FCSVeg FCSFruit FCSPr FCSPulse FCSDairy FCSFat FCSSugar (.=0)

capture confirm variable FCS 
if !_rc {
cap rename FCS old_FCS
}
gen FCS= FCSStap*2+FCSVeg+FCSFruit+FCSPr*4+FCSPulse*3+FCSDairy*4+FCSFat*0.5+FCSSugar*0.5
label var FCS "Food Consumption Score"

*** Use this when analyzing a country with high consumption of sugar and oil – thresholds 28-42

gen FCSCat28=cond(FCS<28,1,cond(FCS<42,2,3))
label var FCSCat28 "FCS Categories, thresholds 28-42"

***Use this when analyzing a country with low consumption of sugar and oil - thresholds 21-35

gen FCSCat21=cond(FCS<21,1,cond(FCS<35,2,3))
label var FCSCat21 "FCS Categories, thresholds 21-35"

*** define variables labels and properties for "FCS Categories".

label define FCSCat 1 "poor" 2 "borderline" 3 "acceptable"
label values FCSCat21 FCSCat
label values FCSCat28 FCSCat