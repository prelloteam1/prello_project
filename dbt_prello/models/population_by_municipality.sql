{{ config(
    materialized='table'
)}}

SELECT * FROM {{ ref ('stg_population_by_municipality')}}