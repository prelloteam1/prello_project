
SELECT
*
FROM
dbt_prello_staging.stg_notary_real_estate_sale_with_null
WHERE
uniques_id IS NOT NULL