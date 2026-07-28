---
title: "TP Packet Tracer : découverte des voisins avec LLDP"
tags:
  - fondamentaux-reseaux
  - tp
  - packet-tracer
  - lldp
---

# TP Packet Tracer — Découverte des voisins avec LLDP

> Chapitre associé : [[02-couche-liaison/02-couche-liaison|Couche liaison]]

> [!INFO] Durée indicative
> 30 minutes.

## Objectifs

- activer LLDP sur des équipements Cisco ;
- découvrir automatiquement les voisins directs ;
- identifier les informations utiles à la documentation et au diagnostic.

## Topologie

Utilisez deux switches reliés directement, par exemple la topologie du [[02-couche-liaison/tp/07-lacp|TP LACP]].

## Commandes utilisables

```text
lldp run
no lldp run
show lldp
show lldp neighbors
show lldp neighbors detail
hostname <nom>
```

## Travail demandé

### Partie A — Préparer les équipements

1. Nommez les switches `S1` et `S2`.
2. Vérifiez que leur liaison est active.
3. Activez LLDP globalement sur les deux switches.
4. Contrôlez l’état du protocole avec `show lldp`.

### Partie B — Découvrir les voisins

Sur chaque switch :

1. exécutez `show lldp neighbors` ;
2. relevez le nom du voisin ;
3. relevez le port local ;
4. relevez le port distant ;
5. affichez ensuite les détails.

| Équipement interrogé | Voisin | Port local | Port distant | Capacité |
|---|---|---|---|---|
| S1 |  |  |  |  |
| S2 |  |  |  |  |

### Partie C — Provoquer un changement

1. Débranchez la liaison.
2. Attendez l’expiration des informations LLDP ou relancez la simulation.
3. Vérifiez l’évolution de la table des voisins.
4. Rebranchez le lien et observez la redécouverte.

## Questions

1. Combien de voisins chaque switch découvre-t-il ?
2. LLDP découvre-t-il les équipements situés à plusieurs sauts ?
3. Pourquoi le nom d’hôte est-il utile ?
4. Quelle différence principale existe entre LLDP et CDP ?
5. En quoi ces informations facilitent-elles la documentation d’un réseau ?
