-- Affichage des emprunts qui ne sont pas encore rendus --
SELECT*
FROM emprunt
WHERE date_rendu IS NULL;
--NULL est une valeur spécifique . On ne peut pas le vérifier avec l'opérateur '='. on sera obligé d'utiliser "IS NULL ou IS NOT NULL"

-----------------------
--Requete imbriquéé (sur plusieurs tables)

-- Afficher le titre des livres qui n'ont pas encore été rendu. 
--Titre des lives  -> dans la table libre 
-- Rendu ou non  -> dans la table emprunt  ( on ne peut pas utiliser order by ou groupe by)
-- Question : Je vais chercher tous les livres qui n'ont pas encore été rendu 
-- Quel est l'information qui me permet de faire le lien entre les deux table : id_livre
-- Id_livre permet de faire la liaison entre la table livre et emprunt

SELECT titre
FROM livre
WHERE id_livre IN (
SELECT id_livre FROM emprunt WHERE date_rendu IS NULL
);

-- Les requetes imbriquées ne fonctionne que si nous avons un champ commun entre les 2 tables
-- La limite des resquetes imbriquées c'est qu'on ne pourra pas avoir 2 champs de 2 tables différentes.
-- EX: SI l'on souhaite afficher le titre des livres et la date d'emprunt 
-- Ce n'est pas possible avec une requete imbriquée car ce sont 2 champs de 2 tables différentes.

--Afficher le prenom des abonnés qui n'ont pas rendu les livres 
SELECT prenom FROM abonne
WHERE id_abonne IN(
    SELECT id_abonne FROM emprunt WHERE date_rendu IS NULL
);

--Afficher les ID des livres que chloé a emprunté 
-- Je ne connait pas l'ID de chloé 

SELECT id_livre, date_emprunt
FROM emprunt
WHERE id_abonne = (

    SELECT id_abonne FROM abonne WHERE prenom ='chloe'
);

--EXERCICES
-- AFFICHER les prénoms des abonnés ayant emprunté un livre le 11/12/2016
-- C'est la table abonne qui contient les prenoms
-- Ce qui fait le lien entre la table abonné et emprunt c'est id_abonne
-- IN car on veut plusieurs valeurs on ne met pas = 

SELECT prenom
FROM abonne
WHERE id_abonne IN (

    SELECT id_abonne FROM emprunt WHERE date_emprunt ='2016-12-11'
);

-- Combien de livre Guillaume a emprunté a la bibliotheque ? 

SELECT COUNT(*) -- ou id_livre
FROM emprunt
WHERE id_abonne IN(
SELECT id_abonne FROM abonne WHERE prenom = 'Guillaume'

);

-- Afficher la liste des abonnés ayant déja emprunté un livre d'Alphonse Daudet 
-- TABLE abonnés / Table emprunt / table livre 

SELECT * FROM abonne
WHERE id_abonne IN (
SELECT id_abonne FROM emprunt 
WHERE id_livre IN (
SELECT id_livre FROM livre
WHERE auteur = 'Alphonse Daudet'
)
);

-- Afficher le titre des livres que Chloé a emprunté a la bibliotheque
-- Table livre / table emprunt / table abonne 

SELECT titre FROM livre
WHERE id_livre IN (
    SELECT id_livre  FROM emprunt
    WHERE id_abonne IN (
        SELECT id_abonne FROM abonne 
        WHERE prenom ='chloe'
    )
);


-- Afficher le titre des livres que Chloé  n'a pas encore emprunté a la bibliotheque
SELECT titre FROM livre
WHERE id_livre NOT IN (
    SELECT id_livre  FROM emprunt
    WHERE id_abonne IN (
        SELECT id_abonne FROM abonne 
        WHERE prenom ='chloe'
    )
);

-- Afficher le titre des livees que cholé n'a pas encore rendu à la bibliotheque 
-- Table livre / abonne / emprunt 
--Question : quel colonne on a de lié entre livre et emprunt pour le where

SELECT titre FROM livre 
WHERE id_livre IN ( SELECT id_livre FROM emprunt
WHERE id_abonne IN(
SELECT id_abonne FROM abonne 
WHERE prenom ='chloe'
AND date_rendu IS NULL
)

);

--Qui a emprunté le plus de livre a la bibliotheque 
SELECT * FROM abonne
WHERE id_abonne = (
    SELECT id_abonne FROM emprunt
    GROUP BY id_abonne ORDER BY COUNT(id_abonne) DESC LIMIT 1
     );


-- ###### LES JOINTURES ##########
-- Différences entre jointures et requetes imbriqués 
-- Une jointure  est une requete permettrant de relier les tables 
-- On peut faire une jointure dans tous les cas même s'il n ya pas de champs en communs entre les 2 tables. 
--Requete imbriquéé : Possible uniquement si le resultat est issue de la meme table 

--1)  Les jointure Interne  ( on ne récupére que les correspondances )
-- On affiche les dates d'emprunt et de rendu de l'abonné Guillaume
SELECT prenom , date_emprunt, date_rendu
FROM abonne as a, emprunt as e
WHERE a.id_abonne = e.id_abonne   -- faire un alias ou pas  abonne.id_abonne  ou a.id_abonne 
AND a.prenom='Guillaume';

SELECT  a.id_abonne, prenom , date_emprunt, date_rendu
FROM abonne as a, emprunt as e
WHERE a.id_abonne = e.id_abonne   -- faire un alias ou pas  abonne.id_abonne  ou a.id_abonne 
AND a.prenom='Guillaume';


-- Afficher les dates d'emprunt et de rendu des livres d'alphonse Daudet 
SELECT auteur, titre , date_emprunt, date_rendu
FROM livre as l, emprunt as e
WHERE l.id_livre = e.id_livre
AND l.auteur = "Alphonse daudet";

-- Qui a emprunté le livre "une vie " sur l'année 2016
SELECT a.id_abonne id, prenom, titre, auteur, date_emprunt
FROM abonne a, livre l, emprunt e
WHERE a.id_abonne = e.id_abonne
AND l.id_livre = e.id_livre
AND titre ='une vie'
AND date_emprunt LIKE '%2016%';

-- Fonction pour executer plus rapidement q'un like (YEAR), utilise moins de ressources 
SELECT a.id_abonne id, prenom, titre, auteur, date_emprunt -- ou YEAR(date_emprunt)
FROM abonne a, livre l, emprunt e
WHERE a.id_abonne = e.id_abonne
AND l.id_livre = e.id_livre
AND titre ='une vie'
AND YEAR(date_emprunt) = 2016;

-- Le nombre de livre empruntés par chaque abonné 
SELECT prenom, COUNT(id_livre) AS 'nombre de livre'
FROM abonne AS a , emprunt AS e
WHERE a.id_abonne = e.id_abonne
GROUP BY e.id_abonne
ORDER BY COUNT (id_livre) DESC;

-- Afficher le nombre de livres à rendre pour chaque abonné 
SELECT prenom, COUNT(id_livre) AS 'nombre de livre a rendre'
FROM abonne AS a , emprunt AS e
WHERE a.id_abonne = e.id_abonne
AND date_rendu IS NULL
GROUP BY e.id_abonne;

-- Exercice : 
-- Qui a emprunté quel livre et quand ? 
SELECT prenom, date_emprunt, titre, auteur
FROM abonne AS a , emprunt AS e, livre AS l
WHERE a.id_abonne = e.id_abonne
AND  l.id_livre = e.id_livre
ORDER BY prenom DESC; 

---------------------

-- 2 - Jointure Externe ( Sans correspondance exigée )

INSERT INTO abonne (prenom) VALUES ('Riaz');
-- INSERT INTO abonne VALUES (NULL, 'Riaz')


-- Jointure interne ( met que les correspondance )
SELECT prenom , id_livre
FROM abonne AS a, emprunt AS e
WHERE a.id_abonne = e.id_abonne
ORDER BY prenom DESC;

--Jointure externe 
-- Nous permettra de récupérer tous les abonnés et les corredpondances avec les emprunts s'il y'en a .

--LEFT JOIN va nous permettre de récupérer toutes les infos de la table de ' gauche' ( prenom) ET si j'ai une correspondance 
--avec la table emprunt au niveau de l'ID_abonne alors je lui indique l'id_livre
-- LISTE DES ABONNES  avec leur id livre
SELECT prenom, id_livre
FROM abonne AS a  -- table de gauche 
LEFT JOIN emprunt AS e ON e.id_abonne = a.id_abonne;
;
