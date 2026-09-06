Feature: Traçabilité et sécurisation des mouvements d'inventaire
  En tant que directeur d'entrepôt
  Je veux conserver l'historique des entrées et des sorties
  Afin de connaître le stock disponible et d'empêcher tout stock négatif

  Scenario: Une entrée augmente le stock disponible
    Given l'emplacement "Allée A - Rayon 2" contient 10 unités du produit "P-001"
    When le manutentionnaire déclare une entrée de 5 unités
    Then le stock disponible dans cet emplacement est de 15 unités
    And le mouvement d'entrée est ajouté à l'historique de l'inventaire

  Scenario Outline: Contrôle d'une sortie selon le stock disponible
    Given l'emplacement "Allée A - Rayon 2" contient <stock_initial> unités du produit "P-001"
    When le manutentionnaire déclare une sortie de <quantite_sortie> unités
    Then la sortie est <decision>
    And le stock disponible dans cet emplacement est de <stock_final> unités

    Examples:
      | stock_initial | quantite_sortie | decision | stock_final |
      | 10            | 1               | acceptée | 9           |
      | 10            | 9               | acceptée | 1           |
      | 10            | 10              | acceptée | 0           |
      | 10            | 11              | refusée  | 10          |
      | 10            | 0               | refusée  | 10          |