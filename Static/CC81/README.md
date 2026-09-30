# CC.8.1 sample data

Example data for **CC.8.1 Overall satisfaction with WFP assistance delivery**.

| File | Use |
| --- | --- |
| [cc81_sample_30.csv](cc81_sample_30.csv) | Thirty example respondents for the R and Python indicator scripts. |
| [cc81_sample_30.sps](cc81_sample_30.sps) | The same respondents and eight numeric calculation fields for the SPSS indicator syntax. |

The CSV contains 45 columns, beginning with `SvyDate` and ending with `_xform_id`. It includes the calculation inputs, survey context and illustrative export metadata. The example contains no real personally identifiable information.

## Calculation fields

| Variable | Meaning | Codes |
| --- | --- | --- |
| `RESPConsent` | Consent | 1 Yes; 0 No |
| `RESPSex` | Respondent sex | 0 Female; 1 Male |
| `HHAsstWFPSatisf` | Overall satisfaction | 1 Very satisfied; 2 Satisfied; 3 Unsatisfied |
| `HHAsstWFPSatisf_Rec` | Safety | Same satisfaction codes |
| `HHAsstWFPSatisf_Resp` | Respect | Same satisfaction codes |
| `HHAsstWFPSatisf_Time` | Timeliness | Same satisfaction codes |
| `HHAsstWFPSatisf_Qual` | Quality | Same satisfaction codes |
| `HHAsstWFPSatisf_Quan` | Quantity | Same satisfaction codes |

Among consenting respondents, the percentage satisfied is `100 × number answering 1 or 2 / number answering 1, 2 or 3`, calculated separately for each question. Missing and invalid responses are excluded from that question's denominator. A zero denominator produces a missing percentage. Results are unweighted. Overall satisfaction comes from the overall question, not an average of the domain results.

## Run the example

Keep the repository folder structure. For R and SPSS, set the working directory to the repository root containing `Indicators` and `Static`.

- **R:** open [cc81_indicator.R](../../Indicators/CC81/cc81_indicator.R), leave `INPUT` empty in Step 1, and run the complete script.
- **Python:** open [cc81_indicator.py](../../Indicators/CC81/cc81_indicator.py), leave `INPUT` empty in Step 1, and run the file in your Python editor. The script locates the sample relative to its own location.
- **SPSS:** open [cc81_indicator.sps](../../Indicators/CC81/cc81_indicator.sps), leave `!CC81Input INPUT=''.` in Step 1, and choose **Run > All**. Close previous `CC81Results` and `CC81Sample` datasets before rerunning the example.

Results display on screen; saving is optional. The example's **Overall / All** result is **15 satisfied or very satisfied out of 28 valid responses: 53.571429%**, displayed as 53.57% in the R/Python tables.

## Use survey data

Prepare one row per respondent from the intended survey data, preferably, use standard variables and numeric codes as per survey designer. Follow [the repository's export instructions](https://github.com/WFP-VAM/RAMResourcesScripts/blob/main/Static/README.md) for MoDa/ODK CSV data. Preserve the original export and leave unanswered values blank.

In R/Python, enter the survey CSV path in `INPUT`. In SPSS, activate the original numeric survey dataset and use `!CC81Input INPUT='CC81Survey'.` in Step 1. The syntax calculates in a copy and switches off weights, filters and split-file settings in that copy; prepare the intended reporting population as actual rows beforehand. Follow the comments in each script for input selection and optional saving.

## Ordinal regression (optional)

The [R regression](../../Analysis/CC81/cc81_regression.R), [Python regression](../../Analysis/CC81/cc81_regression.py) and [SPSS regression](../../Analysis/CC81/cc81_regression.sps) examine associations between overall satisfaction and the five domain ratings. Use the original respondent-level survey, with the same input selection described above.

R regression uses `MASS`; SPSS regression uses the `PLUM` procedure. Python regression requires `numpy>=1.26,<3`, `pandas>=2.2,<4`, `scipy>=1.12,<2`, `statsmodels>=0.14.4,<0.16` and `patsy>=1.0,<2`.

The scripts require at least 100 complete cases and 10 cases in each overall response category before fitting a model. These are script execution safeguards, not WFP sampling standards. The bundled 30-record sample has 28 complete cases, so it loads but does not fit the regression: R/Python report insufficient cases and SPSS reports no cases for estimation. Use a suitable survey dataset for the model.

The model treats domain ratings as numeric predictors and assumes proportional odds. Results describe associations, not causal effects or percentage contributions. Review convergence, standard errors and model diagnostics before interpretation. Saving the coefficient table for interpretation (optional).
