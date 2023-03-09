{{ config(
    materialized='table'
)}}

--- ajout de la colonne department_code ---
WITH department AS (
    SELECT 
        *,
        LEFT(municipality_code,2) AS department_code
    FROM {{ ref ('stg_POI_tourist_establishments')}}),

--- ajout de la colonne EPCI de la table geographical_referential ---
epci AS (
    SELECT 
        po.*,
        gr.epci_code
    FROM department AS po
    LEFT JOIN {{ ref ('stg_geographical_referential')}} AS gr ON po.municipality_code = gr.municipality_code),

--- ajout de la colonne population de la table population_by_municipality ---
population AS (
    SELECT 
        po.*,
        pm.nb_population
    FROM epci AS po
    LEFT JOIN {{ ref ('population_by_municipality')}} AS pm ON po.municipality_code = pm.municipality_code
    WHERE pm.year_year BETWEEN '2019-01-01' AND '2019-12-31'),

--- supprimer les lignes avec bed_and_breakfast ---
POI_tourist_establishments AS (
    SELECT
        *
    FROM population
    WHERE poi NOT LIKE "bed_and_breakfast")

--- JUSTE POUR GARDER LA SUB-QUERRY D'OUVERTE POUR L'INSTANT --- A CLEANER A LA FIN SI INUTILE ---
SELECT *
FROM POI_tourist_establishments