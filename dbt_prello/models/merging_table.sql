
SELECT 
    m.*,
    h.occupation_rate,
    h.housing_repartition,
    h.secondary_home_rate,
    p.profitability,
    p.normalized_profitability,
    r.nb_establishment,
    r.population,
    t.attractiveness_rank,
    t.normalisation_attractiveness
    
FROM 
    {{ ref ('market_dynamism') }} m
    LEFT JOIN {{ ref ('occupation_rate_repartition_secondary_house') }} h USING(municipality_code)
    LEFT JOIN {{ ref ('profitability_m2') }} p USING(municipality_code)
    LEFT JOIN {{ ref ('ratio_establishment_by_population') }} r USING(municipality_code)
    LEFT JOIN {{ ref ('ratio_touristic_sites') }} t USING(municipality_code)
