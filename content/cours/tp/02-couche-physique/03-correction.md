# TP 02 - Couche physique et cablage - Correction

## Attendus principaux

### Version debutant

Le schema attendu doit montrer :

- les postes relies en FastEthernet aux switches d'acces
- les liaisons inter-switch ou switch-routeur en GigabitEthernet
- un equipement central clairement identifiable

### Reponses types

1. Le Gigabit est prefere entre equipements reseau car il transporte potentiellement le trafic cumule de plusieurs utilisateurs.
2. Un cable defectueux concerne la couche 1 car le probleme touche la transmission du signal.
3. La fibre permet de grandes distances et resiste aux perturbations electromagnetiques.

## Version avancee

### Choix de supports attendus

| Liaison | Support recommande | Justification |
|---|---|---|
| PC vers switch d'etage | RJ45 cuivre | Standard, economique, distance courte |
| Switch d'etage vers coeur reseau a 120 m | Fibre optique | Le cuivre Ethernet classique est limite a 100 m |
| Serveur vers switch coeur | RJ45 ou fibre selon debit voulu | Debits eleves et fiabilite |
| Poste mobile vers borne Wi-Fi | Radio Wi-Fi | Besoin de mobilite |

### Causes possibles de panne couche 1

- cable abime ou mal serti
- port defectueux
- connecteur mal enfonce
- perturbation electromagnetique
- mauvaise negociation de vitesse/duplex

### Premier test pertinent

Le plus simple est d'essayer un **autre cable** ou **un autre port de switch**.

## Point pedagogique

Quand un symptome indique une perte de lien, il faut commencer par le bas :

- support
- port
- voyant
- etat du lien

Avant d'aller chercher plus haut, on valide la couche physique.
