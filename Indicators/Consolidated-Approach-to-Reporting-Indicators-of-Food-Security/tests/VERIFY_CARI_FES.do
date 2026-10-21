* CARI-FES complete-case validation using synthetic records only.
* Expected result: 12 passed cases and zero failed cases.

clear all
set more off

input str8 case_id FCSCat21 rCSI Max_coping_behaviourFS FES Foodexp_4pt expected_CARI_FES
"FES-01" 3 0 1 1 1 1
"FES-02" 3 4 2 2 3 2
"FES-03" 2 10 3 3 4 3
"FES-04" 1 20 4 4 4 4
"FES-05" . 0 1 1 1 .
"FES-06" 3 . 1 1 1 .
"FES-07" 3 0 . 3 3 .
"FES-08" 3 0 1 . . .
"FES-09" 3 0 . . . .
"FES-10" . . . . . .
"FES-11" 3 0 1 . 1 .
"FES-12" 3 0 1 .8 . .
end

* Candidate calculation section.
recode FCSCat21 (1=4) (2=3) (3=1), generate(FCS_4pt)
label variable FCS_4pt "4pt FCG"
label define FCS_4pt 1 "Acceptable" 3 "Borderline" 4 "Poor"
label values FCS_4pt FCS_4pt

recode FCS_4pt (1=2) if rCSI >= 4
label define FCS_4pt_lbl 1 "Acceptable" 2 "Acceptable and rCSI>=4" 3 "Borderline" 4 "Poor"
label values FCS_4pt FCS_4pt_lbl

egen Mean_coping_capacity_FES = rowmean(Max_coping_behaviourFS Foodexp_4pt)
egen CARI_unrounded_FES = rowmean(FCS_4pt Mean_coping_capacity_FES)
gen CARI_FES = round(CARI_unrounded_FES)
replace CARI_FES = . if missing(FCS_4pt, rCSI, Max_coping_behaviourFS, FES, Foodexp_4pt)

* Test assertion: missing matches missing, or calculated value matches expected value.
gen byte TEST_PASS = (missing(expected_CARI_FES) & missing(CARI_FES)) | ///
    (!missing(expected_CARI_FES) & expected_CARI_FES == CARI_FES)
label define TEST_PASS_lbl 0 "Failed" 1 "Passed"
label values TEST_PASS TEST_PASS_lbl

noi display "CARI-FES complete-case validation: all cases"
list case_id FCSCat21 rCSI Max_coping_behaviourFS FES Foodexp_4pt expected_CARI_FES CARI_FES TEST_PASS, noobs abbreviate(24)
tabulate TEST_PASS, missing

count if TEST_PASS == 0
if r(N) == 0 {
    noi display as result "All CARI-FES validation cases passed."
}
else {
    noi display as error "CARI-FES validation failed for " r(N) " case(s)."
    list case_id expected_CARI_FES CARI_FES TEST_PASS if TEST_PASS == 0, noobs
}
assert TEST_PASS == 1
