# Trial-to-Paid Conversion and monetization
### CloudTrack SaaS · Product-Led Growth Analytics · End-to-End Data Analytics Project

![Python](https://img.shields.io/badge/Python-3.11-blue?style=flat-square&logo=python)
![SQL Server](https://img.shields.io/badge/SQL_Server-Express-red?style=flat-square&logo=microsoftsqlserver)
![Power BI](https://img.shields.io/badge/Power_BI-Dashboard-yellow?style=flat-square&logo=powerbi)
![scikit-learn, ML](https://img.shields.io/badge/scikit--learn-ML_Model-orange?style=flat-square&logo=scikitlearn)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=flat-square)

---

## The Business Problem

**CloudTrack** is a B2B SaaS project management tool that offers a 14-day free trial to every new signup.
On paper, free trials are the most efficient customer acquisition lever in SaaS — they let potential buyers
experience the product before committing, lowering purchase friction and shortening the sales cycle.

But free trials only create financial value when they convert to paid.

CloudTrack was converting just **8% of trial users** into paying customers — well below the industry
benchmark of 12–20% for B2B SaaS. The remaining 94% simply stopped using the product when their trial
expired, yielding zero lifetime value from what was, in many cases, a paid marketing spend to acquire them.

This isn't just a product problem — it's a unit economics crisis. When trial conversion is low:

- **CAC payback stretches** — CloudTrack was taking 15 months to recover its acquisition cost per customer,
  far above the healthy threshold of 12 months or less.
- **LTV:CAC ratio collapses** — at 8% conversion, the ratio sat at 1.7×, well below the 3× minimum that
  signals a scalable, investor-grade SaaS business.
- **MRR growth stalls** — adding new trials without improving conversion means the revenue engine leaks
  faster than it fills. CloudTrack's MRR was growing but not compounding.
- **Retention starts at trial** — users who don't reach their "aha moment" during the trial don't understand the product's value, meaning even the 8% who did convert were churning faster in the first 90 days.

The core question the business needed answered was: **which specific in-app behaviors during the 14-day
trial predict whether a user will convert — and can we detect these signals early enough to intervene?**

This project builds the complete data infrastructure and analytics system to answer that question,
from raw event logs to sql cleaning and modelling to a machine learning, pyhton scoring model to an executive Power BI dashboard.

---

## Project Overview

| Attribute         | Detail                                                        |
|-------------------|---------------------------------------------------------------|
| Industry          | SaaS / IT / Product Analytics                                 |
| Dataset           | Synthetic — 5,000 trial users, 5 CSV tables, Python-generated |
| Tools             | SQL Server · Python · Excel · Power BI                        |
| Techniques        | 14 DA techniques (EDA, A/B Testing, Logistic Regression, etc) |
                                
| Model Performance | 90% accuracy · 0.93 ROC-AUC                                  |
| Business Impact   | +$31K projected ARR · CAC payback 15 → 9.6 months            |

---

## Key Results & Findings

> **Funnel Insight:** 76% of trial users invited a team member — the single strongest behavioral
> predictor of conversion. Users who sent even one team invite converted at 4× the baseline rate.

> **A/B Test Winner:** The redesigned onboarding flow (Treatment group) achieved **15.9% conversion vs
> 8% control baseline** — an 87.5% relative lift — with Chi-Square p < 0.05 (statistically significant).

> **ML Model:** Logistic Regression and Random Forest both trained on behavioral features.
> Top predictors: active days, invites sent, features used. ROC-AUC = 0.93.

> **Revenue Impact:** Implementing the Treatment onboarding across all new signups projects:
> - +$31,000 additional ARR per year
> - CAC payback compressed from 15 → 9.6 months
> - LTV:CAC ratio crossing the 3× investor threshold

---

## Techniques Covered

| Technique                         | Tool                  
|-----------------------------------|-----------------------
| Exploratory Data Analysis (EDA)   | Python(pandas, numpy) + SQL          
| ETL (Extract, Transform, Load)    | Python + SQL Server   
| Star Schema / Data Modelling      | SQL Server + Power BI         
| Funnel Analysis                   | Python + Power BI     
| A/B Testing & Hypothesis Testing  | Python (scipy) + SQL        
| Cohort Analysis                   | Python + SQL + Power BI     
| RFM Analysis (adapted)            | Python + SQL         
| Logistic Regression               | Python (sklearn,seaborn,matplotlib)      
| Random Forest                     | Python (sklearn)     
| KPI Design & Framework            | Power BI      
| Time Series Analysis              | Python               
| Data Warehousing                  | SQL Server            
| DAX Measures (15+)                | Power BI            
| Prompt Engineering / Gen AI       | Claude API            

---

## Dataset — 5 Synthetic CSV Tables

All data generated using `generate_data.py`. using python script

```
users.csv            →  5,000 rows   — Trial user registry (signup date, industry, company size, variant)
trials.csv           →  5,000 rows   — Trial outcomes (converted flag, conversion date)
events.csv           →  ~55,000 rows — In-app event log (login, feature_used, invite_sent, etc.)
subscriptions.csv    →  ~600 rows    — Post-conversion MRR and churn data
ab_test_results.csv  →  5,000 rows   — Onboarding A/B test group assignments and outcomes
```

### Schema (Star Schema)

```
                          ┌─────────────┐
                          │  dim_users  │  ← Central dimension table
                          └──────┬──────┘
           ┌──────────────┬──────┴──────┬──────────────┐-------------- scored_users(ML Result)
           ▼              ▼             ▼               ▼
    fact_trials    fact_events   fact_subscriptions  fact_ab_test
```

---

## File Structure

```
cloudtrack-conversion-optimizer/
│
├── data/
│   ├── users.csv
│   ├── trials.csv
│   ├── events.csv
│   ├── subscriptions.csv
│   ├── ab_test_results.csv
│   └── scored_users.csv              ← ML output generated 
│
├── python/
│   ├── generate_data.py              ← Step 1: Generate all 5 CSV files
│   ├── 02_eda_funnel.py              ← Step 2: EDA, funnel chart, cohort analysis
│   ├── 03_ab_testing.py              ← Step 3: Chi-square + Z-test A/B hypothesis test
│   └── 04_ml_model.py               ← Step 4: Logistic Regression + Random Forest
│
├── sql/
│   ├── 01_create_schema.sql          ← Star schema DDL (SQL Server)
│   ├── 02_load_data.sql              ← BULK INSERT from CSV files
│   └── 03_queries.sql               ← 6 analytical queries (funnel, MRR, cohort, A/B)
│ 
│
├── powerbi/
│   └── CloudTrack_Dashboard.pbix    ← 3-page dashboard, 20 DAX measures
│
├── outputs/
│   ├── fig_funnel.png
│   ├── fig_conv_by_industry.png
│   ├── fig_cohort.png
│   ├── fig_ab_test.png
│   └── fig_ml_results.png
│
└── README.md
```

---
---

### Step 1 — Generate the dataset

```bash
cd python/
python generate_data.py
```
Expected output:
```
✅ All 5 CSV files generated successfully!
  users.csv           → 5000 rows
  trials.csv          → 5000 rows
  events.csv          → ~55000 rows
  subscriptions.csv   → ~600 rows
  ab_test_results.csv → 5000 rows
```

Move all CSV files to the `data/` folder.

---

### Step 2 — Set up SQL Server

Open SSMS (SQL Server Management Studio) and run in order:

```sql
-- 1. Create database and star schema

-- 2. Load all CSV data
-- Note: update file paths to match your local data/ folder

-- 3. Run analytical queries
-- Queries: Conversion Rate, Funnel Stages, Engagement Score,
--          Monthly Cohort, MRR Breakdown, A/B Test Comparison
```

---

### Step 3 — Run Python Analysis

```
# EDA, funnel chart, cohort trend
python python/02_eda_funnel.py

# A/B hypothesis test (Chi-square + Z-test)
python python/03_ab_testing.py

# ML model training + scoring
python python/04_ml_model.py
```

`04_ml_model.py` exports `data/scored_users.csv` — import this into Power BI alongside the other 5 python generated files.

---

### Step 4 — Power BI Dashboard

1. Open `powerbi/CloudTrack_Dashboard.pbix` in Power BI Desktop
2. Update data source paths to point to your `data/` folder
3. Refresh all tables
4. All 20 DAX measures and 4 dashboard pages load automatically

Dashboard pages:
- **Page 1** — Executive Overview (4 KPI cards, MRR trend, conversion gauge)
- **Page 2** — Trial Funnel (6-stage funnel, drop-off analysis, segment breakdown)
- **Page 3** — ML Scoring Board (risk tiers, feature importance, scored user table)
- **Page 4** — Revenue & MRR (waterfall bridge, plan breakdown, 3-scenario projection)

---

## KPI Framework — 10 Core SaaS Metrics

| KPI                    | Formula                                          | Target       |
|------------------------|--------------------------------------------------|--------------|
| Trial Conversion Rate  | Converted / Total Trials × 100                   | ≥ 15%        |
| Time to Value (TTV)    | AVG(first_feature_date − signup_date)            | ≤ 3 days     |
| Activation Rate        | Completed Onboarding / Signups × 100             | ≥ 75%        |
| Feature Adoption Rate  | Feature Users / Total Trials × 100               | ≥ 75%        |
| Collaboration Rate     | Invite Users / Total Trials × 100                | ≥ 76%        |
| MRR Growth MoM %       | (MRR_t − MRR_t-1) / MRR_t-1                     | ≥ 10%        |
| MRR Churn Rate         | Churned MRR / Total MRR × 100                    | ≤ 5%         |
| CAC Payback Period     | CAC / Avg MRR per Customer                       | < 12 months  |


---

## Model Performance

| Model               | Accuracy | ROC-AUC | Precision | Recall |
|---------------------|----------|---------|-----------|--------|
| Logistic Regression | 88.4%    | 0.91    | 75%       | 62%    |
| Random Forest       | 90.1%    | 0.93    | 78%       | 68%    |
| Baseline (random)   | —        | 0.50    | —         | —      |

**Top 3 conversion predictors (Random Forest feature importance):**
1. `active_days` — number of days the user logged any activity during trial
2. `invite_sent` — whether the user invited at least one team member
3. `feature_used` — total count of core feature interactions

---

## Business Impact Summary

| Metric              | Baseline (8% conv.) | With Treatment (15%) | Delta           |
|---------------------|---------------------|----------------------|-----------------|
| New Paid Users/Mo   | 40                  | 75                   | +35 users/mo    |
| New MRR Added/Mo    | $2,960              | $5,550               | +$2,590/mo      |
| Annual MRR Run Rate | $35,520             | $66,600              | +$31,080/yr     |
| CAC Payback         | 18 months           | 9.6 months           | −8.4 months     |
| LTV:CAC Ratio       | 1.7×                | 3.2×                 | Crosses 3× mark |
| Onboarding Done %   | 38%                 | 62%                  | +24 pp          |
| Avg Time to Value   | 8 days              | 3.1 days             | −4.9 days       |

---

## The Result 

```
Analyzing 5,000 trial users across a 14-day window, the data exposed a clear behavioral divide between users who converted and those who didn't — users who invited a team member were 4× more likely to pay, yet only 76% of all trial users ever reached that step, meaning the product's most powerful conversion trigger was buried behind a friction-heavy onboarding flow that 24% of users never completed. Funnel analysis confirmed that the drop-off wasn't random — it was concentrated at the collaboration and core feature stages, pointing directly to an onboarding design problem rather than product quality problem.

A/B hypothesis testing validated that a redesigned onboarding flow — built around getting users to their first team invite within 48 hours — lifted trial-to-paid conversion from 8% to 15% with p < 0.05 statistical significance, and a Logistic Regression model (88% accuracy, 0.91 AUC) confirmed that active days and invites sent were the two strongest predictors of conversion across 5,000 users. Translating that lift into financial terms. The change, projects +$31K in additional ARR, cuts CAC payback from 18 to 9.6 months, and pushes the LTV:CAC ratio from 1.7× to 3.2× — crossing the 3× threshold that signals a sustainable, scalable SaaS revenue engine to investors.

```
---

## Author

**Aditya Gahlout**
Data and business Analyst · Bengaluru, India
[LinkedIn](https://linkedin.com/in/adityagahlout) · [GitHub](https://github.com/adityagahlout) · adityagahlout2001@gmail.com

---
*This is a portfolio project built on synthetic data to demonstrate end-to-end data analytics
skills for SaaS product analytics and conversion optimization use cases.*
