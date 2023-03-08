{{ config(
    materialized='table'
)}}

WITH base_info AS (
    SELECT 
        DISTINCT (concat(sales_date, "_",sales_amount, "_",street_number, "_",street_code, "_",street_name, "_",nom_commune, "_",municipality_code, "_",premise_type, "_",surface, "_",number_of_principal_rooms, "_", latitude, "_", longitude, "_", sales_price_m2)) as uniques_id,
        *
    FROM
        prello_project.notary_real_estate_sales
    WHERE 
        latitude IS NOT NULL AND
        longitude IS NOT NULL AND
        sales_date IS NOT NULL
) 

SELECT 
    *  
FROM 
    base_info
WHERE 
    uniques_id IS NOT NULL
