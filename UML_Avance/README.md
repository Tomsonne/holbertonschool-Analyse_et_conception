# UML avancé — Paiement asynchrone

Ce projet modélise l’architecture du système de paiement asynchrone de **MegaShop-B2B** à l’aide de diagrammes UML écrits avec Mermaid.

L’objectif est de représenter la structure du système, les échanges entre ses composants et le cycle de vie d’une commande.

## Arborescence

```text
UML_Avance/
├── architecture/
│   ├── 01_class_diagram.md
│   ├── 02_sequence_diagram.md
│   └── 03_state_machine.md
├── specs/
│   └── cahier_des_charges_paiement.md
└── README.md
```

## Diagrammes réalisés

### 1. Diagramme de classes

Le diagramme présente les classes suivantes :

* `Order`
* `OrderService`
* `IOrderRepository`
* `PostgresOrderRepository`

Il illustre le pattern Repository, l’injection de dépendances et l’inversion des dépendances. `OrderService` dépend de l’interface `IOrderRepository` plutôt que directement de PostgreSQL.

### 2. Diagramme de séquence

Le diagramme décrit le traitement asynchrone d’un paiement entre :

* le client ;
* l’API `OrderService` ;
* PostgreSQL ;
* RabbitMQ ;
* le `PaymentWorker` ;
* l’API de la banque.

L’API place la commande dans l’état `PENDING_PAYMENT`, publie un événement `ProcessPaymentEvent`, puis retourne immédiatement une réponse `HTTP 202 Accepted`.

Le Worker traite ensuite le paiement en arrière-plan et fait évoluer la commande vers `PAID` ou `FAILED`.

### 3. Diagramme d’états-transitions

Le diagramme définit le cycle de vie d’une commande :

```text
DRAFT → PENDING_PAYMENT → PAID → SHIPPED
```

En cas d’échec, une nouvelle tentative est possible :

```text
FAILED → PENDING_PAYMENT
```

Les transitions directes invalides, comme `DRAFT → SHIPPED` ou `FAILED → PAID`, ne sont pas autorisées.

## Concepts abordés

* Diagramme de classes UML
* Diagramme de séquence
* Diagramme d’états-transitions
* Pattern Repository
* Injection et inversion des dépendances
* Communication synchrone et asynchrone
* Message Queue avec RabbitMQ
* Traitement en arrière-plan avec un Worker
* Gestion du cycle de vie d’une commande

## Outils

* UML
* Mermaid
* Markdown
* Visual Studio Code
* GitHub
