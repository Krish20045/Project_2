{{ config(materialized='table') }}

WITH source AS (
    SELECT * FROM {{ source('project_2_raw', 'STORES') }}
),

stores AS (
    SELECT
        STORE_ID::INTEGER AS store_id,
        TRIM(STORE_NAME) AS store_name,
        TRIM(STORE_CITY) AS store_city,
        TRIM(STORE_LOCATION) AS store_location,
        -- Fix date conversion with proper format
        TO_DATE(STORE_OPEN_DATE, 'DD-MM-YYYY') AS store_open_date,
        CURRENT_TIMESTAMP() AS _loaded_at
    FROM source
    WHERE STORE_ID IS NOT NULL
)

SELECT * FROM stores