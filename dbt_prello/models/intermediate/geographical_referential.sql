{{ config(
    materialized='table'
)}}

SELECT 
    *
FROM {{ ref ('stg_geographical_referential')}}