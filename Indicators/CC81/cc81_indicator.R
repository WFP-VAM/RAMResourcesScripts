# CC.8.1 Overall satisfaction with WFP assistance delivery
# Survey Designer: 1 Very satisfied, 2 Satisfied, 3 Unsatisfied.
# Unweighted percentage = 100 x satisfied or very satisfied / valid answers.
# Use the original respondent-level survey CSV, with Survey Designer codes.
# Set the working directory to the repository folder, then click Source.
# This script uses base R; no additional packages are required.

# 1. Load the survey data ---------------------------------------------------
# Enter the full path to your CSV using forward slashes, for example:
# INPUT <- "C:/Monitoring/survey.csv"
# Leave INPUT empty to load the example from the repository's Static folder.
# The original file and the data object are retained unchanged.
INPUT <- ""        # Survey CSV path; blank loads the bundled example.
OUTPUT_FILE <- ""  # Optional full path for a CSV; leave blank to display only.

args <- commandArgs(trailingOnly = TRUE)
if (length(args) >= 1) INPUT <- args[1]
if (length(args) >= 2) OUTPUT_FILE <- args[2]
if (!nzchar(trimws(INPUT))) {
  INPUT <- "Static/CC81/cc81_sample_30.csv"
  if (!file.exists(INPUT)) stop("Set the working directory to the repository folder containing Static, or enter your survey CSV in INPUT.")
  message("Input: bundled example dataset (30 records).")
}
data <- read.csv(INPUT, colClasses = "character", check.names = FALSE,
                 na.strings = "", strip.white = TRUE, fill = FALSE,
                 fileEncoding = "UTF-8-BOM")

# 2. Check the variables and define their labels ----------------------------
# Keep these names and codes as specified in Survey Designer.
# Additional columns in your survey may remain in the source data.
domains <- c(
  HHAsstWFPSatisf = "Overall",
  HHAsstWFPSatisf_Rec = "Safety",
  HHAsstWFPSatisf_Resp = "Respect",
  HHAsstWFPSatisf_Time = "Timeliness",
  HHAsstWFPSatisf_Qual = "Quality",
  HHAsstWFPSatisf_Quan = "Quantity"
)
response_labels <- c("Very satisfied" = 1, "Satisfied" = 2, "Unsatisfied" = 3)
required <- c("RESPConsent", "RESPSex", names(domains))
missing_columns <- setdiff(required, names(data))
if (length(missing_columns)) stop(paste("Missing columns:", paste(missing_columns, collapse = ", ")))
if (anyDuplicated(names(data))) stop("Duplicate column names in the CSV.")
if (!nrow(data)) stop("The survey CSV has no records.")

# 3. Select consenting interviews and define reporting groups ---------------
# Use a working copy so that the complete imported survey remains available.
# RESPConsent: 1 Yes, 0 No. RESPSex: 0 Female, 1 Male.
as_code <- function(x) suppressWarnings(as.numeric(trimws(x)))
survey <- data[which(as_code(data$RESPConsent) == 1), , drop = FALSE]
sex <- as_code(survey$RESPSex)
groups <- list(All = seq_len(nrow(survey)), Female = which(sex == 0),
               Male = which(sex == 1), Unknown = which(!(sex %in% c(0, 1))))

# 4. Calculate the indicator and domain percentages -------------------------
# Each question has its own numerator and denominator.
# Numerator: codes 1 and 2. Denominator: codes 1, 2 and 3.
# Overall satisfaction is taken directly from HHAsstWFPSatisf.
# Missing and invalid answers are excluded from that question's denominator.
summary_rows <- list()
for (group in names(groups)) {
  for (variable in names(domains)) {
    raw_response <- trimws(survey[[variable]][groups[[group]]])
    response <- as_code(raw_response)
    valid <- response %in% unname(response_labels)
    satisfied <- response %in% c(1, 2)
    # Only blank answers are missing. Other unrecognised codes are invalid.
    missing <- is.na(raw_response) | raw_response == ""

    row <- data.frame(
      variable = variable, domain = unname(domains[variable]), sex_group = group,
      n_eligible = length(response), n_valid = sum(valid),
      n_satisfied = sum(satisfied), n_unsatisfied = sum(response == 3, na.rm = TRUE),
      n_satisfied_only = sum(response == 2, na.rm = TRUE),
      n_very_satisfied = sum(response == 1, na.rm = TRUE),
      n_missing = sum(missing), n_invalid = sum(!valid & !missing)
    )

    # A zero denominator produces a missing percentage, not zero percent.
    for (category in c("satisfied", "unsatisfied", "satisfied_only", "very_satisfied")) {
      row[[paste0("pct_", category)]] <- if (row$n_valid > 0) {
        100 * row[[paste0("n_", category)]] / row$n_valid
      } else NA_real_
    }
    summary_rows[[length(summary_rows) + 1]] <- row
  }
}
indicator_summary <- do.call(rbind, summary_rows)

# 5. Prepare clearly labelled result tables --------------------------------
# Keep the complete numeric results in indicator_summary for further use.
# Round only the display tables; saved counts and percentages remain unchanged.
satisfaction_table <- indicator_summary[
  c("domain", "sex_group", "n_valid", "n_satisfied", "pct_satisfied")
]
satisfaction_table$pct_satisfied <- round(satisfaction_table$pct_satisfied, 2)
names(satisfaction_table) <- c(
  "Question", "Sex group", "Valid N", "Satisfied N (1+2)",
  "Satisfied % (1+2)"
)

# Show the three individual response categories for all consenting interviews.
# Their valid N is question-specific, as in the main indicator table.
response_distribution <- indicator_summary[
  indicator_summary$sex_group == "All",
  c("domain", "n_valid", "pct_very_satisfied", "pct_satisfied_only", "pct_unsatisfied")
]
response_distribution[3:5] <- lapply(response_distribution[3:5], round, digits = 2)
names(response_distribution) <- c(
  "Question", "Valid N", "Very satisfied (%)", "Satisfied (%)", "Unsatisfied (%)"
)

# 6. Display the results ----------------------------------------------------
# Overall / All in the first table is CC.8.1. The other rows show domains and
# respondent-sex groups. The second table separates the three response codes.
cat("\nCC.8.1 and domains: satisfied or very satisfied, by respondent sex\n")
print(satisfaction_table, row.names = FALSE)
cat("\nResponse distribution: all consenting interviews\n")
print(response_distribution, row.names = FALSE)
# In RStudio, click a table in the Environment pane to open it.

# 7. Optionally save the complete numeric results ---------------------------
# Enter a NEW CSV filename in OUTPUT_FILE in Step 1 to save indicator_summary.
# Leave it empty for on-screen results only. The destination folder must exist.
if (nzchar(trimws(OUTPUT_FILE))) {
  if (file.exists(OUTPUT_FILE)) stop("Choose a new OUTPUT_FILE; that file already exists.")
  write.csv(indicator_summary, OUTPUT_FILE, row.names = FALSE, na = "")
  cat("Saved:", OUTPUT_FILE, "\n")
}

# 8. Remove temporary calculation objects ----------------------------------
# Retain the source data, consenting survey and final result tables.
rm(summary_rows, raw_response, response, valid, satisfied, missing, row,
   category, variable, group, groups, sex, required, missing_columns, args)
