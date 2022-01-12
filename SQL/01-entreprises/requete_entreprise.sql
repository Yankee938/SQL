-- Affichage complet de la table
-- Je souhaite afficher toutes les informations des employes
SELECT id_employes, prenom, nom, sexe, service, date_embauche, salaire
FROM employes;

-- Affichage de la table employes avec le racourci de l'étoile "*" pour dire "ALL"
SELECT id_employes, prenom, nom, sexe, service, date_embauche, salaire
FROM employes;
-- Affiche-moi toutes les colonnes de la table employes

--Affichage du nom et prénom des employés

SELECT prenom, nom
FROM employes;

--Quels sont les differents services occupés par les employés ? 

SELECT service
FROM employes;

-------

-- DISTINCT
-- Affichage sans les doublons
SELECT DISTINCT service
FROM employes;

--------------------
--Condition WHERE
--Affichage des employes du service informatique
SELECT nom, prenom, service
FROM employes
WHERE service = 'informatique';

-------
-- Affichage des employés ayant été recrutés entre 2015 et aujourd'hui

SELECT nom, prenom, date_embauche
FROM employes
WHERE date_embauche BETWEEN '2015-01-01' AND '2022-01-07';


SELECT nom, prenom, date_embauche
FROM employes
WHERE date_embauche BETWEEN '2015-01-01' AND CURDATE();

--Pas de différence entre les quotes ' et les guillements "
--Quand (INT, FLOAT) on ne met pas de guillements ou de quotes 

--------
--Affichage des employés qui ont un prénom commençant par la lettre 's'
--LIKE : permet de trouver une valeur approchante

SELECT prenom 
FROM employes
WHERE prenom LIKE 's%'; -- % Le % indique qu'on ne fait attention au reste.
--le 's%' veut dire qu'on cherche un prenom commenacant par le s 

SELECT prenom 
FROM employes
WHERE prenom LIKE '%s'; -- Ici on cherche un prénom qui se termine par s


SELECT prenom 
FROM employes
WHERE prenom LIKE 's%s'; -- Ici on cherche un prénom qui commence et termine par s 

SELECT prenom 
FROM employes
WHERE prenom LIKE '%s%'; -- Ici on cherche un prénom qui contient la lettre s 

SELECT prenom 
FROM employes
WHERE prenom LIKE '%s%';
OR prenom LIKE'%e'; -- Ici on cherche un prénom qui termine par un s Ou par un e
-- Le or signifie "ou"

-----------
--Affichage des employés sauf le service informatique
SELECT nom, prenom, service
FROM employes
WHERE service != 'informatique';-- l'opérateur '!=' signifie diffent de ...

--Affichage de tous les employés gagnant un salaire supérieur à 3000euros
SELECT*
FROM employes
WHERE salaire > 3000;

----------
--Affichage des employés par ordre alphabétique en fonction du prenom 

SELECT*
FROM employes
ORDER BY prenom; -- par defaut par ordre croissant 

SELECT*
FROM employes
ORDER BY prenom ASC; -- on peut préciser que l'on souhaite bien de maniere croissante


-- On souhaite commencer par la fin
SELECT*
FROM employes
ORDER BY prenom DESC;

-- ORDER BY : permet d'effectuer un classement 
-- ASC : Ascendant / croissant
-- DESC : Descendant / décroissant

------------
-- Affichage des employés par ordre alphabétique en fonction du prénom
--Affichage des employés 3 par 3 
SELECT prenom
FROM employes
ORDER BY prenom ASC LIMIT 3; -- Le 3 correspond au nombre de resultat

SELECT prenom
FROM employes
ORDER BY prenom ASC LIMIT 0,3; -- Le 0 correspond à l'index  et le 3 au nombre de resultat souhaité (l'étendu)


SELECT prenom
FROM employes
ORDER BY prenom ASC LIMIT 3,3; -- IDEM que précédent 

--Exemple : peut servir pour créer une pagination 

--------
--Afficher des employés avec leur salaire annuel 

SELECT prenom, salaire*12
FROM employes;

-- On veut changer le nom de la colonne 'salaire*12'

SELECT prenom AS'pseudo', salaire*12 AS'salaire_annuel'
FROM employes;

---------
--Afficher la masse salarial sur une année 
SELECT SUM(salaire*12) AS 'masse_salarial'
FROM employes;
-- SUM : SOMME

SELECT SUM(salaire*12) AS 'masse_salarial'
FROM employes;
WHERE service ='informatique';

--------
--AVG : average
--Affichage du salaire moyenne
SELECT AVG(salaire)
FROM employes;

--Round : arrondie
SELECT ROUND(AVG(salaire)) AS 'salaire_moyen'
FROM employes;
-- On peut décider du nombre apres la virgue en l'indiquant dans les parenthese 
SELECT ROUND(AVG(salaire, 2)) AS 'salaire_moyen'
FROM employes;

---------
-- COUNT()
-- Affichage du nombre de femm dans l'entreprise
-- COUNT nous permet de retourner le nombre de resultat.
SELECT COUNT (*)
FROM employes
WHERE sexe = "f";

-----------
-- MIN / MAX
--Affichage du salaire maximum / minimum
-- SELECT salaire
-- FROM employes
-- ORDER BY salaire DESC LIMIT 0,1;

SELECT MAX(salaire), MIN(salaire)
FROM employes;

-- Qui gagne le salaire minimum ? je veux le prenom salaire et son service !
-- REQUETE IMBRIQUEE. permet de faire une premiere requete (SECELECT MIN(salaire) FROM employes) de récupérer sa valeur. Et d'utiliser cette valeur dans la requete globale.

SELECT prenom, nom, service, salaire
FROM employes
WHERE salaire = (SELECT MIN(salaire) FROM employes);

---------
--IN
--Affichage des employés du service informatique et comptabilité
--VERSION TROP LONGUE
SELECT*
FROM employes
WHERE service ="informatique" 
OR service ="comptabilité"
OR service "direction";

SELECT*
FROM employes
WHERE service IN ('informatique', 'comptabilité');
-- IN permet de vérifier plusieurs valeurs
-- = permet de vérifier 1 seule valeur

-- NOT IN
-- Afficher des employés qui ne sont pas du service informatique et comptabilité 
SELECT*
FROM employes
WHERE service NOT IN ('informatique', 'comptabilité');
--NOT IN permet d'exclure  plusieurs valeurs
--8+ permet d'exclure 1 seule valeur

-- Affichage des commerciaux gagnant un salaire inférieur à 2000 euros

SELECT*
FROM employes
WHERE service IN ('commercial')
AND salaire<= 2000
ORDER BY salaire ASC;
-- AND : et ....(condition complémentaire)
-- On ne peut pas avoir plusieurs WHERE on utilisera ensuite des AND et OR 


-------
--
--Affichage du nombre d'employés par service
SELECT service, COUNT(*)
FROM employes
GROUP BY service;
-- Group by va associer les membres (+1) par service
-- Il associe es employes qui ont le meme service (GROUP BY service)



------------------------------------
-- #####Requete de l'insertion######
INSERT INTO employes (prenom, nom, sexe, service, salaire, date_embauche)
VALUES ('Riaz', 'Emamuck','m','informatique',2000, CURDATE());

INSERT INTO employes
VALUES (NULL,'Thomas', 'Toto','m','informatique',CURDATE(),1900);

------------------------------------
-- #####Requete de Modification ######
-- Ici on modifie le salaire de l'employé'991'
UPDATE employes 
SET salaire = 5000
WHERE id_employes=991;
-- Sans la condition WHERE on modifierais le salaire de tous les employés

UPDATE employes
SET sexe ='f', service ='informatique'
WHERE id_employes=991;

---------------------------------
-- REPLACE
REPLACE INTO employes
VALUES (991,'test','test','m','markeging','2021-10-03',2500);-- Ici UPDATE

REPLACE INTO employes
VALUES (NULL,'test','test','m','markeging','2021-10-03',2500);-- Ici INSERT
-- SI l'id est trouvé dans la BDD, REPLACE va agir comme un UPDATE. 
-- PAR contre si l'ID n'est pas trouvé, le REPLACE va agir comme un INSERT


-- #####Requete de Suppression ######
-- On peut supprimer un employé par son ID
DELETE FROM employes
WHERE id_employes = 991;

-- Supprimer le service informatique
DELETE FROM employes
WHERE service ='informatique';

########EXERCICES########

-- 1 -- Afficher le service de l'employé 547.

SELECT service
FROM employes
WHERE id_employes = 547;

-- 2 -- Afficher la date d'embauche d'Amandine.

SELECT prenom, date_embauche
FROM employes
WHERE prenom ='Amandine'

-- 3 -- Afficher le nom de famille de Guillaume

SELECT nom
FROM employes
WHERE prenom='Guillaume';

-- 4 -- Afficher le nombre de personne ayant un n° id_employes commençant par le chiffre 5.

SELECT count(*)
FROM employes
WHERE id_employes like "5%";

-- 5 -- Afficher le nombre de commerciaux avec l'alias 'nombre_commerciaux'.

SELECT COUNT(*) AS "nombre_commerciaux"
FROM employes
WHERE service like 'commercial'

-- 6 -- Afficher le salaire moyen des informaticiens (+arrondie) avec l'alias 'salaire_moyen'.
SELECT ROUND(AVG(salaire)) AS "salaire_moyen"
FROM employes
WHERE service like "informatique";

-- 7 -- Afficher les 5 premiers employés après avoir classer leur nom de famille par ordre alphabétique.

SELECT*
FROM employes
ORDER BY nom ASC LIMIT 0,5;

-- 8 -- Afficher le coût des commerciaux sur 1 année.

SELECT SUM (salaire*12)
FROM employes
WHERE service ="commercial";

-- 9 -- Afficher le salaire moyen par service. (service + salaire moyen)

SELECT service, FLOOR(AVG(salaire)
FROM employes
GROUP BY service;

-- 10 -- Afficher le nombre de recrutement sur l'année 2010 (+alias).

SELECT COUNT(*)AS 'Recrutement Année 2010'
FROM employes
WHERE date_embauche BETWEEN "2010-01-01" AND "2010-12-31";

--OU-- FROM employes WHERE date_embauche LIKE '2010%';

-- 11 -- Afficher le salaire moyen appliqué lors des recrutements sur la pèriode allant de début 2012 a fin 2014

SELECT FLOOR(AVG(salaire))
FROM employes
WHERE date_embauche BETWEEN "2012-01-01" AND "2014-12-31";

-- 12 -- Afficher le nombre de service différent

SELECT COUNT(DISTINCT service)
FROM employes;



-- 13 -- Afficher tous les employés (sauf ceux du service production et secrétariat)

SELECT*
FROM employes
WHERE service NOT IN ('prodution', 'secretariat');

-- 14 -- Afficher conjoitement le nombre d'homme et de femme dans l'entreprise

SELECT  sexe, COUNT(*)
FROM employes
GROUP by sexe;

-- 15 -- Afficher les commerciaux ayant été recrutés avant 2016 de sexe masculin et gagnant un salaire supèrieur a 2500€

SELECT*
FROM employes
WHERE date_embauche < '2016-01-01'
AND sexe = 'm'
AND salaire > 2500
AND service = 'commercial';

-- 16 -- Qui a été embauché en dernier

SELECT *
FROM employes
ORDER BY date_embauche DESC LIMIT 1;


SELECT * FROM employes WHERE date_embauche = (SELECT MAX(date_embauche) FROM employes);

-- 17 -- Afficher les informations sur l'employé du service commercial gagnant le salaire le plus élevé

SELECT*
FROM employes
WHERE service="commercial" AND (SELECT MAX(salaire) FROM employes)
ORDER BY salaire DESC LIMIT 1;

SELECT* FROM employes
WHERE salaire = (SELECT MAX(salaire) FROM employes WHERE service='commercial')
AND service ='commercial';


-- 18 -- Afficher le prénom du comptable gagnant le meilleur salaire

18.1 SELECT prenom, salaire
FROM employes
WHERE service="comptabilite"
ORDER BY salaire DESC LIMIT 1;


18.2 SELECT prenom FROM employes 
    WHERE service='comptabilite'
    AND salaire =(SELECT MAX(salaire)FROM employes WHERE service='comptabilité');

-- 19 -- Afficher le prénom de l'informaticien ayant été recruté en premier

SELECT prenom, date_embauche
FROM employes
WHERE service="informatique"
ORDER BY date_embauche ASC LIMIT 1;

SELECT prenom FROM  employes
WHERE date_embauche =(SELECT MIN(date_embauche) FROM employes WHERE service='informatique')
AND service='informatique';

-- 20 -- Augmenter chaque employé de 100 €

UPDATE employes SET salaire = salaire + 100

-- 21 -- Supprimer les employés du service secrétariat
DELETE FROM employes
WHERE service = 'secretariat';


--#########  JOINTURE #######
-- Afficher les employés  (nom, prenom) et leur secteur (ville)
SELECT nom , prenom , ville
FROM employes AS e, secteur AS s
WHERE e.id_secteur = s.id_secteur;

-- LEFT / RIGHT / INNER / NATURAL 
--INNER JOIN DONNE LE MEME RESULTAT  QUE LA REQUETE WHERE AU DESSUS. 
SELECT nom , prenom , ville 
FROM employes AS e
INNER JOIN secteur AS s 
ON e.id_secteur = s.id_secteur;

--LEFT JOIN
--AFFICHER TOUS LES EMPLOYES PLUS LEUR SECTEUR 
SELECT nom, prenom, ville
FROM employes AS e 
LEFT JOIN secteur AS s
ON e.id_secteur = s.id_secteur;

-- RIGHT JOIN
--AFFICHER TOUTES LES VILLES PLUS LES EMPLOYES AFFECTES
-- ROUBAIX  APPARAITERA DONC DANS LA LISTE 

SELECT nom, prenom, ville
FROM employes AS e 
RIGHT JOIN secteur AS s
ON e.id_secteur = s.id_secteur;

-- NATURAL pour une seule liaison possible ( que les correspondance , on aura pas roubaix null )
SELECT nom , prenom, ville 
FROM employes
NATURAL JOIN secteur; 


------###### FONCTIONS SQL########

-- CONCATENER plusieurs colonnes LE NOM ET LE PRENOM
SELECT CONCAT(nom , ' ',prenom) AS 'nom_prenom', ville 
FROM employes
NATURAL JOIN secteur; 

-- CONCATENER 
SELECT CONCAT_WS('- ',nom,prenom) AS 'nom_prenom', ville 
FROM employes
NATURAL JOIN secteur; 


-- A TESTER SUR LA BDD BIBLIOTHEQUE 
-- UNION  --> permet de fusionner 2 resultat dans une meme colonne  ( resultats les uns a la suite des autres )

SELECT auteur AS 'liste personne physique'
FROM livre
UNION SELECT prenom FROM abonne;


