{{ config(
    materialized='table',
    schema='mart'
) }}

SELECT 
    extract(year from order_date) as year,
    extract(month from order_date) as month,
    seller_city,
    sum(price*freight_value) as total_revenue,
    count(distinct order_id) as total_orders
FROM {{ ref('fact_orders') }} as o
INNER JOIN {{ ref('dim_seller') }} as s
ON o.seller_id = s.seller_id
WHERE order_status = 'delivered'
GROUP BY 1,2,3