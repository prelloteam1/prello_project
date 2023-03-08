SELECT
    CAST(municipality_code AS INTEGER) AS municipality_code,
    city_name,
    city_name_normalized,
    municipality_type,
    latitude,
    longitude,
    CAST(department_code AS FLOAT) AS department_code,
    epci_code,
    country_code,
    department_name
FROM   
    prello_project.geographical_referential