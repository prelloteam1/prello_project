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
        gr.epci_code,
        gr.city_name
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
b_n_b AS (
    SELECT
        *
    FROM population
    WHERE poi NOT LIKE "bed_and_breakfast"),

--- ajouter une colonne avec le count d'etablissement par departement
POI_tourist_establishments AS (
    SELECT
        *,
        COUNT(name) OVER (PARTITION BY department_code) AS nb_estab_dpt,
        COUNT(name) OVER (PARTITION BY municipality_code) AS nb_estab_mun,
        COUNT(name) OVER (PARTITION BY epci_code) AS nb_estab_epci
    FROM b_n_b)

--- JUSTE POUR GARDER LA SUB-QUERRY D'OUVERTE POUR L'INSTANT --- A CLEANER A LA FIN SI INUTILE ---
SELECT *
FROM POI_tourist_establishments