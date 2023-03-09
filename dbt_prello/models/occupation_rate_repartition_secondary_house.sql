SELECT 
    municipality_code,
    epci_code,
    department_code,
    g.latitude,
    g.longitude,
    SUM(nb_principal_home) AS nb_principal_home,
    SUM(nb_second_home) AS nb_second_home,
    SUM(nb_vacants_home) AS nb_vacants_home,
    SUM(nb_principal_home + nb_second_home + nb_vacants_home) AS nb_tot_home,
    --- Indicateur permettant de savoir le taux d'occupation des housing 
    SAFE_DIVIDE(SUM(nb_principal_home + nb_second_home),SUM(nb_principal_home + nb_second_home + nb_vacants_home)) AS occupation_rate,
    --- Indicateur permettant de savoir la répartition des biens (près de 0 que du principal | au dessus de 1 plus de secondaire que principal)
    SAFE_DIVIDE(SUM(nb_second_home),SUM(nb_principal_home)) AS housing_repartition,
    --- Indicateur permettant de savoir la proportion de maison secondaire sur la proportion 
    SAFE_DIVIDE(SUM(nb_second_home),SUM(nb_principal_home)) AS secondary_home_rate

FROM 
    {{ ref ('stg_housing_stock')}} h 
    LEFT JOIN {{ ref ('stg_geographical_referential')}} g USING(municipality_code)
GROUP BY 
    3,2,1,4,5
