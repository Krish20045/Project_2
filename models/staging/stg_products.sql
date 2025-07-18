{{ config(materialized='table') }}

WITH source AS (
    SELECT * FROM {{ source('project_2_raw', 'PRODUCTS') }}
),

products AS (
    SELECT
        PRODUCT_ID::INTEGER AS product_id,
        TRIM(PRODUCT_NAME) AS product_name,
        TRIM(PRODUCT_CATEGORY) AS product_category,
        -- Remove dollar sign using SUBSTR (skip first character)
        SUBSTR(PRODUCT_COST, 2) AS product_cost,
        SUBSTR(PRODUCT_PRICE, 2) AS product_price
    FROM source
    WHERE PRODUCT_ID IS NOT NULL
)

SELECT * FROM products