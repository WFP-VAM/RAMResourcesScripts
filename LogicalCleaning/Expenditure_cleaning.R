#------------------------------------------------------------------------------#
#	                    WFP Standardized Scripts
#                      Cleaning Expenditures Module
#------------------------------------------------------------------------------#
# Note:
# This script is based on WFP's standard expenditure module in Survey Designer.
# If you are using a different module or if the module was partially edited 
# (e.g. some expenditure variables added or removed), the List of variables needs to be edited accordingly.
# Important: The script assumes that a single currency is used. 
# If multiple currencies are used, convert to a single currency before running the script.
#------------------------------------------------------------------------------#

# ------------------------------------------------------------------------------*
#                1. Listing Variables in the Expenditure Module
# ------------------------------------------------------------------------------*

# List of variables in the food expenditure module with 7 days recall period (Edit the list of variables if needed)
F_expvars <- c(
  'HHExpFCer_Purch_MN_7D', 'HHExpFCer_GiftAid_MN_7D', 'HHExpFCer_Own_MN_7D',
  'HHExpFTub_Purch_MN_7D', 'HHExpFTub_GiftAid_MN_7D', 'HHExpFTub_Own_MN_7D',
  'HHExpFPuls_Purch_MN_7D', 'HHExpFPuls_GiftAid_MN_7D', 'HHExpFPuls_Own_MN_7D',
  'HHExpFVeg_Purch_MN_7D', 'HHExpFVeg_GiftAid_MN_7D', 'HHExpFVeg_Own_MN_7D',
  'HHExpFFrt_Purch_MN_7D', 'HHExpFFrt_GiftAid_MN_7D', 'HHExpFFrt_Own_MN_7D',
  'HHExpFAnimMeat_Purch_MN_7D', 'HHExpFAnimMeat_GiftAid_MN_7D', 'HHExpFAnimMeat_Own_MN_7D',
  'HHExpFAnimFish_Purch_MN_7D', 'HHExpFAnimFish_GiftAid_MN_7D', 'HHExpFAnimFish_Own_MN_7D',
  'HHExpFFats_Purch_MN_7D', 'HHExpFFats_GiftAid_MN_7D', 'HHExpFFats_Own_MN_7D',
  'HHExpFDairy_Purch_MN_7D', 'HHExpFDairy_GiftAid_MN_7D', 'HHExpFDairy_Own_MN_7D',
  'HHExpFEgg_Purch_MN_7D', 'HHExpFEgg_GiftAid_MN_7D', 'HHExpFEgg_Own_MN_7D',
  'HHExpFSgr_Purch_MN_7D', 'HHExpFSgr_GiftAid_MN_7D', 'HHExpFSgr_Own_MN_7D',
  'HHExpFCond_Purch_MN_7D', 'HHExpFCond_GiftAid_MN_7D', 'HHExpFCond_Own_MN_7D',
  'HHExpFBev_Purch_MN_7D', 'HHExpFBev_GiftAid_MN_7D', 'HHExpFBev_Own_MN_7D',
  'HHExpFOut_Purch_MN_7D', 'HHExpFOut_GiftAid_MN_7D', 'HHExpFOut_Own_MN_7D'
)

# List of variables in the non-food expenditure module with 30 days recall period (Edit the list of variables if needed)
NF_1M_expvars <- c(
  'HHExpNFHyg_Purch_MN_1M', 'HHExpNFHyg_GiftAid_MN_1M',
  'HHExpNFTransp_Purch_MN_1M', 'HHExpNFTransp_GiftAid_MN_1M',
  'HHExpNFFuel_Purch_MN_1M', 'HHExpNFFuel_GiftAid_MN_1M',
  'HHExpNFWat_Purch_MN_1M', 'HHExpNFWat_GiftAid_MN_1M',
  'HHExpNFElec_Purch_MN_1M', 'HHExpNFElec_GiftAid_MN_1M',
  'HHExpNFEnerg_Purch_MN_1M', 'HHExpNFEnerg_GiftAid_MN_1M',
  'HHExpNFDwelSer_Purch_MN_1M', 'HHExpNFDwelSer_GiftAid_MN_1M',
  'HHExpNFPhone_Purch_MN_1M', 'HHExpNFPhone_GiftAid_MN_1M',
  'HHExpNFRecr_Purch_MN_1M', 'HHExpNFRecr_GiftAid_MN_1M',
  'HHExpNFAlcTobac_Purch_MN_1M', 'HHExpNFAlcTobac_GiftAid_MN_1M'
)

# List of variables in the non-food expenditure module with 6 months recall period (Edit the list of variables if needed)
NF_6M_expvars <- c(
  'HHExpNFMedServ_Purch_MN_6M', 'HHExpNFMedServ_GiftAid_MN_6M',
  'HHExpNFMedGood_Purch_MN_6M', 'HHExpNFMedGood_GiftAid_MN_6M',
  'HHExpNFCloth_Purch_MN_6M', 'HHExpNFCloth_GiftAid_MN_6M',
  'HHExpNFEduFee_Purch_MN_6M', 'HHExpNFEduFee_GiftAid_MN_6M',
  'HHExpNFEduGood_Purch_MN_6M', 'HHExpNFEduGood_GiftAid_MN_6M',
  'HHExpNFRent_Purch_MN_6M', 'HHExpNFRent_GiftAid_MN_6M',
  'HHExpNFHHSoft_Purch_MN_6M', 'HHExpNFHHSoft_GiftAid_MN_6M',
  'HHExpNFHHMaint_Purch_MN_6M', 'HHExpNFHHMaint_GiftAid_MN_6M'
)

# List of all expenditure variables
all_expvars <- c(F_expvars, NF_1M_expvars, NF_6M_expvars)

# List of administrative levels (Edit the list of administrative levels accordingly)
admin_levels <- c('ADMIN0Name', 'ADMIN1Name', 'ADMIN2Name', 'ADMIN3Name', 'ADMIN4Name')

# Household Size variable
hhsize_var <- 'HHSize'

# Enumerator Name variable
enumerator_var <- 'EnuName'

#------------------------------------------------------------------------------*
#                2. Checking if all necessary columns are present
#------------------------------------------------------------------------------*

check_columns_exist <- function(df, columns) {
  # Check if all specified columns exist in the DataFrame
  missing_columns <- setdiff(columns, colnames(df))
  
  if (length(missing_columns) > 0) {
    stop(paste("The following columns are missing from the DataFrame:", 
               paste(missing_columns, collapse = ", ")))
  } else {
    message("All columns are present in the DataFrame.")
  }
}

#------------------------------------------------------------------------------*
#                       3. Setting zero and negative values to Missing
#------------------------------------------------------------------------------*

set_zero_negative_to_missing <- function(df, vars) {
  # Set zero and negative values in specified columns to NA
  df[vars] <- lapply(df[vars], function(x) ifelse(x <= 0, NA, x))
  return(df)
}

#------------------------------------------------------------------------------*
#      4. Preliminary checks regarding the usability of the expenditure data
#------------------------------------------------------------------------------*

compute_food_aggregate <- function(df, F_expvars, variable_name) {
  # Compute the total food expenditure aggregate with a 7-day recall period
  df[[variable_name]] <- rowSums(df[F_expvars], na.rm = TRUE) * (30 / 7)
  return(df)
}

compute_nonfood_aggregate <- function(df, NF_1M_expvars, NF_6M_expvars, variable_name) {
  # Compute the total non-food expenditure aggregate using 30-day and 6-month recall periods
  df[[variable_name]] <- rowSums(df[NF_1M_expvars], na.rm = TRUE) + 
    rowSums(df[NF_6M_expvars], na.rm = TRUE) / 6
  return(df)
}

generate_zero_expenditure_flags <- function(df) {
  # Generate flags for zero food, non-food, and total expenditures
  df$zero_F <- ifelse(df$temp_HHExpF_1M == 0, 1, 0)
  df$zero_NF <- ifelse(df$temp_HHExpNF_1M == 0, 1, 0)
  df$zero_Total <- ifelse(df$temp_HHExpF_1M == 0 & df$temp_HHExpNF_1M == 0, 1, 0)
  
  return(df)
}

compute_summary_table <- function(df) {
  # Calculate the counts of zero expenditures
  zero_counts <- colSums(df[, c('zero_F', 'zero_NF', 'zero_Total')], na.rm = TRUE)
  
  # Calculate the proportions (mean of the binary flags)
  zero_proportions <- colMeans(df[, c('zero_F', 'zero_NF', 'zero_Total')], na.rm = TRUE)
  
  # Create a data frame to store counts and proportions together
  summary_table <- data.frame(
    Count = zero_counts,
    Proportion = zero_proportions
  )
  
  return(summary_table)
}

export_summary_to_excel <- function(df, admin_levels, output_dir = "Outputs/Tables/1.Preliminary_Check") {
  # Ensure the output directory exists
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }
  
  # Create a new workbook
  wb <- createWorkbook()
  
  # Step 1: Write the summary table for the whole sample
  summary_table <- compute_summary_table(df)
  addWorksheet(wb, "Whole_sample")
  writeData(wb, "Whole_sample", summary_table)
  
  # Step 2: Loop over each administrative level and calculate the summary for each
  for (admin in admin_levels) {
    if (admin %in% colnames(df) && any(!is.na(df[[admin]]))) {  # Check if admin level exists in the DataFrame
      admin_grouped <- df %>%
        group_by(!!sym(admin)) %>%
        summarise(
          Count_zero_F = sum(zero_F, na.rm = TRUE),
          Proportion_zero_F = mean(zero_F, na.rm = TRUE),
          Count_zero_NF = sum(zero_NF, na.rm = TRUE),
          Proportion_zero_NF = mean(zero_NF, na.rm = TRUE),
          Count_zero_Total = sum(zero_Total, na.rm = TRUE),
          Proportion_zero_Total = mean(zero_Total, na.rm = TRUE)
        )
      
      # Step 3: Write the grouped results to a separate sheet for each admin level
      addWorksheet(wb, admin)
      writeData(wb, admin, admin_grouped)
    }
  }
  
  # Save the workbook to the specified output directory
  saveWorkbook(wb, file = file.path(output_dir, "Preliminary_check.xlsx"), overwrite = TRUE)
}

drop_temporary_columns <- function(df, columns) {
  # Drop the temporary columns created during the data cleaning process
  df <- df[, !(colnames(df) %in% columns)]
  return(df)
}

#------------------------------------------------------------------------------*
#                5. Generating box plots and min-max reports
#------------------------------------------------------------------------------*

generate_box_plots <- function(df, variables, output_dir = "Outputs/Graphs/2.Manual_Stage") {
  # Ensure the output directory exists
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }
  
  # Loop over each variable and create a box plot
  for (var in variables) {
    # Create the box plot
    p <- ggplot(df, aes_string(y = var)) +
      geom_boxplot() +
      ggtitle(paste("Box Plot for", var)) +
      theme_minimal()
    
    # Save the box plot as a PDF
    ggsave(filename = file.path(output_dir, paste0("boxplot_", var, ".pdf")), plot = p)
  }
}

generate_minmax_report <- function(df, variables, output_dir = "Outputs/Tables/2.Manual_Stage") {
  # Ensure the output directory exists
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }
  
  # Number of bottom and top values to retrieve
  num_bottom_top <- 5
  
  # Initialize an empty list to store min/max values
  minmax_list <- list()
  
  # Loop through each variable to compute bottom and top values
  for (var in variables) {
    # Drop missing values for the current variable
    non_missing <- na.omit(df[[var]])
    
    # Retrieve the bottom 5 and top 5 values, with padding if there are fewer than 5 values
    bottom_5 <- head(sort(non_missing), num_bottom_top)
    bottom_5 <- c(bottom_5, rep(NA, num_bottom_top - length(bottom_5)))  # Pad with NA if needed
    
    top_5 <- tail(sort(non_missing), num_bottom_top)
    top_5 <- c(top_5, rep(NA, num_bottom_top - length(top_5)))  # Pad with NA if needed
    
    # Combine bottom and top values into a single vector, using NA as a separator
    combined <- c(bottom_5, NA, top_5)
    
    # Name the vector with the variable name
    minmax_list[[var]] <- combined
  }
  
  # Convert the min/max list to a DataFrame
  minmax_df <- do.call(cbind, minmax_list)
  
  # Set row labels for bottom/top values
  rownames(minmax_df) <- c(paste0("bottom_", 1:num_bottom_top), " ", paste0("top_", 1:num_bottom_top))
  
  # Export the DataFrame to Excel
  write.xlsx(minmax_df, file = file.path(output_dir, "MinMax.xlsx"), rowNames = TRUE)
}

#------------------------------------------------------------------------------
#        6. Cleaning individual expenditure variables, statistical/automatic
#------------------------------------------------------------------------------

express_per_capita <- function(df, vars, hh_size_col = 'HHSize') {
  for (var in vars) {
    pc_col <- paste0('pc_', var)
    df[[pc_col]] <- df[[var]] / df[[hh_size_col]]
  }
  return(df)
}

apply_ihs_transformation <- function(df, vars) {
  for (var in vars) {
    pc_col <- paste0('pc_', var)
    tpc_col <- paste0('tpc_', var)
    df[[tpc_col]] <- log(df[[pc_col]] + sqrt(df[[pc_col]]^2 + 1))
  }
  return(df)
}

standardize_using_mad <- function(df, vars) {
  for (var in vars) {
    tpc_col <- paste0('tpc_', var)
    if (sum(!is.na(df[[tpc_col]])) > 0) {  # Check if there are observations
      median_val <- median(df[[tpc_col]], na.rm = TRUE)
      df[[paste0('p50_', var)]] <- median_val  # Store median value
      
      # Calculate absolute deviation from median
      df[[paste0('d_', var)]] <- abs(df[[tpc_col]] - median_val)
      mad_val <- 1.4826 * median(df[[paste0('d_', var)]], na.rm = TRUE)
      df[[paste0('MAD_', var)]] <- mad_val  # Store MAD
      
      # Standardize the variable
      if (mad_val != 0) {
        df[[paste0('z_', var)]] <- (df[[tpc_col]] - median_val) / mad_val
      } else {
        df[[paste0('z_', var)]] <- NA  # If MAD is zero, set z-score as missing
      }
    } else {
      df[[paste0('z_', var)]] <- NA  # No observations, set z-score as missing
    }
    
    # Drop temporary variables
    df[[tpc_col]] <- NULL
    df[[paste0('p50_', var)]] <- NULL
    df[[paste0('d_', var)]] <- NULL
    df[[paste0('MAD_', var)]] <- NULL
  }
  return(df)
}

identify_outliers <- function(df, vars) {
  for (var in vars) {
    z_col <- paste0('z_', var)
    o_col <- paste0('o_', var)
    df[[o_col]] <- 0  # Initialize outlier indicator as 0
    
    # Top outliers
    df[[o_col]][df[[z_col]] > 3 & !is.na(df[[z_col]])] <- 2
    # Bottom outliers
    df[[o_col]][df[[z_col]] < -3 & !is.na(df[[z_col]])] <- 1
    
    # Drop standardized variable after tagging outliers
    df[[z_col]] <- NULL
  }
  return(df)
}

replace_outliers_with_median <- function(df, vars, admin_levels) {
  # Step 1: Set outliers to missing
  for (var in vars) {
    o_col <- paste0('o_', var)
    pc_col <- paste0('pc_', var)
    df[[pc_col]][df[[o_col]] %in% 1:2] <- NA  # Set outliers to NA
  }
  
  # Step 2: Compute medians for different admin levels
  for (var in vars) {
    pc_col <- paste0('pc_', var)
    for (i in seq_along(admin_levels)) {
      admin_col <- admin_levels[i]  # Access admin levels by index
      
      # Check if the admin column exists in the data frame
      if (!admin_col %in% colnames(df)) {
        next  # Skip this iteration if the admin column is not present
      }
      
      # Create temporary variables for count and median at each admin level
      n_col <- paste0('n', i - 1, '_', var)  # Adjust index for consistency with Stata code
      m_col <- paste0('m', i - 1, '_', var)
      
      # Count valid observations
      df[[n_col]] <- ave(df[[pc_col]], df[[admin_col]], FUN = function(x) sum(!is.na(x)))
      
      # Compute median values
      df[[m_col]] <- ave(df[[pc_col]], df[[admin_col]], FUN = function(x) median(x, na.rm = TRUE))
    }
  }
  
  # Step 3: Replace outliers with medians based on the number of observations
  for (var in vars) {
    pc_col <- paste0('pc_', var)
    o_col <- paste0('o_', var)
    
    # Replace with national level by default (ADMIN0)
    df[[pc_col]][df[[o_col]] %in% 1:2] <- df[[paste0('m0_', var)]][df[[o_col]] %in% 1:2]
    
    # Replace with admin level 1 if more than 150 observations
    if ('ADMIN1Name' %in% colnames(df)) {
      df[[pc_col]][df[[o_col]] %in% 1:2 & df[[paste0('n1_', var)]] > 150] <- df[[paste0('m1_', var)]][df[[o_col]] %in% 1:2 & df[[paste0('n1_', var)]] > 150]
    }
    
    # Replace with admin level 2 if more than 50 observations
    if ('ADMIN2Name' %in% colnames(df)) {
      df[[pc_col]][df[[o_col]] %in% 1:2 & df[[paste0('n2_', var)]] > 50] <- df[[paste0('m2_', var)]][df[[o_col]] %in% 1:2 & df[[paste0('n2_', var)]] > 50]
    }
    
    # Replace with admin level 3 if more than 15 observations
    if ('ADMIN3Name' %in% colnames(df)) {
      df[[pc_col]][df[[o_col]] %in% 1:2 & df[[paste0('n3_', var)]] > 15] <- df[[paste0('m3_', var)]][df[[o_col]] %in% 1:2 & df[[paste0('n3_', var)]] > 15]
    }
    
    # Replace with admin level 4 if more than 5 observations
    if ('ADMIN4Name' %in% colnames(df)) {
      df[[pc_col]][df[[o_col]] %in% 1:2 & df[[paste0('n4_', var)]] > 5] <- df[[paste0('m4_', var)]][df[[o_col]] %in% 1:2 & df[[paste0('n4_', var)]] > 5]
    }
  }
  
  return(df)
}

#------------------------------------------------------------------------------
#       7. Cleaning aggregate expenditure variables, statistical/automatic
#------------------------------------------------------------------------------

generate_list_pc_columns <- function(variable_list) {
  # Return a new list with 'pc_' prefix added to each variable name in the input list
  pc_columns <- paste0("pc_", variable_list)
  return(pc_columns)
}

reconcile_exp_variables <- function(df, F_expvars, NF_1M_expvars, NF_6M_expvars, all_expvars) {
  # Food expenditures ----------------------------------------------------------
  
  # Step 1: Create per capita food variable names
  PC_F_expvars <- paste0("pc_", F_expvars)
  
  # Step 2: Calculate temporary food aggregate
  df$temp_F <- rowSums(df[, PC_F_expvars, drop = FALSE], na.rm = TRUE)
  
  # Step 3: Calculate food share variables at once
  for (var in F_expvars) {
    df[[paste0("s", var)]] <- df[[paste0("pc_", var)]] / df$temp_F
  }
  df[is.na(df)] <- 0 # Replace NA with 0 for non-outliers
  
  # Step 4: Filter out non-outliers and calculate mean shares
  s_F_expvars <- paste0("s", F_expvars)
  filtered_df <- df[df$temp_F > 0 & !(df$o_HHExpF_1M %in% c(1, 2)), ]
  mean_shares_filtered <- colMeans(filtered_df[, s_F_expvars, drop = FALSE], na.rm = TRUE)
  
  # Step 5: Apply updates for food variables for outliers using pc_HHExpF_1M
  for (var in F_expvars) {
    outlier_index <- which(df$o_HHExpF_1M %in% c(1, 2))
    if (length(outlier_index) > 0) {
      if (length(df$pc_HHExpF_1M[outlier_index]) > 0) {
        df[[paste0("pc_", var)]][outlier_index] <- df$pc_HHExpF_1M[outlier_index] * mean_shares_filtered[paste0("s", var)]
      } else {
        warning(paste("Warning: 'pc_HHExpF_1M' has zero length at outlier indices for variable", var))
      }
    }
  }
  
  # Non-Food expenditures ----------------------------------------------------------
  
  # Step 6: Temporarily express 6M recall variables in monthly terms
  for (var in NF_6M_expvars) {
    df[[paste0("pc_", var)]] <- df[[paste0("pc_", var)]] / 6
  }
  
  # Step 7: Create per capita non-food variable names
  PC_NF_1M_expvars <- paste0("pc_", NF_1M_expvars)
  PC_NF_6M_expvars <- paste0("pc_", NF_6M_expvars)
  
  # Step 8: Calculate temporary non-food aggregate
  df$temp_NF <- rowSums(df[, c(PC_NF_1M_expvars, PC_NF_6M_expvars), drop = FALSE], na.rm = TRUE)
  
  # Check if pc_HHExpNF_1M exists in the DataFrame
  if (!"pc_HHExpNF_1M" %in% colnames(df)) {
    stop("Error: The column 'pc_HHExpNF_1M' does not exist in the DataFrame.")
  }
  
  # Step 9: Calculate non-food share variables at once
  for (var in c(NF_1M_expvars, NF_6M_expvars)) {
    df[[paste0("s", var)]] <- df[[paste0("pc_", var)]] / df$temp_NF
  }
  df[is.na(df)] <- 0 # Replace NA with 0 for non-outliers
  
  # Step 10: Filter out non-outliers and calculate mean shares
  s_NF_expvars <- paste0("s", c(NF_1M_expvars, NF_6M_expvars))
  filtered_df <- df[df$temp_NF > 0 & !(df$o_HHExpNF_1M %in% c(1, 2)), ]
  mean_shares_filtered <- colMeans(filtered_df[, s_NF_expvars, drop = FALSE], na.rm = TRUE)
  
  # Step 11: Apply updates for non-food variables for outliers using pc_HHExpNF_1M
  for (var in c(NF_1M_expvars, NF_6M_expvars)) {
    outlier_index <- which(df$o_HHExpNF_1M %in% c(1, 2))
    if (length(outlier_index) > 0) {
      if (length(df$pc_HHExpNF_1M[outlier_index]) > 0) {
        df[[paste0("pc_", var)]][outlier_index] <- df$pc_HHExpNF_1M[outlier_index] * mean_shares_filtered[paste0("s", var)]
      } else {
        warning(paste("Warning: 'pc_HHExpNF_1M' has zero length at outlier indices for variable", var))
      }
    }
  }
  
  # Step 12: Re-express 6M recall variables back into 6M period
  for (var in NF_6M_expvars) {
    df[[paste0("pc_", var)]] <- df[[paste0("pc_", var)]] * 6
  }
  
  # Drop temporary columns ----------------------------------------------------------
  
  # Step 13: Drop temporary columns related to aggregates and share variables
  drop_columns <- c("pc_HHExpF_1M", "pc_HHExpNF_1M", "temp_F", "temp_NF", paste0("s", all_expvars))
  df <- df[, !(colnames(df) %in% drop_columns)]
  
  return(df)
}

# Example Usage
# df <- reconcile_exp_variables(df, F_expvars, NF_1M_expvars, NF_6M_expvars, all_expvars)


retransform_per_capita_to_household <- function(df, vars, hh_size_col = 'HHSize') {
  # Loop through each variable in the list of original variable names
  for (var in vars) {
    # Define the per capita column name
    pc_var <- paste0('pc_', var)
    
    # Check if the per capita column exists in the data frame
    if (pc_var %in% colnames(df)) {
      # Multiply per capita values by household size to get household expenditure
      df[[var]] <- df[[pc_var]] * df[[hh_size_col]]
    }
  }
  
  # Return the modified data frame with re-transformed variables
  return(df)
}

#------------------------------------------------------------------------------*
#                             Main cleaning Code
#------------------------------------------------------------------------------*

# Load the packages
library(readxl)
library(dplyr)
library(openxlsx)

# Load the data (Adjust the path as needed)
df <- read.csv('Expcleaning_Sample_Raw.csv')

# Check if all columns exist in the DataFrame
check_columns_exist(df, c(all_expvars, admin_levels, hhsize_var, enumerator_var))

# Set zero and negative values to missing
df <- set_zero_negative_to_missing(df, all_expvars)

# Aggregating Food Expenditures
df <- compute_food_aggregate(df, F_expvars, 'temp_HHExpF_1M')

# Aggregating Non-Food Expenditures
df <- compute_nonfood_aggregate(df, NF_1M_expvars, NF_6M_expvars, 'temp_HHExpNF_1M')

# Generating Zero Expenditure Flags
df <- generate_zero_expenditure_flags(df)

# Exporting the Summary to Excel
export_summary_to_excel(df, admin_levels)

# Dropping Temporary Columns
df <- drop_temporary_columns(df, c('temp_HHExpF_1M', 'temp_HHExpNF_1M'))

# Generating Box Plots
#generate_box_plots(df, all_expvars)

# Generating Min-Max Report
generate_minmax_report(df, all_expvars)

# Cleaning individual expenditure variables, statistical/automatic
df <- express_per_capita(df, all_expvars)
df <- apply_ihs_transformation(df, all_expvars)
df <- standardize_using_mad(df, all_expvars)
df <- identify_outliers(df, all_expvars)
df <- replace_outliers_with_median(df, all_expvars, admin_levels)

# Dropping temporary columns
col_prefixes <- c('tpc', 'd', 'z', 'o', 'n0', 'm0', 'n1', 'n2', 'n3', 'n4', 'm1', 'm2', 'm3', 'm4')
indv_column_list <- unlist(lapply(col_prefixes, function(prefix) paste0(prefix, '_', all_expvars)))
indv_columns_to_drop <- indv_column_list[indv_column_list %in% colnames(df)]
df <- df[, !(colnames(df) %in% indv_columns_to_drop)]

# Cleaning aggregate expenditure variables, statistical/automatic
# 1. Generate Per Capita Column Lists
PC_F_expvars <- generate_list_pc_columns(F_expvars)
PC_NF_1M_expvars <- generate_list_pc_columns(NF_1M_expvars)
PC_NF_6M_expvars <- generate_list_pc_columns(NF_6M_expvars)
PC_NF_expvars <- c(PC_NF_1M_expvars, PC_NF_6M_expvars)

# 2. Define Aggregate Base Variables
aggr_base_vars <- c('HHExpF_1M', 'HHExpNF_1M')

# 3. Compute Food and Non-Food Aggregate
df <- compute_food_aggregate(df, PC_F_expvars, 'pc_HHExpF_1M')
df <- compute_nonfood_aggregate(df, PC_NF_1M_expvars, PC_NF_6M_expvars, 'pc_HHExpNF_1M')

# 4. Apply IHS Transformation to Aggregate Base Variables
df <- apply_ihs_transformation(df, aggr_base_vars)

# 5. Standardize Using MAD for Aggregate Base Variables
df <- standardize_using_mad(df, aggr_base_vars)

# 6. Identify Outliers in Aggregate Base Variables
df <- identify_outliers(df, aggr_base_vars)

# 7. Replace Outliers with Median at Different Admin Levels
df <- replace_outliers_with_median(df, aggr_base_vars, admin_levels)

# 8. Reconcile expenditures with aggregates
df <- reconcile_exp_variables(df, F_expvars, NF_1M_expvars, NF_6M_expvars, all_expvars)

# 9. Retransform from capita to household
df <- retransform_per_capita_to_household(df, all_expvars, 'HHSize')
