---
title: "TP débutant : couche physique et câblage"
---

# TP 01 - Couche physique et cablage - Version debutant

> [!TIP] Ressource du TP
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/01-couche-physique/tp/01-debutant.md" download>Télécharger ce TP en Markdown</a>

> Chapitre associé : [[01-couche-physique]]

## Objectifs

- Choisir un support adapte a un besoin
- Distinguer ports FastEthernet et GigabitEthernet
- Realiser une topologie simple dans Packet Tracer

## Base de travail

Ce TP reprend l'idee de ton ancien exercice de construction de reseau type "mairie", mais avec des consignes plus progressives.

## Contexte

Tu dois representer le reseau d'un petit centre associatif contenant :

- Salle accueil : 2 PC et 1 imprimante
- Salle bureau : 2 PC
- Salle technique : 1 serveur et 1 switch principal
- Acces Internet : 1 routeur

## Travail demande

### Partie 1 - Choix du materiel

Choisis et nomme :

- 3 switches
- 1 routeur
- 5 PC
- 1 imprimante
- 1 serveur

### Partie 2 - Cablage

1. Relie chaque equipement terminal a son switch local.
2. Relie les switches au switch principal ou au routeur selon ton schema.
3. Utilise :
   - **FastEthernet** pour les postes et l'imprimante
   - **GigabitEthernet** pour les liaisons entre equipements reseau

### Partie 3 - Tableau a completer

| Equipement | Type | Port utilise | Relie a |
|---|---|---|---|
| | | | |

### Partie 4 - Questions

1. Pourquoi utilise-t-on plutot du Gigabit entre equipements reseau ?
2. Pourquoi un cable defectueux releve-t-il de la couche 1 ?
3. Cite un avantage de la fibre optique par rapport au cuivre.

## Verification

- Tous les liens doivent etre actifs
- Le schema doit etre lisible
- Les noms des equipements doivent etre coherents
