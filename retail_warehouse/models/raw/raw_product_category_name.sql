{{ config(
    materialized='table',
    schema='raw'
) }}

select
    product_category_name::varchar(100) as product_category_name,
    product_category_name_english::varchar(100) as product_category_name_english
from {{ source('global', 'product_category_name_translation') }}