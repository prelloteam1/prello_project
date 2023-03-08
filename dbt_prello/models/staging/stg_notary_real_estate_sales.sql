
SELECT
    uniques_id,
    PARSE_DATE("%Y",CAST(year AS STRING)) as sales_date,
    sales_amount,
    street_number,
    street_code,
    street_name,
    nom_commune,
    municipality_code,
    premise_type,
    surface,
    number_of_principal_rooms,
    sales_price_m2,
    latitude,
    longitude
FROM
dbt_prello_staging.stg_notary_real_estate_sale_with_null
WHERE
uniques_id IS NOT NULL