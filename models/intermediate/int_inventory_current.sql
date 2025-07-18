{{ config(materialized='table') }}

WITH inventory AS (
    SELECT * FROM {{ ref('stg_inventory') }}
),

products AS (
    SELECT * FROM {{ ref('stg_products') }}
),

stores AS (
    SELECT * FROM {{ ref('stg_stores') }}
),

inventory_enhanced AS (
    SELECT
        i.store_id,
        i.product_id,
        i.stock_on_hand,
        p.product_name,
        p.product_category,
        p.product_cost::FLOAT AS product_cost,
        p.product_price::FLOAT AS product_price,
        s.store_name,
        s.store_city,
        s.store_location,
        -- Calculate inventory value
        i.stock_on_hand * p.product_cost::FLOAT AS inventory_cost_value,
        i.stock_on_hand * p.product_price::FLOAT AS inventory_retail_value
    FROM inventory i
    LEFT JOIN products p ON i.product_id = p.product_id
    LEFT JOIN stores s ON i.store_id = s.store_id
)

SELECT * FROM inventory_enhanced