SELECT
    CONCAT(municipality_code,"-",year) AS municipality_year_id,
    municipality_code,	
    year AS year_year,
    CAST (population AS INTEGER) AS nb_population,		
    country_code	
FROM 
    prello_project.population_by_municipality
