# User Stories — Système anti-fraude

## US-01 — Évaluation du risque d'un paiement

En tant que Responsable de la Gouvernance Financière,  
je veux que le risque d'un paiement soit évalué selon son montant et le pays de livraison,  
afin de bloquer les transactions potentiellement frauduleuses.

### Critères d'acceptation

- Un paiement supérieur à 10 000 € doit faire l'objet d'une vérification du pays de livraison.
- Si le paiement dépasse 10 000 € et que le pays de livraison figure dans le registre des pays sous embargo, la transaction doit être bloquée.
- Le client doit être informé lorsque sa transaction est bloquée pour suspicion de fraude.
- Un paiement d'un montant inférieur ou égal à 10 000 € ne doit pas être bloqué en raison du pays de livraison.

## US-02 — Exception accordée aux clients VIP

En tant que Responsable de la Gouvernance Financière,  
je veux que les clients VIP soient exemptés du blocage anti-fraude,  
afin que leurs paiements soient toujours autorisés.

### Critères d'acceptation

- Un paiement effectué par un client VIP doit être autorisé indépendamment de son montant.
- Un paiement effectué par un client VIP doit être autorisé même si le pays de livraison figure dans le registre des pays sous embargo.
- Le statut VIP est prioritaire sur les règles habituelles de blocage anti-fraude.