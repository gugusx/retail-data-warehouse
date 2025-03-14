{{ config(
    materialized='table',
    schema='raw'
) }}

select
    seller_id::varchar(100) as seller_id,
    seller_zip_code_prefix::varchar(10) as seller_zip_code_prefix,
    seller_city::varchar(100) as seller_city,
    seller_state::varchar(10) as seller_state
from {{ source('global', 'olist_sellers_dataset') }}