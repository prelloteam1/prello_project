{{ config(
    materialized='table'
)}}

SELECT * FROM {{ ref ('stg_housing_stock')}}