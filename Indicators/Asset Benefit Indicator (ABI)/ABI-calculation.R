# 1. Load the packages you need for this analysis.
#    If any of these are missing, install them first.
pkgs <- c("tidyverse", "labelled", "readr")
to_install <- pkgs[!pkgs %in% installed.packages()[, "Package"]]
if (length(to_install) > 0) install.packages(to_install)

library(tidyverse)
library(labelled)
library(readr)

# 2. Load your dataset.
# IMPORTANT:
# Replace the example below with the full path to your csv file.
# Use forward slashes "/" in the path.

# Example (do NOT copy as-is):
# data <- read_csv("C:/Users/name.lastname/Documents/YourFolder/ABI_Survey_Data.csv")

# Write your own path and file name here:
data <- read_csv("C:/.../.../ABI_Survey_Data.csv")

# 3. Clean missing values.
data[] <- lapply(data, function(x) {
  if (is.character(x)) {
    x <- trimws(x)
    x[tolower(x) %in% c("na", "nan", "n/a")] <- NA
  }
  x
})

# 4. Assign variable and value labels.
# Variable labels.
var_label(data$HHFFAPart) <- "Have you or any of your household member participated in the asset creation activities and received a food assistance transfer?"
var_label(data$HHAssetProtect) <- "Do you think that the assets that were built or rehabilitated in your community are better protecting your household, its belongings and its production capacities (fields, equipment, etc.) from sudden onset natural shocks (floods, mudslides, landslides, etc.)?"
var_label(data$HHAssetWaterAccess) <- "Do you think that the assets that were built or rehabilitated in your community have improved your household water access/availability due to rehabilitated irrigation systems, restored water points, and water conservation practices?"
var_label(data$HHAssetProduct) <- "Do you think that the assets that were built or rehabilitated in your community have allowed your household to increase or diversify its production due to greater water availability and/or soil fertility (e.g., increased or diversified production in agriculture, livestock or other)?"
var_label(data$HHAssetAccess) <- "Do you think that the assets that were built or rehabilitated in your community have improved or restored the ability of your household to access markets and/or basic services due to roads and community infrastructure built or restored (schools, grain stores, medical centers, sanitation, waste management facilities, etc.)?"
var_label(data$HHAssetEnv) <- "Do you think that the assets that were built or rehabilitated in your community have improved your natural environment due to land stabilization/rehabilitation, afforestation (for example more vegetal cover, water availability, water table increased, increase in indigenous flora/fauna, less erosion or siltation of field, etc.)?"
var_label(data$HHTrainingAsset) <- "Do you think that the trainings and other support provided in your community have improved your household’s and community's ability to manage and maintain livelihood assets due to better knowledge, more time availability, or financial resources?"
var_label(data$HHAssetDecHardship) <- "Do you think that the assets that were built or rehabilitated in your community have reduced hardship and/or increased time availability for any of your family members (including women and children)?"

# Value labels.
data <- data %>%
  dplyr::mutate(across(
    c(HHAssetProtect, HHAssetWaterAccess, HHAssetProduct,
      HHAssetAccess, HHAssetEnv, HHTrainingAsset, HHAssetDecHardship),
    ~ labelled(.,
               labels = c("No" = 0,
                          "Yes" = 1,
                          "Not applicable" = 9999))
  ))

data$HHFFAPart <- labelled(
  data$HHFFAPart,
  labels = c("No" = 0, "Yes" = 1)
)

data$HHFFAPart <- as.numeric(data$HHFFAPart)

# 5. ABI sample size.
#    Households with enough information to calculate ABI (at least one of the ABI components non-missing).
ABI_sample_size <- data %>%
  dplyr::summarise(
    N_ABI = sum(
      !is.na(ABIaCalcProtect) |
      !is.na(ABIbCalcWaterAccess) |
      !is.na(ABIcCalcProduct) |
      !is.na(ABIdCalcAccess) |
      !is.na(ABIeCalcEnvBenefit) |
      !is.na(ABIfCalcTraining) |
      !is.na(ABIgCalcDHardship)
    )
  )

ABI_sample_size

# 5b. ABI sample size by participants vs non-participants.
#    Households with enough information to calculate ABI (at least one of the ABI components non-missing), by participation status.
ABI_sample_size_by_group <- data %>%
  dplyr::filter(
    !is.na(ABIaCalcProtect) |
    !is.na(ABIbCalcWaterAccess) |
    !is.na(ABIcCalcProduct) |
    !is.na(ABIdCalcAccess) |
    !is.na(ABIeCalcEnvBenefit) |
    !is.na(ABIfCalcTraining) |
    !is.na(ABIgCalcDHardship)
  ) %>%
  dplyr::summarise(
    Participants = sum(HHFFAPart == 1, na.rm = TRUE),
    Non_participants = sum(HHFFAPart == 0, na.rm = TRUE),
    Total = dplyr::n()
  )

# 6. Calculate the % of households reporting each type of benefit.
# These variables (ABIaCalcProtect–ABIgCalcDHardship) are already calculated in MoDa and coded 1 = Yes, 0 = No.
# This section calculates the % of households that reported each benefit.
ABI_disaggregated <- data %>%
  dplyr::filter(
    !is.na(ABIaCalcProtect) |
    !is.na(ABIbCalcWaterAccess) |
    !is.na(ABIcCalcProduct) |
    !is.na(ABIdCalcAccess) |
    !is.na(ABIeCalcEnvBenefit) |
    !is.na(ABIfCalcTraining) |
    !is.na(ABIgCalcDHardship)
  ) %>%
  dplyr::summarise(
    ABIa = mean(ABIaCalcProtect, na.rm = TRUE),
    ABIb = mean(ABIbCalcWaterAccess, na.rm = TRUE),
    ABIc = mean(ABIcCalcProduct, na.rm = TRUE),
    ABId = mean(ABIdCalcAccess, na.rm = TRUE),
    ABIe = mean(ABIeCalcEnvBenefit, na.rm = TRUE),
    ABIf = mean(ABIfCalcTraining, na.rm = TRUE),
    ABIg = mean(ABIgCalcDHardship, na.rm = TRUE)
  ) %>%
  dplyr::mutate(across(dplyr::everything(), ~ round(.x * 100, 1)))

# Add the corresponding label to each ABI component.
ABI_labels <- tibble(
  component = c("ABIa", "ABIb", "ABIc", "ABId", "ABIe", "ABIf", "ABIg"),
  label = c(
    "a) Improved protection from sudden onset natural shocks",
    "b) Improved water access availability",
    "c) Increased or diversified production",
    "d) Improved access to markets/basic services",
    "e) Improved natural environment",
    "f) Improved asset management/maintenance",
    "g) Reduced hardship / increased time availability"
  )
)

ABI_disaggregated_final <- ABI_disaggregated %>%
  tidyr::pivot_longer(dplyr::everything(), names_to = "component", values_to = "percent") %>%
  dplyr::left_join(ABI_labels, by = "component") %>%
  dplyr::mutate(percent = paste0(percent, "%")) %>% 
  dplyr::select(label, percent)

# 6b. Calculate the % of households reporting each type of benefit, disaggregated by participation status.
ABI_disaggregated_by_group <- data %>%
  dplyr::filter(
    !is.na(ABIaCalcProtect) |
    !is.na(ABIbCalcWaterAccess) |
    !is.na(ABIcCalcProduct) |
    !is.na(ABIdCalcAccess) |
    !is.na(ABIeCalcEnvBenefit) |
    !is.na(ABIfCalcTraining) |
    !is.na(ABIgCalcDHardship)
  ) %>%
  dplyr::group_by(HHFFAPart) %>%
  dplyr::summarise(
    ABIa = mean(ABIaCalcProtect, na.rm = TRUE),
    ABIb = mean(ABIbCalcWaterAccess, na.rm = TRUE),
    ABIc = mean(ABIcCalcProduct, na.rm = TRUE),
    ABId = mean(ABIdCalcAccess, na.rm = TRUE),
    ABIe = mean(ABIeCalcEnvBenefit, na.rm = TRUE),
    ABIf = mean(ABIfCalcTraining, na.rm = TRUE),
    ABIg = mean(ABIgCalcDHardship, na.rm = TRUE)
  ) %>%
  dplyr::mutate(
    dplyr::across(
      -HHFFAPart,
      ~ round(.x * 100, 1)
    )
  ) %>%
  tidyr::pivot_longer(
    cols = -HHFFAPart,
    names_to = "component",
    values_to = "percent"
  ) %>%
  dplyr::mutate(
    group = dplyr::case_when(
      HHFFAPart == 1 ~ "Participants",
      HHFFAPart == 0 ~ "Non-participants"
    )
  ) %>%
  dplyr::left_join(ABI_labels, by = "component") %>%
  dplyr::select(label, group, percent)

ABI_disaggregated_by_group_final <- ABI_disaggregated_by_group %>%
  tidyr::pivot_wider(
    names_from = group,
    values_from = percent
  ) %>%
  dplyr::mutate(
    dplyr::across(
      -label,
      ~ paste0(.x, "%")
    )
  )
# 7. Calculate the overall ABI indicator.
ABI_overall <- tibble(
  ABI_overall = paste0(max(unlist(ABI_disaggregated), na.rm = TRUE), "%")
)

# 7b. Calculate the overall ABI indicator, disaggregated by participation status.
ABI_overall_by_group <- ABI_disaggregated_by_group %>%
  dplyr::group_by(group) %>%
  dplyr::summarise(
    ABI_overall = max(percent, na.rm = TRUE)
  ) %>%
  dplyr::mutate(
    ABI_overall = paste0(ABI_overall, "%")
  )

# 8. Print final outputs.
ABI_disaggregated_final
ABI_overall
ABI_sample_size

# 8b. Print final outputs, disaggregated by participation status.
ABI_disaggregated_by_group_final
ABI_overall_by_group
ABI_sample_size_by_group

