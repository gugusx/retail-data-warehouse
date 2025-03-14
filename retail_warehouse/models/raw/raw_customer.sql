{{ config(
    materialized='table',
    schema='raw'
) }}

select
    customer_id::varchar(100) as customer_id,
    customer_unique_id::varchar(100) as customer_unique_id,
    customer_zip_code_prefix::varchar(10) as customer_zip_code_prefix,
    customer_city::varchar(100) as customer_city,
    customer_state::varchar(10) as customer_state
from {{ source('global', 'olist_customers_dataset') }}