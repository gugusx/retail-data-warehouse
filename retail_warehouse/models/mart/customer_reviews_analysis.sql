{{ config(
    materialized='table',
    schema='mart'
) }}

WITH dd AS (
    SELECT
        review_id,
        order_id,
        (order_delivered_customer_date - order_date) as delivery_days
    FROM {{ ref('fact_orders') }}
)
SELECT 
    review_score,
    COUNT(order_id) as total_reviews,
    AVG(delivery_days) as avg_delivery_days
FROM dd
RIGHT JOIN {{ ref('dim_review') }} r
ON dd.review_id = r.review_id
GROUP BY 1
ORDER BY 1 DESC