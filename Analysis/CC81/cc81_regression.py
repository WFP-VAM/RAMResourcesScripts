# CC.8.1 Factors associated with overall satisfaction
# Optional unweighted ordinal logistic regression using Survey Designer codes.
# Enter INPUT, or leave blank for the bundled example, and run. Results describe associations, not causation.

import argparse
import csv
from pathlib import Path
import warnings
import numpy as np
import pandas as pd
from statsmodels.miscmodels.ordinal_model import OrderedModel

# 1. Load the survey data.
INPUT = ""        # Survey CSV path; blank loads the bundled example.
OUTPUT_FILE = ""  # Optional full path for the coefficients CSV.
options = argparse.ArgumentParser(description="CC.8.1 ordinal regression.")
options.add_argument("--input", default=INPUT)
options.add_argument("--output-file", default=OUTPUT_FILE)
settings = options.parse_args()
if not settings.input.strip():
    settings.input = Path(__file__).resolve().parents[2] / "Static/CC81/cc81_sample_30.csv"
    print("Input: bundled example dataset (30 records).")
with open(settings.input, encoding="utf-8-sig", newline="") as input_file:
    reader = csv.DictReader(input_file)
    headers = reader.fieldnames or []
    rows = list(reader)

# 2. Identify the Survey Designer variables and response labels.
domains = {
    "HHAsstWFPSatisf": "Overall", "HHAsstWFPSatisf_Rec": "Safety",
    "HHAsstWFPSatisf_Resp": "Respect", "HHAsstWFPSatisf_Time": "Timeliness",
    "HHAsstWFPSatisf_Qual": "Quality", "HHAsstWFPSatisf_Quan": "Quantity",
}
required = ["RESPConsent", "RESPSex", *domains]
missing_columns = set(required) - set(headers)
if missing_columns:
    raise ValueError("Missing columns: " + ", ".join(sorted(missing_columns)))
if len(headers) != len(set(headers)):
    raise ValueError("Duplicate column names in the CSV.")
if not rows:
    raise ValueError("The survey CSV has no records.")
if any(None in row or None in row.values() for row in rows):
    raise ValueError("Malformed CSV: a row has a different number of fields.")
data = pd.DataFrame(rows)

# 3. Keep consenting interviews with valid answers to all six questions.
# Survey Designer: 1 Very satisfied, 2 Satisfied, 3 Unsatisfied.
consent = pd.to_numeric(data["RESPConsent"].str.strip(), errors="coerce")
survey = data.loc[consent == 1, list(domains)].apply(pd.to_numeric, errors="coerce")
n_eligible = len(survey)
survey = survey.loc[survey.isin([1, 2, 3]).all(axis=1)].astype(float)
survey = 4 - survey  # Analysis scale: 1 Unsatisfied through 3 Very satisfied.

# 4. Check model data. These are execution safeguards, not sampling standards.
if len(survey) < 100:
    raise ValueError(f"Regression was not fitted: {len(survey)} complete cases; "
                     "at least 100 are required. Supply a suitable survey dataset.")
outcome = survey["HHAsstWFPSatisf"]
predictors = survey[list(domains)[1:]]
if outcome.nunique() != 3 or outcome.value_counts().min() < 10:
    raise ValueError("At least 10 complete cases are required in each overall response category.")
if (predictors.nunique() < 2).any():
    raise ValueError("A domain predictor is constant.")
if np.linalg.matrix_rank(np.column_stack([np.ones(len(survey)), predictors])) < 6:
    raise ValueError("The predictors are collinear.")

# 5. Fit the ordinal logistic model: overall satisfaction on five domain ratings.
# Domain ratings are numeric; the model assumes equal increments and proportional odds.
with warnings.catch_warnings(record=True) as model_warnings:
    warnings.simplefilter("always")
    model = OrderedModel(outcome, predictors, distr="logit").fit(
        method="bfgs", maxiter=1000, gtol=1e-8, disp=False
    )
if not model.mle_retvals.get("converged") or not np.isfinite(model.bse).all():
    raise ValueError("The model did not converge or standard errors are not finite.")
confidence_interval = model.conf_int()
regression_coefficients = pd.DataFrame({
    "variable": predictors.columns,
    "domain": [domains[variable] for variable in predictors],
    "beta": model.params[predictors.columns].to_numpy(),
    "se": model.bse[predictors.columns].to_numpy(),
    "odds_ratio": np.exp(model.params[predictors.columns]).to_numpy(),
    "ci_lower": np.exp(confidence_interval.loc[predictors.columns, 0]).to_numpy(),
    "ci_upper": np.exp(confidence_interval.loc[predictors.columns, 1]).to_numpy(),
    "p_value": model.pvalues[predictors.columns].to_numpy(),
})
model_diagnostics = pd.DataFrame([{
    "n_eligible": n_eligible, "n_complete": len(survey),
    "n_excluded_incomplete": n_eligible - len(survey),
    "converged": True, "log_likelihood": float(model.llf), "aic": float(model.aic),
}])

# 6. Display coefficients and diagnostics. An odds ratio concerns a one-category
# improvement in a domain, adjusting for the other four domain ratings.
print(regression_coefficients.to_string(index=False))
print(model_diagnostics.to_string(index=False))
print(model.summary())
for message in model_warnings:
    print("Model warning:", message.message)
print("Proportional odds is assumed and is not tested by this Python script.")

# 7. Optionally save coefficients. Mode x prevents overwriting an existing file.
if settings.output_file.strip():
    with Path(settings.output_file).open("x", encoding="utf-8", newline="") as output_file:
        regression_coefficients.to_csv(output_file, index=False)
    print("Saved:", settings.output_file)
