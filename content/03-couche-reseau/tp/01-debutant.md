---
title: "TP débutant : IPv4, CIDR et routage"
---

# TP 03 - IPv4, CIDR et routage simple - Version debutant
> Chapitre associé : [[03-couche-reseau]]

## Objectifs

- Lire une adresse IPv4 et son masque
- Identifier reseau, hote, broadcast
- Configurer un routage simple entre deux LAN

## Partie A - Lecture d'adresses

Complete les tableaux suivants.

### Exercice 1

Reseau : `192.168.10.0/24`

| Element | Valeur |
|---|---|
| Adresse reseau | |
| Premiere IP utilisable | |
| Derniere IP utilisable | |
| Broadcast | |

### Exercice 2

Reseau : `192.168.10.64/26`

| Element | Valeur |
|---|---|
| Adresse reseau | |
| Premiere IP utilisable | |
| Derniere IP utilisable | |
| Broadcast | |

## Partie B - Petit routage

### Topologie

- 1 routeur
- 2 switches
- 2 PC dans le LAN 1
- 2 PC dans le LAN 2

### Plan d'adressage

| Equipement | Interface | Adresse |
|---|---|---|
| R1 | G0/0 | 192.168.10.254/24 |
| R1 | G0/1 | 192.168.20.254/24 |
| PC-A | NIC | 192.168.10.11/24 |
| PC-B | NIC | 192.168.10.12/24 |
| PC-C | NIC | 192.168.20.11/24 |
| PC-D | NIC | 192.168.20.12/24 |

### Travail demande

1. Configure les IP sur les postes.
2. Configure les interfaces du routeur.
3. Renseigne la passerelle par defaut de chaque poste.
4. Teste :
   - ping vers la passerelle locale
   - ping entre deux LAN

## Commandes utiles

```text
show ip interface brief
show ip route
```
