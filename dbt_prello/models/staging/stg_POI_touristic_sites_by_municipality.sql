SELECT
    CONCAT(latitude,"_",longitude,"_",name) as geographic_id,
    CASE
        WHEN poi = "1" THEN "world_heritage"
        WHEN poi = "2" THEN "historic_monument"
        ELSE poi
    END AS poi,
    name,
    latitude,
    longitude,
    municipality_code,
    importance,
    LOWER(name_reprocessed) as name_reprocessed
FROM 
    prello_project.POI_touristic_sites_by_municipality
