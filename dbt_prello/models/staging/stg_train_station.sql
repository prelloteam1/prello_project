SELECT 
    libelle,
    REPLACE(commune,"-"," ") AS city_name_normalized, 
    departemen,
    voyageurs,
    geo_point_2d,
    REGEXP_EXTRACT(geo_point_2d, "^(.+?),") AS latitude,
    REGEXP_EXTRACT(geo_point_2d, "[^,]*$") AS longitude 
FROM
    prello_project.list_train_station
WHERE 
    voyageurs = "O"    	
