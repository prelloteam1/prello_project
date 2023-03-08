{{ config(
    materialized='table'
)}}

SELECT 
    *,
    LEFT(municipality_code,2) AS department_code
FROM {{ ref ('stg_real_estate_info_by_municipality')}}