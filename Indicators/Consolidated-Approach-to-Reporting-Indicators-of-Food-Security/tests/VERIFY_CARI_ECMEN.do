* CARI-ECMEN complete-case validation using synthetic records only.
* Expected result: 11 passed cases and zero failed cases.

clear all
set more off

input str10 case_id FCSCat21 rCSI Max_coping_behaviourFS ECMEN_exclAsst ECMEN_exclAsst_SMEB expected_CARI_ECMEN
"ECMEN-01" 3 0 1 1 1 1
"ECMEN-02" 3 4 2 0 1 2
"ECMEN-03" 2 10 3 0 0 3
"ECMEN-04" 1 20 4 0 0 4
"ECMEN-05" . 0 1 1 1 .
"ECMEN-06" 3 . 1 1 1 .
"ECMEN-07" 3 0 . 0 1 .
"ECMEN-08" 3 0 1 . 1 .
"ECMEN-09" 3 0 1 0 . .
"ECMEN-10" . . . . . .
"ECMEN-11" 3 0 1 1 . .
end

* Candidate calculation section.
recode FCSCat21 (1=4) (2=3) (3=1), generate(FCS_4pt)
label variable FCS_4pt "4pt FCG"
label define FCS_4pt 1 "Acceptable" 3 "Borderline" 4 "Poor"
label values FCS_4pt FCS_4pt

recode FCS_4pt (1=2) if rCSI >= 4
label define FCS_4pt_lbl 1 "Acceptable" 2 "Acceptable and rCSI>=4" 3 "Borderline" 4 "Poor"
label values FCS_4pt FCS_4pt_lbl

gen ECMEN_MEB = .
replace ECMEN_MEB = 1 if ECMEN_exclAsst == 1
replace ECMEN_MEB = 2 if ECMEN_exclAsst == 0 & ECMEN_exclAsst_SMEB == 1
replace ECMEN_MEB = 3 if ECMEN_exclAsst == 0 & ECMEN_exclAsst_SMEB == 0
recode ECMEN_MEB (1=1) (2=3) (3=4), generate(ECMEN_class_4pt)
label variable ECMEN_class_4pt "ECMEN 4pt"
label define ECMEN_class_4pt_lbl 1 "Least vulnerable" 3 "Vulnerable" 4 "Highly vulnerable"
label values ECMEN_class_4pt ECMEN_class_4pt_lbl

egen Mean_coping_capacity_ECMEN = rowmean(Max_coping_behaviourFS ECMEN_class_4pt)
egen CARI_unrounded_ECMEN = rowmean(FCS_4pt Mean_coping_capacity_ECMEN)
gen CARI_ECMEN = round(CARI_unrounded_ECMEN)
replace CARI_ECMEN = . if missing(FCS_4pt, rCSI, Max_coping_behaviourFS, ECMEN_exclAsst, ECMEN_exclAsst_SMEB, ECMEN_class_4pt)

* Test assertion: missing matches missing, or calculated value matches expected value.
gen byte TEST_PASS = (missing(expected_CARI_ECMEN) & missing(CARI_ECMEN)) | ///
    (!missing(expected_CARI_ECMEN) & expected_CARI_ECMEN == CARI_ECMEN)
label define TEST_PASS_lbl 0 "Failed" 1 "Passed"
label values TEST_PASS TEST_PASS_lbl

noi display "CARI-ECMEN complete-case validation: all cases"
list case_id FCSCat21 rCSI Max_coping_behaviourFS ECMEN_exclAsst ECMEN_exclAsst_SMEB expected_CARI_ECMEN CARI_ECMEN TEST_PASS, noobs abbreviate(24)
tabulate TEST_PASS, missing

count if TEST_PASS == 0
if r(N) == 0 {
    noi display as result "All CARI-ECMEN validation cases passed."
}
else {
    noi display as error "CARI-ECMEN validation failed for " r(N) " case(s)."
    list case_id expected_CARI_ECMEN CARI_ECMEN TEST_PASS if TEST_PASS == 0, noobs
}
assert TEST_PASS == 1
