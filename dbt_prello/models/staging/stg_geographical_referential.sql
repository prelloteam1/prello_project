SELECT
    municipality_code,
    city_name,
    city_name_normalized,
    municipality_type,
    latitude,
    longitude,
    department_code,
    CASE
        WHEN epci_code IS NULL AND department_code = '13' THEN '241300391'
        WHEN epci_code IS NULL AND department_code = '75' THEN '200054781'
        WHEN epci_code IS NULL AND department_code = '69' THEN '200046977'
        WHEN epci_code IS NULL AND department_code = '22' THEN 'ZZZZZZZZZ'
        WHEN epci_code IS NULL AND department_code = '85' THEN 'ZZZZZZZZZ'
        WHEN epci_code IS NULL AND department_code = '29' THEN 'ZZZZZZZZZ'
        ELSE CAST(epci_code AS STRING)
    END AS epci_code,
    country_code,
    department_name
FROM   
    prello_project.geographical_referential