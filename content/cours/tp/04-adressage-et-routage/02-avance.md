# TP 04 - IPv4, VLSM et routage - Version avancee

## Objectifs

- Construire un plan d'adressage VLSM
- Configurer un routeur avec plusieurs reseaux
- Verifier la table de routage

## Contexte

Tu disposes du reseau principal :

`192.168.50.0/24`

Tu dois creer :

| Segment | Besoin en hotes |
|---|---|
| Administration | 50 |
| Comptabilite | 25 |
| Support | 12 |
| Lien inter-routeur | 2 |

## Travail demande

### Partie 1 - VLSM

1. Classe les besoins du plus grand au plus petit.
2. Propose un masque adapte a chaque segment.
3. Complete le plan d'adressage :

| Segment | Reseau | CIDR | Premiere IP | Derniere IP | Broadcast |
|---|---|---|---|---|---|
| Administration | | | | | |
| Comptabilite | | | | | |
| Support | | | | | |
| Inter-routeur | | | | | |

### Partie 2 - Routage

Construis une topologie avec :

- 2 routeurs
- 3 LAN
- 1 lien point a point entre routeurs

Configure les interfaces en respectant ton plan.

### Partie 3 - Verification

1. Affiche la table de routage sur chaque routeur.
2. Ajoute les routes statiques necessaires si besoin.
3. Verifie la connectivite bout en bout.

### Partie 4 - Questions

1. Pourquoi utilise-t-on VLSM ?
2. Pourquoi un lien inter-routeur peut-il etre en `/30` ?
3. A quoi sert la passerelle par defaut sur un poste ?
