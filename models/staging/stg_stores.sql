{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('maven_toys_raw', 'STORES') }}
),

renamed AS (
    SELECT
        STORE_ID::INTEGER AS store_id,
        TRIM(STORE_NAME) AS store_name,
        TRIM(STORE_CITY) AS store_city,
        TRIM(STORE_LOCATION) AS store_location,
        TO_DATE(STORE_OPEN_DATE, 'DD-MM-YYYY') AS store_open_date,
        CURRENT_TIMESTAMP() AS _loaded_at
    FROM source
    WHERE STORE_ID IS NOT NULL
)

SELECT * FROM renamed