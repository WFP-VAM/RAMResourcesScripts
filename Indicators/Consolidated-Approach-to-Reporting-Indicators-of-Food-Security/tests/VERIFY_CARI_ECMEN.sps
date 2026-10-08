* CARI-ECMEN complete-case validation using synthetic records only.
* Expected result: 10 passed cases and zero failed cases.

NEW FILE.
DATA LIST FREE /
 case_id (A10)
 FCSCat21 rCSI Max_coping_behaviourFS ECMEN_exclAsst ECMEN_exclAsst_SMEB expected_CARI_ECMEN.
BEGIN DATA
"ECMEN-01" 3 0 1 1 1 1
"ECMEN-02" 3 4 2 0 1 2
"ECMEN-03" 2 10 3 0 0 3
"ECMEN-04" 1 20 4 0 0 4
"ECMEN-05" -999 0 1 1 1 -999
"ECMEN-06" 3 -999 1 1 1 -999
"ECMEN-07" 3 0 -999 0 1 -999
"ECMEN-08" 3 0 1 -999 1 -999
"ECMEN-09" 3 0 1 0 -999 -999
"ECMEN-10" -999 -999 -999 -999 -999 -999
END DATA.
DATASET NAME CARI_ECMEN_VALIDATION.

* Convert the explicit synthetic missing-value code to SPSS system-missing.
RECODE FCSCat21 rCSI Max_coping_behaviourFS ECMEN_exclAsst ECMEN_exclAsst_SMEB expected_CARI_ECMEN
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

IF (ECMEN_exclAsst=1) ECMEN_MEB=1.
IF (ECMEN_exclAsst=0 AND ECMEN_exclAsst_SMEB=1) ECMEN_MEB=2.
IF (ECMEN_exclAsst=0 AND ECMEN_exclAsst_SMEB=0) ECMEN_MEB=3.
RECODE ECMEN_MEB (1=1) (2=3) (3=4) INTO ECMEN_class_4pt.
VARIABLE LABELS ECMEN_class_4pt 'ECMEN 4pt'.
VALUE LABELS ECMEN_class_4pt 1 'Least vulnerable' 3 'Vulnerable' 4 'Highly vulnerable'.

COMPUTE Mean_coping_capacity_ECMEN = MEAN(Max_coping_behaviourFS, ECMEN_class_4pt).
COMPUTE CARI_unrounded_ECMEN = MEAN(FCS_4pt, Mean_coping_capacity_ECMEN).
COMPUTE CARI_ECMEN = RND(CARI_unrounded_ECMEN).
IF (NMISS(FCS_4pt, rCSI, Max_coping_behaviourFS, ECMEN_class_4pt) > 0) CARI_ECMEN = $SYSMIS.
EXECUTE.

* Test assertion: missing matches missing, or calculated value matches expected value.
COMPUTE TEST_PASS = ((MISSING(expected_CARI_ECMEN) AND MISSING(CARI_ECMEN)) OR
                     (NOT MISSING(expected_CARI_ECMEN) AND expected_CARI_ECMEN = CARI_ECMEN)).
VALUE LABELS TEST_PASS 0 'Failed' 1 'Passed'.
FORMATS TEST_PASS (F1.0) CARI_ECMEN expected_CARI_ECMEN (F2.0).
EXECUTE.

TITLE 'CARI-ECMEN complete-case validation: all cases'.
LIST VARIABLES=case_id FCSCat21 rCSI Max_coping_behaviourFS ECMEN_exclAsst ECMEN_exclAsst_SMEB expected_CARI_ECMEN CARI_ECMEN TEST_PASS.
FREQUENCIES VARIABLES=TEST_PASS.

TITLE 'CARI-ECMEN complete-case validation: failures only (expected zero cases)'.
TEMPORARY.
SELECT IF (TEST_PASS = 0).
LIST VARIABLES=case_id expected_CARI_ECMEN CARI_ECMEN TEST_PASS.
