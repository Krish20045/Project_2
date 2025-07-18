{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('maven_toys_raw', 'PRODUCTS') }}
),

PRODUCTS AS (
    SELECT
        PRODUCT_ID::INTEGER AS product_id,
        TRIM(PRODUCT_NAME) AS product_name,
        TRIM(PRODUCT_CATEGORY) AS product_category,
        PRODUCT_COST::DECIMAL(10,2) AS product_cost,
        PRODUCT_PRICE::DECIMAL(10,2) AS product_price,
        CURRENT_TIMESTAMP() AS _loaded_at
    FROM source
    WHERE PRODUCT_ID IS NOT NULL
)

SELECT * FROM PRODUCTS