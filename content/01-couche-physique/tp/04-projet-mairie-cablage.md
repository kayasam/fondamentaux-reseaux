---
title: "TP Packet Tracer : réseau physique d’une mairie"
tags:
  - fondamentaux-reseaux
  - tp
  - packet-tracer
  - couche-physique
---

# TP Packet Tracer — Réseau physique d’une mairie

> Chapitre associé : [[01-couche-physique/01-couche-physique|Couche physique]]

> [!INFO] Durée indicative
> 45 à 60 minutes.

## Objectifs

- choisir des équipements adaptés à une petite organisation ;
- réaliser un câblage cohérent ;
- distinguer les ports FastEthernet et GigabitEthernet ;
- produire une topologie Packet Tracer lisible et correctement nommée.

## Cahier des charges

La mairie de Bourg souhaite modéliser son **réseau interne** dans Cisco Packet Tracer.

Le bâtiment comprend trois salles principales, chacune disposant de son propre switch. Les salles doivent être reliées à un **switch cœur de réseau**, lui-même relié à un **routeur principal** qui assurera plus tard la sortie vers Internet.

## Description des salles

| Salle | Service | Équipements présents | Particularité |
|---|---|---|---|
| Salle rouge | Accueil | 2 PC fixes, 1 ordinateur portable, 1 imprimante | Équipements reliés à un switch local |
| Salle bleue | Bureau du maire | 1 PC fixe, 1 ordinateur portable | Équipements reliés à un switch local |
| Salle verte | Informatique | 3 serveurs Web, fichier et messagerie | Serveurs reliés à un switch local |

## Travail demandé

### Partie A — Construire la topologie

1. Créez le réseau complet correspondant aux trois salles.
2. Ajoutez un switch cœur de réseau.
3. Ajoutez le routeur principal.
4. Choisissez des modèles d’équipements adaptés.

### Partie B — Réaliser le câblage

1. Reliez les équipements terminaux à leur switch local en **FastEthernet**.
2. Réalisez les liaisons entre équipements réseau en **GigabitEthernet** :
   - switch local vers switch cœur ;
   - switch cœur vers routeur.
3. Vérifiez le type de câble utilisé et l’état des voyants.

### Partie C — Documenter

1. Nommez clairement chaque équipement.
2. Identifiez visuellement les trois salles.
3. Organisez le schéma afin que les liaisons ne se croisent pas inutilement.
4. Complétez le tableau suivant.

| Nom de l’équipement | Type | Modèle choisi | Rôle ou justification | Équipement et port reliés |
|---|---|---|---|---|
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |

## Contraintes

- aucune configuration IP n’est demandée ;
- le travail porte sur la **couche physique**, le choix du matériel et le câblage ;
- le fichier doit être enregistré sous `TP-mairie-nom-prenom.pkt`.

> [!TIP] Voyants Packet Tracer
> 🟢 lien actif · 🟠 initialisation ou convergence · 🔴 câble incorrect, interface désactivée ou défaut de liaison.

## Questions de synthèse

1. Pourquoi utiliser les ports GigabitEthernet entre les switches ?
2. Quel est le rôle du switch cœur ?
3. Quel équipement permettra plus tard de joindre un autre réseau ?
4. Pourquoi faut-il documenter le nom et le port de chaque liaison ?
