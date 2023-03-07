SELECT
    CONCAT(municipality_code,"-", housing_stock.year) AS municipality_year_id,
    municipality_code,
    year AS year_year,
    nb_principal_home,
    nb_second_home,
    nb_vacants_housing AS nb_vacants_home,
    nb_tot_housing AS nb_tot_home,
    country_code
FROM
    prello_project.housing_stock