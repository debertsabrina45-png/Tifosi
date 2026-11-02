-- Projet : Le Tifosi
-- Script 1 : création de la base et des tables
-- À exécuter sur une base neuve ou vide.
-- Le compte MySQL tifosi et ses droits sont à créer séparément.

CREATE DATABASE IF NOT EXISTS tifosi
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE tifosi;

-- Table des ingrédients
CREATE TABLE IF NOT EXISTS ingredient (
    id_ingredient INT PRIMARY KEY,
    nom_ingredient VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Table des focaccias
CREATE TABLE IF NOT EXISTS focaccia (
    id_focaccia INT PRIMARY KEY,
    nom_focaccia VARCHAR(100) NOT NULL UNIQUE,
    prix DECIMAL(5,2) NOT NULL
) ENGINE=InnoDB;

-- Table des clients (aucun fichier client fourni dans les données du devoir)
CREATE TABLE IF NOT EXISTS client (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    code_postal VARCHAR(10) NOT NULL
) ENGINE=InnoDB;

-- Table des menus (aucun fichier menu fourni dans les données du devoir)
CREATE TABLE IF NOT EXISTS menu (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    nom_menu VARCHAR(100) NOT NULL UNIQUE,
    prix DECIMAL(5,2) NOT NULL
) ENGINE=InnoDB;

-- Table des marques
CREATE TABLE IF NOT EXISTS marque (
    id_marque INT PRIMARY KEY,
    nom_marque VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Table des boissons
CREATE TABLE IF NOT EXISTS boisson (
    id_boisson INT PRIMARY KEY,
    nom_boisson VARCHAR(100) NOT NULL UNIQUE,
    id_marque INT NOT NULL,
    CONSTRAINT fk_boisson_marque FOREIGN KEY (id_marque)
        REFERENCES marque(id_marque)
) ENGINE=InnoDB;

-- Association entre focaccias et ingrédients
CREATE TABLE IF NOT EXISTS comprend (
    id_focaccia INT NOT NULL,
    id_ingredient INT NOT NULL,
    quantite INT NOT NULL,
    PRIMARY KEY (id_focaccia, id_ingredient),
    CONSTRAINT fk_comprend_focaccia FOREIGN KEY (id_focaccia)
        REFERENCES focaccia(id_focaccia),
    CONSTRAINT fk_comprend_ingredient FOREIGN KEY (id_ingredient)
        REFERENCES ingredient(id_ingredient)
) ENGINE=InnoDB;

-- Association entre focaccias et menus
CREATE TABLE IF NOT EXISTS est_constitue (
    id_focaccia INT NOT NULL,
    id_menu INT NOT NULL,
    PRIMARY KEY (id_focaccia, id_menu),
    CONSTRAINT fk_est_constitue_focaccia FOREIGN KEY (id_focaccia)
        REFERENCES focaccia(id_focaccia),
    CONSTRAINT fk_est_constitue_menu FOREIGN KEY (id_menu)
        REFERENCES menu(id_menu)
) ENGINE=InnoDB;

-- Association entre clients et menus achetés
CREATE TABLE IF NOT EXISTS achete (
    id_client INT NOT NULL,
    id_menu INT NOT NULL,
    date_achat DATE NOT NULL,
    PRIMARY KEY (id_client, id_menu, date_achat),
    CONSTRAINT fk_achete_client FOREIGN KEY (id_client)
        REFERENCES client(id_client),
    CONSTRAINT fk_achete_menu FOREIGN KEY (id_menu)
        REFERENCES menu(id_menu)
) ENGINE=InnoDB;

-- Association entre menus et boissons
CREATE TABLE IF NOT EXISTS contient (
    id_menu INT NOT NULL,
    id_boisson INT NOT NULL,
    PRIMARY KEY (id_menu, id_boisson),
    CONSTRAINT fk_contient_menu FOREIGN KEY (id_menu)
        REFERENCES menu(id_menu),
    CONSTRAINT fk_contient_boisson FOREIGN KEY (id_boisson)
        REFERENCES boisson(id_boisson)
) ENGINE=InnoDB;

-- Création du compte applicatif (à faire séparément, sans enregistrer le mot de passe dans GitHub) :
-- CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'REMPLACER_PAR_UN_MOT_DE_PASSE';
-- GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
-- FLUSH PRIVILEGES;
