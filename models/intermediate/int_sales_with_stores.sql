{{ config(materialized='table') }}

WITH sales_products AS (
    SELECT * FROM {{ ref('int_sales_with_products') }}
),

stores AS (
    SELECT * FROM {{ ref('stg_stores') }}
),

sales_with_stores AS (
    SELECT
        sp.*,
        st.store_name,
        st.store_city,
        st.store_location,
        st.store_open_date
    FROM sales_products sp
    LEFT JOIN stores st ON sp.store_id = st.store_id
)

SELECT * FROM sales_with_stores