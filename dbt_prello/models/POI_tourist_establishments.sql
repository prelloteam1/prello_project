{{ config(
    materialized='table'
)}}

SELECT 
    *,
    LEFT(municipality_code,2) AS department_code
FROM {{ ref ('stg_POI_tourist_establishments')}}