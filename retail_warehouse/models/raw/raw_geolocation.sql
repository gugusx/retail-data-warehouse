{{ config(
    materialized='table',
    schema='raw'
) }}

select
    geolocation_zip_code_prefix::varchar(10) as geolocation_zip_code_prefix,
    geolocation_lat::varchar(100) as geolocation_lat,
    geolocation_lng::varchar(100) as geolocation_lng,
    geolocation_city::varchar(100) as geolocation_city,
    geolocation_state::varchar(10) as geolocation_state
from {{ source('global', 'olist_geolocation_dataset') }}