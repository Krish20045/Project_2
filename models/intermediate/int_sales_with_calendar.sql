{{ config(materialized='table') }}

WITH sales_enhanced AS (
    SELECT * FROM {{ ref('int_sales_with_stores') }}
),

calendar AS (
    SELECT * FROM {{ ref('stg_calendar') }}
),

sales_with_calendar AS (
    SELECT
        se.*,
        c.day_name,
        c.month_name,
        c.year,
        c.quarter
    FROM sales_enhanced se
    LEFT JOIN calendar c ON se.sale_date = c.date
)

SELECT * FROM sales_with_calendar