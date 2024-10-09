#------------------------------------------------------------------------------#
#	                    WFP Standardized Scripts
#                      Cleaning Expenditures Module
#------------------------------------------------------------------------------#
"""
Note:
This script is based on WFP's standard expenditure module in Survey Desginer.
If you are using a different module or if the module was partially edited 
(e.g. some expenditure variables added or removed), the List of variables needs to be edited accordingly.
Important: The script assumes that a single currency is used. 
If multiple currencies are used, convert to a single currency before running the script.
"""
#------------------------------------------------------------------------------*
#                1. Listing Variables in the Expenditure Module
# ------------------------------------------------------------------------------*

# List of variables in the food expenditure module with 7 days recall period (Edit the list of variables if needed)
F_expvars = [
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
]

# List of variables in the non-food expenditure module with 30 days recall period (Edit the list of variables if needed)
NF_1M_expvars = [
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
]

# List of variables in the non-food expenditure module with 6 months recall period (Edit the list of variables if needed)
NF_6M_expvars = [
    'HHExpNFMedServ_Purch_MN_6M', 'HHExpNFMedServ_GiftAid_MN_6M',
    'HHExpNFMedGood_Purch_MN_6M', 'HHExpNFMedGood_GiftAid_MN_6M',
    'HHExpNFCloth_Purch_MN_6M', 'HHExpNFCloth_GiftAid_MN_6M',
    'HHExpNFEduFee_Purch_MN_6M', 'HHExpNFEduFee_GiftAid_MN_6M',
    'HHExpNFEduGood_Purch_MN_6M', 'HHExpNFEduGood_GiftAid_MN_6M',
    'HHExpNFRent_Purch_MN_6M', 'HHExpNFRent_GiftAid_MN_6M',
    'HHExpNFHHSoft_Purch_MN_6M', 'HHExpNFHHSoft_GiftAid_MN_6M',
    'HHExpNFHHMaint_Purch_MN_6M', 'HHExpNFHHMaint_GiftAid_MN_6M'
]

# List of all expenditure variables
all_expvars = F_expvars + NF_1M_expvars + NF_6M_expvars

# List of administrative levels (Edit the list of administrative levels accordingly)
admin_levels = ['ADMIN0Name', 'ADMIN1Name', 'ADMIN2Name', 'ADMIN3Name', 'ADMIN4Name']

# Household Size variable
hhsize_var = 'HHSize'

# Enumerator Name variable
enumerator_var = 'EnuName'

#------------------------------------------------------------------------------*
#                2. Checking if all necessary columns are present
#------------------------------------------------------------------------------*

def check_columns_exist(df, columns):
    """
    Check if all specified columns exist in the DataFrame.

    Parameters:
    - df: pandas.DataFrame, the dataset to check
    - columns: list of str, the columns that need to be present in the DataFrame

    Returns:
    - None, raises a ValueError if any of the specified columns are missing
    """
    missing_columns = [col for col in columns if col not in df.columns]
    
    if missing_columns:
        raise ValueError(f"The following columns are missing from the DataFrame: {missing_columns}")

    else:
        print("All columns are present in the DataFrame.")

#------------------------------------------------------------------------------*
#                       3. Setting zero and negative values to Missing
#------------------------------------------------------------------------------*

def set_zero_negative_to_missing(df, vars):
    """
    Set negative values in specified columns to NaN.

    Parameters:
    - df: pandas.DataFrame, the dataset
    - all_expvars: list, list of column names where negative values should be replaced with NaN

    Returns:
    - df: pandas.DataFrame, the modified dataset with negative values replaced by NaN
    """
    df[vars] = df[vars].where(df[vars] > 0, np.nan)
    return df

#------------------------------------------------------------------------------*
#      4. Preliminary checks regarding the usability of the expenditure data
#------------------------------------------------------------------------------*

def compute_food_aggregate(df, F_expvars, variable_name):
    """
    Compute the total food expenditure aggregate with a 7-day recall period.

    Parameters:
    - df: pandas.DataFrame, the dataset containing food expenditure data
    - F_expvars: list of str, the columns representing food expenditure variables

    Returns:
    - pandas.DataFrame, the dataset with a new column 'temp_HHExpF_1M' containing 
      the food expenditure aggregate adjusted to a 30-day period.
    """

    # Compute food expenditure aggregate and adjust for 30-day period
    df[variable_name] = df[F_expvars].sum(axis=1) * (30 / 7)
    
    return df

def compute_nonfood_aggregate(df, NF_1M_expvars, NF_6M_expvars, variable_name):
    """
    Compute the total non-food expenditure aggregate using a combination of 
    30-day and 6-month recall periods.

    Parameters:
    - df: pandas.DataFrame, the dataset containing non-food expenditure data
    - NF_1M_expvars: list of str, the columns representing non-food expenditure variables with a 30-day recall period
    - NF_6M_expvars: list of str, the columns representing non-food expenditure variables with a 6-month recall period

    Returns:
    - pandas.DataFrame, the dataset with a new column 'temp_HHExpNF_1M' containing 
      the non-food expenditure aggregate adjusted to a monthly period.
    """

    # Compute non-food expenditure aggregate (30-day recall + 6-month recall adjusted to monthly)
    df[variable_name] = (
        df[NF_1M_expvars].sum(axis=1) +  # 30-day recall
        (df[NF_6M_expvars].sum(axis=1) / 6)  # Adjust 6-month recall to monthly
    )
    
    return df

def generate_zero_expenditure_flags(df):
    """
    Generate flags for zero food, non-food, and total expenditures.
    
    Parameters:
    - df: pandas.DataFrame, the dataset containing the expenditure aggregates
    
    Returns:
    - pandas.DataFrame, the dataset with new columns for zero food, non-food, and total expenditure flags.
    """

    df['zero_F'] = np.where(df['temp_HHExpF_1M'] == 0, 1, 0)
    df['zero_NF'] = np.where(df['temp_HHExpNF_1M'] == 0, 1, 0)
    df['zero_Total'] = np.where((df['temp_HHExpF_1M'] == 0) & (df['temp_HHExpNF_1M'] == 0), 1, 0)


    
    return df

def compute_summary_table(df):
    """
    Compute the count and percentage of households with zero expenditures.
    
    Parameters:
    - df: pandas.DataFrame, the dataset containing zero expenditure flags
    
    Returns:
    - pandas.DataFrame, summary table with counts and proportions of households with zero expenditures.
    """
    # Calculate the counts of zero expenditures
    zero_counts = df[['zero_F', 'zero_NF', 'zero_Total']].sum()
    
    # Calculate the proportions (mean of the binary flags)
    zero_proportions = df[['zero_F', 'zero_NF', 'zero_Total']].mean()

    # Create a DataFrame to store counts and proportions together
    summary_table = pd.DataFrame({
        'Count': zero_counts,
        'Proportion': zero_proportions
    })
    
    return summary_table

def export_summary_to_excel(df, admin_levels, output_dir="Outputs/Tables/1.Preliminary_Check"):
    """
    Export the summary of zero expenditures for the whole sample and by admin level to an Excel file.
    
    Parameters:
    - df: pandas.DataFrame, the dataset containing zero expenditure flags
    - admin_levels: list, the administrative levels to disaggregate the data
    - output_dir: str, the directory where the Excel file will be saved (default: "Outputs/Tables/1.Preliminary_Check")
    
    Returns:
    - None, the function exports the results to an Excel file.
    """
    # Ensure the output directory exists
    os.makedirs(output_dir, exist_ok=True)

    # Use ExcelWriter to write multiple sheets to the same Excel file
    with pd.ExcelWriter(f'{output_dir}/Preliminary_check.xlsx', engine="openpyxl", mode="w") as writer:
        # Step 1: Write the summary table for the whole sample
        summary_table = compute_summary_table(df)  # Use previously defined function
        summary_table.to_excel(writer, sheet_name="Whole_sample")

        # Step 2: Loop over each administrative level and calculate the summary for each
        for admin in admin_levels:
            if admin in df.columns and df[admin].notnull().any():  # Check if admin level exists in the DataFrame
                admin_grouped = df.groupby(admin, group_keys=False).apply(
                    lambda x: pd.Series({
                        'Count_zero_F': x['zero_F'].sum(),
                        'Proportion_zero_F': x['zero_F'].mean(),
                        'Count_zero_NF': x['zero_NF'].sum(),
                        'Proportion_zero_NF': x['zero_NF'].mean(),
                        'Count_zero_Total': x['zero_Total'].sum(),
                        'Proportion_zero_Total': x['zero_Total'].mean(),
                    }),
                    include_groups=False
                )
                # Step 3: Write the grouped results to a separate sheet for each admin level
                admin_grouped.to_excel(writer, sheet_name=admin)

def drop_temporary_columns(df, columns):
    """
    Drop the temporary columns created during the data cleaning process.

    Parameters:
    - df: pandas.DataFrame, the dataset containing the temporary columns

    Returns:
    - pandas.DataFrame, the dataset with the temporary columns dropped.
    """
    return df.drop(columns=columns)

#------------------------------------------------------------------------------*
#                5. Generating box plots and min-max reports
#------------------------------------------------------------------------------*

def generate_box_plots(df, variables, output_dir="Outputs/Graphs/2.Manual_Stage"):
    """
    Generate and save box plots for each variable in the dataset.
    
    Parameters:
    - df: pandas.DataFrame, the dataset containing the variables
    - variables: list, list of column names to generate box plots for
    - output_dir: str, the directory where the box plots will be saved (default: "Outputs/Graphs/2.Manual_Stage")
    
    Returns:
    - None, the function saves the box plots as PDF files in the specified directory.
    """
    # Ensure the output directory exists
    os.makedirs(output_dir, exist_ok=True)
    
    # Loop over each variable and create a box plot
    for var in variables:
        plt.figure()  # Create a new figure for each plot
        df.boxplot(column=var)  # Generate the box plot for the variable
        plt.title(f"Box Plot for {var}")  # Set the title of the plot
        plt.savefig(f"{output_dir}/boxplot_{var}.pdf")  # Save the plot as a PDF
        plt.close()  # Close the plot to free up memory and avoid display issues

def generate_minmax_report(df, variables, output_dir="Outputs/Tables/2.Manual_Stage"):
    """
    Generate a report showing the bottom and top 5 values for each variable.
    
    Parameters:
    - df: pandas.DataFrame, the dataset containing the variables
    - variables: list, list of column names to generate min/max reports for
    - output_dir: str, the directory where the report will be saved (default: "Outputs/Tables/2.Manual_Stage")
    
    Returns:
    - None, the function saves the MinMax report as an Excel file in the specified directory.
    """
    # Ensure the output directory exists
    os.makedirs(output_dir, exist_ok=True)

    minmax_dict = {}  # Dictionary to hold min/max values for each variable
    num_bottom_top = 5  # Number of top and bottom values to retrieve

    # Loop through each variable to compute bottom and top values
    for var in variables:
        # Drop missing values for the current variable
        non_missing = df[var].dropna()

        # Retrieve the bottom 5 and top 5 values, with padding if there are fewer than 5 values
        bottom_5 = non_missing.nsmallest(num_bottom_top).tolist() + [np.nan] * (num_bottom_top - len(non_missing.nsmallest(num_bottom_top)))
        top_5 = non_missing.nlargest(num_bottom_top).tolist() + [np.nan] * (num_bottom_top - len(non_missing.nlargest(num_bottom_top)))

        # Combine bottom and top values into a single list, using NaN as a separator
        minmax_dict[var] = bottom_5 + [np.nan] + top_5

    # Convert the min/max dictionary to a DataFrame
    minmax_df = pd.DataFrame(minmax_dict)

    # Set row labels for bottom/top values
    minmax_df.index = ["bottom"] * num_bottom_top + [" "] + ["top"] * num_bottom_top

    # Export the DataFrame to Excel
    minmax_df.to_excel(f'{output_dir}/MinMax.xlsx', index=True)

#------------------------------------------------------------------------------
#        6. Cleaning individual expenditure variables, statistical/automatic
#------------------------------------------------------------------------------

def express_per_capita(df, vars, hh_size_col='HHSize'):
    """
    Express expenditure variables in per capita terms.

    Parameters:
    - df: pandas.DataFrame, the dataset
    - all_expvars: list, list of column names to be divided by household size
    - hh_size_col: str, name of the household size column (default is 'HHSize')

    Returns:
    - df: pandas.DataFrame, the modified dataset with per capita values
    """
    # Create a dictionary to hold the new per capita columns
    pc_columns = {f'pc_{var}': df[var] / df[hh_size_col] for var in vars}
    
    # Use pd.concat to add all per capita columns to the DataFrame at once
    df = pd.concat([df, pd.DataFrame(pc_columns)], axis=1)
    return df

def apply_ihs_transformation(df, vars):
    """
    Apply the inverse hyperbolic sine (IHS) transformation to per capita expenditure variables.

    Parameters:
    - df: pandas.DataFrame, the dataset
    - all_expvars: list, list of per capita column names to transform

    Returns:
    - df: pandas.DataFrame, the dataset with transformed columns
    """
    # Apply IHS transformation for all variables
    transformed_columns = [f'tpc_{var}' for var in vars]
    df[transformed_columns] = np.log(df[[f'pc_{var}' for var in vars]] + np.sqrt(df[[f'pc_{var}' for var in vars]]**2 + 1))
    
    return df

def standardize_using_mad(df, vars):
    """
    Standardize the transformed variables using the Median Absolute Deviation (MAD).
    
    Parameters:
    - df: pandas.DataFrame, the dataset
    - all_expvars: list, list of per capita column names that have been transformed
    
    Returns:
    - df: pandas.DataFrame, the dataset with standardized columns
    """
    d_columns = {}
    z_columns = {}

    for var in vars:
        # Only calculate if there are any non-NaN values in the column
        if df[f'tpc_{var}'].notna().any():
            median = df[f'tpc_{var}'].median(skipna=True)
            d_value = np.abs(df[f'tpc_{var}'] - median)
            
            # Only calculate MAD if there are non-NaN values
            if d_value.notna().any():
                mad = d_value.median(skipna=True) * 1.4826
            else:
                mad = np.nan
            
            # Ensure no division by zero when MAD is 0
            z_score = (df[f'tpc_{var}'] - median) / mad if mad != 0 else np.nan
        else:
            # Handle case where the column is all NaNs
            d_value = np.nan
            z_score = np.nan

        # Store d and z scores
        d_columns[f'd_{var}'] = d_value
        z_columns[f'z_{var}'] = z_score

    # Concatenate all the new columns at once
    df = pd.concat([df, pd.DataFrame(d_columns), pd.DataFrame(z_columns)], axis=1)

    return df

def identify_outliers(df, vars):
    """
    Identify outliers based on MAD (3 MADs from the median).
    
    Parameters:
    - df: pandas.DataFrame
    - all_expvars: list of variables to check for outliers
    
    Returns:
    - df: DataFrame with z-scores and outlier flags
    """
    z_columns = {}
    o_columns = {}

    for var in vars:
        # Ensure the column exists and has non-NaN values
        if df[f'tpc_{var}'].notna().any():
            median = df[f'tpc_{var}'].median(skipna=True)
            d_value = np.abs(df[f'tpc_{var}'] - median)

            if d_value.notna().any():  # Only calculate MAD if non-NaN values exist
                mad = d_value.median(skipna=True) * 1.4826
            else:
                mad = np.nan

            # Calculate z-scores, avoiding division by zero
            z_score = pd.Series((df[f'tpc_{var}'] - median) / mad if mad != 0 else np.nan, index=df.index)
        else:
            # Handle case where the column is all NaNs
            z_score = pd.Series(np.nan, index=df.index)

        # Initialize outlier flags (0 = no outlier, 1 = bottom outlier, 2 = top outlier)
        outlier_flag = pd.Series(0, index=df.index)
        
        # Use notna() to handle NaN values before assigning outliers
        outlier_flag.loc[(z_score > 3) & z_score.notna()] = 2  # Top outliers
        outlier_flag.loc[(z_score < -3) & z_score.notna()] = 1  # Bottom outliers

        # Store z-scores and outlier flags
        z_columns[f'z_{var}'] = z_score
        o_columns[f'o_{var}'] = outlier_flag

    # Use pd.concat() to add all z-scores and outlier flags at once to the DataFrame
    df = pd.concat([df, pd.DataFrame(z_columns), pd.DataFrame(o_columns)], axis=1)
    
    return df

def replace_outliers_with_median(df, vars, admin_levels):
    """
    Replace outliers with medians in specified variables based on hierarchical admin levels.

    Parameters:
    - df: DataFrame, the dataset
    - vars: list, list of variables to check and replace outliers for
    - admin_levels: list, list of admin level columns in hierarchical order

    Returns:
    - df: DataFrame with outliers replaced by the median at the appropriate admin level
    """

    # Loop through each variable in the list of variables
    for var in vars:
        # Set outliers to NaN
        df.loc[df[f'o_{var}'].between(1, 2), f'pc_{var}'] = np.nan

        # Prepare a dictionary to hold new columns
        new_cols = {}

        # Compute median and count of valid observations at each admin level
        for i in reversed(range(len(admin_levels))):  # for levels 4 to 0
            admin_col = f'ADMIN{i}Name'
            if admin_col in df.columns:
                group = df.groupby(admin_col)[f'pc_{var}']
                new_cols[f'n{i}_{var}'] = group.transform(lambda x: x.notnull().sum())
                new_cols[f'm{i}_{var}'] = group.transform('median')

        # Add all new columns at once to avoid fragmentation
        df = pd.concat([df, pd.DataFrame(new_cols, index=df.index)], axis=1)

    # Replace outliers with median based on number of observations at each admin level
    for var in vars:
        # Default to national level
        df.loc[df[f'o_{var}'].between(1, 2), f'pc_{var}'] = df.loc[df[f'o_{var}'].between(1, 2), f'm0_{var}']

        if 'ADMIN1Name' in df.columns:
            # Admin level 1 if more than 150 observations
            df.loc[(df[f'o_{var}'].between(1, 2)) & (df[f'n1_{var}'] > 150), f'pc_{var}'] = df[f'm1_{var}']

        if 'ADMIN2Name' in df.columns:
            # Admin level 2 if more than 50 observations
            df.loc[(df[f'o_{var}'].between(1, 2)) & (df[f'n2_{var}'] > 50), f'pc_{var}'] = df[f'm2_{var}']

        if 'ADMIN3Name' in df.columns:
            # Admin level 3 if more than 15 observations
            df.loc[(df[f'o_{var}'].between(1, 2)) & (df[f'n3_{var}'] > 15), f'pc_{var}'] = df[f'm3_{var}']

        if 'ADMIN4Name' in df.columns:
            # Admin level 4 if more than 5 observations
            df.loc[(df[f'o_{var}'].between(1, 2)) & (df[f'n4_{var}'] > 5), f'pc_{var}'] = df[f'm4_{var}']

    return df

#------------------------------------------------------------------------------
#       7. Cleaning aggregate expenditure variables, statistical/automatic
#------------------------------------------------------------------------------

def generate_list_pc_columns(variable_list):
    """
    Generate a list of per capita (pc_) column names based on the provided list of variables.

    Parameters:
    - variable_list: list of str, original variable names (e.g., F_expvars, NF_1M_expvars, etc.)

    Returns:
    - list of str, corresponding per capita column names with 'pc_' prefix
    """
    # Return a new list with 'pc_' prefix added to each variable name in the input list
    return [f"pc_{var}" for var in variable_list]

def reconcile_exp_variables(df, F_expvars, NF_1M_expvars, NF_6M_expvars, all_expvars):
    """
    Reconcile single expenditure variables with modified aggregates for outliers.

    Parameters:
    df (pd.DataFrame): The DataFrame containing expenditure data.
    F_expvars (list): List of food expenditure variables.
    NF_1M_expvars (list): List of non-food expenditure variables with 1M recall.
    NF_6M_expvars (list): List of non-food expenditure variables with 6M recall.
    all_expvars (list): List of all expenditure variables.

    Returns:
    df: DataFrame with cleaned and reconciled per capita expenditure variables.
    """
    # Food expenditures ----------------------------------------------------------
    PC_F_expvars = [f'pc_{var}' for var in F_expvars]
    df['temp_F'] = df[PC_F_expvars].sum(axis=1)

    # Calculate all share variables for food at once
    food_shares = {f's{var}': df[f'pc_{var}'] / df['temp_F'] for var in F_expvars}
    food_shares_df = pd.DataFrame(food_shares).fillna(0)
    df = pd.concat([df, food_shares_df], axis=1)

    s_F_expvars = [f's{var}' for var in F_expvars]
    filtered_df = df[(df['temp_F'] > 0) & (~df['o_HHExpF_1M'].isin([1, 2]))]
    mean_shares_filtered = filtered_df[s_F_expvars].mean()

    # Apply updates for food variables
    food_updates = {
        f'pc_{var}': df['pc_HHExpF_1M'] * mean_shares_filtered[f's{var}']
        for var in F_expvars
    }

    # Update food expenditure values for outliers in one step
    df.update(pd.DataFrame(food_updates).where(df['o_HHExpF_1M'].isin([1, 2])))

    # Non-Food expenditures ----------------------------------------------------------
    for var in NF_6M_expvars:
        df[f'pc_{var}'] /= 6

    PC_NF_1M_expvars = [f'pc_{var}' for var in NF_1M_expvars]
    PC_NF_6M_expvars = [f'pc_{var}' for var in NF_6M_expvars]
    df['temp_NF'] = df[PC_NF_1M_expvars + PC_NF_6M_expvars].sum(axis=1)

    # Calculate all share variables for non-food at once
    non_food_shares = {f's{var}': df[f'pc_{var}'] / df['temp_NF'] for var in NF_1M_expvars + NF_6M_expvars}
    non_food_shares_df = pd.DataFrame(non_food_shares).fillna(0)
    df = pd.concat([df, non_food_shares_df], axis=1)

    s_NF_1M_expvars = [f's{var}' for var in NF_1M_expvars]
    s_NF_6M_expvars = [f's{var}' for var in NF_6M_expvars]
    filtered_df = df[(df['temp_NF'] > 0) & (~df['o_HHExpNF_1M'].isin([1, 2]))]
    mean_shares_filtered = filtered_df[s_NF_1M_expvars + s_NF_6M_expvars].mean()

    # Apply updates for non-food variables
    non_food_updates = {
        f'pc_{var}': df['pc_HHExpNF_1M'] * mean_shares_filtered[f's{var}']
        for var in NF_1M_expvars + NF_6M_expvars
    }

    # Update non-food expenditure values for outliers in one step
    df.update(pd.DataFrame(non_food_updates).where(df['o_HHExpNF_1M'].isin([1, 2])))

    # Re-express expenditure vars with 6M recall into 6M period
    for var in NF_6M_expvars:
        df[f'pc_{var}'] *= 6

    # Drop temporary columns ----------------------------------------------------------
    df.drop(['pc_HHExpF_1M', 'pc_HHExpNF_1M', 'temp_F', 'temp_NF'], axis=1, inplace=True, errors='ignore')

    # Drop temporary share columns
    drop_columns = [f's{var}' for var in all_expvars] + [f'as{var}' for var in all_expvars]
    df.drop(drop_columns, axis=1, inplace=True, errors='ignore')

    return df

def retransform_per_capita_to_household(df, vars, hh_size_col='HHSize'):
    """
    Re-transform single expenditure variables from per capita to household terms.

    Parameters:
    - df: pandas.DataFrame, the dataset containing per capita variables
    - vars: list of str, list of original column names (e.g., ['HHExpFCer_Purch_MN', ...])
    - hh_size_col: str, name of the household size column (default is 'HHSize')

    Returns:
    - df: pandas.DataFrame, the dataset with expenditure variables re-transformed to household terms
    """
    for var in vars:
        pc_var = f'pc_{var}'  # per capita column name
        if pc_var in df.columns:
            # Multiply per capita values by household size to get household expenditure
            df[var] = df[pc_var] * df[hh_size_col]
    return df

#------------------------------------------------------------------------------*
#                            Main cleaning Code
#------------------------------------------------------------------------------*

import pandas as pd
import numpy as np
import os
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

# Load the data (Adjust the path as needed)
df = pd.read_csv('Expcleaning_Sample_Raw.csv')

# Check if all columns exist in the DataFrame
check_columns_exist(df, all_expvars + admin_levels + [hhsize_var, enumerator_var])

# Set zero and negative values to missing
df = set_zero_negative_to_missing(df, all_expvars)

# Aggregating Food and Non-Food Expenditures
df = compute_food_aggregate(df, F_expvars, 'temp_HHExpF_1M')
df = compute_nonfood_aggregate(df, NF_1M_expvars, NF_6M_expvars, 'temp_HHExpNF_1M')

# Preliminary checks regarding the usability of the expenditure data
df = generate_zero_expenditure_flags(df)
export_summary_to_excel(df, admin_levels)
df = drop_temporary_columns(df, ['temp_HHExpF_1M', 'temp_HHExpNF_1M'])

# Generating box plots and min-max reports
# generate_box_plots(df, all_expvars) # Optinal, uncomment this line if you want to generate box plots for each variable
generate_minmax_report(df, all_expvars)

# Cleaning individual expenditure variables, statistical/automatic
df = express_per_capita(df, all_expvars)
df = apply_ihs_transformation(df, all_expvars)
df = standardize_using_mad(df, all_expvars)
df = identify_outliers(df, all_expvars)
df = replace_outliers_with_median(df, all_expvars, admin_levels)

# Dropping temporary columns
col_prefixes = ['tpc', 'd', 'z', 'o', 'n0', 'm0', 'n1', 'n2', 'n3', 'n4', 'm1', 'm2', 'm3', 'm4']
indv_column_dict = {prefix: [f'{prefix}_{col}' for col in all_expvars] for prefix in col_prefixes}
indv_columns_to_drop = [col for cols in indv_column_dict.values() for col in cols] # # Combine all columns to drop into a single list
df = drop_temporary_columns(df, indv_columns_to_drop)

# Cleaning aggregate expenditure variables, statistical/automatic
PC_F_expvars = generate_list_pc_columns(F_expvars)
PC_NF_1M_expvars = generate_list_pc_columns(NF_1M_expvars)
PC_NF_6M_expvars = generate_list_pc_columns(NF_6M_expvars)
PC_NF_expvars = NF_1M_expvars + NF_6M_expvars
aggr_base_vars = ['HHExpF_1M', 'HHExpNF_1M']
df = compute_food_aggregate(df, PC_F_expvars, 'pc_HHExpF_1M')
df = compute_nonfood_aggregate(df, PC_NF_1M_expvars, PC_NF_6M_expvars, 'pc_HHExpNF_1M')
df = apply_ihs_transformation(df, aggr_base_vars)
df = standardize_using_mad(df, aggr_base_vars)
df = identify_outliers(df, aggr_base_vars)
df = replace_outliers_with_median(df, aggr_base_vars, admin_levels)
df = reconcile_exp_variables(df, F_expvars, NF_1M_expvars, NF_6M_expvars, all_expvars)
df = retransform_per_capita_to_household(df, all_expvars, hh_size_col='HHSize')

# Dropping temporary columns
aggr_column_dict = {prefix: [f'{prefix}_{col}' for col in aggr_base_vars] for prefix in col_prefixes}
aggr_columns_to_drop = [col for cols in aggr_column_dict.values() for col in cols] # # Combine all columns to drop into a single list
df = drop_temporary_columns(df, aggr_columns_to_drop)
