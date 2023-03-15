
SELECT 
    m.*,
    h.occupation_rate,
    h.housing_repartition,
    h.secondary_home_rate,
    p.profitability,
    p.normalized_profitability,
    r.nb_establishment,
    r.population,
    t.normalized_ppe,
    t.normalisation_attractiveness,
    t.global_score,
    tr.voyageurs AS has_train_station
    
FROM 
    {{ ref ('market_dynamism') }} m
    LEFT JOIN {{ ref ('occupation_rate_repartition_secondary_house') }} h USING(municipality_code)
    LEFT JOIN {{ ref ('profitability_m2') }} p USING(municipality_code)
    LEFT JOIN {{ ref ('ratio_establishment_by_population') }} r USING(municipality_code)
    LEFT JOIN {{ ref ('ratio_global_tourists') }} t USING(municipality_code)
    LEFT JOIN {{ ref ('stg_train_station') }} tr USING(city_name_normalized) 

