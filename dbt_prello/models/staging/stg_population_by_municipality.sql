SELECT
    CONCAT(municipality_code,"_",year) AS municipality_year_id,
    municipality_code,	
    PARSE_DATE("%Y",CAST(year AS STRING)) AS year_year,	
    CAST(population AS INT) AS nb_population,
    country_code	
FROM 
    prello_project.population_by_municipality