-- models/staging/calendar.sql
{{
  config(
    materialized='view'
  )
}}

SELECT 
  *
FROM 
  data_dictionary;