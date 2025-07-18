{{ config(materialized='view') }}

WITH sales AS (
    SELECT * FROM {{ ref('stg_sales') }}
),

products AS (
    SELECT * FROM {{ ref('stg_products') }}
),

sales_enhanced AS (
    SELECT
        s.sale_id,
        s.sale_date,
        s.store_id,
        s.product_id,
        s.units_sold,
        p.product_name,
        p.product_category,
        p.product_cost,
        p.product_price,
        s.units_sold * p.product_price AS revenue,
        s.units_sold * p.product_cost AS cost,
        (s.units_sold * p.product_price) - (s.units_sold * p.product_cost) AS profit
    FROM sales s
    LEFT JOIN products p ON s.product_id = p.product_id
)

SELECT * FROM sales_enhanced