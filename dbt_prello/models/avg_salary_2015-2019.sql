{{ config(
    materialized='table'
)}}

-- permettre d'afficher l'évolution du salaire moyen dans looker grouper par année, département

with avg_salary_2015 as (
    select 
        AVG(a.avg_net_salary) as avg_net_salary2015,
        g.department_code,
        g.department_name

    from {{ ref ('stg_average_salary_by_municipality')}} a
        LEFT JOIN {{ ref ('stg_geographical_referential')}} g ON a.municipality_code = g.municipality_code
    where a.year_year = '2015-01-01'
    group by g.department_code, g.department_name
),

avg_salary_2019 as (
    select 
        AVG(a.avg_net_salary) as avg_net_salary2019,
        g.department_code,
        g.department_name

    from {{ ref ('stg_average_salary_by_municipality')}} a
        LEFT JOIN {{ ref ('stg_geographical_referential')}} g ON a.municipality_code = g.municipality_code
    where a.year_year = '2019-01-01'
    group by g.department_code, g.department_name
)

select 
    SUM(SAFE_DIVIDE(avg_net_salary2019,avg_net_salary2015)-1)*100 as evo_percent_avg_salary,
    SUM(avg_net_salary2019-avg_net_salary2015) as diff_value_salary,
    a.department_code,
    a.department_name
from avg_salary_2019 a  
    left join avg_salary_2015 USING(department_code)
where department_code IS NOT NULL 
group by a.department_code, a.department_name
order by 1 DESC
        
