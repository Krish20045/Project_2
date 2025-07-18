{{ config(materialized='table') }}

WITH sales_complete AS (
    SELECT * FROM {{ ref('int_sales_with_calendar') }}
),

store_metrics AS (
    SELECT
        store_id,
        store_name,
        store_city,
        store_location,
        store_open_date,
        COUNT(DISTINCT sale_id) AS total_transactions,
        COUNT(DISTINCT product_id) AS unique_products_sold,
        SUM(units_sold) AS total_units_sold,
        SUM(revenue) AS total_revenue,
        SUM(cost) AS total_cost,
        SUM(profit) AS total_profit,
        AVG(revenue) AS avg_transaction_value,
        SUM(profit) / SUM(revenue) AS profit_margin
    FROM sales_complete
    GROUP BY 1, 2, 3, 4, 5
)

SELECT * FROM store_metrics