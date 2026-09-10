# 1. Load the packages you need for this analysis.
pkgs <- c("tidyverse", "labelled", "expss", "readr")
to_install <- pkgs[!pkgs %in% installed.packages()[, "Package"]]
if (length(to_install) > 0) install.packages(to_install)

library(tidyverse)
library(labelled)
library(expss)
library(readr)

# 2. Load your dataset.
# IMPORTANT:
# Replace the example below with the full path to your csv file.
# Use forward slashes "/" in the path.

# Example (do NOT copy as-is):
# data <- read_csv("C:/Users/name.lastname/Documents/YourFolder/HFA_Survey_Data.csv")

# Write your own path and file name here:
data <- read_csv("C:/.../.../HFA_Survey_Data.csv")

# 3. Clean missing values.
data[] <- lapply(data, function(x) {
  if (is.character(x)) {
    x <- trimws(x)
    x[tolower(x) %in% c("na", "nan", "n/a")] <- NA
  }
  x
})

# 4. Pre-processing of food security indicators (FCS, rCSI, and LCS-FS)
# 4.1 FCS calculation.
fcs_vars <- c("FCSStap","FCSPulse","FCSDairy","FCSPr","FCSVeg",
              "FCSFruit","FCSFat","FCSSugar","FCSCond")

for (v in fcs_vars) {
  data[[v]][is.na(data[[v]])] <- 0
  data[[v]][data[[v]] > 7] <- 7
}

data$FCS <- with(data,
                 FCSStap*2 + FCSPulse*3 + FCSDairy*4 +
                 FCSPr*4 + FCSVeg + FCSFruit +
                 FCSFat*0.5 + FCSSugar*0.5)

# 4.2 rCSI calculation.
data <- data %>%
  mutate(rCSI = rCSILessQlty +
                 (rCSIBorrow * 2) +
                 rCSIMealNb +
                 rCSIMealSize +
                 (rCSIMealAdult * 3))

# 4.3 LCSI calculation.
positive_responses <- c(20, 30)

stress_vars    <- grep("^(Lcs_stress|LcsR_stress)", names(data), value = TRUE)
crisis_vars    <- grep("^(Lcs_crisis|LcsR_crisis)", names(data), value = TRUE)
emergency_vars <- grep("^(Lcs_em|LcsR_em)", names(data), value = TRUE)

get_top_n_vars <- function(data, vars, n) {
  counts <- sapply(vars, function(v) sum(data[[v]] %in% positive_responses, na.rm = TRUE))
  names(sort(counts, decreasing = TRUE))[1:min(n, length(counts))]
}

top_stress    <- get_top_n_vars(data, stress_vars, 4)
top_crisis    <- get_top_n_vars(data, crisis_vars, 3)
top_emergency <- get_top_n_vars(data, emergency_vars, 3)

data <- data %>%
  mutate(
    stress_coping_FS    = as.integer(rowSums(across(all_of(top_stress),    ~ .x %in% positive_responses)) > 0),
    crisis_coping_FS    = as.integer(rowSums(across(all_of(top_crisis),    ~ .x %in% positive_responses)) > 0),
    emergency_coping_FS = as.integer(rowSums(across(all_of(top_emergency), ~ .x %in% positive_responses)) > 0)
  )

selected_vars <- c(top_stress, top_crisis, top_emergency)

data <- data %>%
  mutate(
    any_non_missing = rowSums(!is.na(select(., all_of(selected_vars)))) > 0,
    LCSI = case_when(
      !any_non_missing         ~ NA_real_,
      emergency_coping_FS == 1 ~ 4,
      crisis_coping_FS    == 1 ~ 3,
      stress_coping_FS    == 1 ~ 2,
      TRUE                     ~ 1
    )
  )

# 4.4 Categorization of rCSI.
data <- data %>%
  mutate(CSICat = case_when(
    rCSI <= 3  ~ 1,
    rCSI <= 18 ~ 2,
    TRUE       ~ 3
  ))

# 5. Run a function to compute IPC + HFA + shocks for the two FCS thresholds (21/35 and 28/42).
compute_HFA_IPC <- function(data, low_thr, high_thr) {

  # 5.1 FCS categorisation.
  data <- data %>%
    mutate(
      FCSCat = cut(
        FCS,
        breaks = c(0, low_thr, high_thr, Inf),
        include.lowest = TRUE,
        labels = FALSE
      )
    )

  # 5.2 FC_cell matrix calculation.
  data <- data %>%
    mutate(FC_cell = case_when(
      FCSCat == 3 & CSICat == 1 & LCSI == 1 ~ 1,
      FCSCat == 3 & CSICat == 1 & LCSI == 2 ~ 2,
      FCSCat == 3 & CSICat == 1 & LCSI == 3 ~ 3,
      FCSCat == 3 & CSICat == 1 & LCSI == 4 ~ 4,
      FCSCat == 2 & CSICat == 1 & LCSI == 1 ~ 5,
      FCSCat == 2 & CSICat == 1 & LCSI == 2 ~ 6,
      FCSCat == 2 & CSICat == 1 & LCSI == 3 ~ 7,
      FCSCat == 2 & CSICat == 1 & LCSI == 4 ~ 8,
      FCSCat == 1 & CSICat == 1 & LCSI == 1 ~ 9,
      FCSCat == 1 & CSICat == 1 & LCSI == 2 ~ 10,
      FCSCat == 1 & CSICat == 1 & LCSI == 3 ~ 11,
      FCSCat == 1 & CSICat == 1 & LCSI == 4 ~ 12,
      FCSCat == 3 & CSICat == 2 & LCSI == 1 ~ 13,
      FCSCat == 3 & CSICat == 2 & LCSI == 2 ~ 14,
      FCSCat == 3 & CSICat == 2 & LCSI == 3 ~ 15,
      FCSCat == 3 & CSICat == 2 & LCSI == 4 ~ 16,
      FCSCat == 2 & CSICat == 2 & LCSI == 1 ~ 17,
      FCSCat == 2 & CSICat == 2 & LCSI == 2 ~ 18,
      FCSCat == 2 & CSICat == 2 & LCSI == 3 ~ 19,
      FCSCat == 2 & CSICat == 2 & LCSI == 4 ~ 20,
      FCSCat == 1 & CSICat == 2 & LCSI == 1 ~ 21,
      FCSCat == 1 & CSICat == 2 & LCSI == 2 ~ 22,
      FCSCat == 1 & CSICat == 2 & LCSI == 3 ~ 23,
      FCSCat == 1 & CSICat == 2 & LCSI == 4 ~ 24,
      FCSCat == 3 & CSICat == 3 & LCSI == 1 ~ 25,
      FCSCat == 3 & CSICat == 3 & LCSI == 2 ~ 26,
      FCSCat == 3 & CSICat == 3 & LCSI == 3 ~ 27,
      FCSCat == 3 & CSICat == 3 & LCSI == 4 ~ 28,
      FCSCat == 2 & CSICat == 3 & LCSI == 1 ~ 29,
      FCSCat == 2 & CSICat == 3 & LCSI == 2 ~ 30,
      FCSCat == 2 & CSICat == 3 & LCSI == 3 ~ 31,
      FCSCat == 2 & CSICat == 3 & LCSI == 4 ~ 32,
      FCSCat == 1 & CSICat == 3 & LCSI == 1 ~ 33,
      FCSCat == 1 & CSICat == 3 & LCSI == 2 ~ 34,
      FCSCat == 1 & CSICat == 3 & LCSI == 3 ~ 35,
      FCSCat == 1 & CSICat == 3 & LCSI == 4 ~ 36,
      TRUE ~ NA_real_
    ))

  # 5.3 IPC-informed phases calculation.
  data <- data %>%
    mutate(IPC_phase = case_when(
      FC_cell %in% c(1, 5) ~ 1,
      FC_cell %in% c(2, 6, 9, 10, 13, 14, 17, 18, 21, 25, 29) ~ 2,
      FC_cell %in% c(3, 4, 7, 15, 16, 19, 22, 26, 27, 30, 33, 34) ~ 3,
      FC_cell %in% c(8, 11, 12, 20, 23, 24, 28, 31, 32, 35, 36) ~ 4,
      TRUE ~ NA_real_
    ))

  # 5.4 HFA need calculation.
  data <- data %>%
    mutate(HFA_need = case_when(
      IPC_phase %in% c(1, 2) ~ 0,
      IPC_phase %in% c(3, 4) ~ 1,
      TRUE ~ NA_real_
    ))

  # 5.5 Create IPC-informed phases table.
  IPC_labels <- tibble(
    IPC_phase = c(1, 2, 3, 4),
    `IPC-informed Phase` = c("1. None", "2. Stressed", "3. Crisis", "4. Emergency")
  )

  IPC_table_raw <- data %>%
    filter(!is.na(IPC_phase)) %>%
    count(IPC_phase) %>%
    left_join(IPC_labels, by = "IPC_phase") %>%
    mutate(Percent_raw = n / sum(n) * 100)

  IPC_table_adj <- IPC_table_raw %>%
    mutate(Percent_round = round(Percent_raw))

  IPC_table_adj$Percent_round[nrow(IPC_table_adj)] <-
    100 - sum(IPC_table_adj$Percent_round[-nrow(IPC_table_adj)])

  IPC_table_final <- IPC_table_adj %>%
    select(`IPC-informed Phase`, Percent = Percent_round) %>%
    bind_rows(tibble(`IPC-informed Phase` = "Total", Percent = 100)) %>%
    mutate(Percent = paste0(Percent, "%"))

  # 5.6 Climate shocks.
  climate_vars <- c("HHClimFloods","HHClimDroughts","HHStorms","HHHeatWave","HHWildFire")

  climate_labels <- tibble(
    shock_type = climate_vars,
    Shock = c("Floods","Droughts","Storms / Cyclone","Heat Wave","Wildfire")
  )

  climate_affected <- data %>%
    filter(!is.na(IPC_phase)) %>%
    summarise(across(
      all_of(climate_vars),
      ~ round(mean(.x %in% c(1, 2, 3), na.rm = TRUE) * 100, 1)
    )) %>%
    pivot_longer(everything(), names_to = "shock_type", values_to = "Percent affected") %>%
    left_join(climate_labels, by = "shock_type") %>%
    select(Shock, `Percent affected`) %>%
    mutate(`Percent affected` = paste0(`Percent affected`, "%"))

  # 5.7 Climate severity.
  climate_severity <- data %>%
    filter(!is.na(IPC_phase)) %>%
    pivot_longer(
      all_of(climate_vars),
      names_to = "shock_type",
      values_to = "severity"
    ) %>%
    filter(severity %in% c(1, 2, 3)) %>%
    mutate(
      Severity = case_when(
        severity == 1 ~ "Low",
        severity == 2 ~ "Medium",
        severity == 3 ~ "High"
      )
    ) %>%
    count(shock_type, Severity) %>%
    group_by(shock_type) %>%
    mutate(Percent = round(n / sum(n) * 100, 1)) %>%
    ungroup() %>%
    left_join(climate_labels, by = "shock_type") %>%
    select(Shock, Severity, Percent) %>%
    mutate(Percent = paste0(Percent, "%"))

  # 5.8 SEI shocks.
  sei_vars_all <- c(
    "HHSEINew_SEISlides","HHSEINew_SEIVolcano","HHSEINew_SEIFPrice",
    "HHSEINew_SEICost","HHSEINew_SEIElec","HHSEINew_SEIWater",
    "HHSEINew_SEIRemit","HHSEINew_SEIUnemp","HHSEINew_SEILowPrice",
    "HHSEINew_SEILowWage","HHSEINew_SEIHouse","HHSEINew_SEIConflict",
    "HHSEINew_SEIInstab","HHSEINew_SEIMovement","HHSEINew_SEIDispl",
    "HHSEINew_SEIGender","HHSEINew_SEIDiscr","HHSEINew_SEIRaid",
    "HHSEINew_SEICropDis","HHSEINew_SEILiveDis","HHSEINew_SEIHumDis",
    "HHSEINew_SEIFarmLoss","HHSEINew_SEITheft","HHSEINew_SEIHouseLoss",
    "HHSEINew_SEIAsst"
  )

  sei_vars <- intersect(sei_vars_all, names(data))

  sei_labels <- tibble(
    sei_shock = sei_vars_all,
    Shock = c(
      "Landslides / Rockfalls","Volcanic activity","High food prices",
      "Increased cost of inputs / fuel / rent","Electricity cuts / blackouts",
      "Water supply shortages","Reduced remittances",
      "Unemployment / lack of livelihood opportunities",
      "Low prices for selling products","Lower daily wage rates",
      "Unsafe to leave home / access livelihoods","Conflict / violence",
      "Political instability / civil unrest","Movement restrictions (curfew, checkpoints)",
      "Displacement / forced movement","Gender discrimination / harassment",
      "Other discrimination / harassment","Livestock raiding",
      "Crop pests / diseases","Livestock disease / injury / death",
      "Illness / injury / death in household","Loss of farming / grazing land",
      "Theft / robbery","Loss of home or rental property",
      "Delays or cuts in humanitarian assistance"
    )
  )

  sei_shocks_summary <- data %>%
    filter(!is.na(IPC_phase)) %>%
    summarise(across(
      all_of(sei_vars),
      ~ round(mean(.x == 1, na.rm = TRUE) * 100, 1)
    )) %>%
    pivot_longer(everything(), names_to = "sei_shock", values_to = "Percent affected") %>%
    left_join(sei_labels, by = "sei_shock") %>%
    select(Shock, `Percent affected`) %>%
    mutate(`Percent affected` = paste0(`Percent affected`, "%"))

  # 5.9 Return outputs.
  list(
    data = data,
    IPC_table_final = IPC_table_final,
    HFA_sample_size = sum(!is.na(data$IPC_phase)),
    climate_affected = climate_affected,
    climate_severity = climate_severity,
    sei_shocks_summary = sei_shocks_summary
  )
}

# 6. Run two versions using the two FCS thresholds.
results_21_35 <- compute_HFA_IPC(data, 21, 35)
results_28_42 <- compute_HFA_IPC(data, 28, 42)

# 7. Print outputs

# You should select the results based on the Food Consumption Score thresholds 
# officially used in your country. Using the correct national thresholds ensures 
# that the HFA classification reflects local dietary patterns and avoids 
# misinterpretation or misclassification of food security outcomes.
 

# Results using 21/35 FCS thresholds.
results_21_35$HFA_sample_size
results_21_35$IPC_table_final
results_21_35$climate_affected
results_21_35$climate_severity
results_21_35$sei_shocks_summary

# Results using 28/42 FCS thresholds.
results_28_42$HFA_sample_size
results_28_42$IPC_table_final
results_28_42$climate_affected
results_28_42$climate_severity
results_28_42$sei_shocks_summary
