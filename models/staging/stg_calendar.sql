{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('maven_toys_raw', 'CALENDAR') }}
),

CALENDAR AS (
    SELECT
        TO_DATE(DATE, 'DD-MM-YYYY') AS date_day,
        EXTRACT(YEAR FROM TO_DATE(DATE, 'DD-MM-YYYY')) AS year,
        EXTRACT(MONTH FROM TO_DATE(DATE, 'DD-MM-YYYY')) AS month,
        EXTRACT(DAY FROM TO_DATE(DATE, 'DD-MM-YYYY')) AS day,
        EXTRACT(QUARTER FROM TO_DATE(DATE, 'DD-MM-YYYY')) AS quarter,
        EXTRACT(WEEK FROM TO_DATE(DATE, 'DD-MM-YYYY')) AS week_of_year,
        DAYNAME(TO_DATE(DATE, 'DD-MM-YYYY')) AS day_name,
        MONTHNAME(TO_DATE(DATE, 'DD-MM-YYYY')) AS month_name,
        CASE 
            WHEN DAYNAME(TO_DATE(DATE, 'DD-MM-YYYY')) IN ('Saturday', 'Sunday') 
            THEN TRUE 
            ELSE FALSE 
        END AS is_weekend,
        CURRENT_TIMESTAMP() AS _loaded_at
    FROM source
    WHERE DATE IS NOT NULL
)

SELECT * FROM CALENDAR