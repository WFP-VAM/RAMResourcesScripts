* Encoding: UTF-8.
********************************************************************************
 * STATA Syntax for example of gap analysis
 *******************************************************************************
						   
* This syntax file refers to the sample dataset accessible here: XXXXX

* Detailed guidance on conducting a gap analysis can be found here: XXXX

*-------------------------------------------------------------------------------*

*-------------------------------------------------------------------------------*
* Open dataset
*-------------------------------------------------------------------------------*

 * // replace before publishing.
GET
  FILE='C:\Users\lorenzo.moncada\OneDrive - World Food Programme\Shared Documents\05 - Guidance package\Gap Analysis guidance\Syntax_Data\Gap_Analysis_Sample.sav'.


*------------------------------------------------------------------------------*
*  Estimate the gap 
*------------------------------------------------------------------------------*

*** Step 1 - Identifying the cost of essential needs.
* A MEB is already available in the dataset, expressed in per capita monthly term, and differentiated by groups of household size to account for household economies of scale.



*** Step 2 - Computing the household economic capacity.
* The computation of the household economic capacity should follow the methodology used for the ECMEN indicator (version excluding assistance).

	** Sum food expenditures, value of consumed food from own-production, and non-food expenditures.
	COMPUTE PCExp_ECMEN=SUM.1(PC_HHExp_Food_Purch_MN_1M, PC_HHExp_Food_Own_MN_1M, 
                        PC_HHExpNFTotal_Purch_MN_1M). /* at least an argument must be non-missing.
                        VARIABLE LABELS  PCExp_ECMEN 'Household Economic Capacity per capita - monthly'.
                        EXECUTE. 

	** Deduct the value of cash assistance received from WFP and partner humanitarian organizations.
                        RECODE PC_HHAsstCBTRec_Cons_1M (SYSMIS=0).  /* code missing assistance as zero.
                        COMPUTE PCExp_ECMEN = PCExp_ECMEN-PC_HHAsstCBTRec_Cons_1M.
                         IF (PCExp_ECMEN<0) PCExp_ECMEN=0.  /* set negative values to zero.
                        EXECUTE.

*** Step 3 - Identifying the gap analysis cohort.
* In this example the gap analysis group is made of the households with economic capacity below the MEB and who are moderately or severely food insecure based on CARI.

	** create a variable to identify the cohort.
	COMPUTE Gap_ref = (PCExp_ECMEN<MEB AND (CARI_ECMEN=3 OR CARI_ECMEN=4)).
	VARIABLE LABELS Gap_ref  'Gap analysis cohort (below MEB and food insecure)'.
	VALUE LABELS  Gap_ref 1 'Part of cohort'  0 'Not part of cohort'.
	EXECUTE.


*** Step 4 - Estimating the gap.

	** Compute per capita gap for each household.
                        IF (PCExp_ECMEN<MEB) 	PCGap= MEB - PCExp_ECMEN. /* the gap is defined only for hh with economic capacity below the MEB.
	VARIABLE LABELS PCGap 'Gap, per capita, monthly'.
                        EXECUTE.

	** Compute average gap for the gap analysis cohort and save to a variable.
                            AGGREGATE
                              /OUTFILE=* MODE=ADDVARIABLES
                              /BREAK=Gap_ref
                              /PCGap_avg 'Average per capita gap (cohort: below MEB and food insecure)'=MEAN(PCGap).
                              IF (Gap_ref = 0)  PCGap_avg = $sysmis. /* avg gap defined only for the cohort.
                              EXECUTE.


	** Express the average gap as share of the (average) MEB.
                              /* First we need to calculate the average MEB for the reference cohort. Reminder: in this example the MEB is differentiated by groups of household size - if this is not the case this passage is not needed.
                          AGGREGATE
                              /OUTFILE=* MODE=ADDVARIABLES
                              /BREAK=Gap_ref
                              /avg_MEB 'Average per capita MEB (cohort: below MEB and food insecure)'=MEAN(MEB).
                              EXECUTE.                    
    
	COMPUTE PCGap_share_MEB = PCGap_avg/avg_MEB.
                        IF (Gap_ref = 0) PCGap_share_MEB = $sysmis. /* defined only for the cohort.
                        VARIABLE LABELS PCGap_share_MEB 'Gap/MEB per capita (cohort: below MEB and food insecure)'.
                        EXECUTE.
                        DELETE VARIABLES avg_MEB. 
                        EXECUTE.

*------------------------------------------------------------------------------*
*  Estimate the gap by household size
*------------------------------------------------------------------------------*

* In this dataset different MEB values are provided for 4 categories of household size, to take into account household economies of scale: small (1-3), medium (4-6), large (7-9), extra-large (10+). Accordingly, different gaps will be estimated.

	** Create a variable representing the different categories of household size.
	RECODE hhsize (SYSMIS=SYSMIS) (1 thru 3=1) (4 thru 6=2) (7 thru 9=3) (ELSE=4)  INTO hhsize_cat.
                        VARIABLE LABELS hhsize_cat  'Classes of household size'.
                        VALUE LABELS hhsize_cat 1 "Small" 2"Medium" 3"Large" 4"Extra large".
                        ADD FILES file * /keep  hhid district hhsize  hhsize_cat ALL.
                        EXECUTE.


	** Compute the average gap for household size cat and save into a variable.
                        FILTER BY Gap_ref. /* work only on gap analysis cohort.
                              
                        AGGREGATE
                              /OUTFILE=* MODE=ADDVARIABLES
                              /BREAK=  hhsize_cat
                              /PCGap_avg_hhcat  'Average gap per hh size (cohort: below MEB and food insecure)'=MEAN(PCGap).
                              EXECUTE.       

	FILTER OFF.

	** Display the different gaps by hh size.
                        MEANS TABLES= PCGap_avg_hhcat BY hhsize_cat
                          /CELLS=MEAN.

*------------------------------------------------------------------------------*
*  Compare the gap with and without assistance
*------------------------------------------------------------------------------*
* See Box 3 in the guidance note.
* The gap without assistance has already been computed in the previous section. Now the objective is repeating the procedure but using a version of the household economic capacity "including assistance".

*** Step 1 - Identifying the cost of essential needs.
* Same as in previous section.



*** Step 2 - Computing the household economic capacity .
* The computation of the household economic capacity should follow the methodology used for the ECMEN indicator (version including assistance).

	** Sum food expenditures, value of food consumed from in-kind assistance and gifts, value of consumed food from own-production, non-food expenditures, and the value of non-food from in-kind assistance and gifts.
	COMPUTE PCExp_ECMEN_inclAsst=SUM.1( PC_HHExp_Food_Purch_MN_1M, PC_HHExp_Food_GiftAid_MN_1M, PC_HHExp_Food_Own_MN_1M, PC_HHExpNFTotal_Purch_MN_1M, PC_HHExpNFTotal_GiftAid_MN_1M).
	VARIABLE LABELS PCExp_ECMEN_inclAsst  'Household Economic Capacity per capita - incl assistance - monthly'.
                        EXECUTE.


	* Note that in this time the value of received cash assistance should not be deducted.



*** Step 3 - Identifying the gap analysis cohort.
* In this example the gap analysis group is made of the households with economic capacity below the MEB and who are moderately or severely food insecure based on CARI.

	** create a variable to identify the cohort.
	COMPUTE Gap_ref_inclAsst = (PCExp_ECMEN_inclAsst<MEB AND (CARI_ECMEN=3 OR CARI_ECMEN=4)).
	VARIABLE LABELS Gap_ref_inclAsst 'Gap analysis cohort (below MEB and food insecure) - incl assistance'.
	VALUE LABELS Gap_ref_inclAsst 1 'Part of cohort'  0 'Not part of cohort'.


*** Step 4 - Estimating the gap

	** Compute per capita gap for each household.
	 IF (PCExp_ECMEN_inclAsst<MEB) PCGap_inclAsst = MEB - PCExp_ECMEN_inclAsst.  /* the gap is defined only for hh with economic capacity below the MEB.
	VARIABLE LABELS PCGap_inclAsst 'Gap, per capita, monthly - incl assistance'.



	** Compute average gap for the gap analysis cohort and save to a variable.
                            AGGREGATE
                              /OUTFILE=* MODE=ADDVARIABLES
                              /BREAK=Gap_ref_inclAsst
                              /PCGap_avg_inclAsst  'Average gap - incl assistance (cohort: below MEB and food insecure)'=MEAN(PCGap_inclAsst).
                              IF (Gap_ref_inclAsst = 0)  PCGap_avg_inclAsst  = $sysmis. /* avg gap defined only for the cohort.
                              EXECUTE.


	** Express the average gap as share of the (average) MEB.
                              /* First we need to calculate the average MEB for the reference cohort. Reminder: in this example the MEB is differentiated by groups of household size - if this is not the case this passage is not needed.
                          AGGREGATE
                              /OUTFILE=* MODE=ADDVARIABLES
                              /BREAK=Gap_ref_inclAsst
                              /avg_MEB 'Average per capita MEB (cohort: below MEB and food insecure)'=MEAN(MEB).
                              EXECUTE.                    
    
	COMPUTE PCGap_share_MEB_inclAsst = PCGap_avg_inclAsst/avg_MEB.
                        IF (Gap_ref_inclAsst = 0) PCGap_share_MEB_inclAsst = $sysmis. /* defined only for the cohort.
                        VARIABLE LABELS PCGap_share_MEB_inclAsst 'Gap/MEB per capita- incl assistance (cohort: below MEB and food insecure)'.
                        EXECUTE.
                        DELETE VARIABLES avg_MEB. 
                        EXECUTE.


	*** Compare the gaps (expressed as percentage of the MEB) without and with assistance.
                        DESCRIPTIVES VARIABLES=PCGap_share_MEB PCGap_share_MEB_inclAsst
                          /STATISTICS=MEAN. /* the difference is very small, because in this dataset the population does not receive much assistance.


*------------------------------------------------------------------------------*
*  Estimate the food gap
*------------------------------------------------------------------------------*
* Repeat the 4 standard steps of the gap analysis procedure.

*** Step 1 - Identifying the cost of food needs.
* A food MEB is already available in the dataset. This should be used as cost of food needs.



*** Step 2 - Computing the household economic capacity used for food

	** Sum food expenditures and the value of consumed food from own-production.
	COMPUTE PCExpF_ECMEN=SUM.1(PC_HHExp_Food_Purch_MN_1M, PC_HHExp_Food_Own_MN_1M).
	VARIABLE LABELS PCExpF_ECMEN 'Household Economic Capacity - food - per capita, monthly'.

	** Deduct the value of cash assistance received from WFP and partner humanitarian organizations, that is likely spent on food.
	* In this case, the part of received cash assistance spent on food can be be approximated using the Food Expenditure Share of the gap analysis cohort. The Food Expenditure Share is already provided in the dataset.
                         
                        *calculate average FES for the gap analysis cohort - we still use the old reference cohort (for the general gap) as that for the food gap is defined at the next step.
                        MEANS TABLES= FES BY Gap_ref
                          /CELLS=MEAN.   /* The average share of FES for the reference cohort is .7065.

                         * obtain the part of consumed cash assistance spent on food by multiplying  consumed received cash assistance by the average FES of the cohort.
                        COMPUTE  PC_HHAsstCBTRec_ConsF_1M =  PC_HHAsstCBTRec_Cons_1M*.7065. /* IMPORTANT: make sure to replace the average value of FES for the reference cohort if you using a different dataset/defining a different cohort.
	VARIABLE LABELS PC_HHAsstCBTRec_ConsF_1M "Monthly PC cash received by human. sector used for food consumption".
                        EXECUTE.

	* Deduct. 
	RECODE PC_HHAsstCBTRec_ConsF_1M (SYSMIS=0).  /* code missing assistance as zero.
                        COMPUTE PCExpF_ECMEN = PCExpF_ECMEN-PC_HHAsstCBTRec_ConsF_1M.
                         IF (PCExpF_ECMEN<0) PCExpF_ECMEN=0.  /* set negative values to zero.
                        EXECUTE.


*** Step 3 - Identifying the gap analysis cohort.
* In this example the gap analysis group is made of the households with economic capacity used for food below the food MEB and who are moderately or severely food insecure based on CARI.

	** create a variable to identify the cohort.
	COMPUTE FGap_ref = (PCExpF_ECMEN<Food_MEB AND (CARI_ECMEN=3 OR CARI_ECMEN=4)).
	VARIABLE LABELS FGap_ref  "Gap analysis cohort (below food MEB and food insecure)".
	VALUE LABELS FGap_ref 1 'Part of cohort'  0 'Not part of cohort'.
                        EXECUTE.


*** Step 4 - Estimating the gap.

	** Compute per capita food gap for each household.
	IF PCExpF_ECMEN<Food_MEB  PCFGap = (Food_MEB - PCExpF_ECMEN). /* the food gap is defined only for hh with economic capacity used for food below the food MEB.
	VARIABLE LABELS PCFGap "Food gap, per capita, monthly".

	** Compute average food gap for the gap analysis cohort and save to a variable.
                          AGGREGATE
                              /OUTFILE=* MODE=ADDVARIABLES
                              /BREAK=FGap_ref
                              /PCFGap_avg 'Average per capita food gap (cohort: below food MEB and food insecure)'=MEAN(PCFGap).
                              IF (FGap_ref = 0)  PCFGap_avg  = $sysmis. /* avg gap defined only for the cohort.
                              EXECUTE.          


	** Express the average food gap as share of the average food MEB.
	IF (FGap_ref=1) PCFGap_share_Food_MEB = PCFGap_avg/Food_MEB.  /* Note: in this example the food MEB is the same for all households, so no need to average the MEB.
	VARIABLE LABELS PCFGap_share_Food_MEB "Food Gap/Food MEB per capita (cohort: below food MEB and food insecure)".

	** Compare the gap and the food gap.
                        DESCRIPTIVES VARIABLES=PCGap_avg PCFGap_avg
                          /STATISTICS=MEAN.
* ---------
** End of Scripts.
