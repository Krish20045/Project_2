{{ config(materialized='table') }}

WITH source AS (
    SELECT * FROM {{ source('project_2_raw', 'SALES') }}
),

sales AS (
    SELECT
        SALE_ID::INTEGER AS sale_id,
        -- Fix the date conversion (use TO_DATE instead of DATE)
        TO_DATE(DATE, 'DD-MM-YYYY') AS sale_date,
        STORE_ID::INTEGER AS store_id,
        PRODUCT_ID::INTEGER AS product_id,
        UNITS::INTEGER AS units_sold,
        CURRENT_TIMESTAMP() AS _loaded_at
    FROM source
    WHERE SALE_ID IS NOT NULL
      AND STORE_ID IS NOT NULL
      AND PRODUCT_ID IS NOT NULL
      AND UNITS > 0
)

SELECT * FROM sales