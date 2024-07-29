*------------------------------------------------------------------------------*
*                            WFP Standardized Scripts
*                Calculating the Household Hunger Scale (HHS)
*------------------------------------------------------------------------------*

* Define variable labels -------------------------------------------------------*
label variable HHSNoFood      "In the past [4 weeks/30 days], was there ever no food to eat of any kind in your house because of lack of resources to get food?"
label variable HHSNoFood_FR   "How often did this happen in the past [4 weeks/30 days]?"
label variable HHSBedHung     "In the past [4 weeks/30 days], did you or any household member go to sleep at night hungry because there was not enough food?"
label variable HHSBedHung_FR  "How often did this happen in the past [4 weeks/30 days]?"
label variable HHSNotEat      "In the past [4 weeks/30 days], did you or any household member go a whole day and night without eating anything because there was not enough food?"
label variable HHSNotEat_FR   "How often did this happen in the past [4 weeks/30 days]?"

* Define value labels ----------------------------------------------------------*
label define hhs_nofood 0 "No" 1 "Yes"
label values HHSNoFood hhs_nofood

label define hhs_freq 1 "Rarely (1–2 times)"        ///
                      2 "Sometimes (3–10 times)"    ///
                      3 "Often (more than 10 times)"
label values HHSNoFood_FR HHSBedHung_FR HHSNotEat_FR hhs_freq

* Clean HHS variables ----------------------------------------------------------*
gen HHSNoFood  = (HHSNoFood_FR > 0)
gen HHSBedHung = (HHSBedHung_FR > 0)
gen HHSNotEat  = (HHSNotEat_FR > 0)

* Recode frequency-of-occurrence questions ------------------------------------*
recode HHSNoFood_FR  (1=1) (2=1) (3=2) (else=0), gen(HHSQ1)
recode HHSBedHung_FR (1=1) (2=1) (3=2) (else=0), gen(HHSQ2)
recode HHSNotEat_FR  (1=1) (2=1) (3=2) (else=0), gen(HHSQ3)

* Define variable labels for new variables -------------------------------------*
label variable HHSQ1 "Was there ever no food to eat in HH?"
label variable HHSQ2 "Did any HH member go sleep hungry?"
label variable HHSQ3 "Did any HH member go whole day without food?"

* Compute Household Hunger Score ------------------------------------------------*
gen HHS = HHSQ1 + HHSQ2 + HHSQ3
label variable HHS "Household Hunger Score"

* Display HHS summary statistics -------------------------------------------------*
summarize HHS, detail

* Create categorical HHS indicators ---------------------------------------------*
recode HHS (0/1 = 1) (2/3 = 2) (4/.) = 3, gen(HHSCat)
label define hhs_cat 1 "No or little hunger in the household" ///
                     2 "Moderate hunger in the household"     ///
                     3 "Severe hunger in the household"
label values HHSCat hhs_cat

* IPC Categories ----------------------------------------------------------------*
recode HHS (0 = 0) (1 = 1) (2/3 = 2) (4 = 3) (5/.) = 4, gen(HHSCatr)
label define hhs_cat_ipc 0 "No hunger in the household"                 ///
                         1 "Little hunger in the household (stress)"    ///
                         2 "Moderate hunger in the household (crisis)"  ///
                         3 "Severe hunger in the household (emergency)" ///
                         4 "Very severe hunger in the household (catastrophe)"
label values HHSCatr hhs_cat_ipc

* Display categorical HHS indicators --------------------------------------------*
tab HHSCat
tab HHSCatr

* End of Scripts