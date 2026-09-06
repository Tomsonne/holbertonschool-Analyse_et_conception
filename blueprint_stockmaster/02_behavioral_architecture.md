# Architecture comportementale — StockMaster-Pro

Ce document représente le traitement d'une demande de mouvement de stock.

L'API calcule le stock actuel à partir de l'historique des mouvements. Elle ne lit aucune colonne de quantité totale dans la table `emplacement`.

## Diagramme de séquence

```mermaid
sequenceDiagram
    actor Manutentionnaire
    participant API as Inventory API
    participant Service as InventoryService
    participant Database as PostgreSQL

    Manutentionnaire->>API: POST /inventory/movements
    activate API

    API->>Service: createMovement(emplacementId, typeMouvement, quantite)
    activate Service

    Service->>Database: SELECT des mouvements de l'emplacement
    activate Database
    Database-->>Service: Stock actuel calculé
    deactivate Database

    alt SORTIE et quantité supérieure au stock actuel
        Service-->>API: Mouvement refusé
        deactivate Service
        API-->>Manutentionnaire: HTTP 409 Conflict
    else Mouvement autorisé
        Service->>Database: INSERT mouvement_stock
        activate Database
        Database-->>Service: Mouvement créé
        deactivate Database
        Service-->>API: Mouvement enregistré
        deactivate Service
        API-->>Manutentionnaire: HTTP 201 Created
    end

    deactivate API
```

## Calcul du stock actuel

Le stock d'un emplacement est obtenu en additionnant les entrées et en soustrayant les sorties :

```sql
SELECT COALESCE(
    SUM(
        CASE
            WHEN type_mouvement = 'ENTREE' THEN quantite
            WHEN type_mouvement = 'SORTIE' THEN -quantite
        END
    ),
    0
) AS stock_actuel
FROM mouvement_stock
WHERE id_emplacement = :emplacement_id;
```

## Règles de traitement

- Une `ENTREE` est autorisée lorsque la quantité est strictement positive.
- Une `SORTIE` est autorisée si la quantité demandée est inférieure ou égale au stock actuel.
- Une `SORTIE` supérieure au stock actuel est refusée avec `HTTP 409 Conflict`.
- Un mouvement autorisé est enregistré dans `mouvement_stock`.
- Le stock actuel est toujours calculé depuis l'historique des mouvements.

## Correspondance entre l'API et la base

| Contrat API | Modèle SQL |
|---|---|
| `emplacementId` | `id_emplacement` |
| `typeMouvement` | `type_mouvement` |
| `quantite` | `quantite` |
| `dateMouvement` | `date_mouvement` |

L'API utilise la convention `camelCase`, tandis que PostgreSQL utilise la convention `snake_case`. Le mapping reste explicite et sans ambiguïté.
