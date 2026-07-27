---
title: "TP avancé : topologies et modèle OSI"
---

# TP 00 - Topologies et modele OSI - Version avancee
> Chapitre associé : [[00-introduction-reseaux]]

## Objectifs

- Comparer plusieurs architectures reseau
- Justifier des choix techniques simples
- Analyser un incident en s'appuyant sur OSI

## Contexte

Une mairie possede :

- un service accueil
- un service comptabilite
- une salle de reunion avec Wi-Fi
- un acces Internet

Le directeur veut un schema reseau lisible et une premiere analyse de risques.

## Travail demande

### Partie 1 - Concevoir

Propose un schema logique contenant :

- 1 box ou routeur d'acces Internet
- 2 switches
- 1 point d'acces Wi-Fi
- 6 postes filaires
- 2 postes Wi-Fi
- 1 imprimante reseau

Tu dois faire apparaitre :

- la topologie globale
- les liaisons filaires
- la zone Wi-Fi
- le role de chaque equipement

### Partie 2 - Comparer deux approches

Explique en quelques lignes les avantages et limites de :

- une architecture client/serveur
- une architecture pair-a-pair

Puis indique laquelle tu recommanderais pour cette mairie et pourquoi.

### Partie 3 - Diagnostic OSI

Pour chaque incident, indique la couche OSI la plus probable et une piste de verification :

| Incident | Couche probable | Verification proposee |
|---|---|---|
| Le cable reseau est debranche | | |
| Le poste n'obtient pas d'adresse IP | | |
| Le poste ping la passerelle mais pas le site web | | |
| Le navigateur affiche un certificat invalide | | |
| Deux PC du meme service ne communiquent pas dans le meme VLAN | | |

### Partie 4 - Justification

Redige un court paragraphe repondant a la question :

> Pourquoi le modele OSI reste-t-il utile meme s'il ne correspond pas exactement aux protocoles reels ?

## Livrable attendu

- Un schema argumente
- Un tableau d'analyse OSI
- Une justification technique concise
