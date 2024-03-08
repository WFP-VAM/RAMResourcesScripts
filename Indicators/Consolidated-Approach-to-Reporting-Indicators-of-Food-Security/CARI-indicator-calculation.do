*************************************************************
********************************
** Food Security Indicators ****
********************************
gen dm_fcs_below 		= cond(FCS<21.5,1,0)
gen dm_fcs_between  	= cond(FCS>21 & FCS <42.5,1,0)
gen dm_fcs_above  		= cond(FCS>42,1,0)


*********************************************************
**** Consolidated Approach for Reporting Indicators ****
*********************************************************
** Food Consumption Indicators ****
* Consumption based coping strategies
recode rCSILessQlty rCSIBorrow rCSIMealSize rCSIMealAdult rCSIMealNb (.=0)
gen rCSI=rCSILessQlty*1+rCSIBorrow*2+rCSIMealSize*1+rCSIMealAdult*1+rCSIMealNb*3

* Food Consumption Score
capture confirm variable FCS 
if _rc==0 {

	*Simulated category
	gen FCSCat21=cond(FCS<21,1,cond(FCS<35,2,3))
	label var FCSCat21 "FCS Categories, thresholds 21-35"

	gen Fcs_4pt_4=cond(FCSCat21==1,1,0)
	gen Fcs_4pt_3=cond(FCSCat21==2,1,0)
	gen Fcs_4pt_2=cond(FCSCat21==0,1,0)
	gen Fcs_4pt_1=cond(FCSCat21==3,1,0)

	gen Fcs_4pt=cond(Fcs_4pt_4==1,4,cond(Fcs_4pt_3==1,3,cond(Fcs_4pt_2==1,2,1)))
	
	
****	Current Status Pillar **************************************************

	gen CurrentStatus=Fcs_4pt
	gen CurrentStatus_4pt_4=Fcs_4pt_4
	gen CurrentStatus_4pt_3=Fcs_4pt_3
	gen CurrentStatus_4pt_2=Fcs_4pt_2
	gen CurrentStatus_4pt_1=Fcs_4pt_1
	replace CurrentStatus_4pt_2=cond(CurrentStatus_4pt_1==1 & rCSI>=4,1,0)
	replace CurrentStatus_4pt_1=cond(CurrentStatus_4pt_2==1,0,CurrentStatus_4pt_1)
	
	label var CurrentStatus_4pt_4 "Poor food consumption"
	label var CurrentStatus_4pt_3 "Marginally poor food consumption"
	label var CurrentStatus_4pt_2 "Marginally adequate food consumption"
	label var CurrentStatus_4pt_1 "Adequate food consumption"
	
	local CurrentStatus_4pt `"Current status based on food consumption score"'
}

* Food energy shortfall 
* If there are kcal based outputs:
else {
	cap confirm var PCFCKcal
	if _rc==0 {
		gen dm_kcal_1800 		= cond(PCFCKcal <1800,1,0)
		gen dm_kcal_1800_2100  	= cond(PCFCKcal >=1800 & PCFCKcal <2100,1,0)
		gen dm_kcal_2100		= cond(PCFCKcal >=2100,1,0)

		gen depth_kcal_1800		= cond(PCFCKcal <1800,1800-PCFCKcal,0)
		gen depth_kcal_2100		= cond(PCFCKcal <2100,2100-PCFCKcal,0)	
		
		gen gap_kg_1800			= depth_kcal_1800 	* 7/3115
		gen gap_kg_2100			= depth_kcal_2100 	* 7/3115	

		gen net_depth_kcal_adultequi		=PCFCKcal	*HHSize - HHKcalReq
		replace net_depth_kcal_adultequi	=cond(net_depth_kcal_adultequi>0,0,-net_depth_kcal_adultequi)

		gen Fes_4pt_4=cond(PCFCKcal_S<1600,1,0)
		gen Fes_4pt_3=cond(PCFCKcal_S>=1600 & PCFCKcal_S<1850,1,0)
		gen Fes_4pt_2=cond(PCFCKcal_S>=1850 & PCFCKcal_S<2100,1,0)
		gen Fes_4pt_1=cond(PCFCKcal_S>=2100,1,0) 

		label var Fes_4pt_4 "Food energy shortfall 1600 kcal/p/d"
		label var Fes_4pt_3 "Food energy shortfall 1850 kcal/p/d"
		label var Fes_4pt_2 "Food energy shortfall 2100 kcal/p/d"
		label var Fes_4pt_1 "No food energy shortfall 2100 kcal/p/d"
		gen Fes_4pt=cond(Fes_4pt_4==1,4,cond(Fes_4pt_3==1,3,cond(Fes_4pt_2==1,2,1)))
		
		
	****	Current Status Pillar **************************************************
		gen CurrentStatus=Fes_4pt
		gen CurrentStatus_4pt_4=Fes_4pt_4
		gen CurrentStatus_4pt_3=Fes_4pt_3
		gen CurrentStatus_4pt_2=Fes_4pt_2
		gen CurrentStatus_4pt_1=Fes_4pt_1
		replace CurrentStatus_4pt_2=cond(CurrentStatus_4pt_1==1 & rCSI>=4,1,0)
		replace CurrentStatus_4pt_1=cond(CurrentStatus_4pt_2==1,0,CurrentStatus_4pt_1)
		
		
		label var CurrentStatus_4pt_4 "Food energy shortfall 1600 kcal/p/d"
		label var CurrentStatus_4pt_3 "Food energy shortfall 1850 kcal/p/d"
		label var CurrentStatus_4pt_2 "Food energy shortfall 2100 kcal/p/d"
		label var CurrentStatus_4pt_1 "No food energy shortfall 2100 kcal/p/d"
		
		local CurrentStatus_4pt `"Current status based on food energy shortfall"'
		
		
	}
	else {
		di as error in red "No FCS or Caloric consumption indicator" 
		di as error in red "It is not possible to calculate the CARI"
		di as error in red "Please revise dataset input"
		exit
		
	}
}

********************************************************************************

* Poverty *
cap confirm var PCExpenditures_S
if _rc==0 {
	gen Pov_4pt_2=0
	gen Pov_4pt_4=cond(PCExpenditures/30< 	1.0*Exchange_rate_USD									,1,0)
	gen Pov_4pt_3=cond(PCExpenditures/30>= 	1.0*Exchange_rate_USD	 & PCExpenditures_S/30< 1.90*Exchange_rate_USD	,1,0)
	gen Pov_4pt_1=cond(PCExpenditures/30>= 	1.90*Exchange_rate_USD									,1,0)

	label var Pov_4pt_4 "Household has expenditures below the food poverty line"
	label var Pov_4pt_3 "Household has expenditures below the abs. poverty line, but above food povery line"
	label var Pov_4pt_1 "Household has expenditures above the abs. poverty line"
	gen _1_PovStat_4pt=cond(Pov_4pt_4==1,4,cond(Pov_4pt_3==1,3,1))

	local Pov_4pt_4 "Household has expenditures below the food poverty line"
	local Pov_4pt_3 "Household has expenditures below the abs. poverty line, but above food povery line"
	local Pov_4pt_1 "Household has expenditures above the abs. poverty line"

	* ECMEN *
	cap confirm var MEB_S
	if _rc==0 {
		gen ECMEN_4pt_4=cond(PCExpenditures< 	SMEB,1,0)
			gen ECMEN_4pt_3=cond(PCExpenditures>= 	SMEB & PCExpenditures< MEB ,1,0)
			gen ECMEN_4pt_1=cond(PCExpenditures>=  MEB	,1,0)
	
			label var ECMEN_4pt_4 "Household has expenditures below the survival expenditure basket threshold"
			label var ECMEN_4pt_3 "Household has expenditures below the abs. poverty line, but above survival expenditure basket threshold"
			label var ECMEN_4pt_1 "Household has expenditures above the minimum expenditure basket threshold"
			replace _1_PovStat_4pt=cond(ECMEN_4pt_4==1,4,cond(ECMEN_4pt_3==1,3,1))

		}
		
	}
}
* Food Expenditure Shares
gen sh_exp_food = PCFoodExpenditures/PCExpenditures
gen Food_exp_share_4pt_4=cond(sh_exp_food>=0.75						,1,0)
gen Food_exp_share_4pt_3=cond(sh_exp_food>=0.65 & sh_exp_food<0.75	,1,0)
gen Food_exp_share_4pt_2=cond(sh_exp_food>=0.50 & sh_exp_food<0.65	,1,0)
gen Food_exp_share_4pt_1=cond(sh_exp_food<0.50						,1,0)

label var Food_exp_share_4pt_4 "Share of expenditures on food greater or equal than 75%"
label var Food_exp_share_4pt_3 "Share of expenditures on food greater or equal than 65% and lower than 75%"
label var Food_exp_share_4pt_2 "Share of expenditures on food greater or equal than 50% and lower than 65%"
label var Food_exp_share_4pt_1 "Share of expenditures on food lower than 50%"
gen _2_PovStat_4pt=cond(Food_exp_share_4pt_4==1,4,cond(Food_exp_share_4pt_3==1,3,cond(Food_exp_share_4pt_2==1,2,1)))

cap confirm var MEB
if _rc==0 {
	egen EconVuln_4pt=rowmean(_1_PovStat_4pt)
	local EconVuln_4pt_1_lab=`"Poverty status: food secure (ECMEN)"'
	local EconVuln_4pt_2_lab=`"Poverty status: marginally food secure (ECMEN)"'
	local EconVuln_4pt_3_lab=`"Poverty status: marginally food insecure (ECMEN)"'
	local EconVuln_4pt_4_lab=`"Poverty status: severely food insecure (ECMEN)"'
}
else {
	cap confirm var PCExpenditures
	if _rc==0 {
		egen EconVuln_4pt=rowmean(_1_PovStat_4pt)
	local EconVuln_4pt_1_lab=`"Poverty status: food secure (international poverty line)"'
	local EconVuln_4pt_2_lab=`"Poverty status: marginally food secure (international poverty line)"'
	local EconVuln_4pt_3_lab=`"Poverty status: marginally food insecure (international poverty line)"'
	local EconVuln_4pt_4_lab=`"Poverty status: severely food insecure (international poverty line)"'
	}
	else {
		egen EconVuln_4pt=rowmean(_2_PovStat_4pt)
	local EconVuln_4pt_1_lab=`"Poverty status: food secure (share of expenditures on food)"'
	local EconVuln_4pt_2_lab=`"Poverty status: marginally food secure (share of expenditures on food)"'
	local EconVuln_4pt_3_lab=`"Poverty status: marginally food insecure (share of expenditures on food)"'
	local EconVuln_4pt_4_lab=`"Poverty status: severely food insecure (share of expenditures on food)"'
	}
}

gen EconVuln_4pt_1=EconVuln_4pt==1
gen EconVuln_4pt_2=EconVuln_4pt==2
gen EconVuln_4pt_3=EconVuln_4pt==3
gen EconVuln_4pt_4=EconVuln_4pt==4

cap drop _2_PovStat_4pt 
cap drop _1_PovStat_4pt

* Livelihood based coping strategy index - LCSI *
/// HERE we use baseline only, no simulated value (2021/06)
gen livelihoodCSI_4pt_1=cond(stressLivelihoodCoping==0 & crisisLivelihoodCoping==0 & emergencyLivelihoodCoping==0	,1,0) 
gen livelihoodCSI_4pt_2=cond(stressLivelihoodCoping==1 & crisisLivelihoodCoping==0 & emergencyLivelihoodCoping==0,1,0)
gen livelihoodCSI_4pt_3=cond(crisisLivelihoodCoping==1  & emergencyLivelihoodCoping==0,1,0)
gen livelihoodCSI_4pt_4=cond(emergencyLivelihoodCoping==1,1,0)

label var livelihoodCSI_4pt_1 "No livelihood coping stategy"
label var livelihoodCSI_4pt_2 "Stress livelihood coping stategy"
label var livelihoodCSI_4pt_3 "Crisis livelihood coping stategy"
label var livelihoodCSI_4pt_4 "Emergency livelihood coping stategy"

gen livelihoodCSI_4pt=cond(livelihoodCSI_4pt_4==1,4,cond(livelihoodCSI_4pt_3==1,3,cond(livelihoodCSI_4pt_2==1,2,1)))
egen CopingCapacity=rowmean(EconVuln_4pt livelihoodCSI_4pt)
********************************************************************************
egen FSI=rowmean(CurrentStatus CopingCapacity)
gen FSI_4pt=round(FSI) 

gen FSI_4pt_4=cond(FSI_4pt==4,1,0)
gen FSI_4pt_3=cond(FSI_4pt==3,1,0)
gen FSI_4pt_2=cond(FSI_4pt==2,1,0)
gen FSI_4pt_1=cond(FSI_4pt==1,1,0)

label var FSI_4pt_1 "Food secure (CARI)"
label var FSI_4pt_2 "Marginally food secure (CARI) "
label var FSI_4pt_3 "Marginally food insecure (CARI)"
label var FSI_4pt_4 "Food insecure (CARI)"