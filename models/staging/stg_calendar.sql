{{ config(materialized='table') }}

WITH source AS (
    SELECT * FROM {{ source('project_2_raw', 'CALENDAR') }}
),

calendar AS (
    SELECT
        "DATE"::DATE AS date,
        -- Extract day name from the date
        DAYNAME("DATE") AS day_name,
        -- Extract month name from the date
        MONTHNAME("DATE") AS month_name,
        -- Extract year from the date
        DATE_PART('year', "DATE")::INTEGER AS year,
        -- Extract quarter from the date
        DATE_PART('quarter', "DATE")::INTEGER AS quarter,
        CURRENT_TIMESTAMP() AS _loaded_at
    FROM source
    WHERE "DATE" IS NOT NULL
)

SELECT * FROM calendar