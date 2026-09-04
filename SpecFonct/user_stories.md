# User Stories — Gouvernance des paiements

## US-01 — Évaluer le risque d'un paiement standard

**En tant que** Responsable de la Gouvernance Financière,
**je veux** que les paiements des clients standards soient évalués selon leur montant et leur destination,
**afin de** bloquer les transactions présentant un risque de fraude.

### Critères d'acceptation

- Un paiement d'un montant inférieur ou égal à 10 000 euros est accepté, quelle que soit sa destination.
- Un paiement d'un montant strictement supérieur à 10 000 euros est accepté lorsque sa destination n'est pas sous embargo.
- Un paiement d'un montant strictement supérieur à 10 000 euros est refusé lorsque sa destination est sous embargo.
- Lorsqu'un paiement est refusé, le client est informé que sa transaction est bloquée pour suspicion de fraude.

## US-02 — Exempter un client VIP du contrôle

**En tant que** Responsable de la Gouvernance Financière,
**je veux** que les paiements des clients VIP soient exemptés du contrôle lié au montant et à la destination,
**afin de** garantir le traitement privilégié accordé à ces clients.

### Critères d'acceptation

- Le paiement d'un client VIP est accepté, quel que soit son montant.
- Le paiement d'un client VIP est accepté, même lorsque sa destination est sous embargo.

## Vérification INVEST

| Critère | Application aux User Stories |
| --- | --- |
| Indépendante | L'évaluation standard et l'exemption VIP sont décrites séparément. |
| Négociable | Les stories expriment le besoin métier sans imposer de solution technique. |
| Valuable | Chaque story apporte une valeur explicite à la gouvernance financière. |
| Estimable | Les règles et leurs résultats attendus sont clairement délimités. |
| Small | Chaque story porte sur un seul comportement métier. |
| Testable | Chaque règle possède des critères d'acceptation observables. |
