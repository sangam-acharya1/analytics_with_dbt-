
It builds an analytics pipeline using dbt to transform NYC taxi trip data into analytics-ready models.

🎯 Objective

Build a dbt project that:

Cleans and standardizes raw taxi trip data
Combines multiple datasets (Green, Yellow, FHV)
Creates fact and dimension models
Produces monthly revenue analytics
Applies dbt testing and best practices
🧱 Project Architecture
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
Analytics Output Tables
📂 Models Overview
1. Staging Models (models/staging/)
Purpose:
Clean raw data
Rename columns
Standardize schema across datasets
Models:
stg_green_tripdata
stg_yellow_tripdata
stg_fhv_tripdata
2. Intermediate Models (models/intermediate/)
Purpose:
Combine multiple datasets
Add derived fields
Model:
int_trips_unioned
Key logic:
Union of Green + Yellow trips
Adds service_type (green/yellow)
3. Dimension Models (models/dimensions/)
Model:
dim_zones
Source:
Taxi Zone lookup (seed data)
Columns:
locationid
borough
zone
service_zone
4. Fact Models (models/marts/)
🚖 fct_trips
Purpose:

Enriched trip-level fact table

Features:
Joins zone metadata
Deduplication using surrogate logic
Adds derived fields
Key columns:
pickup_zone
dropoff_zone
service_type
trip_id (surrogate key)
📊 fct_monthly_zone_revenue
Purpose:

Aggregated analytics table for reporting

Grain:

One record per:

service_type
pickup_zone
year
month
Metrics:
total_monthly_trips
revenue_monthly_total_amount
🔗 Data Lineage
stg_green_tripdata     stg_yellow_tripdata
            \             /
             int_trips_unioned
                     ↓
                fct_trips
                     ↓
     fct_monthly_zone_revenue
                     ↑
               dim_zones (lookup)
⚙️ Setup Instructions
1. Install dependencies
dbt deps
2. Load seed data
dbt seed
3. Run models
dbt run
4. Run full pipeline (recommended)
dbt build --target prod
🧪 Testing

This project uses dbt built-in tests:

not null
unique
accepted_values
custom schema tests

Run tests:

dbt test
📊 Example Analytics Output
service_type	pickup_zone	year	month	total_monthly_trips	revenue
green	Manhattan	2020	01	12000	450000
yellow	Brooklyn	2020	01	18000	520000
🧠 Key dbt Concepts Demonstrated
ref() for model dependencies
source() for raw tables
staging → intermediate → marts architecture
surrogate key generation
deduplication using row_number()
dimensional modeling (facts & dimensions)
dbt tests for data quality
📌 Tools Used
dbt Core
SQL
DuckDB / BigQuery (depending on environment)
Git & GitHub
🚀 How to Validate Project

To ensure project is correct:

dbt build --target prod

Expected results:

All models succeed
No failing tests
Fact tables generated correctly
