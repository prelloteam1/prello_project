{{ config(
    materialized='table'
)}}

--- Calculate the kpis of POI_touristic_sites ---

SELECT
    department_code,
    IF(epci_code IS NULL, 'ZZZZZZZZZ', epci_code) AS epci_code,
    municipality_code,
    COUNT(DISTINCT name) AS nb_touristic_sites,
    SUM(poi_notation) AS attractiveness
FROM {{ref('POI_touristic_sites_by_municipality')}}
GROUP BY department_code, epci_code, municipality_code