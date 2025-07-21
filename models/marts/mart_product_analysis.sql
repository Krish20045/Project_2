{{ config(materialized='table') }}

WITH sales_data AS (
    SELECT * FROM {{ ref('int_sales_with_calendar') }}
),

inventory_data AS (
    SELECT * FROM {{ ref('int_inventory_current') }}
),

product_sales_metrics AS (
    SELECT
        product_id,
        product_name,
        product_category,
        product_cost,
        product_price,
        COUNT(DISTINCT sale_id) AS total_transactions,
        COUNT(DISTINCT store_id) AS stores_sold_in,
        COUNT(DISTINCT sale_date) AS active_days,
        SUM(units_sold) AS total_units_sold,
        SUM(revenue) AS total_revenue,
        SUM(cost) AS total_cost,
        SUM(profit) AS total_profit,
        ROUND(SUM(profit) / SUM(revenue) * 100, 2) AS profit_margin_pct,
        ROUND(AVG(units_sold), 2) AS avg_units_per_transaction,
        ROUND(SUM(revenue) / COUNT(DISTINCT sale_date), 2) AS avg_daily_revenue
    FROM sales_data
    GROUP BY 1, 2, 3, 4, 5
),

product_inventory_metrics AS (
    SELECT
        product_id,
        COUNT(DISTINCT store_id) AS stores_with_inventory,
        SUM(stock_on_hand) AS total_inventory_units,
        AVG(stock_on_hand) AS avg_inventory_per_store,
        SUM(inventory_cost_value) AS total_inventory_cost,
        SUM(inventory_retail_value) AS total_inventory_value
    FROM inventory_data
    GROUP BY 1
)

SELECT
    p.*,
    COALESCE(i.stores_with_inventory, 0) AS stores_with_inventory,
    COALESCE(i.total_inventory_units, 0) AS total_inventory_units,
    COALESCE(i.avg_inventory_per_store, 0) AS avg_inventory_per_store,
    COALESCE(i.total_inventory_cost, 0) AS total_inventory_cost,
    COALESCE(i.total_inventory_value, 0) AS total_inventory_value,
    -- Performance rankings
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank,
    RANK() OVER (ORDER BY total_profit DESC) AS profit_rank,
    RANK() OVER (ORDER BY total_units_sold DESC) AS volume_rank,
    RANK() OVER (ORDER BY profit_margin_pct DESC) AS margin_rank,
    -- Category rankings
    RANK() OVER (PARTITION BY product_category ORDER BY total_revenue DESC) AS category_revenue_rank
FROM product_sales_metrics p
LEFT JOIN product_inventory_metrics i ON p.product_id = i.product_id
ORDER BY total_revenue DESC