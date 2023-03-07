{{ config(
    materialized='table'
)}}

SELECT * FROM {{ ref ('stg_POI_tourist_establishments')}}