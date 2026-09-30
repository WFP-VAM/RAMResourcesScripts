* Encoding: UTF-8.
* CC.8.1 bundled example: the eight calculation fields from cc81_sample_30.csv.
* Contains the same 30 example respondents, in the same order, as the CSV.
* Called by the indicator and regression syntax when INPUT is blank.

DATA LIST FREE /
 RESPConsent (F10.0) RESPSex (F10.0)
 HHAsstWFPSatisf (F10.0) HHAsstWFPSatisf_Rec (F10.0)
 HHAsstWFPSatisf_Resp (F10.0) HHAsstWFPSatisf_Time (F10.0)
 HHAsstWFPSatisf_Qual (F10.0) HHAsstWFPSatisf_Quan (F10.0).
BEGIN DATA
1 0 3 2 3 2 2 2
1 1 2 3 1 1 2 3
1 0 1 3 1 2 2 2
1 1 3 3 1 1 3 2
1 0 3 2 3 3 2 1
1 1 2 3 2 1 2 3
1 0 3 2 2 1 2 3
1 1 2 2 2 1 3 1
1 0 1 2 2 2 1 2
1 1 3 2 2 2 2 3
1 0 1 2 1 2 1 3
1 1 3 2 2 3 3 2
1 0 1 2 2 2 1 2
1 1 3 2 3 2 3 2
1 0 2 3 1 1 1 3
1 1 1 3 1 1 1 2
1 0 1 3 1 1 1 1
1 1 2 2 2 1 2 1
1 0 3 2 3 3 2 2
1 1 2 3 3 2 3 2
1 0 3 3 2 1 2 2
1 1 3 2 2 2 3 2
1 0 3 2 1 2 2 2
1 1 3 2 2 2 2 2
1 0 1 3 3 1 1 1
1 1 2 2 1 2 2 1
1 0 1 2 2 2 1 3
1 1 3 2 1 2 3 2
0 . . . . . . .
0 . . . . . . .
END DATA.
EXECUTE.
DATASET NAME CC81Sample.
