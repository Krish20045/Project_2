-- Test for sales without matching products
SELECT s.*
FROM {{ ref('stg_sales') }} s
LEFT JOIN {{ ref('stg_products') }} p ON s.product_id = p.product_id
WHERE p.product_id IS NULL