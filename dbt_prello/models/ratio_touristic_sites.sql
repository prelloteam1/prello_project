{{ config(
    materialized='table'
)}}

--- Calculate the kpis of POI_touristic_sites ---

WITH ratio_touristic_sites AS (
    SELECT
        department_code,
        department_name,
        IF(epci_code IS NULL, 'ZZZZZZZZZ', epci_code) AS epci_code,
        municipality_code,
        COUNT(DISTINCT name) AS nb_touristic_sites,
        SUM(poi_notation) AS attractiveness, 
        COUNT(DISTINCT name) * SUM(poi_notation) AS attractiveness_score
    FROM {{ref('POI_touristic_sites_by_municipality')}}
    GROUP BY department_code, department_name, epci_code, municipality_code
)

SELECT 
    *,
    DENSE_RANK() OVER(ORDER BY attractiveness_score DESC) AS attractiveness_rank
FROM ratio_touristic_sites
ORDER BY attractiveness_rank