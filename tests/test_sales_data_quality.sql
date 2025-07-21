-- Test for negative sales
SELECT *
FROM {{ ref('stg_sales') }}
WHERE units_sold <= 0