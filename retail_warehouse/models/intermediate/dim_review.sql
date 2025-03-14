{{ config(
    materialized='table',
    schema='intermediate'
) }}


SELECT
    review_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM {{ ref('raw_order_reviews') }}