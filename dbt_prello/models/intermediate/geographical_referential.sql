{{ config(
    tags=["no_use"],
    docs={'node_color': 'red'}
)}}

SELECT 
    *
FROM {{ ref ('stg_geographical_referential')}}