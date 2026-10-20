# CC.8.1 Factors associated with overall satisfaction
# Optional unweighted ordinal logistic regression using Survey Designer codes.
# Enter INPUT, or leave blank for the bundled example, then click Source. Results describe associations, not causation.

# 1. Load the survey data. MASS is included with standard R installations.
INPUT <- ""        # Survey CSV path; blank loads the bundled example.
OUTPUT_FILE <- ""  # Optional full path for the coefficients CSV.
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

# 2. Identify the Survey Designer variables and response labels.
domains <- c(HHAsstWFPSatisf = "Overall", HHAsstWFPSatisf_Rec = "Safety",
             HHAsstWFPSatisf_Resp = "Respect", HHAsstWFPSatisf_Time = "Timeliness",
             HHAsstWFPSatisf_Qual = "Quality", HHAsstWFPSatisf_Quan = "Quantity")
required <- c("RESPConsent", "RESPSex", names(domains))
missing_columns <- setdiff(required, names(data))
if (length(missing_columns)) stop(paste("Missing columns:", paste(missing_columns, collapse = ", ")))
if (anyDuplicated(names(data))) stop("Duplicate column names in the CSV.")
if (!nrow(data)) stop("The survey CSV has no records.")

# 3. Keep consenting interviews with valid answers to all six questions.
# Survey Designer codes: 1 Very satisfied, 2 Satisfied, 3 Unsatisfied.
as_code <- function(x) suppressWarnings(as.numeric(trimws(x)))
survey <- data[which(as_code(data$RESPConsent) == 1), names(domains), drop = FALSE]
n_eligible <- nrow(survey)
survey[] <- lapply(survey, function(x) {
  response <- as_code(x)
  response[!(response %in% 1:3)] <- NA_real_
  response
})
survey <- survey[complete.cases(survey), , drop = FALSE]

# Reverse the analysis scale: 1 Unsatisfied, 2 Satisfied, 3 Very satisfied.
survey[] <- lapply(survey, function(x) 4 - x)

# 4. Check the model data. These are execution safeguards, not sampling standards.
if (nrow(survey) < 100) stop(paste("Regression was not fitted:", nrow(survey),
  "complete cases; at least 100 are required. Supply a suitable survey dataset."))
if (length(unique(survey[[1]])) != 3 || min(table(survey[[1]])) < 10)
  stop("At least 10 complete cases are required in each overall response category.")
if (any(vapply(survey[-1], function(x) length(unique(x)) < 2, logical(1))))
  stop("A domain predictor is constant.")
if (qr(cbind(1, as.matrix(survey[-1])))$rank < 6) stop("The predictors are collinear.")

# 5. Fit the ordinal logistic model: overall satisfaction on five domain ratings.
# Domain ratings are numeric; the model assumes equal increments and proportional odds.
survey$HHAsstWFPSatisf <- ordered(survey$HHAsstWFPSatisf, levels = 1:3)
model <- MASS::polr(
  HHAsstWFPSatisf ~ HHAsstWFPSatisf_Rec + HHAsstWFPSatisf_Resp +
    HHAsstWFPSatisf_Time + HHAsstWFPSatisf_Qual + HHAsstWFPSatisf_Quan,
  data = survey, Hess = TRUE, method = "logistic",
  control = list(maxit = 1000, reltol = 1e-10)
)
if (model$convergence != 0) stop("The model did not converge.")
beta <- coef(model)
standard_error <- sqrt(diag(vcov(model)))[names(beta)]
if (any(!is.finite(standard_error))) stop("Standard errors are not finite.")
regression_coefficients <- data.frame(
  variable = names(beta), domain = unname(domains[names(beta)]),
  beta = as.numeric(beta), se = as.numeric(standard_error),
  odds_ratio = exp(beta), ci_lower = exp(beta - qnorm(.975) * standard_error),
  ci_upper = exp(beta + qnorm(.975) * standard_error),
  p_value = 2 * pnorm(-abs(beta / standard_error))
)
model_diagnostics <- data.frame(
  n_eligible = n_eligible, n_complete = nrow(survey),
  n_excluded_incomplete = n_eligible - nrow(survey),
  converged = TRUE, log_likelihood = as.numeric(logLik(model)), aic = AIC(model)
)

# 6. Display coefficients and diagnostics. An odds ratio concerns a one-category
# improvement in a domain, adjusting for the other four domain ratings.
print(regression_coefficients, row.names = FALSE, digits = 8)
print(model_diagnostics, row.names = FALSE, digits = 12)
print(summary(model))
cat("Proportional odds is assumed and is not tested by this R script.\n")

# 7. Optionally save coefficients. Model objects remain in the R Environment.
if (nzchar(trimws(OUTPUT_FILE))) {
  if (file.exists(OUTPUT_FILE)) stop("Choose a new OUTPUT_FILE; that file already exists.")
  write.csv(regression_coefficients, OUTPUT_FILE, row.names = FALSE)
  cat("Saved:", OUTPUT_FILE, "\n")
}
