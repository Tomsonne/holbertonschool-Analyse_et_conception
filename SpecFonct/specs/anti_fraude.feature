# User Stories â€” Gouvernance des paiements

## US-01 â€” Ã‰valuer le risque d'un paiement standard

**En tant que** Responsable de la Gouvernance FinanciÃ¨re,
**je veux** que les paiements des clients standards soient Ã©valuÃ©s selon leur montant et leur destination,
**afin de** bloquer les transactions prÃ©sentant un risque de fraude.

### CritÃ¨res d'acceptation

- Un paiement d'un montant infÃ©rieur ou Ã©gal Ã  10 000 euros est acceptÃ©, quelle que soit sa destination.
- Un paiement d'un montant strictement supÃ©rieur Ã  10 000 euros est acceptÃ© lorsque sa destination n'est pas sous embargo.
- Un paiement d'un montant strictement supÃ©rieur Ã  10 000 euros est refusÃ© lorsque sa destination est sous embargo.
- Lorsqu'un paiement est refusÃ©, le client est informÃ© que sa transaction est bloquÃ©e pour suspicion de fraude.

## US-02 â€” Exempter un client VIP du contrÃ´le

**En tant que** Responsable de la Gouvernance FinanciÃ¨re,
**je veux** que les paiements des clients VIP soient exemptÃ©s du contrÃ´le liÃ© au montant et Ã  la destination,
**afin de** garantir le traitement privilÃ©giÃ© accordÃ© Ã  ces clients.

### CritÃ¨res d'acceptation

- Le paiement d'un client VIP est acceptÃ©, quel que soit son montant.
- Le paiement d'un client VIP est acceptÃ©, mÃªme lorsque sa destination est sous embargo.

## VÃ©rification INVEST

| CritÃ¨re | Application aux User Stories |
| --- | --- |
| IndÃ©pendante | L'Ã©valuation standard et l'exemption VIP sont dÃ©crites sÃ©parÃ©ment. |
| NÃ©gociable | Les stories expriment le besoin mÃ©tier sans imposer de solution technique. |
| Valuable | Chaque story apporte une valeur explicite Ã  la gouvernance financiÃ¨re. |
| Estimable | Les rÃ¨gles et leurs rÃ©sultats attendus sont clairement dÃ©limitÃ©s. |
| Small | Chaque story porte sur un seul comportement mÃ©tier. |
| Testable | Chaque rÃ¨gle possÃ¨de des critÃ¨res d'acceptation observables. |