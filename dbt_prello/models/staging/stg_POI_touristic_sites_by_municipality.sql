SELECT
    CONCAT(latitude,"_",longitude,"_",name) as geographic_id,
    poi,
    name,
    latitude,
    longitude,
    municipality_code,
    importance,
    LOWER(name_reprocessed) as name_reprocessed
FROM 
    prello_project.POI_touristic_sites_by_municipality
