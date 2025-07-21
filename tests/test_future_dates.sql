-- Test for future sales dates
SELECT *
FROM {{ ref('stg_sales') }}
WHERE sale_date > CURRENT_DATE()