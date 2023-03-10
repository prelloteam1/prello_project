{{ config(
    materialized='table'
)}}

WITH population AS (
SELECT
    SUM(p.nb_population) as nb_population,
    LEFT(p.municipality_code,2) as department_code,
    g.epci_code,
    CONCAT((LEFT(p.municipality_code,2)),'-', g.city_name) as dep_city_name,
    IF(p.municipality_code LIKE '75%', '75056', p.municipality_code) AS municipality_code,
FROM
    {{ ref ('stg_population_by_municipality')}} p
    LEFT JOIN {{ ref ('stg_geographical_referential')}} g USING(municipality_code)
WHERE
    year_year = "2019-01-01"
GROUP BY
    2,3,4,5
),
establishments AS (
SELECT
    LEFT(e.municipality_code,2) as department_code,
    e.municipality_code,
    g.epci_code,
    COUNT(DISTINCT(e.name)) AS nb_hotel
FROM
    {{ ref ('stg_POI_tourist_establishments')}} e
    LEFT JOIN {{ ref ('stg_geographical_referential')}} g USING(municipality_code)
GROUP BY
    1,2,3
)

SELECT
e.department_code,
e.epci_code,
e.municipality_code,
p.dep_city_name,
SUM(e.nb_hotel) AS nb_establishment,
SUM(p.nb_population) AS population
FROM
    establishments e
    LEFT JOIN population p USING(municipality_code)
GROUP BY 
1,2,3,4