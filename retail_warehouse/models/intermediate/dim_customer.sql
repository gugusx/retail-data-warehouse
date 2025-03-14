{{ config(
    materialized='table',
    schema='intermediate'
) }}


SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM {{ ref('raw_customer') }}