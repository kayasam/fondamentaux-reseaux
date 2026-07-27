---
title: "TP avancé : NAT, DMZ et filtrage"
---

# TP 06 - NAT, DMZ et filtrage - Version avancee
> Chapitre associé : [[06-securite-et-acces]]

## Objectifs

- Mettre en place un acces Internet simule
- Publier un service en zone externe ou DMZ
- Reflechir a des regles de filtrage simples

## Contexte

Une PME possede :

- un LAN utilisateurs
- un serveur web a publier
- un acces Internet

Tu dois proposer une architecture simple qui limite l'exposition du LAN interne.

## Travail demande

### Partie 1 - Architecture

Concois un schema avec :

- une zone LAN
- une zone DMZ ou reseau externe expose
- un routeur ou pare-feu logique

### Partie 2 - NAT

1. Mets en place le PAT pour les postes internes.
2. Explique la difference entre masquer des sorties utilisateurs et publier un service.

### Partie 3 - Publication

Propose une solution simple pour rendre un serveur web accessible depuis l'exterieur sans exposer directement tout le LAN.

### Partie 4 - Filtrage

Propose trois regles minimales :

- web sortant autorise
- SSH d'administration autorise seulement depuis un sous-reseau precise
- trafic entrant non necessaire bloque

### Partie 5 - VPN

Explique en quelques lignes :

1. la difference entre VPN site-a-site et VPN d'acces distant
2. dans quel cas l'entreprise utiliserait chacun

## Livrable attendu

- Un schema logique de securite
- Des explications courtes mais techniques
- Des regles de filtrage simples et justifiees
