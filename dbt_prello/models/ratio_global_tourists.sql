{{ config(
    materialized='table'
)}}

--- Assembler les attractivités par établissements et par sites touristiques ---

WITH ratios_tourists AS (
    SELECT
        e.department_code,
        e.department_name,
        e.epci_code,
        e.municipality_code,
        e.dep_city_name,
        e.nb_establishment,
        e.population,
        e.population_per_establishment,
        t.nb_touristic_sites,
        t.attractiveness,
        t.score_attractiveness,
        e.normalized_ppe,
        t.normalisation_attractiveness
    FROM {{ref('ratio_establishment_by_population')}} e
    LEFT JOIN {{ref('ratio_touristic_sites')}} t ON e.municipality_code = t.municipality_code
)

SELECT 
    *,
    ROUND((normalized_ppe + normalisation_attractiveness)/2, 4) AS global_score
FROM ratios_tourists
ORDER BY global_score DESC