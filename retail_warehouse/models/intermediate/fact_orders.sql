{{ config(
    materialized='table',
    schema='intermediate',
    post_hook=[
        "{{ create_indexes(this, [
            {'name': 'idx_orders_id', 'column': 'order_id'},
            {'name': 'idx_orders_status', 'column': 'order_status'}
        ]) }}"
    ]
) }}


SELECT
    o.order_id,
    customer_id,
    product_id,
    order_status,
    order_purchase_timestamp as order_date,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    price,
    freight_value,
    seller_id,
    review_id
FROM {{ ref('raw_orders') }} as o
LEFT JOIN {{ ref('raw_order_items') }} as od
ON o.order_id = od.order_id
LEFT JOIN {{ ref('raw_order_reviews') }} as r
ON o.order_id = r.order_id