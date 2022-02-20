{{ config(materialized='view') }}


select 
*
from {{source('staging', 'fhv_trips')}}


-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=false) %}
  limit 100
{% endif %}