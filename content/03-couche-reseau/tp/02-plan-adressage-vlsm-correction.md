---
title: Correction 02 - Plan d'adressage VLSM
publier: true
---

# TP 02 - Correction

> [!TIP] Ressource de la correction
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/03-couche-reseau/tp/02-plan-adressage-vlsm-correction.md" download>Télécharger cette correction en Markdown</a>


> Correction du TP : [[02-plan-adressage-vlsm]]

## Étape 1 — Masque nécessaire par besoin

| Département | Besoin | Masque retenu | Hôtes utilisables |
|---|---:|---:|---:|
| Technique | 50 | /26 | 62 |
| Direction | 25 | /27 | 30 |
| Comptabilité | 12 | /28 | 14 |
| Support | 10 | /28 | 14 |
| Lien inter-routeur | 2 | /30 | 2 |

> [!TIP]
> /27 (30 hôtes) ne suffit pas pour la Technique (50 machines) : il faut passer au bloc supérieur, /26.

## Étape 2 — Classement du plus grand au plus petit

Technique (50) → Direction (25) → Comptabilité (12) → Support (10) → Lien inter-routeur (2)

## Étape 3 — Plan d'adressage complet

Base : `192.168.10.0/24`, attribution des blocs dans l'ordre, sans chevauchement.

| Département | Réseau | Masque | Plage d'hôtes | Broadcast |
|---|---|---|---|---|
| Technique | 192.168.10.0 | /26 | .1 à .62 | 192.168.10.63 |
| Direction | 192.168.10.64 | /27 | .65 à .94 | 192.168.10.95 |
| Comptabilité | 192.168.10.96 | /28 | .97 à .110 | 192.168.10.111 |
| Support | 192.168.10.112 | /28 | .113 à .126 | 192.168.10.127 |
| Lien inter-routeur | 192.168.10.128 | /30 | .129 à .130 | 192.168.10.131 |

Espace restant disponible pour une extension future : `192.168.10.132` à `192.168.10.255`.

## Points de vigilance

- Toujours placer le plus grand bloc en premier : un petit bloc placé trop tôt casse l'alignement et empêche de caser un grand bloc contigu ensuite.
- Chaque bloc doit démarrer sur une frontière multiple de sa propre taille (le lien /30 doit commencer sur un multiple de 4, ce qui est le cas ici avec `.128`).
- Le lien inter-routeur n'a besoin que d'un /30 (2 hôtes utilisables) : un /24 ou /29 serait un gaspillage.
