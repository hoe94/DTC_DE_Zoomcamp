{{ config(materialized='table') }}

with fhv_data as (
    select * from {{ ref('stg_fhv_tripdata') }}
), 

dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select fhv_data.*, 
pickup_zone.Borough,	
pickup_zone.Zone,	
pickup_zone.service_zone
from fhv_data
inner join dim_zones as pickup_zone
on fhv_data.PULocationID = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on fhv_data.DOLocationID = dropoff_zone.locationid
