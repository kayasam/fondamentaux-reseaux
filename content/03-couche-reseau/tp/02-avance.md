---
title: "TP complémentaire : routage dynamique"
---

# TP 03B - Routage dynamique et notions avancees - Version avancee
> Chapitre associé : [[03-couche-reseau]]

## Objectifs

- Construire un mini-reseau a plusieurs routeurs
- Activer un protocole de routage dynamique simple
- Comparer IPv4 et IPv6

## Contexte

Tu dois interconnecter trois LAN via trois routeurs.

Chaque routeur possede :

- un LAN local
- deux liaisons vers les autres routeurs

## Travail demande

### Partie 1 - Topologie

Construis :

- 3 routeurs
- 3 switches
- 3 PC

### Partie 2 - Adressage

Propose un plan d'adressage logique en IPv4 pour :

- les 3 LAN
- les liens inter-routeurs

### Partie 3 - Routage dynamique

Configure un protocole dynamique adapte a un TP de base, de preference **OSPF** si disponible dans ton environnement.

Tu dois verifier :

- les voisins
- les routes apprises
- la connectivite entre les trois LAN

### Partie 4 - Changement de topologie

Coupe un lien entre deux routeurs et observe :

1. si une autre route est apprise
2. si le trafic continue a passer

### Partie 5 - IPv6

Reponds en quelques lignes :

1. Cite deux differences importantes entre IPv4 et IPv6.
2. Pourquoi le NAT est-il moins central en IPv6 ?
3. Donne un exemple d'adresse IPv6 valide.

## Commandes utiles

```text
show ip route
show ip ospf neighbor
show ipv6 interface brief
```
