SELECT
    int64_field_0 AS municipality_year_id,
    municipality_code,
    PARSE_DATE("%Y",CAST(year AS STRING)) AS year_year,
    nb_principal_home,
    nb_second_home,
    nb_vacants_housing AS nb_vacants_home,
    nb_tot_housing AS nb_tot_home,
    principal_home_rate,
    secondary_home_rate,
    vacants_housing_rate,
    country_code

FROM
    prello_project.housing_stock
		
