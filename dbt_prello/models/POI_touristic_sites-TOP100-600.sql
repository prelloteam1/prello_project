{{ config(
    materialized='table'
)}}

SELECT
    p.department_code,
    p.department_name,
    p.epci_code,
    p.municipality_code,
    p.dep_city_name,
    p.nb_touristic_sites,
    p.nb_population,
    p.attractiveness,
    p.score_attractiveness,
    p.normalisation_attractiveness
FROM  {{ ref ('ratio_touristic_sites')}} p
WHERE p.nb_population >= 600
ORDER BY 8 DESC
LIMIT 100