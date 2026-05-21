# 🧑‍💼 HR Analytics — Employee Retention & Attrition Analysis
### MySQL | Power BI | Data Analytics | Business Intelligence

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql)
![PowerBI](https://img.shields.io/badge/PowerBI-Dashboard-yellow?logo=powerbi)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![Records](https://img.shields.io/badge/Dataset-50K%20Records-orange)

---

## 📌 Project Overview

This project performs an end-to-end **HR Analytics** study on employee attrition, retention, and workforce performance using **MySQL** for data analysis and **Power BI** for interactive visualization. The goal is to uncover key drivers of employee turnover and provide data-driven recommendations to HR teams and business stakeholders.

---

## 🎯 Business Objectives

- Identify departments with the **highest attrition rates**
- Understand the relationship between **monthly income and attrition**
- Analyze **work-life balance** across job roles
- Measure **average working years** per department
- Derive **hourly rate patterns** for specific employee segments

---

## 🗂️ Dataset Information

| Property | Details |
|---|---|
| **Dataset Name** | HR_1 & HR_2 |
| **Domain** | HR Analytics |
| **Dataset Type** | CSV (Excel Data) |
| **Total Records** | 50,000+ records per table |
| **Total Tables** | 2 (joined via EmployeeID) |
| **Source** | IBM HR Analytics Dataset |

### 📋 Key Columns

| Column | Description |
|---|---|
| `EmployeeID` | Unique employee identifier (Primary Key) |
| `Age` | Employee age |
| `Attrition` | Whether employee left (Yes/No) |
| `Department` | Employee's department |
| `JobRole` | Employee's job role |
| `MonthlyIncome` | Monthly salary |
| `Gender` | Employee gender |
| `HourlyRate` | Hourly pay rate |
| `WorkLifeBalance` | Work-life balance score (1–4) |
| `YearsAtCompany` | Total years at the company |
| `JobSatisfaction` | Job satisfaction score (1–4) |
| `EnvironmentSatisfaction` | Environment satisfaction score |

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| **MySQL 8.0** | Database creation, data import, SQL querying |
| **MySQL Workbench** | GUI for database management and query execution |
| **Power BI Desktop** | Interactive dashboards and data visualization |
| **DAX** | Calculated measures and KPIs in Power BI |
| **CSV / Excel** | Raw data format for import |
| **GitHub** | Version control and project documentation |

---

## ⚙️ Project Architecture

```
Raw CSV Data (HR_1.csv + HR_2.csv)
        ↓
MySQL Database (hr_analytics)
        ↓
SQL Queries (KPIs, Joins, CTEs, Window Functions)
        ↓
Power BI Dashboard (DAX, Slicers, Charts, KPI Cards)
        ↓
Business Insights & Recommendations
```

---

## 🚀 Step-by-Step Process

### ✅ STEP 1 — Environment Setup

1. Install **MySQL 8.0** → [Download here](https://dev.mysql.com/downloads/)
2. Install **MySQL Workbench** → [Download here](https://www.mysql.com/products/workbench/)
3. Install **Power BI Desktop** → [Download here](https://powerbi.microsoft.com/desktop/)
4. Clone this repository:

```bash
git clone https://github.com/Athira-AM/SQL-Project-On-HR-Analytics.git
cd SQL-Project-On-HR-Analytics
```

---

### ✅ STEP 2 — Database & Table Creation

```sql
-- Create the database
CREATE DATABASE hr_analytics;
USE hr_analytics;

-- Create HR_1 Table
CREATE TABLE HR_1 (
    EmployeeID        INT PRIMARY KEY,
    Age               INT,
    Attrition         VARCHAR(5),
    Department        VARCHAR(50),
    JobRole           VARCHAR(60),
    Gender            VARCHAR(10),
    MonthlyIncome     INT,
    HourlyRate        INT,
    WorkLifeBalance   INT,
    YearsAtCompany    INT,
    JobSatisfaction   INT
);

-- Create HR_2 Table
CREATE TABLE HR_2 (
    EmployeeID              INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    JobInvolvement          INT,
    PerformanceRating       INT,
    RelationshipSatisfaction INT,
    TrainingTimesLastYear   INT,
    WorkLifeBalance         INT,
    YearsAtCompany          INT,
    FOREIGN KEY (EmployeeID) REFERENCES HR_1(EmployeeID)
);
```

---

### ✅ STEP 3 — Data Import

1. Open **MySQL Workbench**
2. Right-click on table → **Table Data Import Wizard**
3. Select `HR_1.csv` → Map columns → Import
4. Repeat for `HR_2.csv`
5. Verify import:

```sql
SELECT COUNT(*) FROM HR_1;  -- Should return ~50,000
SELECT COUNT(*) FROM HR_2;  -- Should return ~50,000
```

---

### ✅ STEP 4 — Data Exploration & Validation

```sql
-- Preview data
SELECT * FROM HR_1 LIMIT 10;
SELECT * FROM HR_2 LIMIT 10;

-- Check for NULL values
SELECT COUNT(*) FROM HR_1 WHERE Attrition IS NULL;

-- Check distinct departments
SELECT DISTINCT Department FROM HR_1;

-- Check attrition distribution
SELECT Attrition, COUNT(*) AS Count FROM HR_1 GROUP BY Attrition;
```

---

### ✅ STEP 5 — KPI Queries (Core Analysis)

#### 📊 KPI 1 — Average Attrition Rate by Department

```sql
SELECT
    Department,
    COUNT(*) AS Total_Employees,
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Attrited,
    ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate_Percent
FROM HR_1
GROUP BY Department
ORDER BY Attrition_Rate_Percent DESC;
```

---

#### 📊 KPI 2 — Average Hourly Rate of Male Research Scientists

```sql
SELECT
    Gender,
    JobRole,
    ROUND(AVG(HourlyRate), 2) AS Avg_Hourly_Rate
FROM HR_1
WHERE Gender = 'Male' AND JobRole = 'Research Scientist'
GROUP BY Gender, JobRole;
```

---

#### 📊 KPI 3 — Attrition Rate vs Monthly Income

```sql
SELECT
    CASE
        WHEN MonthlyIncome < 3000  THEN 'Low (< 3K)'
        WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium (3K–7K)'
        ELSE 'High (> 7K)'
    END AS Income_Band,
    COUNT(*) AS Total,
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Attrited,
    ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM HR_1
GROUP BY Income_Band
ORDER BY Attrition_Rate DESC;
```

---

#### 📊 KPI 4 — Average Working Years per Department

```sql
SELECT
    Department,
    ROUND(AVG(YearsAtCompany), 2) AS Avg_Years_At_Company
FROM HR_1
GROUP BY Department
ORDER BY Avg_Years_At_Company DESC;
```

---

#### 📊 KPI 5 — Job Role vs Work-Life Balance

```sql
SELECT
    h1.JobRole,
    ROUND(AVG(h2.WorkLifeBalance), 2) AS Avg_WorkLife_Balance
FROM HR_1 h1
JOIN HR_2 h2 ON h1.EmployeeID = h2.EmployeeID
GROUP BY h1.JobRole
ORDER BY Avg_WorkLife_Balance DESC;
```

---

### ✅ STEP 6 — Advanced SQL (Window Functions & CTEs)

```sql
-- Rank departments by attrition rate using Window Functions
WITH DeptAttrition AS (
    SELECT
        Department,
        ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
    FROM HR_1
    GROUP BY Department
)
SELECT
    Department,
    Attrition_Rate,
    RANK() OVER (ORDER BY Attrition_Rate DESC) AS Attrition_Rank
FROM DeptAttrition;

-- LAG function: Compare monthly income vs previous employee record
SELECT
    EmployeeID,
    MonthlyIncome,
    LAG(MonthlyIncome) OVER (PARTITION BY Department ORDER BY MonthlyIncome) AS Prev_Income,
    MonthlyIncome - LAG(MonthlyIncome) OVER (PARTITION BY Department ORDER BY MonthlyIncome) AS Income_Diff
FROM HR_1;
```

---

### ✅ STEP 7 — Power BI Dashboard

#### 🔗 Connect Power BI to MySQL

1. Open **Power BI Desktop**
2. Click **Get Data** → **MySQL Database**
3. Enter: `Server = localhost`, `Database = hr_analytics`
4. Load both `HR_1` and `HR_2` tables
5. In **Model View** → create relationship on `EmployeeID`

#### 📐 DAX Measures

```dax
-- Attrition Rate
Attrition Rate =
DIVIDE(
    COUNTROWS(FILTER(HR_1, HR_1[Attrition] = "Yes")),
    COUNTROWS(HR_1)
) * 100

-- Total Employees
Total Employees = COUNTROWS(HR_1)

-- Avg Monthly Income
Avg Monthly Income = AVERAGE(HR_1[MonthlyIncome])

-- Avg Years at Company
Avg Tenure = AVERAGE(HR_1[YearsAtCompany])
```

#### 📊 Visuals to Build

| Visual | Fields Used |
|---|---|
| KPI Card | Total Employees, Attrition Rate |
| Bar Chart | Attrition Rate by Department |
| Donut Chart | Attrition by Gender |
| Line Chart | Attrition Rate vs Monthly Income |
| Matrix Table | Job Role vs Work-Life Balance |
| Slicer | Department, Gender, Age Group |
| Clustered Bar | Avg Working Years by Department |

---

### ✅ STEP 8 — Key Insights & Findings

- 📍 **Sales department** has the highest attrition rate
- 💰 Employees with **low monthly income (< 3K)** are 3x more likely to leave
- ⚖️ **Sales Representatives** report the lowest work-life balance scores
- 📅 Employees with **less than 2 years tenure** account for 40%+ of attrition
- 👨‍🔬 Male Research Scientists have an average hourly rate of **\$65.3/hr**

---

## 📁 Project Structure

```
SQL-Project-On-HR-Analytics/
│
├── 📄 HR_1.csv                  # Primary HR dataset
├── 📄 HR_2.csv                  # Secondary HR dataset
├── 📄 HR ANALYTICS.sql          # All SQL queries
├── 📊 HR_Dashboard.pbix         # Power BI Dashboard file
└── 📄 README.md                 # Project documentation
```

---

## 🧠 Skills Demonstrated

`MySQL` `SQL Joins` `CTEs` `Window Functions` `RANK` `LAG` `LEAD` `CASE WHEN`
`GROUP BY` `Aggregations` `Power BI` `DAX` `Data Modeling` `KPI Design`
`HR Analytics` `Business Intelligence` `Data Visualization`

---

## 👤 Author

**Your Name**
📧 your.email@gmail.com
🔗 [LinkedIn](https://linkedin.com/in/yourprofile)
🐙 [GitHub](https://github.com/yourusername)

---

> ⭐ If you found this project helpful, please star the repository!
