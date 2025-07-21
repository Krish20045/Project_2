{% snapshot snap_products %}

    {{
        config(
          target_database='PROJECT_2',
          target_schema='snapshots',
          unique_key='product_id',
          strategy='check',
          check_cols=['product_name', 'product_category', 'product_cost', 'product_price'],
        )
    }}

    SELECT 
        product_id,
        product_name,
        product_category,
        product_cost,
        product_price,
        CURRENT_TIMESTAMP() as snapshot_time
    FROM PROJECT_2.DBT_KPATEL2_PUBLIC.STG_PRODUCTS

{% endsnapshot %}