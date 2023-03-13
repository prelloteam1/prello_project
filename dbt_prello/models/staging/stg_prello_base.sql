SELECT 
    localisation,
    title,
    CAST(price AS INTEGER) AS price_one_eighth,
    CAST(TRIM(surface,'m²') AS INTEGER) AS surface_m2
FROM 
    prello_project.prello_base
