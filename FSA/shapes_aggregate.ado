cap program drop shapes_aggregate
program shapes_aggregate, rclass
	version 16.0
	display "Aggregating output"
	
	syntax [if] [in] [, grouping(varlist) mean(varlist) median(varlist)]
	marksample touse
	
	di `"`grouping'"'
	di `"`mean'"'
	di `"`median'"'
	
	cap confirm variable WeightHH
	if _rc==0 {
		assert WeightHH!=.
	}
	else {
		cap confirm variable HHWeight
		if _rc==0 {
			assert HHWeight!=.
			gen WeightHH=HHWeight
			drop HHWeight
		}
		else {
			gen WeightHH=1
		}
	}
	
**** Check consistency of grouping: at least 30 obs, encoded variables
	local gplist
	foreach v of varlist `grouping' {
		capture confirm numeric variable `v'
		if _rc==0 {
			count if `v'!=.	
		}
		else {
			count if `v'!=""
		}

		if r(N) < 30 {
			continue
			noi di in red "`v' has less than 30 observations, insufficient for grouping" 
			local discarded_groups `discarded_groups' `v'
		}
		else {
			local gplist `gplist' `v'
			di `v'
		}
	}

	foreach var of varlist `gplist' {
		capture confirm numeric variable `var'
		if _rc==0 {	
			di "`var' - labelfinder"
			labelfinder `var'
			local lbl_`var': value label `var'
			di "`r(var_value_label)'"
			*local lbl_`var': `r(value_label_`varname')'
			di "`lbl_`var'' - lbl_`var'"
			label list `lbl_`var''
		}
		else {
			noi di in red "`var' is not numeric (encoded)"
			exit()
		}
	}
********************************************************************************
*** Initiate group list
********************************************************************************
	
	local i = 1
	foreach v in `gplist' {
	di "`v'"
	* no of count by group
	qui tabstat `v', by(`v') stat(n) nototal save
	qui tabstatmat n_`i'
	qui mat rownames n_`i' = `v'
	* key values for by groups
	qui tabstat `v', by(`v') stat(mean) nototal save
	qui tabstatmat gpvar_key_`i'
	* mean matrix by group
	qui tabstat WeightHH, by(`v') stat(sum) nototal save
	qui tabstatmat p_pop`i'
	qui tabstat `mean' [aweight=WeightHH], by(`v') stat(mean) nototal save
	qui tabstatmat M_`i'
	qui tabstat `median' [aweight=WeightHH], by(`v') stat(p50) nototal save
	qui tabstatmat p_`i'
	* merge count and mean
	qui mat output`i'= (n_`i',gpvar_key_`i',p_pop`i', M_`i', p_`i')
	local i = `i'+1
	}

	local i = `i'-1		 // get no. of grouping
	local coln no_of_count gp_var_key p_population `mean' `median' // prepare header lable 
	scalar r = colsof(output1) 	 // get no. of columns of the profile table 
	mat blkrow = J(1,r,.)	 // prepare blank row	

	* merge all groupings into one big matrix
	local output blkrow
	foreach n of numlist 1/`i' {
		local output `output' \ output`n'
	}
	mat output_all =`output'

	matlist output_all
	
	* column name of the big matrix
	mat colnames output_all = `coln'
	cap mat drop  	IDAP_Output
	mat rename 		output_all IDAP_Output

	* export profile table to dataset 
	*net install dm79.pkg
	drop * 
	svmat2 IDAP_Output, rname(grouping)

	order grouping, first
	drop if (grouping == "r1") 	//delete the 1st blank row
	di "`coln'"

	rename ( * ) (grouping `coln')
	gen var_labels_consolidated=""

	recode `mean' (.=0)

	** export grouping variable value labels into var_labels_consolidated
	
	foreach var of local gplist {
		gen temp_var0 = gp_var_key if grouping=="`var'"
		cap label values temp_var0 `lbl_`var''
		cap decode temp_var0, gen(temp_var)
		cap replace var_labels_consolidated=temp_var if grouping=="`var'"
		cap drop temp_var0 temp_var
	}
/*
	foreach var of varlist `geoGpList' {
		cap tostring `var', gen(temp_var) force
		cap replace var_labels_consolidated=temp_var if grouping=="`var'"
		cap drop temp_var
	}
*/
	cap replace var_labels_consolidated="National" if grouping=="ADMIN0Code"
	
	

	return local mean_varlist `"`mean'"'
	return local median_varlist `"`median'"'
	return local grouping_varlist `"`gplist'"'
	return local discarded_groups `"`discarded_groups'"'
	
	return local mean_output `"`mean'"'
	*/
end


cap prog drop labelfinder
prog def labelfinder, rclass
    syntax varname
    di "`varlist'"
	local has_label = ("`: value label `varlist''" != "")
	di "`has_label'"
	if `has_label' == 1 {
		di "`varlist' has value labels"
	}
	else {
		cap label drop `varlist'
		levelsof `varlist', local(levels_gp)
		if r(r)>50 {
			exit 
		}
		foreach lvl of local levels_gp {
			di "`lvl'"
			label define `varlist' `lvl' "`lvl'", add
		}
		label values `varlist' `varlist'
	}
	return local var_value_label "`: value label `varlist''"	
end


