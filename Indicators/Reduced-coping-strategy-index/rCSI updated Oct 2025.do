*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                         reduced Coping Strategies Index (rCSI)


*** Last Update: Oct 2025
*** Purpose: This script calculates the reduced Coping Strategies Index

***   Data Quality Guidance References:
***   - Recommended high frequency checks: Page 31
***   - Recommended cleaning steps: Page 38

*** ----------------------------------------------------------------------------------------------------

*** Define group labels-  these should match Survey Designer naming conventions

label var rCSILessQlty "Rely on less preferred and less expensive food in the past 7 days"
label var rCSIBorrow   "Borrow food or rely on help from a relative or friend in the past 7 days"
label var rCSIMealNb   "Reduce number of meals eaten in a day in the past 7 days"
label var rCSIMealSize "Limit portion size of meals at meal times in the past 7 days"
label var rCSIMealAdult "Restrict consumption by adults in order for small children to eat in the past 7 days"

*** Check individual strategies

summarize rCSILessQlty rCSIBorrow rCSIMealNb rCSIMealSize rCSIMealAdult, detail

**OR**

tabstat rCSILessQlty rCSIBorrow rCSIMealNb rCSIMealSize rCSIMealAdult, stats(mean median min max) columns(var)

*** Harmonize Data Quality Guidance measures
*** Clean impossible values 

foreach v in rCSILessQlty rCSIBorrow rCSIMealNb rCSIMealSize rCSIMealAdult {
    replace `v' = . if `v' < 0 | `v' > 7
}

*** Calculate rCSI (use + instead of SUM to automatically drop missing values from the final rCSI)

gen rCSI = (rCSILessQlty*1) + (rCSIBorrow*2) + (rCSIMealNb*1) + (rCSIMealSize*1) + (rCSIMealAdult*3)

label var rCSI "Reduced coping strategies index (rCSI)"

*** Harmonize Data Quality Guidance measures
*** Check that rCSI is between 0-56

tabstat rCSI, stats(mean median sd min max) columns(var)

**OR**
summarize rCSI, detail

*** Clean any impossible rCSI values

replace rCSI = . if rCSI < 0 | rCSI > 56

*** Flagging potential Data Quality issues. If any cases reflected here, refer to the Data Quality Guidance note page 31. This can be found on the VAM Ressource Centre, 
*** Note that having a low rCSI is likely not a data quality issue if the area surveyed is relatively food secure
*** Note that having a high rCSI can be real if the area surveyed is very food insecure

*************************************************************
*** Flag: LOW rCSI values (0–3)
*************************************************************

gen rCSI_flag_low = 0
replace rCSI_flag_low = 1 if rCSI <= 3

label var rCSI_flag_low ///
"rCSI has low values that could be a Data Quality issue unless the population surveyed is generally food secure. Flag to team leader if poor or borderline FCS."

label define rCSI_low_lbl 0 "No" 1 "Yes"
label values rCSI_flag_low rCSI_low_lbl


*************************************************************
*** Flag: HIGH rCSI values (>= 42)
*************************************************************

gen rCSI_flag_high = 0
replace rCSI_flag_high = 1 if rCSI >= 42

label var rCSI_flag_high ///
"rCSI has high values that could be a Data Quality issue unless the population surveyed is generally food insecure. Flag to team leader if acceptable FCS, low levels of livelihood coping etc."

label define rCSI_high_lbl 0 "No" 1 "Yes"
label values rCSI_flag_high rCSI_high_lbl

*** Check flagged cases
*** If it is found that flags might be data quality issues (i.e. high number of flag_low in very food insecure areas or flag_high in seeminly food secure areas), it is recommended to do a crosstab to see the frequency by enumerator to understand if flags are coming from the same few enumerators

tab rCSI_flag_low, missing
tab rCSI_flag_high, missing

*** Check distribution of final categories

tabstat rCSI, stats(min max mean) columns(var)

tab rCSI, missing

*** Optional: Compute the same variable to be used directly for IPC analysis (referring to IPC phases)

recode rCSI (0/3 = 1) (4/18 = 2) (19/max = 3), gen(rCSI_IPC)

label var rCSI_IPC "Official IPC Classification for rCSI"

label define rCSI_IPC_lbl ///
    1 "rCSI [0-3] - IPC Phase 1" ///
    2 "rCSI [4-18] - IPC Phase 2" ///
    3 "rCSI [>=19] - IPC Phase 3-5"

label values rCSI_IPC rCSI_IPC_lbl    

*** Check distribution of final categories

tab rCSI_IPC, missing

*** Optional: Compute the same variable to be used directly for IPC analysis (referring to IPC phases) - indicating high values (potential Phase 4)

recode rCSI (0/3 = 1) (4/18 = 2) (19/42 = 3) (43/max = 4), gen(rCSI_IPC_HighValues)

label var rCSI_IPC_HighValues ///
"Informal IPC Classification indicating high values (potential Phase 4)"

label define rCSI_IPC_HV_lbl ///
    1 "rCSI [0-3] - IPC Phase 1" ///
    2 "rCSI [4-18] - IPC Phase 2" ///
    3 "rCSI [19-42] - IPC Phase 3" ///
    4 "rCSI [>42] - IPC Phase 4"

label values rCSI_IPC_HighValues rCSI_IPC_HV_lbl

*** Check distribution of final categories

tab rCSI_IPC_HighValues, missing

*** ----------------------------------------------------------------------------------------------------
*** END OF SCRIPT
*** ----------------------------------------------------------------------------------------------------