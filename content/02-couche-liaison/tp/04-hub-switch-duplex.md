---
title: "TP Packet Tracer : hub, switch et duplex"
tags:
  - fondamentaux-reseaux
  - tp
  - packet-tracer
  - couche-liaison
---

# TP Packet Tracer — Hub, switch et duplex

> Chapitres associés : [[01-couche-physique/01-couche-physique|Couche physique]] et [[02-couche-liaison/02-couche-liaison|Couche liaison]]

> [!INFO] Durée indicative
> 60 minutes.

## Objectifs

- observer la différence de comportement entre un hub et un switch ;
- comprendre les collisions, le flooding et l’apprentissage des adresses MAC ;
- mesurer les effets d’un désaccord half-duplex/full-duplex.

## Matériel

- 3 PC ;
- 1 hub ;
- 2 switches Cisco ;
- des câbles Ethernet.

## Partie A — Observer un hub

1. Placez trois PC reliés à un hub.
2. Attribuez-leur des adresses dans le même réseau IPv4.
3. Passez en mode **Simulation**.
4. Lancez plusieurs `ping` simultanément.
5. Observez la circulation des données et les éventuelles collisions.

Questions :

1. Sur quels ports le hub répète-t-il un signal reçu ?
2. Les machines non destinataires voient-elles passer le trafic ?
3. Combien existe-t-il de domaines de collision ?

## Partie B — Remplacer le hub par un switch

1. Reproduisez exactement la même topologie avec un switch.
2. Effacez les événements de simulation.
3. Lancez un premier `ping`.
4. Consultez la table MAC :

```text
show mac address-table
```

5. Lancez un second `ping` entre les mêmes postes.
6. Comparez le premier échange et les suivants.

Questions :

1. Pourquoi le switch diffuse-t-il certaines trames au début ?
2. Quelles informations apprend-il ?
3. Pourquoi les trames suivantes sont-elles mieux dirigées ?
4. Combien existe-t-il maintenant de domaines de collision ?

## Partie C — Provoquer un désaccord de duplex

Reliez deux switches puis configurez les deux extrémités différemment.

Sur le switch A :

```text
enable
configure terminal
interface gigabitEthernet0/1
duplex full
```

Sur le switch B :

```text
enable
configure terminal
interface gigabitEthernet0/1
duplex half
```

1. Générez du trafic entre les deux switches.
2. Consultez les statistiques de chaque interface :

```text
show interfaces gigabitEthernet0/1
```

3. Relevez les erreurs et les performances observées.
4. Replacez les deux côtés en full-duplex.
5. Vérifiez la disparition du problème.

## Synthèse

Complétez ce tableau :

| Critère | Hub | Switch |
|---|---|---|
| Couche principale |  |  |
| Décision à partir d’une adresse MAC |  |  |
| Domaine de collision |  |  |
| Envoi vers tous les ports |  |  |
| Full-duplex possible |  |  |

> [!TIP] Aide Cisco
> Consultez [[Ressources/cisco-packet-tracer-commandes|la fiche pratique Cisco CLI]] pour les commandes de vérification.
