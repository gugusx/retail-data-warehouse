{{ config(
    materialized='table',
    schema='mart'
) }}

SELECT 
    date(order_date) as order_date,
    sum(price*freight_value) as total_revenue,
    count(distinct order_id) as total_orders,
    count(distinct product_id) as products_variant_sold
FROM {{ ref('fact_orders') }} 
WHERE order_status = 'delivered'
GROUP BY 1
ORDER BY 1