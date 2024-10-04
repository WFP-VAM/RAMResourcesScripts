*------------------------------------------------------------------------------#
*	                    WFP Standardized Scripts
*                      Cleaning Expenditures Module
*------------------------------------------------------------------------------#
/*
Note:
This script is based on WFP's standard expenditure module in Survey Desginer.
If you are using a different module or if the module was partially edited 
(e.g. some expenditure variables added or removed), the List of variables needs to be edited accordingly.
Important: The script assumes that a single currency is used. 
If multiple currencies are used, convert to a single currency before running the script.
*/					

#------------------------------------------------------------------------------*
#                  Import data (Adjust the path as needed)
# ------------------------------------------------------------------------------*
import delimited "E:/LogicalCleaning/Expcleaning_Sample_Raw.csv", clear

#------------------------------------------------------------------------------*
#                1. Listing Variables in the Expenditure Module
# ------------------------------------------------------------------------------*
	
* list of variables in food expenditure module (edit if needed)
global F_expvars HHExpFCer_Purch_MN_`rec' HHExpFCer_GiftAid_MN_`rec' HHExpFCer_Own_MN_`rec' HHExpFTub_Purch_MN_`rec' HHExpFTub_GiftAid_MN_`rec' HHExpFTub_Own_MN_`rec' HHExpFPuls_Purch_MN_`rec' HHExpFPuls_GiftAid_MN_`rec' HHExpFPuls_Own_MN_`rec' HHExpFVeg_Purch_MN_`rec' HHExpFVeg_GiftAid_MN_`rec' HHExpFVeg_Own_MN_`rec' HHExpFFrt_Purch_MN_`rec' HHExpFFrt_GiftAid_MN_`rec' HHExpFFrt_Own_MN_`rec' HHExpFAnimMeat_Purch_MN_`rec' HHExpFAnimMeat_GiftAid_MN_`rec' HHExpFAnimMeat_Own_MN_`rec' HHExpFAnimFish_Purch_MN_`rec' HHExpFAnimFish_GiftAid_MN_`rec' HHExpFAnimFish_Own_MN_`rec' HHExpFFats_Purch_MN_`rec' HHExpFFats_GiftAid_MN_`rec' HHExpFFats_Own_MN_`rec' HHExpFDairy_Purch_MN_`rec' HHExpFDairy_GiftAid_MN_`rec' HHExpFDairy_Own_MN_`rec' HHExpFEgg_Purch_MN_`rec' HHExpFEgg_GiftAid_MN_`rec' HHExpFEgg_Own_MN_`rec' HHExpFSgr_Purch_MN_`rec' HHExpFSgr_GiftAid_MN_`rec' HHExpFSgr_Own_MN_`rec' HHExpFCond_Purch_MN_`rec' HHExpFCond_GiftAid_MN_`rec' HHExpFCond_Own_MN_`rec' HHExpFBev_Purch_MN_`rec' HHExpFBev_GiftAid_MN_`rec' HHExpFBev_Own_MN_`rec' HHExpFOut_Purch_MN_`rec' HHExpFOut_GiftAid_MN_`rec' HHExpFOut_Own_MN_`rec'

* list of variables in non-food module with 30 days recall (edit if needed)
global NF_1M_expvars HHExpNFHyg_Purch_MN_1M HHExpNFHyg_GiftAid_MN_1M HHExpNFTransp_Purch_MN_1M HHExpNFTransp_GiftAid_MN_1M HHExpNFFuel_Purch_MN_1M HHExpNFFuel_GiftAid_MN_1M HHExpNFWat_Purch_MN_1M HHExpNFWat_GiftAid_MN_1M HHExpNFElec_Purch_MN_1M HHExpNFElec_GiftAid_MN_1M HHExpNFEnerg_Purch_MN_1M HHExpNFEnerg_GiftAid_MN_1M HHExpNFDwelSer_Purch_MN_1M HHExpNFDwelSer_GiftAid_MN_1M HHExpNFPhone_Purch_MN_1M HHExpNFPhone_GiftAid_MN_1M HHExpNFRecr_Purch_MN_1M HHExpNFRecr_GiftAid_MN_1M HHExpNFAlcTobac_Purch_MN_1M HHExpNFAlcTobac_GiftAid_MN_1M 

* list of variables in non-food module with 6 months recall (edit if needed)
global NF_6M_expvars HHExpNFMedServ_Purch_MN_6M HHExpNFMedServ_GiftAid_MN_6M HHExpNFMedGood_Purch_MN_6M HHExpNFMedGood_GiftAid_MN_6M HHExpNFCloth_Purch_MN_6M HHExpNFCloth_GiftAid_MN_6M HHExpNFEduFee_Purch_MN_6M HHExpNFEduFee_GiftAid_MN_6M HHExpNFEduGood_Purch_MN_6M HHExpNFEduGood_GiftAid_MN_6M HHExpNFRent_Purch_MN_6M HHExpNFRent_GiftAid_MN_6M HHExpNFHHSoft_Purch_MN_6M HHExpNFHHSoft_GiftAid_MN_6M HHExpNFHHMaint_Purch_MN_6M HHExpNFHHMaint_GiftAid_MN_6M

* list of all expenditure variables
global all_expvars $F_expvars $NF_1M_expvars $NF_6M_expvars

#------------------------------------------------------------------------------*
#                2. Checking if all necessary columns are present
#------------------------------------------------------------------------------*

// Define the `check_columns_exist` program to check if variables are present in the dataset
program define check_columns_exist
    args columns
    local missing_columns

    // Loop through each column and check its existence
    foreach col in `columns' {
        capture confirm variable `col'
        if _rc { // If the variable does not exist, add it to the missing list
            local missing_columns `missing_columns' `col'
        }
    }

    // If any variables are missing, display an error message and stop execution
    if "`missing_columns'" != "" {
        di as error "The following variables are missing from the dataset: `missing_columns'"
        exit 198
    }
    else {
        di as result "All specified variables are present in the dataset."
    }
end

// Call the program to check if all expenditure variables exist in the dataset
check_columns_exist "$all_expvars"

*------------------------------------------------------------------------------*
*  Preliminary checks regarding the usability of the expenditure data
*------------------------------------------------------------------------------*

*------------------------------------------------------------------------------*
*                  Aggregating Food and Non-Food Expenditures
*------------------------------------------------------------------------------*

// Aggregate Food Expenditure
egen temp_HHExpF_1M = rowtotal($F_expvars)
if "`rec'" == "7D" replace temp_HHExpF_1M = temp_HHExpF_1M * 30 / 7  // Convert to monthly if recall is 7 days

// Aggregate Non-Food Expenditure with 1-Month Recall
egen temp_HHExpNF_30D = rowtotal($NF_1M_expvars)

// Aggregate Non-Food Expenditure with 6-Month Recall
egen temp_HHExpNF_6M = rowtotal($NF_6M_expvars)
replace temp_HHExpNF_6M = temp_HHExpNF_6M / 6  // Convert to monthly terms

// Total Non-Food Expenditure (Monthly)
egen temp_HHExpNF_1M = rowtotal(temp_HHExpNF_30D temp_HHExpNF_6M)

// Drop temporary non-food variables
drop temp_HHExpNF_30D temp_HHExpNF_6M

// Save aggregate names into a local macro
local temp_aggregates temp_HHExpF_1M temp_HHExpNF_1M

// Display final aggregates
di as result "Food Expenditure Aggregate: temp_HHExpF_1M"
di as result "Non-Food Expenditure Aggregate: temp_HHExpNF_1M"

*------------------------------------------------------------------------------*
*  Computing share of observations with zero food or non-food expenditures
*------------------------------------------------------------------------------*

// Define dummy variables to report zero expenditures
gen zero_F = (temp_HHExpF_1M == 0)
label var zero_F "Zero total food expenditures"

gen zero_NF = (temp_HHExpNF_1M == 0)
label var zero_NF "Zero total non-food expenditures"

gen zero_Total = (temp_HHExpF_1M == 0) & (temp_HHExpNF_1M == 0)
label var zero_Total "Zero total expenditures"

// Produce and export tables for the whole sample
preserve
collapse (mean) zero_F zero_NF zero_Total
export excel "${OUT}/Tables/1.Preliminary_Check/Preliminary_check.xlsx", sheet("Whole_sample") first(var) keepcellfmt replace
restore

// Produce and export tables at different admin levels
forvalues i = 1/4 {
    // Check if the admin level is defined
    count if missing(ADMIN`i'Name)
    if r(N) != _N { // If not all observations are missing
        preserve
        collapse (mean) zero_F zero_NF zero_Total, by(ADMIN`i'Name)
        export excel "${OUT}/Tables/1.Preliminary_Check/Preliminary_check.xlsx", sheet("ADMIN`i'") first(var) keepcellfmt replace
        restore
    }
    else {
        di as info "ADMIN`i'Name not defined - no results produced at this admin level"
    }
}

// Drop temporary variables
drop zero_F zero_NF zero_Total

*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*
*  Stage 1: cleaning variable by variable, manual
*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*

* A: Producing reports --------------------------------------------------------*
/*
*** Optional: Create and export a box plot for each variable
*** Uncomment this section if you need box plots for visual inspection
foreach var in $all_expvars {
    graph box `var', mark(1, mlab(HHID)) nolabel
    graph export "${OUT}/Graphs/2.Manual_Stage/boxplot_`var'.pdf", replace // Ensure the "Graphs" folder exists
}
*/

*** Show the bottom and top 5 observations and save them to an excel file

* Initialize a matrix to store bottom and top 5 values for each variable
local max_vars = min(100, wordcount("$all_expvars")) // Limit to 100 variables or fewer
mat minmax = J(11, `max_vars', .)

local h = 1

foreach var in $all_expvars {
    preserve
    drop if missing(`var') // Drop missing values temporarily

    count
    local N = r(N)
    if `N' >= 10 { // If there are at least 10 observations
        sort `var'
        // Save bottom 5 values
        forvalues i = 1/5 {
            mat minmax[`i', `h'] = `var'[`i']
        }
        // Save top 5 values
        forvalues i = 0/4 {
            mat minmax[`6+`i', `h'] = `var'[_N-`i']
        }
    } 
    else if `N' > 0 { // If fewer than 10 but more than 0 observations
        sort `var'
        local x = ceil(`N'/2) // Number of values to report on each side

        // Save the first `x' values as bottom
        forvalues i = 1/`x' {
            mat minmax[`i', `h'] = `var'[`i']
        }
        // Save the last `x' values as top
        forvalues i = 0/(`x'-1) {
            mat minmax[`6+`i', `h'] = `var'[_N-`i']
        }
    }

    restore
    local h = `h' + 1
    if `h' > `max_vars' {
        break
    }
}

* Assign column names and row names to the matrix
mat colnames minmax = $all_expvars
mat rownames minmax = "bottom1" "bottom2" "bottom3" "bottom4" "bottom5" " " "top5" "top4" "top3" "top2" "top1"

* Export the matrix to an Excel file
putexcel set "${OUT}/Tables/2.Manual_Stage/MinMax.xlsx", replace
putexcel A2 = matrix(minmax), names nfor(0.00)

* B: Manual corrections -------------------------------------------------------*
*** Based on the outputs generated above, correct values that are obvious mistakes, 
*** whose true value can be logically deduced. Correct them by adding syntax here 
*** and explaining the corrections.

/// ENTER HERE MANUAL CORRECTIONS /// 

*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*
*  Stage 2: Cleaning variable by variable, statistical/automatic
*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*

* A. Identify outliers --------------------------------------------------------*

// Set negative values as missing
foreach var in $all_expvars {
    replace `var' = . if `var' < 0
}

// Express all variables into per capita terms
foreach var in $all_expvars {
    gen pc_`var' = `var' / HHSize
}

// Apply inverse hyperbolic sine (IHS) transformation to approximate normality
foreach var in $all_expvars {
    gen tpc`var' = log(pc_`var' + sqrt(pc_`var'^2 + 1))
}

// Standardize using Median Absolute Deviation (MAD)
foreach var in $all_expvars {
    qui sum tpc`var', detail // calculate summary statistics
    if `r(N)' > 0 { // if variable has observations
        local median = `r(p50)'
        gen p50`var' = `median' // save median value

        gen d`var' = abs(tpc`var' - `median') // absolute deviation from median
        qui sum d`var', detail
        gen MAD`var' = 1.4826 * `r(p50)' // calculate and store MAD

        // Standardize the variable
        gen z`var' = (tpc`var' - `median') / MAD`var' if MAD`var' != 0
    }
    else {
        gen z`var' = . // no observations, keep as missing
    }

    // Drop temporary variables
    drop tpc`var' p50`var' d`var' MAD`var'
}

// Identify outliers based on 3 MADs from the median
label define outliers 0 "no out" 1 "bottom out" 2 "top out"
foreach var in $all_expvars {
    gen o_`var' = 0 if !missing(z`var') // initialize outlier indicator
    replace o_`var' = 2 if z`var' > 3 & !missing(z`var') // top outliers
    replace o_`var' = 1 if z`var' < -3 & !missing(z`var') // bottom outliers
    label val o_`var' outliers
    drop z`var' // drop standardized variable after tagging outliers
}

* B. Treat outliers (median imputation) ---------------------------------------*

// Compute median values for different admin levels
foreach var in $all_expvars {
    forvalues i = 0/4 { 
        replace pc_`var' = . if inrange(o_`var', 1, 2) // set outliers to missing
        egen n`i'`var' = count(pc_`var') if !missing(ADMIN`i'Name), by(ADMIN`i'Name)  // count valid observations at each admin level
        egen m`i'`var' = median(pc_`var'), by(ADMIN`i'Name) // calculate median
    }
}

// Replace outliers with median based on number of observations at each admin level
foreach var in $all_expvars {
    replace pc_`var' = m0`var' if inrange(o_`var', 1, 2) // default national level
    replace pc_`var' = m1`var' if inrange(o_`var', 1, 2) & n1`var' > 150 // admin 1 if more than 150 obs
    replace pc_`var' = m2`var' if inrange(o_`var', 1, 2) & n2`var' > 50 // admin 2 if more than 50 obs
    replace pc_`var' = m3`var' if inrange(o_`var', 1, 2) & n3`var' > 15 // admin 3 if more than 15 obs
    replace pc_`var' = m4`var' if inrange(o_`var', 1, 2) & n4`var' > 5 // admin 4 if more than 5 obs
}

// Drop all temporary variables
foreach var in $all_expvars {
    drop n*`var' m*`var'
}

*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*
*  Stage 3: Cleaning Aggregates, Statistical/Automatic
*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*

*------------------------------------------------------------------------------*
*  Step 2.1: Compute Aggregates
*------------------------------------------------------------------------------*
* Note: Aggregates are computed in per capita (pc) monthly terms, based on variables cleaned in the previous stage.

*** Compute Food Aggregate ***
local PC_F_expvars
foreach var of varlist $F_expvars {
    local PC_F_expvars `PC_F_expvars' pc_`var'
}

egen HHExpF_1M = rowtotal(`PC_F_expvars')
if "`rec'" == "7D" {
    replace HHExpF_1M = HHExpF_1M * 30 / 7 // Convert to monthly terms if recall period is 7 days
}

*** Compute Non-Food Aggregate ***
local PC_NF_1M_expvars
foreach var of varlist $NF_1M_expvars {
    local PC_NF_1M_expvars `PC_NF_1M_expvars' pc_`var'
}
egen temp_HHExpNF_30D = rowtotal(`PC_NF_1M_expvars') // 1-month recall

local PC_NF_6M_expvars
foreach var of varlist $NF_6M_expvars {
    local PC_NF_6M_expvars `PC_NF_6M_expvars' pc_`var'
}
egen temp_HHExpNF_6M = rowtotal(`PC_NF_6M_expvars') // 6-month recall
replace temp_HHExpNF_6M = temp_HHExpNF_6M / 6 // Convert to monthly terms for 6-month recall

egen HHExpNF_1M = rowtotal(temp_HHExpNF_30D temp_HHExpNF_6M) // Total non-food aggregate
drop temp_HHExpNF_30D temp_HHExpNF_6M // Drop temporary variables

*** Save aggregate names into a global ***
global aggregates HHExpF_1M HHExpNF_1M

*------------------------------------------------------------------------------*
*  Step 2.2: Clean Aggregates
*------------------------------------------------------------------------------*

* A. Identify Observations with Zero Expenditures -----------------------------------
foreach var in $aggregates {
    gen o_`var' = 0 if `var' != . // Create outlier tag variable
    replace o_`var' = 1 if `var' == 0 // Identify as bottom outlier if zero
}

* B. Identify Outliers ----------------------------------------------------------

*** Apply Inverse Hyperbolic Sine (IHS) Transformation ***
foreach var in $aggregates {
    gen tpc`var' = log(`var' + sqrt(`var'^2 + 1))
}

*** Standardize using Median Absolute Deviation (MAD) ***
foreach var in $aggregates {
    qui sum tpc`var', detail // Calculate summary statistics

    if `r(N)' > 0 { // If there are observations
        local median = `r(p50)'
        gen p50`var' = `median' // Save median

        gen d`var' = abs(tpc`var' - `median') // Absolute deviation from median
        qui sum d`var', detail
        gen MAD`var' = 1.4826 * `r(p50)' // Calculate MAD

        // Standardize the variable
        gen z`var' = (tpc`var' - `median') / MAD`var' if MAD`var' != 0
    }
    else {
        gen z`var' = . // No observations, keep missing
    }

    // Drop temporary variables
    drop tpc`var' p50`var' d`var' MAD`var'
}

*** Identify Outliers Based on 3 MADs from the Median ***
foreach var in $aggregates {
    replace o_`var' = 2 if z`var' > 3 & !missing(z`var') // Top outliers
    replace o_`var' = 1 if z`var' < -3 & !missing(z`var') // Bottom outliers
    label val o_`var' outliers
    drop z`var' // Drop standardized variable after tagging outliers
}

* C. Treat Outliers (Median Imputation) ----------------------------------------

*** Compute Number of Valid Observations and Median at Different Admin Levels ***
foreach var in $aggregates {
    forvalues i = 0/4 { 
        replace `var' = . if inrange(o_`var', 1, 2) // Set outliers to missing
        egen n`i'`var' = count(`var') if !missing(ADMIN`i'Name), by(ADMIN`i'Name) // Count valid obs
        egen m`i'`var' = median(`var'), by(ADMIN`i'Name) // Calculate median
    }
}

*** Replace Outliers with Median Based on Number of Observations ***
foreach var in $aggregates {
    replace `var' = m0`var' if inrange(o_`var', 1, 2) // Default national level
    replace `var' = m1`var' if inrange(o_`var', 1, 2) & n1`var' > 150 // Admin 1
    replace `var' = m2`var' if inrange(o_`var', 1, 2) & n2`var' > 50 // Admin 2
    replace `var' = m3`var' if inrange(o_`var', 1, 2) & n3`var' > 15 // Admin 3
    replace `var' = m4`var' if inrange(o_`var', 1, 2) & n4`var' > 5 // Admin 4
}

// Drop temporary variables
foreach var in $aggregates {
    drop n*`var' m*`var'
}

* D. Reconcile Single Expenditure Variables with Modified Aggregates ----------

*** Estimate Average Consumption Share of Each Food Variable and Match with Corrected Aggregate ***
local PC_F_expvars
foreach var of varlist $F_expvars {
    local PC_F_expvars `PC_F_expvars' pc_`var'
}
egen temp_F = rowtotal(`PC_F_expvars') // Recalculate food aggregate

foreach var in $F_expvars {
    gen s`var' = pc_`var' / temp_F if o_HHExpF_1M != 1 & o_HHExpF_1M != 2 // Share for non-outliers
    replace s`var' = 0 if missing(s`var') & (o_HHExpF_1M != 1 & o_HHExpF_1M != 2)
    egen as`var' = mean(s`var') // Compute mean share
    replace pc_`var' = HHExpF_1M * as`var' if inrange(o_HHExpF_1M, 1, 2) // Replace value for outliers
}

*** Estimate Average Consumption Share of Each Non-Food Variable ***
foreach var in $NF_6M_expvars {
    replace pc_`var' = pc_`var' / 6 // Temporarily express 6M recall in monthly terms
}
foreach var in $NF_1M_expvars $NF_6M_expvars {
    gen s`var' = pc_`var' / HHExpNF_1M if o_HHExpNF_1M != 1 & o_HHExpNF_1M != 2 // Share for non-outliers
    replace s`var' = 0 if missing(s`var') & (o_HHExpNF_1M != 1 & o_HHExpNF_1M != 2)
    egen as`var' = mean(s`var') // Compute mean share
    replace pc_`var' = HHExpNF_1M * as`var' if inrange(o_HHExpNF_1M, 1, 2) // Replace value for outliers
}
foreach var in $NF_6M_expvars {
    replace pc_`var' = pc_`var' * 6 // Re-express in 6M period
}

// Drop temporary variables
foreach var in $all_expvars {
    drop s`var' as`var'
}
drop HHExpF_1M HHExpNF_1M temp_F

*------------------------------------------------------------------------------*
* Re-transform single exp variables from per capita to household
*------------------------------------------------------------------------------*
foreach var in $all_expvars {
	replace `var'= pc_`var'*HHSize
	}
