SELECT 
    CONCAT(municipality_code,"_", year) AS municipality_year_id,
    municipality_code,
    avg_net_salary,
    PARSE_DATE("%Y",CAST(year AS STRING)) AS year_year,
    country_code
FROM
    prello_project.average_salary_by_municipality