{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('maven_toys_raw', 'INVENTORY') }}
),

renamed AS (
    SELECT
        STORE_ID::INTEGER AS store_id,
        PRODUCT_ID::INTEGER AS product_id,
        STOCK_ON_HAND::INTEGER AS stock_quantity,
        CURRENT_TIMESTAMP() AS _loaded_at
    FROM source
    WHERE STORE_ID IS NOT NULL
      AND PRODUCT_ID IS NOT NULL
      AND STOCK_ON_HAND >= 0
)

SELECT * FROM renamed