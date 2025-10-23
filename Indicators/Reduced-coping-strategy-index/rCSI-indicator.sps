* Encoding: UTF-8.
*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                                     reduced Coping Strategies Index (rCSI)


*** Last Update: Oct 2025
*** Purpose: This script calculates the reduced Coping Strategies Index

***   Data Quality Guidance References:
***   - Recommended high frequency checks: Page 31
***   - Recommended cleaning steps: Page 38

*** ----------------------------------------------------------------------------------------------------

*** Define group labels-  these should match Survey Designer naming conventions

VARIABLE LABELS
rCSILessQlty           "Rely on less preferred and less expensive food in the past 7 days"
rCSIBorrow              "Borrow food or rely on help from a relative or friend in the past 7 days"
rCSIMealNb             "Reduce number of meals eaten in a day in the past 7 days"
rCSIMealSize           "Limit portion size of meals at meal times in the past 7 days"
rCSIMealAdult          "Restrict consumption by adults in order for small children to eat in the past 7 days".

*** Check individual strategies
    
FREQUENCIES VARIABLES=rCSILessQlty rCSIBorrow rCSIMealNb rCSIMealSize rCSIMealAdult
  /FORMAT=NOTABLE
  /STATISTICS=MINIMUM MAXIMUM MEAN.

*** Harmonize Data Quality Guidance measures
*** Clean impossible values 

RECODE rCSILessQlty rCSIBorrow rCSIMealNb rCSIMealSize rCSIMealAdult (LOWEST THRU -1 = SYSMIS).
RECODE rCSILessQlty rCSIBorrow rCSIMealNb rCSIMealSize rCSIMealAdult (8 THRU HIGHEST = SYSMIS).
EXECUTE.

*** Calculate rCSI (use + instead of SUM to automatically drop missing values from the final rCSI)

COMPUTE rCSI = (rCSILessQlty*1) + (rCSIBorrow*2) + (rCSIMealNb*1) + (rCSIMealSize*1) + (rCSIMealAdult*3).
VARIABLE LABELS rCSI 'Reduced coping strategies index (rCSI)'.
EXECUTE.

*** Harmonize Data Quality Guidance measures
*** Check that rCSI is between 0-56

DESCRIPTIVES VARIABLES=rCSI
  /STATISTICS=MEAN STDDEV MIN MAX.

*** Clean any impossible FCS values

RECODE rCSI (LOWEST THRU -1 = SYSMIS).
RECODE rCSI (57 THRU HIGHEST = SYSMIS).
EXECUTE.

*** Flagging potential Data Quality issues. If any cases reflected here, refer to the Data Quality Guidance note page 31. This can be found on the VAM Ressource Centre, 
*** Note that having a low rCSI is likely not a data quality issue if the area surveyed is relatively food secure
*** Note that having a high rCSI can be real if the area surveyed is very food insecure

COMPUTE rCSI_flag_low = 0.    
IF (rCSI LE 3) rCSI_flag_low = 1.
VARIABLE LABELS rCSI_flag_low "rCSI has low values that could be a Data Quality issue unless the population surveyed is generally food secure. Flag to team leader if poor or boderline FCS".
VALUE LABELS rCSI_flag_low
    0 "No"
    1 "Yes".

COMPUTE rCSI_flag_high = 0.    
IF (rCSI GE 42) rCSI_flag_high = 1.
VARIABLE LABELS rCSI_flag_high "rCSI has high values that could be a Data Quality issue unless the population surveyed is generally food insecure. Flag to team leader if acceptable FCS, low levels of livelihood coping etc".
VALUE LABELS rCSI_flag_high
    0 "No"
    1 "Yes".

*** Check flagged cases
*** If it is found that flags might be data quality issues (i.e. high number of flag_low in very food insecure areas or flag_high in seeminly food secure areas), 
it is recommended to do a crosstab to see the frequency by enumerator to understand if flags are coming from the same few enumerators    

FREQUENCIES VARIABLES=rCSI_flag_low rCSI_flag_high
  /ORDER=ANALYSIS.

*** Check distribution of final categories

FREQUENCIES VARIABLES=rCSI
  /FORMAT=NOTABLE
  /STATISTICS=MINIMUM MAXIMUM MEAN.

*** Optional: Compute the same variable to be used directly for IPC analysis (referring to IPC phases)

RECODE rCSI (LOWEST THRU 3 = 1) (4 THRU 18 = 2) (19 THRU HIGHEST = 3) INTO rCSI_IPC.
VARIABLE LABELS rCSI_IPC "Official IPC Classification for rCSI".
VALUE LABELS rCSI_IPC
    1 "rCSI [0-3] - IPC Phase 1"
    2 "rCSI [4-18] - IPC Phase 2"
    3 "rCSI [>=19] - IPC Phase 3-5".
EXECUTE.

*** Check distribution of final categories

FREQUENCIES VARIABLES=rCSI_IPC
  /ORDER=ANALYSIS.

*** Optional: Compute the same variable to be used directly for IPC analysis (referring to IPC phases) - indicating high values (potential Phase 4)

RECODE rCSI (LOWEST THRU 3 = 1) (4 THRU 18 = 2) (19 THRU 42 = 3) (43 THRU HIGHEST = 4) INTO rCSI_IPC_HighValues.
VARIABLE LABELS rCSI_IPC_HighValues "Informal IPC Classification indicating high values (potential Phase 4)".
VALUE LABELS rCSI_IPC_HighValues
    1 "rCSI [0-3] - IPC Phase 1"
    2 "rCSI [4-18] - IPC Phase 2"
    3 "rCSI [19-42]  - IPC Phase 3"
    4 "rCSI [>42] - IPC Phase 4".
EXECUTE.

*** Check distribution of final categories

FREQUENCIES VARIABLES=rCSI_IPC_HighValues
  /ORDER=ANALYSIS.

*** ----------------------------------------------------------------------------------------------------
*** END OF SCRIPT
*** ----------------------------------------------------------------------------------------------------

