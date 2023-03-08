{{ config(
    materialized='table'
)}}

SELECT 
    *,
    CAST(LEFT(municipality_code,2) AS INTEGER) AS department_code,
FROM {{ ref ('stg_average_salary_by_municipality')}}