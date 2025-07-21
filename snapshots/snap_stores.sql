{% snapshot snap_stores %}

    {{
        config(
          target_database='PROJECT_2',
          target_schema='snapshots',
          unique_key='store_id',
          strategy='check',
          check_cols=['store_name', 'store_city', 'store_location'],
        )
    }}

    SELECT 
        store_id,
        store_name,
        store_city,
        store_location,
        store_open_date,
        CURRENT_TIMESTAMP() as snapshot_time
    FROM PROJECT_2.DBT_KPATEL2_PUBLIC.STG_STORES

{% endsnapshot %}