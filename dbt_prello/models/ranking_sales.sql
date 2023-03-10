SELECT 
    LEFT(n.municipality_code,2) AS department_code,
    p.department_name,
    n.nom_commune,
    n.municipality_code,
    EXTRACT( YEAR FROM CAST(n.sales_date AS DATE)) as year_year,
    SUM(n.sales_amount) as sum_total_sales_amount,
    COUNT(n.sales_date) as nb_sales,
    AVG(n.sales_price_m2) as avg_sales_price_m2

    
FROM  {{ ref ('stg_notary_real_estate_sales')}} n 
    LEFT JOIN {{ ref ('stg_geographical_referential')}} p ON n.municipality_code = p.municipality_code
GROUP BY department_code,department_name, nom_commune,  municipality_code, year_year
ORDER BY 6 DESC, 7 DESC