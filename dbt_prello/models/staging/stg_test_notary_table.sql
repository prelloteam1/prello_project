select distinct
    concat(
        sales_date, "_", latitude, "_", longitude, "_", sales_price_m2
    ) as primary_key
from prello_project.notary_real_estate_sales
where
    concat(sales_date, "_", latitude, "_", longitude, "_", sales_price_m2) is not null
    and latitude is not null
    and longitude is not null
    and sales_price_m2 is not null
