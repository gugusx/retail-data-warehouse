{{ config(
    materialized='table',
    schema='raw'
) }}

select
    order_id::varchar(100) as order_id,
    order_item_id::int as order_item_id,
    product_id::varchar(100) as product_id,
    seller_id::varchar(100) as seller_id,
    shipping_limit_date::timestamp as shipping_limit_date,
    price::numeric(20,2) as price,
    freight_value::numeric(20,2) as freight_value
from {{ source('global', 'olist_order_items_dataset') }}