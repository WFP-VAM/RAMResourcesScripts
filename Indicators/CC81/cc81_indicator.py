# CC.8.1 Overall satisfaction with WFP assistance delivery
# Survey Designer: 1 Very satisfied, 2 Satisfied, 3 Unsatisfied.
# Unweighted percentage = 100 x satisfied or very satisfied / valid answers.
# Use the original respondent-level survey CSV, with Survey Designer codes.
# Run this file from your editor or from the command line.
# This script uses Python's standard library; no extra packages are required.

import argparse
import csv
import math
from pathlib import Path

# 1. Load the survey data ---------------------------------------------------
# Enter your CSV path using forward slashes, for example:
# INPUT = "C:/Monitoring/survey.csv"
# Leave INPUT empty to load the example from the repository's Static folder.
# Command-line --input and --output-file take precedence over these settings.
INPUT = ""        # Survey CSV path; blank loads the bundled example.
OUTPUT_FILE = ""  # Optional full CSV path; leave blank to display only.

options = argparse.ArgumentParser(description="Calculate CC.8.1 satisfaction.")
options.add_argument("--input", default=INPUT)
options.add_argument("--output-file", default=OUTPUT_FILE)
settings = options.parse_args()
if not settings.input.strip():
    settings.input = Path(__file__).resolve().parents[2] / "Static/CC81/cc81_sample_30.csv"
    print("Input: bundled example dataset (30 records).")
with open(settings.input, encoding="utf-8-sig", newline="") as input_file:
    reader = csv.DictReader(input_file)
    headers = reader.fieldnames or []
    data = list(reader)

# 2. Check the variables and define their labels ----------------------------
domains = {
    "HHAsstWFPSatisf": "Overall",
    "HHAsstWFPSatisf_Rec": "Safety",
    "HHAsstWFPSatisf_Resp": "Respect",
    "HHAsstWFPSatisf_Time": "Timeliness",
    "HHAsstWFPSatisf_Qual": "Quality",
    "HHAsstWFPSatisf_Quan": "Quantity",
}
response_labels = {1: "Very satisfied", 2: "Satisfied", 3: "Unsatisfied"}
required = ["RESPConsent", "RESPSex", *domains]
missing_columns = set(required) - set(headers)
if missing_columns:
    raise ValueError("Missing columns: " + ", ".join(sorted(missing_columns)))
if len(headers) != len(set(headers)):
    raise ValueError("Duplicate column names in the CSV.")
if not data:
    raise ValueError("The survey CSV has no records.")
if any(None in row or None in row.values() for row in data):
    raise ValueError("Malformed CSV: a row has a different number of fields.")

# Read numeric codes; nonnumeric or infinite values remain invalid.
def as_code(value):
    try:
        number = float(str(value).strip())
        return number if math.isfinite(number) else None
    except (TypeError, ValueError):
        return None

# 3. Select consenting interviews and define reporting groups ---------------
# RESPConsent: 1 Yes, 0 No. RESPSex: 0 Female, 1 Male.
survey = [row for row in data if as_code(row["RESPConsent"]) == 1]
groups = {
    "All": survey,
    "Female": [row for row in survey if as_code(row["RESPSex"]) == 0],
    "Male": [row for row in survey if as_code(row["RESPSex"]) == 1],
    "Unknown": [row for row in survey if as_code(row["RESPSex"]) not in (0, 1)],
}

# 4. Calculate the indicator and domain percentages -------------------------
# Numerator: codes 1 and 2. Denominator: codes 1, 2 and 3.
# Overall satisfaction is taken directly from HHAsstWFPSatisf.
# Missing and invalid answers are excluded from that question's denominator.
indicator_summary = []
for group, interviews in groups.items():
    for variable, domain in domains.items():
        responses = [as_code(row[variable]) for row in interviews]
        counts = {code: responses.count(code) for code in response_labels}
        valid = sum(counts.values())
        missing = sum(row[variable].strip() == "" for row in interviews)
        result = {
            "variable": variable, "domain": domain, "sex_group": group,
            "n_eligible": len(interviews), "n_valid": valid,
            "n_satisfied": counts[1] + counts[2], "n_unsatisfied": counts[3],
            "n_satisfied_only": counts[2], "n_very_satisfied": counts[1],
            "n_missing": missing, "n_invalid": len(interviews) - valid - missing,
        }
        # A zero denominator produces a missing percentage, not zero percent.
        for category in ["satisfied", "unsatisfied", "satisfied_only", "very_satisfied"]:
            result["pct_" + category] = 100 * result["n_" + category] / valid if valid else None
        indicator_summary.append(result)

# 5. Display the indicator and domain percentages ---------------------------
# Overall / All is CC.8.1. Satisfied below includes codes 1 and 2 together.
# indicator_summary holds the complete numeric results without display rounding.
print("\nCC.8.1 and domains: satisfied or very satisfied, by respondent sex")
print(f"{'Domain':<12} {'Sex group':<10} {'Valid N':>8} {'Satisfied N':>12} {'Satisfied %':>12}")
for row in indicator_summary:
    percentage = "" if row["pct_satisfied"] is None else f"{row['pct_satisfied']:.2f}"
    print(f"{row['domain']:<12} {row['sex_group']:<10} {row['n_valid']:>8} "
          f"{row['n_satisfied']:>12} {percentage:>12}")

# 6. Display the three response categories for all consenting interviews -----
# A blank percentage means that the question has no valid answers.
print("\nResponse distribution: all consenting interviews (percent of valid answers)")
print(f"{'Domain':<12} {'Valid N':>8} {'Very satisfied':>16} {'Satisfied':>12} {'Unsatisfied':>12}")
for row in indicator_summary:
    if row["sex_group"] == "All":
        percentages = ["" if row[field] is None else f"{row[field]:.2f}"
                       for field in ("pct_very_satisfied", "pct_satisfied_only", "pct_unsatisfied")]
        print(f"{row['domain']:<12} {row['n_valid']:>8} {percentages[0]:>16} "
              f"{percentages[1]:>12} {percentages[2]:>12}")

# 7. Optionally save the complete numeric results ---------------------------
# Leave OUTPUT_FILE empty for on-screen results only.
# A new CSV contains all 24 rows and all counts and percentages.
# Mode x preserves existing files. The destination folder must already exist.
if settings.output_file.strip():
    with Path(settings.output_file).open("x", encoding="utf-8", newline="") as output_file:
        writer = csv.DictWriter(output_file, fieldnames=list(indicator_summary[0]))
        writer.writeheader()
        writer.writerows(indicator_summary)
    print("Saved:", settings.output_file)
