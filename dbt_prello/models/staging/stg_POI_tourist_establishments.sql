SELECT
    CONCAT(latitude, "_", longitude) AS geographic_id,
    poi,
    name,
    latitude,
    longitude,
    CAST(municipality_code AS INTEGER) AS municipality_code,
    importance,
    LOWER(name_reprocessed) AS name_reprocessed
FROM
    prello_project.POI_tourist_establishments
