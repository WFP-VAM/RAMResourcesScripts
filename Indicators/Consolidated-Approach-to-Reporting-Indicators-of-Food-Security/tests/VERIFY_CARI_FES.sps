* CARI-FES complete-case validation using synthetic records only.
* Expected result: 12 passed cases and zero failed cases.

NEW FILE.
DATA LIST FREE /
 case_id (A8)
 FCSCat21 rCSI Max_coping_behaviourFS FES Foodexp_4pt expected_CARI_FES.
BEGIN DATA
"FES-01" 3 0 1 1 1 1
"FES-02" 3 4 2 2 3 2
"FES-03" 2 10 3 3 4 3
"FES-04" 1 20 4 4 4 4
"FES-05" -999 0 1 1 1 -999
"FES-06" 3 -999 1 1 1 -999
"FES-07" 3 0 -999 3 3 -999
"FES-08" 3 0 1 -999 -999 -999
"FES-09" 3 0 -999 -999 -999 -999
"FES-10" -999 -999 -999 -999 -999 -999
"FES-11" 3 0 1 -999 1 -999
"FES-12" 3 0 1 .8 -999 -999
END DATA.
DATASET NAME CARI_FES_VALIDATION.

* Convert the explicit synthetic missing-value code to SPSS system-missing.
RECODE FCSCat21 rCSI Max_coping_behaviourFS FES Foodexp_4pt expected_CARI_FES
  (-999=SYSMIS).
EXECUTE.

* Candidate calculation section.
RECODE FCSCat21 (1=4) (2=3) (3=1) INTO FCS_4pt.
VARIABLE LABELS FCS_4pt '4pt FCG'.
VALUE LABELS FCS_4pt 1 'Acceptable' 3 'Borderline' 4 'Poor'.

DO IF (rCSI >= 4).
RECODE FCS_4pt (1=2).
END IF.
VALUE LABELS FCS_4pt 1 'Acceptable' 2 'Acceptable and rCSI>=4' 3 'Borderline' 4 'Poor'.

COMPUTE Mean_coping_capacity_FES = MEAN(Max_coping_behaviourFS, Foodexp_4pt).
COMPUTE CARI_unrounded_FES = MEAN(FCS_4pt, Mean_coping_capacity_FES).
COMPUTE CARI_FES = RND(CARI_unrounded_FES).
IF (NMISS(FCS_4pt, rCSI, Max_coping_behaviourFS, FES, Foodexp_4pt) > 0) CARI_FES = $SYSMIS.
EXECUTE.

* Test assertion: missing matches missing, or calculated value matches expected value.
COMPUTE TEST_PASS = ((MISSING(expected_CARI_FES) AND MISSING(CARI_FES)) OR
                     (NOT MISSING(expected_CARI_FES) AND expected_CARI_FES = CARI_FES)).
VALUE LABELS TEST_PASS 0 'Failed' 1 'Passed'.
FORMATS TEST_PASS (F1.0) CARI_FES expected_CARI_FES (F2.0).
EXECUTE.

TITLE 'CARI-FES complete-case validation: all cases'.
LIST VARIABLES=case_id FCSCat21 rCSI Max_coping_behaviourFS FES Foodexp_4pt expected_CARI_FES CARI_FES TEST_PASS.
FREQUENCIES VARIABLES=TEST_PASS.

TITLE 'CARI-FES complete-case validation: failures only (expected zero cases)'.
TEMPORARY.
SELECT IF (TEST_PASS = 0).
LIST VARIABLES=case_id expected_CARI_FES CARI_FES TEST_PASS.
