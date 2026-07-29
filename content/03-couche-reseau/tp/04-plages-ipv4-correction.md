---
title: Correction 04 - Plages IPv4 et broadcast
publier: true
---

# TP 04 - Correction

> Correction du TP : [[04-plages-ipv4]]

## Exercice 1 — 192.168.10.0 /26

| Réseau | Première IP | Dernière IP | Broadcast |
|---|---|---|---|
| 192.168.10.0 | 192.168.10.1 | 192.168.10.62 | 192.168.10.63 |
| 192.168.10.64 | 192.168.10.65 | 192.168.10.126 | 192.168.10.127 |

Pour rappel, le découpage complet du /24 en /26 donne aussi `192.168.10.128` et `192.168.10.192`, non demandés ici.

## Exercice 2 — 192.168.10.0 /27

| Réseau | Première IP | Dernière IP | Broadcast |
|---|---|---|---|
| 192.168.10.0 | 192.168.10.1 | 192.168.10.30 | 192.168.10.31 |
| 192.168.10.32 | 192.168.10.33 | 192.168.10.62 | 192.168.10.63 |
| 192.168.10.64 | 192.168.10.65 | 192.168.10.94 | 192.168.10.95 |

## Exercice 3 — 192.168.10.0 /28

| Réseau | Première IP | Dernière IP | Broadcast |
|---|---|---|---|
| 192.168.10.0 | 192.168.10.1 | 192.168.10.14 | 192.168.10.15 |
| 192.168.10.16 | 192.168.10.17 | 192.168.10.30 | 192.168.10.31 |
| 192.168.10.32 | 192.168.10.33 | 192.168.10.46 | 192.168.10.47 |

## Erreurs fréquentes à surveiller

- Oublier que le broadcast est l'adresse **juste avant** le réseau suivant, pas la dernière IP hôte.
- Confondre le pas (taille du bloc) avec le nombre d'hôtes utilisables (pas - 2).
- Repartir de 0 à chaque exercice au lieu d'enchaîner les blocs (le réseau suivant commence toujours à `précédent + pas`).
