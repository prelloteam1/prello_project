WITH uniques AS (
select distinct
    concat(sales_date, "_", latitude, "_", longitude,"_",sales_price_m2) as primary_key
from 
    prello_project.notary_real_estate_sales
), 

bases AS (
SELECT 
    concat(sales_date, "_", latitude, "_", longitude,"_",sales_price_m2) as primary_key,
    * 
from 
    prello_project.notary_real_estate_sales
)

SELECT 
    uniques.primary_key as primary_key,
    sales_date,
    sales_amount,
    street_number,
    street_code,
    street_name,
    nom_commune,
    CAST(municipality_code AS INTEGER) AS municipality_code,
    premise_type,
    surface,
    number_of_principal_rooms,
    sales_price_m2,
    latitude,
    longitude

FROM 
    bases
    RIGHT JOIN uniques ON  uniques.primary_key = bases.primary_key
WHERE 
    uniques.primary_key IS NOT NULL