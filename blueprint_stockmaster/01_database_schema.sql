-- StockMaster-Pro
-- Schéma relationnel PostgreSQL
-- Gestion de l'inventaire par historique de mouvements

BEGIN;

DROP TABLE IF EXISTS mouvement_stock CASCADE;
DROP TABLE IF EXISTS emplacement CASCADE;
DROP TABLE IF EXISTS produit CASCADE;

-- Produits stockés dans l'entrepôt
CREATE TABLE produit
(
    id BIGSERIAL PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    reference VARCHAR(50) NOT NULL UNIQUE
);

-- Emplacements physiques de l'entrepôt
-- Chaque emplacement contient un seul type de produit
CREATE TABLE emplacement
(
    id BIGSERIAL PRIMARY KEY,
    nom VARCHAR(150) NOT NULL UNIQUE,
    id_produit BIGINT NOT NULL,

    CONSTRAINT fk_emplacement_produit
        FOREIGN KEY (id_produit)
        REFERENCES produit(id)
        ON DELETE RESTRICT
);

-- Historique immuable des entrées et sorties de stock
CREATE TABLE mouvement_stock
(
    id BIGSERIAL PRIMARY KEY,
    id_emplacement BIGINT NOT NULL,
    type_mouvement VARCHAR(10) NOT NULL,
    quantite INTEGER NOT NULL,
    date_mouvement TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_mouvement_emplacement
        FOREIGN KEY (id_emplacement)
        REFERENCES emplacement(id)
        ON DELETE RESTRICT,

    CONSTRAINT check_type_mouvement
        CHECK (type_mouvement IN ('ENTREE', 'SORTIE')),

    CONSTRAINT check_quantite_positive
        CHECK (quantite > 0)
);

COMMIT;