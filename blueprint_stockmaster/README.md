# StockMaster-Pro — Blueprint d’architecture

Ce projet constitue le blueprint technique du système d’inventaire **StockMaster-Pro** pour MegaShop-B2B.

Il rassemble la modélisation des données, le comportement interne, le contrat d’API et les règles métier dans une documentation cohérente et versionnable.

## Fonctionnalités

* Gestion des produits et des emplacements.
* Enregistrement des entrées et sorties de stock.
* Conservation de l’historique des mouvements.
* Calcul du stock actuel depuis les mouvements.
* Refus des sorties supérieures au stock disponible.
* Garantie qu’un stock ne puisse jamais devenir négatif.

## Arborescence

```text
blueprint_stockmaster/
├── .spectral.yaml
├── 01_database_schema.sql
├── 02_behavioral_architecture.md
├── 03_api_contract.yaml
├── 04_business_specs.feature
└── README.md
```

## Livrables

### Base de données

`01_database_schema.sql` définit les tables :

* `produit`
* `emplacement`
* `mouvement_stock`

Les contraintes SQL garantissent que la quantité d’un mouvement est strictement positive et que son type est `ENTREE` ou `SORTIE`.

### Architecture comportementale

`02_behavioral_architecture.md` contient un diagramme de séquence Mermaid décrivant :

* la réception d’un mouvement ;
* le calcul du stock actuel ;
* la création d’un mouvement autorisé ;
* le refus d’une sortie produisant un stock négatif.

### Contrat d’API

`03_api_contract.yaml` définit l’endpoint OpenAPI suivant :

```http
POST /inventory/movements
```

Réponses principales :

* `201 Created` : mouvement enregistré ;
* `400 Bad Request` : données invalides ;
* `409 Conflict` : stock insuffisant.

### Spécification métier

`04_business_specs.feature` décrit les règles avec Gherkin :

* une entrée augmente le stock ;
* une sortie inférieure ou égale au stock est acceptée ;
* une sortie supérieure au stock est refusée ;
* une quantité nulle est refusée.

## Validation OpenAPI

Depuis le dossier `blueprint_stockmaster` :

```bash
npx @stoplight/spectral-cli lint 03_api_contract.yaml
```

Résultat attendu :

```text
No results with a severity of 'error' found!
```

## Concepts utilisés

* Modélisation relationnelle et SQL 3NF
* Event Sourcing
* Contraintes d’intégrité SQL
* Diagramme de séquence UML
* OpenAPI 3.0.3
* Behavior-Driven Development
* Gherkin et Scenario Outline
* Cohérence inter-modèles
* Documentation as Code
