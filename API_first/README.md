# API Design, RESTful et OpenAPI 3.0

Ce projet consiste à concevoir le contrat d’un endpoint public permettant à la banque partenaire de **MegaShop-B2B** de notifier la plateforme du résultat d’un paiement.

La spécification est réalisée avec une approche **API First** : le contrat de l’API est défini et validé avant son implémentation.

## Contexte

Lorsqu’une transaction est validée ou refusée, la banque partenaire doit transmettre le résultat à MegaShop-B2B.

L’ancienne route proposée était :

```http
POST /api/v1/updatePaymentStatus
```

Cette route contient un verbe d’action (`update`), ce qui ne respecte pas les conventions REST. Une URL REST doit identifier une ressource tandis que la méthode HTTP décrit l’action effectuée.

La route retenue est donc :

```http
POST /payments/webhook
```

## Arborescence

```text
API_first/
├── .spectral.yaml
├── api/
│   └── openapi.yaml
├── docs/
│   └── brief_api_paiement.md
└── README.md
```

* `.spectral.yaml` : configuration du linter Spectral.
* `api/openapi.yaml` : contrat de l’API au format OpenAPI 3.0.3.
* `docs/brief_api_paiement.md` : besoins métier du webhook de paiement.

## Endpoint

### Notification d’un paiement

```http
POST /payments/webhook
```

Cet endpoint permet à la banque partenaire d’indiquer si une transaction a réussi ou échoué.

Le corps de la requête doit être envoyé au format `application/json`.

### Exemple de requête

```json
{
  "orderId": "550e8400-e29b-41d4-a716-446655440000",
  "status": "SUCCESS",
  "transactionId": "TXN-12345678"
}
```

## Contrat de la requête

| Champ           | Type   | Contrainte                            |
| --------------- | ------ | ------------------------------------- |
| `orderId`       | string | UUID valide                           |
| `status`        | string | `SUCCESS` ou `FAILED`                 |
| `transactionId` | string | `TXN-` suivi exactement de 8 chiffres |

Les trois propriétés sont obligatoires.

La règle suivante interdit également les champs non prévus dans le contrat :

```yaml
additionalProperties: false
```

La validation de `transactionId` repose sur cette expression régulière :

```regex
^TXN-[0-9]{8}$
```

Les caractères `^` et `$` imposent la validation de la chaîne complète.

## Réponses HTTP

| Code              | Signification                                                |
| ----------------- | ------------------------------------------------------------ |
| `204 No Content`  | La notification a été acceptée. Aucun contenu n’est renvoyé. |
| `400 Bad Request` | Le corps de la requête ne respecte pas le contrat.           |

Le code `204` est utilisé lorsque la requête est acceptée, car l’API n’a aucune donnée supplémentaire à retourner.

## Exemples de données invalides

Les données suivantes doivent être refusées :

```json
{
  "orderId": "abc",
  "status": "SUCCESS",
  "transactionId": "TXN-12345678"
}
```

Raison : `orderId` n’est pas un UUID valide.

```json
{
  "orderId": "550e8400-e29b-41d4-a716-446655440000",
  "status": "PENDING",
  "transactionId": "TXN-12345678"
}
```

Raison : `PENDING` ne fait pas partie des statuts autorisés.

```json
{
  "orderId": "550e8400-e29b-41d4-a716-446655440000",
  "status": "FAILED",
  "transactionId": "TXN-1234567"
}
```

Raison : l’identifiant de transaction ne contient que 7 chiffres.

Une requête contenant une propriété supplémentaire doit également être rejetée grâce à `additionalProperties: false`.

## Validation avec Spectral

La spécification est contrôlée avec **Spectral** et son jeu de règles OpenAPI standard.

Depuis le dossier `API_first`, exécuter :

```bash
npx @stoplight/spectral-cli lint api/openapi.yaml
```

Le fichier `.spectral.yaml` contient la configuration suivante :

```yaml
extends:
  - spectral:oas
```

Spectral permet notamment de vérifier :

* la validité de la syntaxe OpenAPI ;
* la présence des informations importantes ;
* la déclaration des tags ;
* la présence d’un `operationId` ;
* le respect des bonnes pratiques de conception.

## Vérification avec Swagger Editor

La spécification peut également être ouverte dans [Swagger Editor](https://editor.swagger.io/).

Il suffit de copier le contenu du fichier `api/openapi.yaml` dans l’éditeur afin de :

* vérifier visuellement la documentation ;
* consulter les schémas ;
* contrôler les champs obligatoires ;
* repérer les erreurs OpenAPI ;
* visualiser les réponses de l’endpoint.

## Technologies utilisées

* OpenAPI 3.0.3
* YAML
* Spectral CLI
* Swagger Editor

## Points clés

* Une URL REST représente une ressource et non une action.
* Le contrat d’API est défini avant l’implémentation.
* Les champs obligatoires sont déclarés dans le tableau `required`.
* `additionalProperties: false` interdit les propriétés imprévues.
* `enum` limite les valeurs autorisées.
* `format: uuid` impose le format de l’identifiant de commande.
* Une expression régulière valide le format de l’identifiant bancaire.
* `204 No Content` indique un succès sans corps de réponse.
