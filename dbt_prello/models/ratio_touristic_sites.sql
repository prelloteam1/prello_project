{{ config(
    materialized='table'
)}}

--- Calculate the kpis of POI_touristic_sites ---
WITH ratio_touristic_sites AS (
    SELECT
        m.department_code,
        m.department_name,
        IF(m.epci_code IS NULL, 'ZZZZZZZZZ', m.epci_code) AS epci_code,
        m.municipality_code,
        m.city_name,
        p.nb_population,
        CONCAT(m.department_code,'-',m.city_name) AS dep_city_name,
        COUNT(DISTINCT m.name) AS nb_touristic_sites,
        SUM(m.poi_notation) AS attractiveness, 
        COUNT(DISTINCT m.name) * SUM(poi_notation) AS score_attractiveness,
    FROM {{ref('POI_touristic_sites_by_municipality')}} m
    LEFT JOIN {{ref('stg_population_by_municipality')}} p USING(municipality_code)
    WHERE municipality_code NOT LIKE '75%' AND p.year_year BETWEEN '2019-01-01' AND '2019-12-31'
    GROUP BY department_code, department_name, epci_code, municipality_code, city_name, nb_population
)

SELECT 
    *,
    DENSE_RANK() OVER(ORDER BY score_attractiveness DESC) AS attractiveness_rank,
    SAFE_DIVIDE(score_attractiveness, 149286) AS normalisation_attractiveness
FROM ratio_touristic_sites
ORDER BY attractiveness_rank