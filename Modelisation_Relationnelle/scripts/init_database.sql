-- Script d'initialisation de la base MegaShop-B2B
-- Auteur : [Votre Nom]

BEGIN;

-- Permet de générer automatiquement des identifiants UUID
CREATE EXTENSION IF NOT EXISTS pgcrypto;

DROP TABLE IF EXISTS ligne_commande CASCADE;
DROP TABLE IF EXISTS commande CASCADE;
DROP TABLE IF EXISTS produit CASCADE;
DROP TABLE IF EXISTS client CASCADE;


-- Table clients
CREATE TABLE client
(
    id_client UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    client_nom VARCHAR(150) NOT NULL,
    client_contact VARCHAR(255) NOT NULL,
    adr_livraison VARCHAR(255) NOT NULL
);

-- Table produits
CREATE TABLE produit
(
    code_prod VARCHAR(20) PRIMARY KEY,
    designation VARCHAR(150) NOT NULL,
    prix_unitaire_ht DECIMAL(10, 2) NOT NULL,
    CONSTRAINT check_prix_unitaire_positif
        CHECK (prix_unitaire_ht >= 0)
);

-- Table commandes
CREATE TABLE commande
(
    id_cmd VARCHAR(20) PRIMARY KEY,
    date_achat DATE NOT NULL,
    statut_cmd VARCHAR(50) NOT NULL,
    id_client UUID NOT NULL,

    CONSTRAINT fk_commande_client
        FOREIGN KEY (id_client)
        REFERENCES client(id_client)
        ON DELETE RESTRICT
);

-- Table ligne_commande ( "CONTIENT" entre commande et produit )
CREATE TABLE ligne_commande
(
    id_cmd VARCHAR(20) NOT NULL,
    code_prod VARCHAR(20) NOT NULL,
    qte INTEGER NOT NULL,

    CONSTRAINT pk_ligne_commande
        PRIMARY KEY (id_cmd, code_prod),

    CONSTRAINT fk_ligne_commande_commande
        FOREIGN KEY (id_cmd)
        REFERENCES commande(id_cmd)
        ON DELETE CASCADE,

    CONSTRAINT fk_ligne_commande_produit
        FOREIGN KEY (code_prod)
        REFERENCES produit(code_prod)
        ON DELETE RESTRICT,

    CONSTRAINT check_quantite_positive
        CHECK (qte > 0)
);

COMMIT;