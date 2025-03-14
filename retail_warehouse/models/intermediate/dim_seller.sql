{{ config(
    materialized='table',
    schema='intermediate'
) }}


SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM {{ ref('raw_sellers') }}