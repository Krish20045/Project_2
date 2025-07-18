{{ config(materialized='table') }}

WITH sales AS (
    SELECT * FROM {{ ref('stg_sales') }}
),

products AS (
    SELECT * FROM {{ ref('stg_products') }}
),

sales_with_products AS (
    SELECT
        s.sale_id,
        s.sale_date,
        s.store_id,
        s.product_id,
        s.units_sold,
        p.product_name,
        p.product_category,
        p.product_cost::FLOAT AS product_cost,
        p.product_price::FLOAT AS product_price,
        -- Calculate metrics
        s.units_sold * p.product_price::FLOAT AS revenue,
        s.units_sold * p.product_cost::FLOAT AS cost,
        (s.units_sold * p.product_price::FLOAT) - (s.units_sold * p.product_cost::FLOAT) AS profit
    FROM sales s
    LEFT JOIN products p ON s.product_id = p.product_id
)

SELECT * FROM sales_with_products