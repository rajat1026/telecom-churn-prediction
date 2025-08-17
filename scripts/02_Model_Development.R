# ------------------------------------------------------------------
# SCRIPT: 02_Model_Development.R
# PURPOSE: Train and evaluate Logistic Regression and Random Forest
#          models for churn prediction.
# ------------------------------------------------------------------

# 1. SETUP AND DATA LOADING
# ------------------------------------------------------------------
# Install necessary packages if you don't have them
# install.packages(c("caret", "ROCR", "lift", "randomForest", "ggplot2", "e1071"))

library(caret)
library(ROCR)
library(lift)
library(randomForest)
library(ggplot2)

# Set working directory to the project's root (update this path if needed)
# setwd("path/to/your/telecom-churn-prediction")

# Load the preprocessed dataset
final_data <- read.csv("data/final_data_updated.csv")
print("Preprocessed data loaded.")

# 2. DATA PREPARATION
# ------------------------------------------------------------------
# Set a seed for reproducibility
set.seed(100)

# Split data into 70% training and 30% validation
train_index <- createDataPartition(final_data$churn, p = 0.7, list = FALSE)
train_data <- final_data[train_index, ]
validation_data <- final_data[-train_index, ]

print(paste("Training set size:", nrow(train_data)))
print(paste("Validation set size:", nrow(validation_data)))

# 3. MODEL 1: LOGISTIC REGRESSION
# ------------------------------------------------------------------
print("--- Training Logistic Regression Model ---")

# Train the model
lr_model <- glm(churn ~ ., data = train_data, family = "binomial")

# Get model summary and ANOVA table
print(summary(lr_model))
anova(lr_model, test = "Chisq")

# Predict on validation data
lr_probs <- predict(lr_model, newdata = validation_data, type = "response")

# --- Evaluation ---
# Create prediction object for ROCR
lr_pred_obj <- prediction(lr_probs, validation_data$churn)

# ROC Curve
lr_perf <- performance(lr_pred_obj, "tpr", "fpr")
plot(lr_perf, main = "ROC Curve - Logistic Regression", colorize = TRUE)

# AUC
lr_auc <- performance(lr_pred_obj, measure = "auc")@y.values[[1]]
print(paste("Logistic Regression AUC:", round(lr_auc, 4)))

# Gini Coefficient
lr_gini <- 2 * lr_auc - 1
print(paste("Logistic Regression Gini Coefficient:", round(lr_gini, 4)))

# Confusion Matrix at a 0.15 cutoff
lr_class_15 <- ifelse(lr_probs > 0.15, 1, 0)
print("Confusion Matrix for LR at cutoff = 0.15:")
print(table(Actual = validation_data$churn, Predicted = lr_class_15))

# 4. MODEL 2: RANDOM FOREST (RECOMMENDED)
# ------------------------------------------------------------------
print("--- Training Random Forest Model ---")

# Convert churn to a factor for classification
train_data$churn <- as.factor(train_data$churn)
validation_data$churn <- as.factor(validation_data$churn)

# Train the model
# NOTE: ntree can be lowered for faster execution during testing (e.g., ntree = 100)
rf_model <- randomForest(churn ~ ., data = train_data, ntree = 500)

# Print model summary
print(rf_model)

# --- Evaluation ---
# Predict probabilities and classes on validation data
rf_probs <- predict(rf_model, newdata = validation_data, type = "prob")[, "1"]
rf_class <- predict(rf_model, newdata = validation_data)

# Confusion Matrix (using the default 0.5 threshold from the model)
print("Confusion Matrix for Random Forest (default cutoff):")
confusionMatrix(rf_class, validation_data$churn, positive = "1")

# Create prediction object for ROCR
rf_pred_obj <- prediction(rf_probs, validation_data$churn)

# ROC Curve
rf_perf <- performance(rf_pred_obj, "tpr", "fpr")
plot(rf_perf, main = "ROC Curve - Random Forest", colorize = TRUE)

# AUC
rf_auc <- performance(rf_pred_obj, measure = "auc")@y.values[[1]]
print(paste("Random Forest AUC:", round(rf_auc, 4)))

# Gini Coefficient
rf_gini <- 2 * rf_auc - 1
print(paste("Random Forest Gini Coefficient:", round(rf_gini, 4)))

# Confusion Matrix at the recommended 0.15 cutoff
rf_class_15 <- ifelse(rf_probs > 0.15, "1", "0")
print("Confusion Matrix for RF at cutoff = 0.15:")
print(table(Actual = validation_data$churn, Predicted = as.factor(rf_class_15)))

# Lift Chart
plotLift(rf_probs, validation_data$churn, cumulative = TRUE)
title("Cumulative Lift Chart - Random Forest")

print("--- Model Development Complete ---")