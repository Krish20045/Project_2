{{ config(materialized='table') }}

WITH current_inventory AS (
    SELECT * FROM {{ ref('int_inventory_current') }}
),

sales_velocity AS (
    SELECT
        store_id,
        product_id,
        COUNT(DISTINCT sale_date) AS days_sold,
        SUM(units_sold) AS total_units_sold,
        ROUND(AVG(units_sold), 2) AS avg_units_per_transaction,
        MAX(sale_date) AS last_sale_date
    FROM {{ ref('int_sales_with_calendar') }}
    GROUP BY 1, 2
),

inventory_analysis AS (
    SELECT
        i.store_id,
        i.store_name,
        i.store_city,
        i.product_id,
        i.product_name,
        i.product_category,
        i.stock_on_hand,
        i.inventory_cost_value,
        i.inventory_retail_value,
        COALESCE(s.total_units_sold, 0) AS total_units_sold,
        COALESCE(s.days_sold, 0) AS days_sold,
        COALESCE(s.avg_units_per_transaction, 0) AS avg_units_per_transaction,
        s.last_sale_date,
        -- Calculate days since last sale
        CASE 
            WHEN s.last_sale_date IS NOT NULL 
            THEN DATEDIFF('day', s.last_sale_date, CURRENT_DATE())
            ELSE NULL
        END AS days_since_last_sale,
        -- Calculate inventory turnover metrics
        CASE 
            WHEN s.total_units_sold > 0 AND s.days_sold > 0
            THEN ROUND(s.total_units_sold / s.days_sold, 2)
            ELSE 0
        END AS avg_daily_sales,
        -- Calculate days of inventory remaining
        CASE 
            WHEN s.total_units_sold > 0 AND s.days_sold > 0
            THEN ROUND(i.stock_on_hand / (s.total_units_sold / s.days_sold), 0)
            ELSE NULL
        END AS days_of_inventory_remaining
    FROM current_inventory i
    LEFT JOIN sales_velocity s ON i.store_id = s.store_id AND i.product_id = s.product_id
),

inventory_categories AS (
    SELECT
        *,
        CASE 
            WHEN stock_on_hand = 0 THEN 'Out of Stock'
            WHEN stock_on_hand <= 10 THEN 'Low Stock'
            WHEN days_of_inventory_remaining IS NOT NULL AND days_of_inventory_remaining <= 7 THEN 'Critical - Less than 1 week'
            WHEN days_of_inventory_remaining IS NOT NULL AND days_of_inventory_remaining <= 30 THEN 'Low - Less than 1 month'
            WHEN days_since_last_sale > 90 THEN 'Slow Moving'
            WHEN days_since_last_sale IS NULL THEN 'Never Sold'
            ELSE 'Normal'
        END AS inventory_status
    FROM inventory_analysis
)

SELECT * FROM inventory_categories
ORDER BY store_name, inventory_status, product_category, product_name