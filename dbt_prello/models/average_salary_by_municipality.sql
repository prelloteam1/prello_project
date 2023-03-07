{{ config(
    materialized='table'
)}}

SELECT * FROM {{ ref ('stg_average_salary_by_municipality')}}