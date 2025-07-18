{{ config(materialized='table') }}

SELECT 
    'stg_products' AS table_name,
    'product_id' AS field_name,
    'Unique identifier for each product' AS description

UNION ALL

SELECT 
    'stg_products' AS table_name,
    'product_name' AS field_name,
    'Product name (trimmed for consistency)' AS description

UNION ALL

SELECT 
    'stg_products' AS table_name,
    'product_category' AS field_name,
    'Product category (trimmed for consistency)' AS description

UNION ALL

SELECT 
    'stg_products' AS table_name,
    'product_cost' AS field_name,
    'Product cost - dollar sign removed' AS description

UNION ALL

SELECT 
    'stg_products' AS table_name,
    'product_price' AS field_name,
    'Product retail price - dollar sign removed' AS description

UNION ALL

-- STG_INVENTORY
SELECT 
    'stg_inventory' AS table_name,
    'store_id' AS field_name,
    'Store identifier' AS description

UNION ALL

SELECT 
    'stg_inventory' AS table_name,
    'product_id' AS field_name,
    'Product identifier' AS description

UNION ALL

SELECT 
    'stg_inventory' AS table_name,
    'stock_on_hand' AS field_name,
    'Stock quantity of the product in the store (inventory)' AS description

UNION ALL

-- STG_STORES
SELECT 
    'stg_stores' AS table_name,
    'store_id' AS field_name,
    'Store identifier' AS description

UNION ALL

SELECT 
    'stg_stores' AS table_name,
    'store_name' AS field_name,
    'Store name (trimmed for consistency)' AS description

UNION ALL

SELECT 
    'stg_stores' AS table_name,
    'store_city' AS field_name,
    'City in Mexico where the store is located' AS description

UNION ALL

SELECT 
    'stg_stores' AS table_name,
    'store_location' AS field_name,
    'Location in the city where the store is located' AS description

UNION ALL

SELECT 
    'stg_stores' AS table_name,
    'store_open_date' AS field_name,
    'Date when the store was opened (converted from DD-MM-YYYY)' AS description

UNION ALL

-- STG_SALES
SELECT 
    'stg_sales' AS table_name,
    'sale_id' AS field_name,
    'Sale identifier' AS description

UNION ALL

SELECT 
    'stg_sales' AS table_name,
    'sale_date' AS field_name,
    'Date of the transaction (converted from DD-MM-YYYY)' AS description

UNION ALL

SELECT 
    'stg_sales' AS table_name,
    'store_id' AS field_name,
    'Store identifier' AS description

UNION ALL

SELECT 
    'stg_sales' AS table_name,
    'product_id' AS field_name,
    'Product identifier' AS description

UNION ALL

SELECT 
    'stg_sales' AS table_name,
    'units_sold' AS field_name,
    'Units sold in the transaction' AS description

UNION ALL

-- STG_CALENDAR
SELECT 
    'stg_calendar' AS table_name,
    'date' AS field_name,
    'Calendar date' AS description

UNION ALL

SELECT 
    'stg_calendar' AS table_name,
    'day_name' AS field_name,
    'Day name extracted from date (Monday, Tuesday, etc.)' AS description

UNION ALL

SELECT 
    'stg_calendar' AS table_name,
    'month_name' AS field_name,
    'Month name extracted from date (January, February, etc.)' AS description

UNION ALL

SELECT 
    'stg_calendar' AS table_name,
    'year' AS field_name,
    'Year extracted from date' AS description

UNION ALL

SELECT 
    'stg_calendar' AS table_name,
    'quarter' AS field_name,
    'Quarter extracted from date (1, 2, 3, 4)' AS description

UNION ALL

-- Add _loaded_at audit columns for all staging tables
SELECT 
    'stg_products' AS table_name,
    '_loaded_at' AS field_name,
    'Timestamp when record was loaded into staging' AS description

UNION ALL

SELECT 
    'stg_inventory' AS table_name,
    '_loaded_at' AS field_name,
    'Timestamp when record was loaded into staging' AS description

UNION ALL

SELECT 
    'stg_stores' AS table_name,
    '_loaded_at' AS field_name,
    'Timestamp when record was loaded into staging' AS description

UNION ALL

SELECT 
    'stg_sales' AS table_name,
    '_loaded_at' AS field_name,
    'Timestamp when record was loaded into staging' AS description

UNION ALL

SELECT 
    'stg_calendar' AS table_name,
    '_loaded_at' AS field_name,
    'Timestamp when record was loaded into staging' AS description

ORDER BY table_name, field_name