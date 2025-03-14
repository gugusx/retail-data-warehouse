{{ config(
    materialized='table',
    schema='raw'
) }}

select
    product_id::varchar(100) as product_id,
    product_category_name::varchar(100) as product_category_name,
    product_name_length::int as product_name_length,
    product_description_length::int as product_description_length,
    product_photos_qty::int as product_photos_qty,
    product_weight_g::int as product_weight_g,
    product_length_cm::int as product_length_cm,
    product_height_cm::int as product_height_cm,
    product_width_cm::int as product_width_cm
from {{ source('global', 'olist_products_dataset') }}