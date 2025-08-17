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
    git clone [https://github.com/rajat1026/telecom-churn-prediction.git]
    cd telecom-churn-prediction
    ```

3.  **Install Packages**: The required R packages are listed at the top of each script. Key packages include `mice`, `randomForest`, `caret`, and `ROCR`.

4.  **Run the Scripts**:
    * Execute `scripts/01_Data_Preprocessing.R` to clean and impute the raw data.
    * Execute `scripts/02_Model_Development.R` to train the Logistic Regression and Random Forest models and evaluate their performance.

---


Here is the complete content to paste into your README.md file. It combines information from your project report, code, and the original problem statement to create a comprehensive overview.

Markdown

# Predicting Customer Churn in the Telecommunications Industry

## 📝 Project Overview

[cite_start]This project aims to develop a predictive model to identify telecommunications customers who are likely to "churn"—or voluntarily terminate their service[cite: 3, 192]. [cite_start]In the highly competitive wireless industry, where annual churn rates can be as high as 20-40%, accurately predicting churn allows for proactive retention strategies, such as targeted communication and incentive programs[cite: 4, 194].

This repository documents the entire process, from data preprocessing to model development and evaluation. [cite_start]The final recommendation is a **Random Forest model**, which demonstrated superior performance in identifying at-risk customers[cite: 103, 153]. [cite_start]The goal is to provide a reliable tool to reduce customer attrition, which is a critical challenge to the profitability of wireless carriers[cite: 100].

---

## 📂 The Dataset

[cite_start]The data for this project was provided by the Teradata Center for Customer Relationship Management at Duke University and consists of three main files[cite: 196, 255]:

* **Calibration Data**: Contains 100,000 customer records with 171 predictor variables and a churn indicator. [cite_start]This dataset is used to train the predictive models[cite: 6, 198, 256].
* [cite_start]**Current Score Data**: Includes 51,306 customer records with the same 171 predictor variables but without the churn indicator[cite: 199, 256].
* [cite_start]**Future Score Data**: Consists of 100,462 customer records, also with predictor variables but no churn indicator[cite: 199, 256].

[cite_start]The predictor variables cover behavioral data, company interaction data, and customer household demographics[cite: 265, 266]. [cite_start]A key feature of the calibration data is that churners were oversampled to create a nearly 50-50 split, which helps in training a balanced model[cite: 271].

---

## 🛠️ Methodology

### Data Preprocessing

1.  [cite_start]**Variable Selection**: The initial set of 172 fields was reduced to 78 candidate predictor variables through multivariate analysis to remove redundant attributes[cite: 128].

2.  [cite_start]**Missing Value Imputation**: To handle missing data, **MICE (Multivariate Imputation by Chained Equations)** was used[cite: 9, 129]. [cite_start]This method was chosen over simpler mean/median imputation because it considers the relationships between variables, reducing bias and effectively handling non-linear relationships through the CART method[cite: 10, 13, 14].

### Model Development

[cite_start]The preprocessed data was split into a **70% training set (`dt`)** and a **30% validation set (`dv`)** to build and test the models[cite: 34, 65]. Two primary models were developed:

#### 1. Logistic Regression

* [cite_start]**Reasoning**: A baseline model was created using Logistic Regression because it is specifically designed for binary outcomes like churn (yes/no) and is less prone to overfitting than more complex models[cite: 55, 59].
* [cite_start]**Performance**: The model produced a **Gini Coefficient of 26.08%**, which was deemed too low for effective prediction, indicating it was only marginally better than random classification[cite: 148, 149].

#### 2. Random Forest (Recommended Model) 🏆

* [cite_start]**Reasoning**: Random Forest was chosen for its high accuracy, robustness against overfitting, and its ability to handle both numerical and categorical data while providing insights into feature importance[cite: 83, 84, 86, 87].
* **Performance**: The Random Forest model achieved a much better result:
    * [cite_start]**Accuracy**: ~62%[cite: 153].
    * [cite_start]**Sensitivity**: 63% (correctly identifies churners)[cite: 154].
    * [cite_start]**Specificity**: 61% (correctly identifies non-churners)[cite: 156].
    * [cite_start]**AUC**: 0.67[cite: 163].
    * [cite_start]**Gini Coefficient**: 0.34[cite: 174].

[cite_start]The model proved to be moderately effective at distinguishing between churners and non-churners[cite: 174]. [cite_start]An optimal probability **cutoff of 0.15** was selected to maximize the identification of potential churners without excessively misclassifying loyal customers[cite: 171].

---

## 🚀 How to Use This Repository

1.  **Prerequisites**: Ensure you have R and RStudio installed.

2.  **Clone the Repository**:
    ```bash
    git clone [https://github.com/your-username/telecom-churn-prediction.git](https://github.com/your-username/telecom-churn-prediction.git)
    cd telecom-churn-prediction
    ```

3.  **Install Packages**: The required R packages are listed at the top of each script. Key packages include `mice`, `randomForest`, `caret`, and `ROCR`.

4.  **Run the Scripts**:
    * Execute `scripts/01_Data_Preprocessing.R` to clean and impute the raw data.
    * Execute `scripts/02_Model_Development.R` to train the Logistic Regression and Random Forest models and evaluate their performance.

---

## 📁 Repository Structure

.
├── .gitignore
├── README.md
├── data/
│   └── (Your data files would go here)
├── report/
│   └── BIA Term Project Report - Final.docx
└── scripts/
├── 01_Data_Preprocessing.R
└── 02_Model_Development.R
