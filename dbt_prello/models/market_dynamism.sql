--- Nombre de vente 
WITH sales AS (
SELECT 
    h.municipality_code
    ,g.epci_code
    ,g.latitude
    ,g.longitude
    ,LEFT(h.municipality_code, 2) as department_code
    ,COUNT(DISTINCT s.uniques_id) as nb_ventes
FROM 
    {{ ref ('stg_housing_stock') }} h 
    LEFT JOIN {{ ref ('stg_notary_real_estate_sales') }} s USING(municipality_code)
    LEFT JOIN {{ ref ('stg_geographical_referential')}} g ON h.municipality_code = g.municipality_code
GROUP BY 
    5,2,1,4,3
),
--- Nombre de reference (maison primaire + maison secondaire + maison vacante)
reference AS (
SELECT 
    h.municipality_code
    ,g.epci_code
    ,LEFT(h.municipality_code, 2) as department_code
    ,SUM(h.nb_tot_home) as nb_reference
FROM
    {{ ref ('stg_housing_stock') }} h 
    LEFT JOIN {{ ref ('stg_geographical_referential')}} g ON h.municipality_code = g.municipality_code
GROUP BY 
    3,2,1
)

--- Query 
SELECT 
    s.municipality_code as municipality_code,
    s.epci_code as epci_code,
    s.department_code as department_code,
    s.nb_ventes as nb_ventes,
    r.nb_reference as nb_reference,
    s.latitude as latitude,
    s.longitude as longitude,
    ---- Express market_dynamism the highest, the more the market is open, the least the market is completely locked
    SAFE_DIVIDE(s.nb_ventes,r.nb_reference) AS market_dynamism,
    ---- Express market_dynamism on a scale from 0 to 1 | 0.06424697538589905 corresponding to the max value
    SAFE_DIVIDE(s.nb_ventes,r.nb_reference)/0.06424697538589905 AS market_dynamism_normalized
FROM 
    sales s 
    LEFT JOIN reference r USING(municipality_code)
ORDER BY
    9 DESC 

