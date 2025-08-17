# Predicting Customer Churn in the Telecommunications Industry

## 📝 Project Overview

This project aims to develop a predictive model to identify telecommunications customers who are likely to "churn"—or voluntarily terminate their service. In the highly competitive wireless industry, where annual churn rates can be as high as 20-40%, accurately predicting churn allows for proactive retention strategies, such as targeted communication and incentive programs.

This repository documents the entire process, from data preprocessing to model development and evaluation. The final recommendation is a **Random Forest model**, which demonstrated superior performance in identifying at-risk customers. The goal is to provide a reliable tool to reduce customer attrition, which is a critical challenge to the profitability of wireless carriers.

---

## 📂 The Dataset

The data for this project was provided by the Data Center for Customer Relationship Management at University and consists of three main files:

**Calibration Data**: Contains 100,000 customer records with 171 predictor variables and a churn indicator. This dataset is used to train the predictive models.
**Current Score Data**: Includes 51,306 customer records with the same 171 predictor variables but without the churn indicator.
**Future Score Data**: Consists of 100,462 customer records, also with predictor variables but no churn indicator.

The predictor variables cover behavioral data, company interaction data, and customer household demographics. A key feature of the calibration data is that churners were oversampled to create a nearly 50-50 split, which helps in training a balanced model.

---

## 🛠️ Methodology

### Data Preprocessing

1.  **Variable Selection**: The initial set of 172 fields was reduced to 78 candidate predictor variables through multivariate analysis to remove redundant attributes.

2.  **Missing Value Imputation**: To handle missing data, **MICE (Multivariate Imputation by Chained Equations)** was used. This method was chosen over simpler mean/median imputation because it considers the relationships between variables, reducing bias and effectively handling non-linear relationships through the CART method.

### Model Development

The preprocessed data was split into a **70% training set (`dt`)** and a **30% validation set (`dv`)** to build and test the models. Two primary models were developed:

#### 1. Logistic Regression

**Reasoning**: A baseline model was created using Logistic Regression because it is specifically designed for binary outcomes like churn (yes/no) and is less prone to overfitting than more complex models.
**Performance**: The model produced a **Gini Coefficient of 26.08%**, which was deemed too low for effective prediction, indicating it was only marginally better than random classification.

#### 2. Random Forest (Recommended Model) 🏆

**Reasoning**: Random Forest was chosen for its high accuracy, robustness against overfitting, and its ability to handle both numerical and categorical data while providing insights into feature importance.\
**Performance**: The Random Forest model achieved a much better result:
    * **Accuracy**: ~62%
    * **Sensitivity**: 63% (correctly identifies churners).
    * **Specificity**: 61% (correctly identifies non-churners)
    * **AUC**: 0.67
    * **Gini Coefficient**: 0.34

The model proved to be moderately effective at distinguishing between churners and non-churners. An optimal probability **cutoff of 0.15** was selected to maximize the identification of potential churners without excessively misclassifying loyal customers.

---

## 🚀 How to Use This Repository

1.  **Prerequisites**: Ensure you have R and RStudio installed.

2.  **Clone the Repository**:
    ```bash
    git clone [https://github.com/your-username/telecom-churn-prediction.git](https://github.com/rajat1026/telecom-churn-prediction.git)
    cd telecom-churn-prediction
    ```

3.  **Install Packages**: The required R packages are listed at the top of each script. Key packages include `mice`, `randomForest`, `caret`, and `ROCR`.

4.  **Run the Scripts**:
    * Execute `scripts/01_Data_Preprocessing.R` to clean and impute the raw data.
    * Execute `scripts/02_Model_Development.R` to train the Logistic Regression and Random Forest models and evaluate their performance.

---
