{{ config(
    materialized='table',
    schema='mart'
) }}

SELECT 
    order_id,
    customer_city,
    customer_state,
    order_estimated_delivery_date,
    order_delivered_customer_date,
    (order_delivered_customer_date - order_estimated_delivery_date) as delay_days
FROM {{ ref('fact_orders') }} o
INNER JOIN {{ ref('dim_customer') }} c 
ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'