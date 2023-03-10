{{ config(
    materialized='table'
)}}

SELECT 
    *,
    LEFT(municipality_code,2) AS department_code,
    p.department_name
FROM {{ ref ('stg_housing_stock')}} a
    LEFT JOIN {{ ref ('stg_geographical_referential')}} p USING(municipality_code)
