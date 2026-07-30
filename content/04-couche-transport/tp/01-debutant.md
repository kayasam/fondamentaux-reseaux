---
title: "TP débutant : TCP, UDP et ports"
---

# TP 04 - TCP, UDP et ports - Version debutant

> [!TIP] Ressource du TP
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/04-couche-transport/tp/01-debutant.md" download>Télécharger ce TP en Markdown</a>

> Chapitre associé : [[04-couche-transport]]

## Objectifs

- Distinguer TCP et UDP
- Associer un service a un port
- Lire des sorties simples d'outils de diagnostic

## Partie 1 - Tableau a completer

Indique si le service utilise plutot TCP, UDP, ou les deux.

| Service | Port | TCP / UDP |
|---|---|---|
| HTTP | 80 | |
| HTTPS | 443 | |
| DNS | 53 | |
| DHCP | 67/68 | |
| SSH | 22 | |
| SMTP | 25 | |

## Partie 2 - Classement

Place chaque cas dans la bonne colonne :

| Cas | TCP | UDP |
|---|---|---|
| Navigation web | | |
| DNS | | |
| VoIP | | |
| Transfert de fichier fiable | | |
| Streaming temps reel | | |

## Partie 3 - Analyse

Reponds aux questions :

1. Pourquoi HTTP classique utilise-t-il TCP ?
2. Pourquoi DNS utilise-t-il souvent UDP ?
3. Qu'est-ce qu'un port ?

## Partie 4 - Lecture d'outils

On te donne une sortie fictive :

```text
TCP  192.168.1.10:51544   93.184.216.34:443   ESTABLISHED
UDP  0.0.0.0:68           *:*
TCP  0.0.0.0:22           0.0.0.0:0          LISTENING
```

Explique :

1. Quelle ligne correspond a une connexion web securisee ?
2. Quelle ligne correspond a un service en ecoute ?
3. Quelle ligne evoque un client DHCP ?
