{{ config(
    tags=["not_show"],
    docs={'node_color': 'blue'}
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
WHERE p.nb_population >= 5000 AND nb_touristic_sites >= 10
ORDER BY 9 DESC
LIMIT 100