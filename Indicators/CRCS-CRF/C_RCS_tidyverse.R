# 1. Load the packages you need for this analysis.
#    If any of these are missing, install them first.
library(tidyverse)
library(labelled)
library(expss)
library(dplyr)
library(tidyr)

install.packages("readr")
library(readr)

# 2. Load your dataset.
#    Replace the file name below with the name of your survey file.
#    Make sure the file is in the same folder as this script.
data <- read_csv("C_RCS_Survey_Data.csv")

# 3. Clean missing values.
data[] <- lapply(data, function(x) {
  if (is.character(x)) {
    x <- trimws(x)
    x[tolower(x) %in% c("na", "nan", "n/a")] <- NA
  }
  x
})

# 4. Sample size (valid N only).
# This tells you how many households have a valid C/RCS score.
sample_size <- data %>%
  summarise(valid_N = sum(!is.na(HHC_RCS_excel)))

sample_size

# 5. Shock type distribution (climate vs other).
# This shows how many households reported climate shocks vs other shocks.
shock_type_dist <- data %>%
  filter(!is.na(HHShocksType)) %>%
  mutate(
    shock_label = recode(HHShocksType,
                         `1` = "Climate and weather-related shock",
                         `2` = "Other type of shock")
  ) %>%
  count(shock_label) %>%
  mutate(percent = 100 * n / sum(n))

shock_type_dist

# 6. Climate shocks – YES (%) only.
# These are the climate-related shocks.
climate_vars <- c(
  "HHCRCSFloods",
  "HHCRCSDroughts",
  "HHCRCSStorms",
  "HHCRCSHeatWave",
  "HHCRCSWildFire",
  "HHCRCSOther"
)

climate_vars <- intersect(climate_vars, names(data))

climate_labels <- c(
  HHCRCSFloods   = "Floods",
  HHCRCSDroughts = "Droughts",
  HHCRCSDroughts = "Droughts",
  HHCRCSStorms   = "Storm/Cyclone",
  HHCRCSHeatWave = "Heat Wave",
  HHCRCSWildFire = "Wildfire",
  HHCRCSOther    = "Other weather-related shock"
)

# This calculates the % of households that said "Yes" to each climate shock.
climate_shocks <- data %>%
  filter(HHShocksType == 1) %>%   # Only climate-shock households
  summarise(across(all_of(climate_vars),
                   ~ 100 * mean(. == 1, na.rm = TRUE))) %>%
  pivot_longer(everything(),
               names_to = "variable",
               values_to = "yes_percent") %>%
  mutate(
    shock_label = climate_labels[variable],
    yes_percent = round(yes_percent, 1)
  ) %>%
  select(shock_label, yes_percent)

climate_shocks

# 7. Other shocks – YES (%) only.
# This automatically finds all SEI shock variables that have been selected for your dataset.
sei_vars <- names(data)[
  startsWith(names(data), "HHSEINew_SEI") &
    !endsWith(names(data), "_Imp")
]

# These are the labels for all possible SEI shocks.
# The script will only use the ones that exist in your dataset.
sei_labels <- c(
  HHSEINew_SEIFPrice    = "High food prices / food price spikes",
  HHSEINew_SEICost      = "Increased costs of agricultural/livelihood inputs, fuel or rent",
  HHSEINew_SEIElec      = "Electricity cuts / blackouts",
  HHSEINew_SEIWater     = "Water supply shortages",
  HHSEINew_SEIRemit     = "Decrease in remittances received",
  HHSEINew_SEIUnemp     = "Unemployment / lack of wage or livelihood opportunities",
  HHSEINew_SEILowPrice  = "Low prices when selling agricultural or livestock products",
  HHSEINew_SEILowWage   = "Decreased daily wage labour rates",
  HHSEINew_SEIHouse     = "Not safe to leave house / access livelihoods",
  HHSEINew_SEIConflict  = "Armed conflict, gang violence or ethnic clashes",
  HHSEINew_SEIInstab    = "Political instability or civil unrest",
  HHSEINew_SEIMovement  = "Movement restrictions (checkpoints, curfew, lockdown)",
  HHSEINew_SEIDispl     = "Displacement or forced movement",
  HHSEINew_SEIGender    = "Gender discrimination or harassment",
  HHSEINew_SEIDiscr     = "Discrimination or harassment (ethnicity, refugee status, etc.)",
  HHSEINew_SEIRaid      = "Cattle or livestock raiding",
  HHSEINew_SEICropDis   = "Crop pests or diseases",
  HHSEINew_SEILiveDis   = "Livestock disease, injury or death",
  HHSEINew_SEIHumDis    = "Illness, injury or death in the household",
  HHSEINew_SEIFarmLoss  = "Loss of farming or grazing land",
  HHSEINew_SEITheft     = "Theft or robbery",
  HHSEINew_SEIHouseLoss = "Loss of home or rental property",
  HHSEINew_SEIAsst      = "Delays or cuts in humanitarian assistance"
)
# Keep only the labels for variables that actually exist in your dataset.
sei_labels <- sei_labels[names(sei_labels) %in% sei_vars]
sei_vars   <- names(sei_labels)

# This calculates the % of households that said "Yes" to each SEI shock.
sei_shocks <- data %>%
  filter(HHShocksType == 2) %>%   # Only non-climate-shock households
  summarise(across(all_of(sei_vars),
                   ~ 100 * mean(. == 1, na.rm = TRUE))) %>%
  pivot_longer(everything(),
               names_to = "variable",
               values_to = "yes_percent") %>%
  mutate(
    shock_label = sei_labels[variable],
    yes_percent = round(yes_percent, 1)
  ) %>%
  select(shock_label, yes_percent)

sei_shocks

# 8. C/RCS indicator table.
# Variables for the five C/RCS components
crcs_vars <- c(
  "HHC_RCS_excel_category",
  "HHC_RCScategory_anticipatory_capacity_excel",
  "HHC_RCScategory_absorptive_capacity_excel",
  "HHC_RCScategory_transform_capacity_excel",
  "HHC_RCScategory_adaptive_capacity_excel"
)

# Add labels to each variable
crcs_labels <- c(
  HHC_RCS_excel_category                      = "Total C/RCS",
  HHC_RCScategory_anticipatory_capacity_excel = "Anticipatory Capacity",
  HHC_RCScategory_absorptive_capacity_excel   = "Absorptive Capacity",
  HHC_RCScategory_transform_capacity_excel    = "Transformative Capacity",
  HHC_RCScategory_adaptive_capacity_excel     = "Adaptive Capacity"
)

recode_crcs <- function(x) {
  recode(x,
         "A-low" = "Low",
         "B-medium" = "Medium",
         "C-high" = "High")
}

crcs_table_long <- lapply(crcs_vars, function(v) {
  data %>%
    filter(!is.na(.data[[v]])) %>%
    mutate(category = recode_crcs(.data[[v]])) %>%
    count(category) %>%
    mutate(
      percent_raw = 100 * n / sum(n),
      component = crcs_labels[[v]]
    )
}) %>%
  bind_rows() %>%
  mutate(
    category = factor(category, levels = c("Low", "Medium", "High")),
    component = factor(component,
                       levels = c("Anticipatory Capacity", "Absorptive Capacity",
                                  "Transformative Capacity", "Adaptive Capacity",
                                  "Total C/RCS"))
  )

crcs_table_adj <- crcs_table_long %>%
  group_by(component) %>%
  arrange(category) %>%  # ensures order: Low, Medium, High
  mutate(
    percent_round = round(percent_raw)
  ) %>%
  mutate(
    percent_round = if_else(
      category == "High",
      100 - sum(percent_round[category != "High"]),
      percent_round
    )
  ) %>%
  ungroup()

# Step 3: reshape + add % sign
crcs_table_wide <- crcs_table_adj %>%
  select(component, category, percent_round) %>%
  pivot_wider(
    names_from = category,
    values_from = percent_round,
    values_fill = 0
  ) %>%
  mutate(
    Low    = paste0(Low, "%"),
    Medium = paste0(Medium, "%"),
    High   = paste0(High, "%")
  ) %>%
  arrange(component)

crcs_table_wide

# 9. Print all outputs at once for easier interpretation.
sample_size
shock_type_dist
climate_shocks
sei_shocks
crcs_table_wide      
