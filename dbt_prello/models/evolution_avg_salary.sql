{{ config(
    materialized='table'
)}}

-- permettre d'afficher l'évolution du salaire moyen dans looker grouper par année, département, code epci
select 
    AVG(a.avg_net_salary) as avg_net_salary,
    a.year_year,
    a.country_code as department_code,
    g.epci_code,
    g.department_name

from {{ ref ('stg_average_salary_by_municipality')}} a
    LEFT JOIN {{ ref ('stg_geographical_referential')}} g ON a.municipality_code = g.municipality_code

GROUP BY year_year, department_code, g.department_name, epci_code, 