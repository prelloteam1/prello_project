{{ config(
    materialized='table'
)}}

WITH POI_touristic_sites_category AS (
    SELECT 
        *,
        --- ajout des codes par département
        LEFT(municipality_code,2) AS department_code,
        --- ajout de la colonne des catégories pour grouper les poi de façon pertinante et les noter ensuite
        CASE
            WHEN REGEXP_CONTAINS(LOWER(poi),'castle') THEN 'castle'
            WHEN REGEXP_CONTAINS(LOWER(poi),'museum|theatre|monument') THEN 'culture'
            WHEN REGEXP_CONTAINS(LOWER(poi),'zoo|casino|cinema|allotments|attraction|theme_park|water_park|golf_course') THEN 'hobbies'
            WHEN REGEXP_CONTAINS(LOWER(poi),'historic_monument') THEN 'historic_monument'
            WHEN REGEXP_CONTAINS(LOWER(poi),'islet|water|geyser|wetland|waterfall') THEN 'nature_water'
            WHEN REGEXP_CONTAINS(LOWER(poi),'rock|cliff|ridge|valley|volcano|cave_entrance') THEN 'nature_mountain'
            WHEN REGEXP_CONTAINS(LOWER(poi),'park|forest|national_park|protected_area') THEN 'park_forest'
            WHEN REGEXP_CONTAINS(LOWER(poi),'world_heritage') THEN 'world_heritage'
            WHEN REGEXP_CONTAINS(LOWER(poi),'dune|sand|beach|marina') THEN 'beach'
            WHEN REGEXP_CONTAINS(LOWER(poi),'viewpoint') THEN 'viewpoint'
            WHEN REGEXP_CONTAINS(LOWER(poi),'vineyard') THEN 'vineyard'
            ELSE 'other'
        END AS poi_category
    FROM {{ ref ('stg_POI_touristic_sites_by_municipality')}}
),

--- ajout de la colonne epci_code sur la table POI touristic sites by municipality
POI_touristic_sites_by_municipality AS (
    SELECT
        t.*,
        g.epci_code
    FROM POI_touristic_sites_category t
    LEFT JOIN {{ref('stg_geographical_referential')}} g ON t.municipality_code = g.municipality_code
),

--- ajout de la colonne de notation des catégories de poi
POI_category AS (
    SELECT 
        *,
        CASE
            WHEN REGEXP_CONTAINS(poi_category,'nature_mountain|historic_monument|beach|world_heritage') THEN 6
            WHEN REGEXP_CONTAINS(poi_category,'castle|culture|hobbies|nature_water|park_forest|vineyard') THEN 4
            WHEN REGEXP_CONTAINS(poi_category,'viewpoint') THEN 2
            ELSE 0
        END AS poi_notation,
    FROM POI_touristic_sites_by_municipality
)

--- calcul des kpis
SELECT
    *,
    COUNT(DISTINCT name) OVER(PARTITION BY department_code) AS nb_sites_by_department,
    COUNT(DISTINCT name) OVER(PARTITION BY epci_code) AS nb_sites_by_epci,
    SUM(poi_notation) OVER(PARTITION BY department_code) AS attrativeness_by_department,
    SUM(poi_notation) OVER(PARTITION BY epci_code) AS attrativeness_by_epci
FROM POI_category