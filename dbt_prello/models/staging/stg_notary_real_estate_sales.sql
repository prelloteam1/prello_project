
-- Identify duplicates rows
WITH uniques AS (select distinct
    concat(sales_date, "_", latitude, "_", longitude) as primary_key
from prello_project.notary_real_estate_sales), 

bases AS (
SELECT 
concat(sales_date, "_", latitude, "_", longitude) as primary_key,
* 
from prello_project.notary_real_estate_sales )

SELECT 
    uniques.primary_key,
    sales_date,
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

FROM uniques
left join bases ON  uniques.primary_key = bases.primary_key