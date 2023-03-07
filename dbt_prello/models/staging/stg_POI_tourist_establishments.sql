SELECT 
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