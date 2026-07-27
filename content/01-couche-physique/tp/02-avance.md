# TP 01 - Couche physique et cablage - Version avancee
> Chapitre associé : [[01-couche-physique]]

## Objectifs

- Concevoir un cablage realiste
- Justifier un choix de support
- Analyser un probleme de couche 1

## Contexte

Une entreprise occupe deux etages :

- Rez-de-chaussee : 8 postes, 1 imprimante, 1 borne Wi-Fi
- Etage : 6 postes, 1 imprimante, 1 baie reseau
- Salle serveur : 2 serveurs, 1 switch coeur, 1 routeur

La distance entre l'etage et la salle serveur est de 120 metres.

## Travail demande

### Partie 1 - Conception

Propose une architecture physique avec :

- les equipements principaux
- le type de liaison
- le debit attendu

### Partie 2 - Choix des supports

Pour chaque liaison, indique le support le plus adapte :

| Liaison | Support propose | Justification |
|---|---|---|
| PC vers switch d'etage | | |
| Switch d'etage vers coeur reseau | | |
| Serveur vers switch coeur | | |
| Poste mobile vers borne Wi-Fi | | |

### Partie 3 - Incident

On observe les symptomes suivants :

- un poste du rez-de-chaussee se deconnecte aleatoirement
- les autres postes du meme switch fonctionnent
- le voyant du port passe parfois orange puis vert

Reponds aux questions :

1. Donne trois causes possibles en couche 1.
2. Quel test ferais-tu en premier ?
3. Pourquoi ne commences-tu pas par accuser le DNS ou TCP ?

### Partie 4 - Bonus

Explique simplement :

- attenuation
- EMI
- full-duplex

## Livrable attendu

- Un schema physique annote
- Un tableau de choix de supports
- Une mini-analyse d'incident
