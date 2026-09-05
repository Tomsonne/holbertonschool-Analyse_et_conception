# Spécification fonctionnelle — Système anti-fraude

Ce projet présente la spécification comportementale d’un système de contrôle des paiements pour **MegaShop-B2B**.

L’objectif est de transformer un besoin client contenant des détails techniques en règles métier claires, compréhensibles et testables avec le **Behavior-Driven Development (BDD)**.

## Règles métier

* Un paiement standard est accepté lorsque son montant ne dépasse pas 10 000 €.
* Un paiement supérieur à 10 000 € est bloqué lorsque sa destination figure dans le registre des pays sous embargo.
* Un client VIP est toujours exempté du blocage, quels que soient le montant et la destination.
* Le client doit être informé lorsqu’un paiement est refusé.

## Arborescence

```text
SpecFonct/
├── docs/
│   ├── brief_metier_gouvernance.md
│   └── user_stories_anti_fraude.md
├── specs/
│   └── anti_fraude.feature
└── README.md
```

## Spécification Gherkin

Le fichier `specs/anti_fraude.feature` contient :

* le chemin nominal d’un paiement sans risque ;
* l’exception accordée aux clients VIP ;
* une matrice de tests utilisant `Scenario Outline` et `Examples` ;
* des tests sur la valeur limite de 10 000 € ;
* les cas d’acceptation et de refus selon le montant et la destination.

## Validation

La spécification doit être vérifiée avec l’extension **Cucumber (Gherkin) Full Support** dans Visual Studio Code.

Elle doit :

* respecter la syntaxe Gherkin ;
* contenir un tableau `Examples` correctement aligné ;
* utiliser des paramètres correspondant exactement aux colonnes du tableau ;
* rester compréhensible par une personne sans connaissances techniques ;
* ne contenir aucun détail d’implémentation comme SQL, API, HTTP ou interface graphique.

## Technologies et concepts

* Behavior-Driven Development
* Gherkin
* User Stories
* Critères INVEST
* Boundary Value Analysis
* Scenario Outline
