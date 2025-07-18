{{ config(materialized='table') }}

WITH source AS (
    SELECT * FROM {{ source('project_2_raw', 'INVENTORY') }}
),

inventory AS (
    SELECT
        STORE_ID::INTEGER AS store_id,
        PRODUCT_ID::INTEGER AS product_id,
        STOCK_ON_HAND::INTEGER AS stock_on_hand,
        CURRENT_TIMESTAMP() AS _loaded_at
    FROM source
    WHERE STORE_ID IS NOT NULL
      AND PRODUCT_ID IS NOT NULL
)

SELECT * FROM inventory