{{ config(materialized='table') }}

WITH sales_complete AS (
    SELECT * FROM {{ ref('int_sales_with_calendar') }}
),

product_metrics AS (
    SELECT
        product_id,
        product_name,
        product_category,
        product_cost,
        product_price,
        COUNT(DISTINCT sale_id) AS total_transactions,
        COUNT(DISTINCT store_id) AS stores_sold_in,
        SUM(units_sold) AS total_units_sold,
        SUM(revenue) AS total_revenue,
        SUM(cost) AS total_cost,
        SUM(profit) AS total_profit,
        AVG(units_sold) AS avg_units_per_transaction,
        SUM(profit) / SUM(revenue) AS profit_margin
    FROM sales_complete
    GROUP BY 1, 2, 3, 4, 5
)

SELECT * FROM product_metrics