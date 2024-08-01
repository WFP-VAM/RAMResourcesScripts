*------------------------------------------------------------------------------
*                          WFP Standardized Scripts
*    Engagement in Income Generation Activities (EIG) Calculation
*------------------------------------------------------------------------------

* This script calculates the Engagement in Income Generation Activities (EIG)
* using standard variable names and sample data.
* Detailed guidelines can be found in the WFP documentation.

* Import static sample data
import delim using "../../Static/EIG_Sample_Survey.csv", clear case(preserve) bindquotes(strict) varn(1)

* Rearrange variable names and codes to ensure consistency in the dataset
* In particular, variables within repeats are imported with progressive integer names (v1-v2-v3...) as they would be all assigned the same name otherwise
* The loop below names variables as [Variablename]+[_number of option]+[_number of repetition]

qui su RepeatPAsstEIG_count
loc RepeatNum = `r(max)'

local num1 = 1
foreach var of varlist v* {
    local `var'_lab : variable label `var'
    loc `var'_lab = subinstr(`"``var'_lab'"', "/", "", .)
    di `"``var'_lab'"'
    cap rename `var' ``var'_lab'
    if _rc == 110 {
        cap rename ``var'_lab' ``var'_lab'_1
        cap rename `var' ``var'_lab'_`num1'
        if _rc == 110 {
            local num1 = `num1' + 1
            cap rename `var' ``var'_lab'_`num1'
        }
    }
}

assert `num1' == `RepeatNum' // check if all household members have been accounted in the loop

qui foreach var of varlist * {
    cap destring `var', replace i("n/a") // destring variables that have "n/a", which will be replaced with "." (as per Stata convention)
}

* Repeat for the number of HH members participating
forval i = 1(1)`RepeatNum' {
    local PTrainingPart
    * Loop is set to account for up to 9 training types, with 0 as no training
    forval j = 1(1)9 {
        cap confirm var PTrainingTypes`j'_`i'
        if _rc == 0 {
            local PTrainingPart `PTrainingPart' PTrainingTypes`j'_`i'
        }
    }
    
    egen PostTrainingEngagement_`i' = rowmax(PPostTrainingEmpl_`i' PPostTrainingIncome_`i') // if individual was either employed or started a self-employment
    local PostTrainingEngagement `PostTrainingEngagement' PostTrainingEngagement_`i' 
    
    egen PTrainingPart_`i' = rowmax(`PTrainingPart') // if individual participated at least a training activity in the list
    local PTrainingPartNb `PTrainingPartNb' PTrainingPart_`i'
}

* Variables (counts and shares) are still at household level
egen PostTrainingEngagement = rowtotal(`PostTrainingEngagement')
label var PostTrainingEngagement "Number of training participants engaging in income generating activities (self-employed or salaried)"
egen PTrainingPartNb = rowtotal(`PTrainingPartNb')
label var PTrainingPartNb "Number of training participants"

gen EIG = PostTrainingEngagement / PTrainingPartNb
label var EIG "Share of training participants who were able to engage in income generating activities post-training"
cap drop `PTrainingPartNb' `PostTrainingEngagement'

* Example of summary statistic for full sample, more analysis code is provided in the dedicated repository
sum EIG

* End of Scripts