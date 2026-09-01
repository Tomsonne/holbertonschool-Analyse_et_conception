## 1. Sujets principaux identifiés

L’analyse du fichier `legacy_data.csv` permet d’identifier les entités suivantes :

- **Client** : entreprise qui passe une commande.
- **Commande** : achat effectué par un client à une date donnée et à une adresse donnée.
- **Produit** : article pouvant être commandé.
- **Ligne de commande** : association entre une commande et un produit, avec une quantité et un prix unitaire.


`total_ligne` n’est pas une entité. Il s’agit d’une donnée calculée :

```text
total_ligne = quantité × prix_unitaire_ht
```

## 2. Regles de gestion

### Relation entre Client et Commande

1. Un client peut ne passer aucune commande ou en passer plusieurs.
2. Une commande est obligatoirement passée par un seul client.
3. Une commande ne peut pas appartenir à plusieurs clients.

**Cardinalités :**

- Client vers Commande : `(0, N)`
- Commande vers Client : `(1, 1)`

### Relation entre Commande et Ligne de commande

4. Une commande doit contenir au minimum une ligne de commande.
5. Une commande peut contenir plusieurs lignes de commande.
6. Une ligne de commande appartient obligatoirement à une seule commande.

**Cardinalités :**

- Commande vers Ligne de commande : `(1, N)`
- Ligne de commande vers Commande : `(1, 1)`

### Relation entre Produit et Ligne de commande

7. Un produit peut exister dans le catalogue sans avoir encore été commandé.
8. Un produit peut apparaître dans plusieurs lignes de commande.
9. Une ligne de commande concerne obligatoirement un seul produit.

**Cardinalités :**

- Produit vers Ligne de commande : `(0, N)`
- Ligne de commande vers Produit : `(1, 1)`

### Relation entre Commande et Produit

10. Une commande contient un ou plusieurs produits.
11. Un produit peut être présent dans aucune, une ou plusieurs commandes.

**Cardinalités :**

- Commande vers Produit : `(1, N)`
- Produit vers Commande : `(0, N)`

CLIENT (0, N) ─── passe ─── (1, 1) COMMANDE

COMMANDE (1, N) ─── possede ─── (1, 1) LIGNE_COMMANDE

PRODUIT (0, N) ─── apparaît dans ─── (1, 1) LIGNE_COMMANDE



