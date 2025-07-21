{% snapshot snap_inventory %}

    {{
        config(
          target_database='PROJECT_2',
          target_schema='snapshots',
          unique_key='CONCAT(store_id, \'_\', product_id)',
          strategy='check',
          check_cols=['stock_on_hand'],
        )
    }}

    SELECT 
        store_id,
        product_id,
        stock_on_hand,
        CURRENT_TIMESTAMP() as snapshot_time
    FROM PROJECT_2.DBT_KPATEL2_PUBLIC.STG_INVENTORY

{% endsnapshot %}


