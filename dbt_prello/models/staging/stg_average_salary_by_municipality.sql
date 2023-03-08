SELECT 
    CONCAT(municipality_code,"_", year) AS municipality_year_id,
    CAST(municipality_code AS INTEGER) AS municipality_code,
    avg_net_salary,
    year AS year_year,
    country_code
FROM
    prello_project.average_salary_by_municipality