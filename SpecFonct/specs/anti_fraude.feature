Feature: Gouvernance et blocage des paiements frauduleux
  En tant que Responsable de la Gouvernance Financière
  Je veux que le système évalue le niveau de risque de chaque paiement
  Afin de bloquer les transactions potentiellement frauduleuses et de protéger l'entreprise

  Background:
    Given les pays sous embargo sont la "Syldavie" et la "Bordurie"

  Scenario: Validation d'un paiement standard sans risque
    Given un client standard
    And une commande d'un montant de 5000 euros à destination de la "France"
    When le client soumet son paiement
    Then le paiement est accepté par la gouvernance

  Scenario: Exemption de contrôle pour les clients VIP
    Given un client VIP
    And une commande d'un montant de 15000 euros à destination de la "Syldavie"
    When le client soumet son paiement
    Then le paiement est accepté par la gouvernance grâce au statut VIP

  Scenario Outline: Blocage par la gouvernance selon la matrice de risque
    Given un client standard
    And une commande d'un montant de <montant_cmd> euros à destination de la <destination>
    When le client soumet son paiement
    Then le paiement est <decision> par la gouvernance
    And la notification de blocage est <notification>

    Examples:
      | montant_cmd | destination | decision | notification |
      | 9999        | "France"    | accepté  | absente      |
      | 10000       | "France"    | accepté  | absente      |
      | 10001       | "France"    | accepté  | absente      |
      | 9999        | "Syldavie"  | accepté  | absente      |
      | 10000       | "Syldavie"  | accepté  | absente      |
      | 10001       | "Syldavie"  | refusé   | présentée    |
      | 10001       | "Bordurie"  | refusé   | présentée    |
      