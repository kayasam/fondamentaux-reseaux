---
title: "TP Packet Tracer : VLAN sur plusieurs switches"
tags:
  - fondamentaux-reseaux
  - tp
  - packet-tracer
  - vlan
  - trunk
---

# TP Packet Tracer — VLAN sur plusieurs switches

> Chapitre associé : [[02-couche-liaison/02-couche-liaison|Couche liaison]]

> [!INFO] Durée indicative
> 45 à 60 minutes.

## Objectifs

- étendre plusieurs VLAN sur deux switches ;
- configurer un lien trunk IEEE 802.1Q ;
- distinguer un port access d’un trunk ;
- vérifier les VLAN autorisés sur le lien.

## Prérequis

Vous pouvez repartir du [[02-couche-liaison/tp/05-vlan-access|TP VLAN et ports access]].

## Table d’adressage

| Nom | Adresse IP | VLAN | Port |
|---|---|---:|---|
| PC-BLEU-1 | `192.168.10.1/24` | 10 | S1 Fa0/1 |
| PC-VERT-1 | `192.168.20.1/24` | 20 | S1 Fa0/23 |
| PC-BLEU-2 | `192.168.10.2/24` | 10 | S2 Fa0/1 |
| PC-VERT-2 | `192.168.20.2/24` | 20 | S2 Fa0/23 |
| S1 vers S2 | — | Trunk 10,20 | S1 Gi0/1 |
| S2 vers S1 | — | Trunk 10,20 | S2 Gi0/1 |

## Travail demandé

### Partie A — Étendre la topologie

1. Ajoutez un second switch nommé S2.
2. Reliez S1 Gi0/1 à S2 Gi0/1.
3. Ajoutez les deux nouveaux PC sur S2.
4. Créez les VLAN 10 et 20 sur les deux switches.
5. Configurez les ports des postes en mode access.

### Partie B — Configurer le trunk

Configurez Gi0/1 sur chaque switch afin de :

- fonctionner en mode trunk ;
- transporter uniquement les VLAN 10 et 20.

Vérifiez avec :

```text
show interfaces trunk
show vlan brief
```

### Partie C — Tester

| Test | Résultat attendu | Résultat obtenu |
|---|---|---|
| VLAN 10 entre S1 et S2 |  |  |
| VLAN 20 entre S1 et S2 |  |  |
| VLAN 10 vers VLAN 20 |  |  |

### Partie D — Observer les trames

1. Passez en mode Simulation.
2. Filtrez le trafic ICMP et ARP.
3. Observez le passage d’une trame sur le trunk.
4. Expliquez le rôle du tag 802.1Q.

## Questions

1. Pourquoi faut-il créer les VLAN sur les deux switches ?
2. Quelle différence existe entre un port access et un trunk ?
3. Pourquoi le trunk ne permet-il pas, à lui seul, la communication entre VLAN ?
4. Que se passe-t-il si le VLAN 20 est retiré de la liste des VLAN autorisés ?
