# Project_2

dbt Project Implementation Report
1. Project Overview
The goal of this project was to design and implement a data pipeline using dbt for data transformation and Snowflake as the data warehouse. The pipeline follows a layered architecture—staging, intermediate, and marts—to ensure clean, reliable, and analytics-ready data.


2. Project Steps and Approach

Step 1: Understanding the Data & Requirements
Reviewed raw tables available in Snowflake (calendar, data_dictionary, inventory, products, sales, stores).
Identified the business requirements for cleaning, transforming, and analyzing the data.

Step 2: Setting Up dbt & Snowflake
Initialized a new dbt project.
Configured the profiles.yml to connect dbt to the Snowflake environment.
Created a source configuration file (_sources.yml) in the staging folder to register all required raw tables.

Step 3: Staging Layer
Purpose: Clean and standardize raw data for downstream processing.
Implementation:
Created staging models for each source table:
stg_calendar.sql
stg_data_dictionary.sql
stg_inventory.sql
stg_products.sql
stg_sales.sql
stg_stores.sql
Applied basic cleaning: column renaming, data type consistency, handling nulls/missing values, and filtering irrelevant records.

Step 4: Intermediate Layer
Purpose: Apply business logic and transformations to prepare data for analytical use.
Implementation:
Created intermediate models to join and enrich data:
int_inventory_current.sql — Calculates current inventory.
int_product_performance.sql — Aggregates product-level performance metrics.
int_sales_with_calendar.sql — Joins sales with calendar data.
int_sales_with_products.sql — Enriches sales with product details.
int_sales_with_stores.sql — Adds store information to sales.
int_store_performance.sql — Summarizes sales at the store level.
Performed transformations such as aggregations, calculations, and business logic.

Step 5: Marts Layer
Purpose: Provide final, analysis-ready tables for reporting and analytics.
Implementation:
Created marts models:
mart_inventory_report.sql — Final inventory metrics for business consumption.
mart_product_analysis.sql — Product-level analytics for reporting.
Ensured these tables are optimized for dashboarding and data consumption.

Step 6: Testing
Purpose: Ensure data quality and correctness.
Implementation:
Added dbt tests (e.g., not_null, unique, relationships) to key columns in staging, intermediate, and marts models.
Ran dbt test to validate that all models meet data quality requirements.

Step 7: Snapshots
Purpose: Track historical changes in inventory, products, and stores.
Implementation:
Defined dbt snapshot configurations for relevant tables.
Enabled tracking of updates and historical changes for auditing and trend analysis.

Step 8: Execution & Validation
Ran the dbt pipeline (dbt run) to build all models in Snowflake.
Queried the Snowflake warehouse to ensure the transformed tables and marts reflected the expected changes and business logic.

Validated the end-to-end pipeline by comparing outputs with requirements.
3. Project Structure
intermediate/
    int_inventory_current.sql
    int_product_performance.sql
    int_sales_with_calendar.sql
    int_sales_with_products.sql
    int_sales_with_stores.sql
    int_store_performance.sql
marts/
    mart_inventory_report.sql
    mart_product_analysis.sql
staging/
    _sources.yml
    stg_calendar.sql
    stg_data_dictionary.sql
    stg_inventory.sql
    stg_products.sql
    stg_sales.sql
    stg_stores.sql

7. Testing snapshot changes 
I changes product price of desired product id and it reflectd the changes in valid date to end date and also status is updated 
This shows the usage of snapshot

8. Features used 
Macros
Staging(Models)
Intermediate(Models)
Marts(Models)
Snapshot
Tests

THIS IS OVERALL PROCESS FROM CLEANING TO TRANSFORMATION AND USING FEATURES OF DBT
