---
title: "TP Packet Tracer : VLAN et ports access"
tags:
  - fondamentaux-reseaux
  - tp
  - packet-tracer
  - vlan
---

# TP Packet Tracer — VLAN et ports access

> Chapitre associé : [[02-couche-liaison/02-couche-liaison|Couche liaison]]

> [!INFO] Durée indicative
> 45 minutes.

## Objectifs

- créer des VLAN sur un switch ;
- affecter des ports en mode access ;
- vérifier la communication dans un VLAN et l’isolation entre VLAN différents ;
- observer la table MAC par VLAN.

## Table d’adressage

| Nom | Adresse IP | VLAN | Port |
|---|---|---:|---|
| PC-BLEU-1 | `192.168.10.1/24` | 10 | S1 Fa0/1 |
| PC-BLEU-2 | `192.168.10.2/24` | 10 | S1 Fa0/2 |
| PC-VERT-1 | `192.168.20.1/24` | 20 | S1 Fa0/23 |
| PC-VERT-2 | `192.168.20.2/24` | 20 | S1 Fa0/24 |

## Travail demandé

### Partie A — Construire et adresser

1. Placez un switch Cisco 2960 et quatre PC.
2. Réalisez le câblage indiqué.
3. Configurez les adresses IP.

### Partie B — Créer les VLAN

1. Créez le VLAN 10 nommé `BLEU`.
2. Créez le VLAN 20 nommé `VERT`.
3. Affectez Fa0/1 et Fa0/2 au VLAN 10.
4. Affectez Fa0/23 et Fa0/24 au VLAN 20.

Commandes de vérification :

```text
show vlan brief
show interfaces status
```

### Partie C — Tester

Effectuez les tests suivants et notez le résultat attendu puis le résultat obtenu :

| Test | Résultat attendu | Résultat obtenu |
|---|---|---|
| PC-BLEU-1 vers PC-BLEU-2 |  |  |
| PC-VERT-1 vers PC-VERT-2 |  |  |
| PC-BLEU-1 vers PC-VERT-1 |  |  |

### Partie D — Observer la table MAC

1. Lancez plusieurs échanges.
2. Affichez la table MAC :

```text
show mac address-table
```

3. Relevez pour chaque PC l’adresse MAC, le VLAN et le port appris.

## Questions

1. Pourquoi deux PC appartenant au même VLAN peuvent-ils communiquer ?
2. Pourquoi les VLAN 10 et 20 ne communiquent-ils pas directement ?
3. Quel équipement ou quelle fonction faudrait-il ajouter ?
4. Un port access peut-il transporter plusieurs VLAN simultanément ?

> [!TIP] À retenir
> Un VLAN forme un domaine de diffusion logique. Un port access transporte normalement le trafic d’un seul VLAN côté poste.
