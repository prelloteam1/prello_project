{{ config(
    materialized='table'
)}}


SELECT 
    p.department_code,
    p.epci_code,
    p.municipality_code,
    p.dep_city_name,
    SUM(p.nb_establishment) AS nb_establishment,
    SUM(p.population) AS population,
    SUM(p.population)/SUM(p.nb_establishment) AS pop_per_est,
    p.normalized_ppe
FROM  {{ ref ('ratio_establishment_by_population')}} p
WHERE p.dep_city_name NOT LIKE '75%' AND p.population >= 600
GROUP BY 1,2,3,4,8
ORDER BY 7 ASC 

LIMIT 100