-- Projet : Le Tifosi
-- Script 3 : les 10 requêtes de test demandées

USE tifosi;

-- Requête 1 : afficher les focaccias par ordre alphabétique
SELECT nom_focaccia
FROM focaccia
ORDER BY nom_focaccia ASC;

-- Requête 2 : compter le nombre total d'ingrédients
SELECT COUNT(*) AS nombre_total_ingredients
FROM ingredient;

-- Requête 3 : calculer le prix moyen des focaccias
SELECT ROUND(AVG(prix), 2) AS prix_moyen
FROM focaccia;

-- Requête 4 : afficher les boissons avec leur marque, par ordre alphabétique
SELECT
    b.nom_boisson,
    m.nom_marque
FROM boisson b
INNER JOIN marque m
    ON b.id_marque = m.id_marque
ORDER BY b.nom_boisson ASC;

-- Requête 5 : afficher les ingrédients de la Raclaccia et leurs quantités
SELECT
    i.nom_ingredient,
    c.quantite
FROM comprend c
INNER JOIN focaccia f
    ON c.id_focaccia = f.id_focaccia
INNER JOIN ingredient i
    ON c.id_ingredient = i.id_ingredient
WHERE f.nom_focaccia = 'Raclaccia'
ORDER BY i.nom_ingredient ASC;

-- Requête 6 : compter les ingrédients de chaque focaccia
SELECT
    f.nom_focaccia,
    COUNT(c.id_ingredient) AS nombre_ingredients
FROM focaccia f
INNER JOIN comprend c
    ON f.id_focaccia = c.id_focaccia
GROUP BY f.id_focaccia, f.nom_focaccia
ORDER BY f.nom_focaccia ASC;

-- Requête 7 : trouver la focaccia qui contient le plus d'ingrédients
SELECT
    f.nom_focaccia,
    COUNT(c.id_ingredient) AS nombre_ingredients
FROM focaccia f
INNER JOIN comprend c
    ON f.id_focaccia = c.id_focaccia
GROUP BY f.id_focaccia, f.nom_focaccia
ORDER BY nombre_ingredients DESC
LIMIT 1;

-- Requête 8 : trouver les focaccias contenant de l'ail
SELECT
    f.nom_focaccia
FROM focaccia f
INNER JOIN comprend c
    ON f.id_focaccia = c.id_focaccia
INNER JOIN ingredient i
    ON c.id_ingredient = i.id_ingredient
WHERE i.nom_ingredient = 'Ail'
ORDER BY f.nom_focaccia ASC;

-- Requête 9 : trouver les ingrédients qui ne sont utilisés dans aucune focaccia
SELECT
    i.nom_ingredient
FROM ingredient i
LEFT JOIN comprend c
    ON i.id_ingredient = c.id_ingredient
WHERE c.id_ingredient IS NULL
ORDER BY i.nom_ingredient ASC;

-- Requête 10 : trouver les focaccias sans champignons
SELECT
    f.nom_focaccia
FROM focaccia f
WHERE NOT EXISTS (
    SELECT 1
    FROM comprend c
    INNER JOIN ingredient i
        ON c.id_ingredient = i.id_ingredient
    WHERE c.id_focaccia = f.id_focaccia
      AND i.nom_ingredient = 'Champignon'
)
ORDER BY f.nom_focaccia ASC;
