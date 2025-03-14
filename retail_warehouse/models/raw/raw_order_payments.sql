{{ config(
    materialized='table',
    schema='raw'
) }}

select
    order_id::varchar(100) as order_id,
    payment_sequential::int as payment_sequential,
    payment_type::varchar(50) as payment_type,
    payment_installments::int as payment_installments,
    payment_value::numeric(20,2) as payment_value
from {{ source('global', 'olist_order_payments_dataset') }}