SELECT 
    n.sales_date,
    n.sales_amount,
    n.street_number,
    n.street_code,
    n.street_name,
    n.nom_commune,
    n.municipality_code,
    n.premise_type,
    n.surface,
    n.number_of_principal_rooms,
    n.sales_price_m2,
    p.latitude,
    p.longitude,
    LEFT(n.municipality_code,2) AS department_code

FROM  {{ ref ('stg_notary_real_estate_sales')}} n 
LEFT JOIN {{ ref ('stg_geographical_referential')}} p 
ON n.municipality_code = p.municipality_code

