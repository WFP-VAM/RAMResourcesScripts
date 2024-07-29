*------------------------------------------------------------------------------*
*                           WFP Standardized Scripts
*                Calculating the Household Hunger Scale (HHS)
*------------------------------------------------------------------------------*

* Define variables and labels -------------------------------------------------*

VARIABLE LABELS
    HHSNoFood        'In the past [4 weeks/30 days], was there ever no food to eat of any kind in your house because of lack of resources to get food?'
    HHSNoFood_FR     'How often did this happen in the past [4 weeks/30 days]?'
    HHSBedHung       'In the past [4 weeks/30 days], did you or any household member go to sleep at night hungry because there was not enough food?'
    HHSBedHung_FR    'How often did this happen in the past [4 weeks/30 days]?'
    HHSNotEat        'In the past [4 weeks/30 days], did you or any household member go a whole day and night without eating anything because there was not enough food?'
    HHSNotEat_FR     'How often did this happen in the past [4 weeks/30 days]?'

* Define value labels --------------------------------------------------------*

VALUE LABELS HHSNoFood HHSBedHung HHSNotEat
    0 'No'
    1 'Yes'.

VALUE LABELS HHSNoFood_FR HHSBedHung_FR HHSNotEat_FR
    1 'Rarely (1–2 times)'
    2 'Sometimes (3–10 times)'
    3 'Often (more than 10 times)'.

* Clean HHS variables --------------------------------------------------------*

* HHSNoFood and HHSNoFood_FR
DO IF (HHSNoFood_FR > 0).
    COMPUTE HHSNoFood = 1.
ELSE.
    COMPUTE HHSNoFood = 0.
END IF.
EXECUTE.

* HHSBedHung and HHSBedHung_FR
DO IF (HHSBedHung_FR > 0).
    COMPUTE HHSBedHung = 1.
ELSE.
    COMPUTE HHSBedHung = 0.
END IF.
EXECUTE.

* HHSNotEat and HHSNotEat_FR
DO IF (HHSNotEat_FR > 0).
    COMPUTE HHSNotEat = 1.
ELSE.
    COMPUTE HHSNotEat = 0.
END IF.
EXECUTE.

* Recode frequency-of-occurrence questions -----------------------------------*

RECODE HHSNoFood_FR HHSBedHung_FR HHSNotEat_FR (1=1) (2=1) (3=2) (ELSE=0) INTO HHSQ1 HHSQ2 HHSQ3.

* Define variable labels for new variables -----------------------------------*

VARIABLE LABELS
    HHSQ1 'Was there ever no food to eat in HH?'
    HHSQ2 'Did any HH member go sleep hungry?'
    HHSQ3 'Did any HH member go whole day without food?'.
EXECUTE.

* Compute Household Hunger Score ------------------------------------------------*

COMPUTE HHS = HHSQ1 + HHSQ2 + HHSQ3.
VARIABLE LABELS HHS 'Household Hunger Score'.
EXECUTE.

* Display HHS summary statistics ----------------------------------------------*

FREQUENCIES VARIABLES = HHS
    /STATISTICS = MEAN MEDIAN MINIMUM MAXIMUM
    /ORDER = ANALYSIS.

* Create categorical HHS indicators -------------------------------------------*

* HHS Categories
RECODE HHS (0 THRU 1 = 1) (2 THRU 3 = 2) (4 THRU HI = 3) INTO HHSCat.
VARIABLE LABELS HHSCat 'Household Hunger Score Categories'.
VALUE LABELS HHSCat
    1 'No or little hunger in the household'
    2 'Moderate hunger in the household'
    3 'Severe hunger in the household'.
EXECUTE.

* IPC Categories
RECODE HHS (0 = 0) (1 = 1) (2 THRU 3 = 2) (4 = 3) (5 THRU HI = 4) INTO HHSCatr.
VARIABLE LABELS HHSCatr 'Household Hunger Score Categories'.
VALUE LABELS HHSCatr
    0 'No hunger in the household'
    1 'Little hunger in the household (stress)'
    2 'Moderate hunger in the household (crisis)'
    3 'Severe hunger in the household (emergency)'
    4 'Very severe hunger in the household (catastrophe)'.
EXECUTE.

* Display categorical HHS indicators ------------------------------------------*
FREQUENCIES VARIABLES = HHSCat HHSCatr.

** End of Scripts