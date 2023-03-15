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
        s.department_code,
        s.department_name,
        s.municipality_code,
        s.dep_city_name,
        SUM(c.beach) AS beach,
        SUM(c.nature_water) AS nature_water,
        SUM(c.nature_mountain) AS nature_mountain,
        SUM(c.park_forest) AS park_forest,
        SUM(c.castle) AS castle,
        SUM(c.historic_monument) AS historic_monument,
        SUM(c.world_heritage) AS world_heritage,
        SUM(c.culture) AS culture,
        SUM(c.hobbies) AS hobbies,
        SUM(c.vineyard) AS vineyard,
        SUM(c.viewpoint) AS viewpoint,
        SUM(c.other) AS other
    FROM {{ref('ratio_touristic_sites')}} s
    LEFT JOIN POI_category c ON s.municipality_code = c.municipality_code
    GROUP BY department_code, department_name, municipality_code, dep_city_name
)

SELECT
    b.*,
    s.nb_population, 
    s.nb_touristic_sites,
    s.attractiveness,
    s.score_attractiveness,
    s.normalisation_attractiveness
FROM POI_boolean b
LEFT JOIN {{ref('ratio_touristic_sites')}} s ON s.municipality_code = b.municipality_code