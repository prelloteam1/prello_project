<<<<<<< HEAD
SELECT
=======
SELECT 
>>>>>>> 6ebd5fb572f0b133474e2a05934036075a0a47db
    CONCAT(latitude, "-", longitude) AS geographic_id,
    poi,
    name,
    latitude,
    longitude,
    municipality_code,
    importance,
    LOWER(name_reprocessed) AS name_reprocessed
FROM
    prello_project.POI_tourist_establishments
