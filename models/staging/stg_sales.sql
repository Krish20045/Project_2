{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('maven_toys_raw', 'SALES') }}
),

renamed AS (
    SELECT
        SALE_ID::INTEGER AS sale_id,
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

SELECT * FROM renamed