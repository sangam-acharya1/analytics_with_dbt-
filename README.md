#  Module 4: Analytics Engineering with dbt (NYC Taxi Data)


It builds an analytics pipeline using **dbt** to transform NYC taxi trip data into analytics-ready datasets for reporting and analysis.

---

# 🎯 Objective

The goal of this project is to:

- Clean and standardize raw NYC taxi data
- Combine multiple datasets (Green, Yellow, FHV)
- Build staging, intermediate, and mart models
- Create fact and dimension tables
- Generate monthly revenue analytics
- Apply dbt tests and best practices

---



# 🧱 Data Architecture

```text
Raw Data (Parquet / CSV)
        ↓
Staging Models (stg_)
        ↓
Intermediate Models (int_)
        ↓
Dimension Models (dim_)
        ↓
Fact Models (fct_)
        ↓
Analytics Tables
