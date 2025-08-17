# ------------------------------------------------------------------
# SCRIPT: 01_Data_Preprocessing.R
# PURPOSE: Load raw data, handle missing values for continuous and
#          categorical variables, and create a final, clean dataset.
# ------------------------------------------------------------------

# 1. SETUP
# ------------------------------------------------------------------
# Install necessary packages if you don't have them
# install.packages(c("mice", "fastDummies"))

library(mice)
library(fastDummies)

# Set working directory to the project's root (update this path if needed)
# setwd("path/to/your/telecom-churn-prediction")

# Load raw data
raw_data <- read.csv("data/calibration.csv", na.strings = c("", " ", "NA", "N/A"))
print("Raw data loaded.")

# 2. IMPUTE CONTINUOUS VARIABLES
# ------------------------------------------------------------------
print("Starting imputation for continuous variables...")

# Manually impute 'retdays' where NA means the customer has not returned a phone
raw_data$retdays[is.na(raw_data$retdays)] <- 0

# Define the list of continuous variables needing imputation
continuous_vars <- c("adjqty", "attempt_Mean", "avg3qty", "avg6qty", "avgqty", "blck_dat_Mean",
                     "blck_vce_Mean", "callfwdv_Mean", "callwait_Mean", "comp_dat_Mean",
                     "comp_vce_Mean", "complete_Mean", "custcare_Mean", "da_Mean", "datovr_Mean",
                     "drop_dat_Mean", "drop_vce_Mean", "eqpdays", "inonemin_Mean",
                     "iwylis_vce_Mean", "months", "mou_Mean", "mou_rvce_Mean", "owylis_vce_Mean",
                     "opk_dat_Mean", "opk_vce_Mean", "peak_dat_Mean", "peak_vce_Mean",
                     "plcd_dat_Mean", "plcd_vce_Mean", "recv_sms_Mean", "recv_vce_Mean",
                     "rev_Mean", "roam_Mean", "threeway_Mean", "totcalls", "totmrc_Mean",
                     "totrev", "unan_dat_Mean", "unan_vce_Mean", "vceovr_Mean")

continuous_subset <- raw_data[, continuous_vars]

# Use MICE with the CART method for imputation
imputed_continuous_mice <- mice(continuous_subset, method = 'cart', m = 2, maxit = 3)
imputed_continuous_data <- complete(imputed_continuous_mice)

# Add back the manually imputed 'retdays' column
imputed_continuous_data$retdays <- raw_data$retdays

print("Continuous variable imputation complete.")

# 3. IMPUTE CATEGORICAL VARIABLES
# ------------------------------------------------------------------
print("Starting imputation for categorical variables...")

# Define categorical variables
categorical_vars <- c("actvsubs", "adults", "age1", "age2", "area", "asl_flag", "car_buy", "creditcd", "crtcount",
                      "div_type", "dualband", "ethnic", "forgntvl", "hnd_price", "hnd_webcap", "income",
                      "kid16_17", "lor", "mailflag", "marital", "models", "new_cell", "ownrent", "pcowner",
                      "phones", "REF_QTY", "refurb_new", "kid11_15", "solflag", "tot_acpt", "tot_ret",
                      "uniqsubs", "churn")

categorical_subset <- raw_data[, categorical_vars]

# Manual imputation for variables where NA has a clear business meaning
categorical_subset$crtcount[is.na(categorical_subset$crtcount)] <- "0"
categorical_subset$mailflag[is.na(categorical_subset$mailflag)] <- "Y"
categorical_subset$REF_QTY[is.na(categorical_subset$REF_QTY)] <- "0"
categorical_subset$solflag[is.na(categorical_subset$solflag)] <- "Y"
categorical_subset$tot_ret[is.na(categorical_subset$tot_ret)] <- "0"
categorical_subset$pcowner[is.na(categorical_subset$pcowner)] <- "N"
categorical_subset$div_type[is.na(categorical_subset$div_type)] <- "NAS"

# Create dummy variables for 'tot_acpt'
categorical_subset <- dummy_cols(categorical_subset, select_columns = "tot_acpt",
                                 remove_first_dummy = TRUE, remove_selected_columns = TRUE)

# Fill NAs in new dummy columns with 0
dummy_names <- names(categorical_subset)[grepl("tot_acpt_", names(categorical_subset))]
for (col in dummy_names) {
    categorical_subset[[col]][is.na(categorical_subset[[col]])] <- 0
}

# Impute remaining categorical variables using MICE
vars_for_mice_cat <- c("adults", "age1", "age2", "area", "car_buy", "creditcd", "ethnic", "forgntvl",
                       "hnd_price", "hnd_webcap", "income", "kid16_17", "lor", "marital", "ownrent", "kid11_15")

df_for_mice <- as.data.frame(lapply(categorical_subset[, vars_for_mice_cat], as.factor))
imputed_cat_mice <- mice(df_for_mice, method = 'cart', m = 2, maxit = 3)
imputed_cat_data <- complete(imputed_cat_mice)

# Combine manually and MICE-imputed categorical data
final_categorical_data <- categorical_subset[, !(names(categorical_subset) %in% vars_for_mice_cat)]
final_categorical_data <- cbind(final_categorical_data, imputed_cat_data)

print("Categorical variable imputation complete.")

# 4. COMBINE AND SAVE FINAL DATASET
# ------------------------------------------------------------------
final_data <- cbind(imputed_continuous_data, final_categorical_data)
write.csv(final_data, "data/final_data_updated.csv", row.names = FALSE)

print("Preprocessing complete. Cleaned data saved to 'data/final_data_updated.csv'.")