{{ config(
    materialized='table'
)}}

-- rentabilité au m², loyer moyen / prix m² moyen par epci


-- selecting average price/m² in notary_real_estate_sales table per department and epci.
with avg_price_m2 as (
    select
        AVG(a.sales_price_m2) as avg_sales_price_m2
        ,p.department_code
        ,a.municipality_code
        ,p.department_name
        ,p.epci_code
        ,p.latitude
        ,p.longitude
    from {{ ref ('stg_notary_real_estate_sales')}} a
        LEFT JOIN {{ ref ('stg_geographical_referential')}} p 
        USING (municipality_code)
    group by
    2,3,4,5,6,7
),
-- selecting average rent per municipality and epci_code
rent as (
    select
        AVG(b.rental_med_all) as avg_rent_all
        ,p.municipality_code
        ,p.department_code
        ,p.department_name
        ,p.epci_code
        ,p.latitude
        ,p.longitude
    from {{ ref ('stg_real_estate_info_by_municipality')}} b
        LEFT JOIN {{ ref ('stg_geographical_referential')}} p USING (municipality_code)
    group by 2,3,4,5,6,7
)

select 
-- add profitability
        SAFE_DIVIDE(p.avg_sales_price_m2,rent.avg_rent_all) as profitability
-- add normalized profitabilty which is in between 0 and 1 : max value is 1090,... max number of months to pay
-- here normalized profitability is 0 : minimum profitable over territory and 1 max profitable in France
       ,1-SAFE_DIVIDE(p.avg_sales_price_m2,rent.avg_rent_all)/1090.9207324881547 as normalized_profitability
       ,avg_rent_all as rental_means
       ,p.municipality_code
       ,p.epci_code
       ,p.department_code
       ,p.department_name
       ,p.latitude
       ,p.longitude
from avg_price_m2 p 
    LEFT JOIN rent USING(municipality_code)
WHERE SAFE_DIVIDE(p.avg_sales_price_m2,rent.avg_rent_all) IS NOT NULL
ORDER BY 1 DESC