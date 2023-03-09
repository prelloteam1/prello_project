SELECT
    municipality_code,
    city_name,
    city_name_normalized,
    municipality_type,
    latitude,
    longitude,
    department_code,
    CAST(epci_code AS STRING) AS epci_code,
    country_code,
    department_name
FROM   
    prello_project.geographical_referential