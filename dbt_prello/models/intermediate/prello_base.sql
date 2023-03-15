{{ config(
    materialized='table'
)}}

WITH prello_base AS (
    SELECT * FROM {{ ref('stg_prello_base')}})

SELECT
    *,
    ROUND(price_one_eighth*8,0) AS total_price
FROM prello_base