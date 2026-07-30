---
title: "Correction : NAT, DMZ et filtrage"
publier: true
---

# TP 06 - NAT, DMZ et filtrage - Correction

> [!TIP] Ressource de la correction
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/06-securite-et-acces/tp/03-correction.md" download>Télécharger cette correction en Markdown</a>

> Chapitre associé : [[06-securite-et-acces]]
> Correction des TP : [version débutant](01-debutant.md) et [version avancée](02-avance.md)

## Version debutant

### Logique attendue

- Le LAN prive utilise des adresses non routables sur Internet.
- Le routeur realise le PAT pour permettre aux postes de sortir.
- Les tests doivent faire apparaitre des entrees dans la table NAT.

### Pourquoi le NAT est utile

- il permet a plusieurs postes prives de partager une IP externe
- il economise les adresses IPv4 publiques
- il masque l'adressage interne

## Version avancee

### Publication d'un service

La bonne logique n'est pas de publier directement tout le LAN, mais de :

- placer le serveur dans une zone separee, type DMZ
- filtrer strictement les flux autorises
- garder le LAN interne non expose

### Regles de filtrage possibles

| Regle | Sens |
|---|---|
| Autoriser TCP 80 et 443 vers Internet | Sortant |
| Autoriser SSH seulement depuis le reseau d'administration | Entrant ou admin |
| Bloquer les connexions entrantes inutiles vers le LAN | Entrant |

### VPN

- **VPN d'acces distant** : un utilisateur se connecte depuis l'exterieur au reseau de l'entreprise
- **VPN site-a-site** : deux reseaux entiers sont relies de facon permanente

## Point a retenir

NAT n'est pas un pare-feu a lui seul.

La securite correcte combine :

- segmentation
- filtrage
- publication maitrisee
- chiffrement si acces distant
