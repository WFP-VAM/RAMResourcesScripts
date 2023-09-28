********************************************************************************
 * STATA Syntax for example of gap analysis
 *******************************************************************************
						   
* This syntax file refers to the sample dataset accessible here: XXXXX

* Detailed guidance on conducting a gap analysis can be found here: XXXX

*-------------------------------------------------------------------------------*

*-------------------------------------------------------------------------------*
* Open dataset
*-------------------------------------------------------------------------------*

clear all


use "XXX/Gap_Analysis_Sample" // replace before publishing


*------------------------------------------------------------------------------*
*  Estimate the gap 
*------------------------------------------------------------------------------*

*** Step 1 - Identifying the cost of essential needs
* A MEB is already available in the dataset, expressed in per capita monthly term, and differentiated by groups of household size to account for household economies of scale



*** Step 2 - Computing the household economic capacity 
* The computation of the household economic capacity should follow the methodology used for the ECMEN indicator (version excluding assistance).

	** Sum food expenditures, value of consumed food from own-production, and non-food expenditures
	egen PCExp_ECMEN=rowtotal(PC_HHExp_Food_Purch_MN_1M PC_HHExp_Food_Own_MN_1M PC_HHExpNFTotal_Purch_MN_1M), missing // will be missing if all sub-aggregates are missing
	label var PCExp_ECMEN "Household Economic Capacity per capita - monthly"

	** Deduct the value of cash assistance received from WFP and partner humanitarian organizations
	replace PCExp_ECMEN = PCExp_ECMEN-PC_HHAsstCBTRec_Cons_1M if PC_HHAsstCBTRec_Cons_1M!=.
	replace PCExp_ECMEN=0 if PCExp_ECMEN<0 // set negative values to zero



*** Step 3 - Identifying the gap analysis cohort
* In this example the gap analysis group is made of the households with economic capacity below the MEB and who are moderately or severely food insecure based on CARI

	** create a variable to identify the cohort
	gen Gap_ref = PCExp_ECMEN<MEB & (CARI_ECMEN==3 | CARI_ECMEN==4)
	label var Gap_ref "Gap analysis cohort (below MEB and food insecure)"
	label define  cohort 1 "Part of cohort"  0 "Not part of cohort"
	label val Gap_ref cohort


*** Step 4 - Estimating the gap

	** Compute per capita gap for each household
	gen PCGap= MEB - PCExp_ECMEN if PCExp_ECMEN<MEB // the gap is defined only for hh with economic capacity below the MEB
	label var PCGap"Gap, per capita, monthly"

	** Compute average gap for the gap analysis cohort and save to a variable
	sum PCGap if Gap_ref==1 // compute average
	gen PCGap_avg = `r(mean)' if Gap_ref==1 // store calculated average into a variable (defined only for the cohort)
	label var PCGap_avg  "Average per capita gap (cohort: below MEB and food insecure)"


	** Express the average gap as share of the (average) MEB
	sum MEB if Gap_ref==1 // calculate the average MEB for the reference cohort (reminder: in this example the MEB is differentiated by groups of household size - if this is not the case this passage is not needed)
	gen PCGap_share_MEB = PCGap_avg/`r(mean)' if Gap_ref==1 // use the average MEB calculated in the previous line. Note: this variable is defined only for the cohort
	label var PCGap_share_MEB "Gap/MEB per capita (cohort: below MEB and food insecure)"

*------------------------------------------------------------------------------*
*  Estimate the gap by household size
*------------------------------------------------------------------------------*

* In this dataset different MEB values are provided for 4 categories of household size, to take into account household economies of scale: small (1-3), medium(4-6), large(7-9), extra-large (10+). Accordingly, different gaps will be estimated

	** Create a variable representing the different categories of household size
	recode hhsize (1/3=1) (4/6=2) (7/9=3) (nonmissing=4), gen(hhsize_cat)
	label var hhsize_cat "Classes of household size"
	label define hhsize 1 "Small" 2"Medium" 3"Large" 4"Extra large"
	label val hhsize_cat hhsize
	order hhsize_cat, after(hhsize)

	** Create a variable taking the average gap value for each household size category
	gen PCGap_avg_hhcat = .
	label var PCGap_avg_hhcat "Average per capita gap per hh size (cohort: below MEB and food insecure)"

	** Compute the average gap for household size cat and save into the variable created before
	forvalues i = 1/4 { // we will loop through the four household size categories
	sum  PCGap if Gap_ref==1  & hhsize_cat==`i' // compute average for hh size cat within the gap analysis cohort
	replace PCGap_avg_hhcat = `r(mean)' if Gap_ref==1 & hhsize_cat==`i' // store average into variable
	}

	** Display the different gaps by hh size
	graph bar (mean) PCGap_avg_hhcat, over(hhsize_cat) title(Gapby household size groups) blabel(bar)


*------------------------------------------------------------------------------*
*  Compare the gap with and without assistance
*------------------------------------------------------------------------------*
* See Box 3 in the guidance note

* The gap without assistance has already been computed in the previous section. Now the objective is repeating the procedure but using a version of the household economic capacity "including assistance"

*** Step 1 - Identifying the cost of essential needs
* Same as in previous section



*** Step 2 - Computing the household economic capacity 
* The computation of the household economic capacity should follow the methodology used for the ECMEN indicator (version including assistance).

	** Sum food expenditures, value of food consumed from in-kind assistance and gifts, value of consumed food from own-production, non-food expenditures, and the value of non-food from in-kind assistance and gifts.
	egen PCExp_ECMEN_inclAsst=rowtotal( PC_HHExp_Food_Purch_MN_1M PC_HHExp_Food_GiftAid_MN_1M PC_HHExp_Food_Own_MN_1M PC_HHExpNFTotal_Purch_MN_1M PC_HHExpNFTotal_GiftAid_MN_1M)
	label var PCExp_ECMEN_inclAsst "Household Economic Capacity per capita - incl assistance - monthly"

	* Note that in this time the value of received cash assistance should not be deducted



*** Step 3 - Identifying the gap analysis cohort
* In this example the gap analysis group is made of the households with economic capacity below the MEB and who are moderately or severely food insecure based on CARI

	** create a variable to identify the cohort
	gen Gap_ref_inclAsst = PCExp_ECMEN_inclAsst<MEB & (CARI_ECMEN==3 | CARI_ECMEN==4)
	label var Gap_ref_inclAsst "Gap analysis cohort (below MEB and food insecure) - incl assistance"
	label val Gap_ref_inclAsst cohort


*** Step 4 - Estimating the gap

	** Compute per capita gap for each household
	gen PCGap_inclAsst = MEB - PCExp_ECMEN_inclAsst if PCExp_ECMEN_inclAsst<MEB // the gap is defined only for hh with economic capacity below the MEB
	label var PCGap_inclAsst "Gap, per capita, monthly - incl assistance"

	** Compute average gap for the gap analysis cohort and save to a variable
	sum PCGap_inclAsst if Gap_ref_inclAsst==1 // compute average
	gen PCGap_avg_inclAsst = `r(mean)' if Gap_ref_inclAsst==1 // store calculated average into a variable (defined only for the cohort)
	label var PCGap_avg_inclAsst  "Average gap - incl assistance (cohort: below MEB and food insecure)"
	
	
	** Express the average gap as share of the (average) MEB
	sum MEB if Gap_ref_inclAsst==1 // calculate the average MEB for the reference cohort (reminder: in this example the MEB is differentiated by groups of household size - if this is not the case this passage is not needed)
	gen PCGap_share_MEB_inclAsst = PCGap_avg_inclAsst/`r(mean)' if Gap_ref_inclAsst==1 // use the average MEB calculated in the previous line. Note: this variable is defined only for the cohort
	label var PCGap_share_MEB_inclAsst "Gap/MEB per capita - incl assist (cohort: below MEB and food insecure)"	
	

	*** Compare the gaps (expressed as percentage of the MEB) without and with assistance
	graph bar (mean) PCGap_share_MEB PCGap_share_MEB_inclAsst, legend(label(1 "without assistance")) legend(label(2 "with assistance")) title(Gap as percentage of the MEB) blabel(bar) // the difference is very small, because in this dataset the population does not receive much assistance


*------------------------------------------------------------------------------*
*  Estimate the food gap
*------------------------------------------------------------------------------*
* Repeat the 4 standard steps of the gap analysis procedure

*** Step 1 - Identifying the cost of food needs
* A food MEB is already available in the dataset. This should be used as cost of food needs



*** Step 2 - Computing the household economic capacity used for food

	** Sum food expenditures and the value of consumed food from own-production
	egen PCExpF_ECMEN=rowtotal(PC_HHExp_Food_Purch_MN_1M PC_HHExp_Food_Own_MN_1M)
	label var PCExpF_ECMEN "Household Economic Capacity - food - per capita, monthly"

	** Deduct the value of cash assistance received from WFP and partner humanitarian organizations, that is likely spent on food

	* In this case, the part of received cash assistance spent on food can be be approximated using the Food Expenditure Share of the gap analysis cohort. The Food Expenditure Share is already provided in the dataset
	sum FES if  Gap_ref==1 // calculate average FES for the gap analysis cohort - we still use the old reference cohort (for the general gap) as that for the food gap is defined at the next step.
	gen  PC_HHAsstCBTRec_ConsF_1M =  PC_HHAsstCBTRec_Cons_1M*`r(mean)' // obtain the part of consumed cash assistance spent on food by multiplying  consumed received cash assistance by the average FES of the cohort.
	label var PC_HHAsstCBTRec_ConsF_1M "Monthly PC cash received by human. sector used for food consumption"

	* Deduct 
	replace PCExpF_ECMEN = PCExpF_ECMEN-PC_HHAsstCBTRec_ConsF_1M if PC_HHAsstCBTRec_ConsF_1M!=.



*** Step 3 - Identifying the gap analysis cohort
* In this example the gap analysis group is made of the households with economic capacity used for food below the food MEB and who are moderately or severely food insecure based on CARI

	** create a variable to identify the cohort
	gen FGap_ref = PCExpF_ECMEN<Food_MEB & (CARI_ECMEN==3 | CARI_ECMEN==4)
	label var FGap_ref "Gap analysis cohort (below food MEB and food insecure)"
	label val FGap_ref cohort


*** Step 4 - Estimating the gap

	** Compute per capita food gap for each household
	gen PCFGap = Food_MEB - PCExpF_ECMEN if PCExpF_ECMEN<Food_MEB // the food gap is defined only for hh with economic capacity used for food below the food MEB
	label var PCFGap "Food gap, per capita, monthly"

	** Compute average food gap for the gap analysis cohort and save to a variable
	sum PCFGap if FGap_ref==1 // compute average
	gen PCFGap_avg = `r(mean)' if FGap_ref==1 // store calculated average into a variable (defined only for the cohort)
	label var PCFGap_avg  "Average per capita food gap (cohort: below food MEB and food insecure)"


	** Express the average food gap as share of the average food MEB
	gen PCFGap_share_Food_MEB = PCFGap_avg/Food_MEB if FGap_ref==1 // Note: in this example the food MEB is the same for all households, so no need to average the MEB
	label var PCFGap_share_Food_MEB "Food Gap/Food MEB per capita (cohort: below food MEB and food insecure)"

	** Compare the gap and the food gap
	graph bar (mean) PCGap_avg  PCFGap_avg, legend(label(1 "Gap")) legend(label(2 "Food gap")) title("Gap and Food Gap, monthly per capita") blabel(bar)

* ---------
** End of Scripts
