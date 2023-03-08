SELECT
    CONCAT(municipality_code,"_",year) AS municipality_year_id,
    CAST(municipality_code AS INTEGER) AS municipality_code,	
    year AS year_year,
    CAST (population AS INTEGER) AS nb_population,		
    country_code	
FROM 
    prello_project.population_by_municipality
