{{ config(
    materialized='table',
    schema='mart'
) }}

SELECT 
    product_category_name,
    count(distinct order_id) as total_orders,
    sum(price*freight_value) as total_revenue
FROM {{ ref('fact_orders') }} as o
INNER JOIN {{ ref('dim_product') }} as p
ON o.product_id = p.product_id
WHERE order_status = 'delivered'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 100