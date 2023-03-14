{{ config(
    materialized='table'
)}}

WITH POI_category AS(
    SELECT
        geographic_id,
        poi,
        name,
        latitude,
        longitude,
        municipality_code,
        name_reprocessed,
        department_code,
        poi_category,
        IF(REGEXP_CONTAINS(poi_category,'beach'),1,0) AS beach,
        IF(REGEXP_CONTAINS(poi_category,'park_forest'),1,0) AS park_forest,
        IF(REGEXP_CONTAINS(poi_category,'hobbies'),1,0) AS hobbies,
        IF(REGEXP_CONTAINS(poi_category,'vineyard'),1,0) AS vineyard,
        IF(REGEXP_CONTAINS(poi_category,'nature_water'),1,0) AS nature_water,
        IF(REGEXP_CONTAINS(poi_category,'castle'),1,0) AS castle,
        IF(REGEXP_CONTAINS(poi_category,'nature_mountain'),1,0) AS nature_mountain,
        IF(REGEXP_CONTAINS(poi_category,'culture'),1,0) AS culture,
        IF(REGEXP_CONTAINS(poi_category,'historic_monument'),1,0) AS historic_monument,
        IF(REGEXP_CONTAINS(poi_category,'world_heritage'),1,0) AS world_heritage,
        IF(REGEXP_CONTAINS(poi_category,'viewpoint'),1,0) AS viewpoint,
        IF(REGEXP_CONTAINS(poi_category,'other'),1,0) AS other
    FROM {{ref('POI_touristic_sites_by_municipality')}}
),

POI_boolean AS (
    SELECT
        department_code,
        municipality_code,
        SUM(beach) AS beach,
        SUM(nature_water) AS nature_water,
        SUM(nature_mountain) AS nature_mountain,
        SUM(park_forest) AS park_forest,
        SUM(castle) AS castle,
        SUM(historic_monument) AS historic_monument,
        SUM(world_heritage) AS world_heritage,
        SUM(culture) AS culture,
        SUM(hobbies) AS hobbies,
        SUM(vineyard) AS vineyard,
        SUM(viewpoint) AS viewpoint,
        SUM(other) AS other
    FROM POI_category
    GROUP BY department_code, municipality_code
)

SELECT 
    s.department_code,
    s.department_name,
    s.epci_code,
    s.municipality_code,
    s.dep_city_name,
    s.nb_population, 
    s.nb_touristic_sites,
    s.attractiveness,
    s.score_attractiveness,
    s.normalisation_attractiveness,
    b.beach,
    b.nature_mountain,
    b.nature_water,
    b.park_forest,
    b.castle,
    b.historic_monument,
    b.world_heritage,
    b.culture,
    b.hobbies,
    b.vineyard,
    b.viewpoint,
    b.other
FROM {{ref('ratio_touristic_sites')}} s 
LEFT JOIN POI_boolean b ON s.municipality_code = b.municipality_code
ORDER BY s.normalisation_attractiveness DESC