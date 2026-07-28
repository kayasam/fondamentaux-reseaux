---
title: "TP : concevoir un plan d’adressage VLSM"
tags:
  - fondamentaux-reseaux
  - tp
  - ipv4
  - vlsm
---

# TP — Concevoir un plan d’adressage VLSM

> Chapitre associé : [[03-couche-reseau/03-couche-reseau|Couche réseau]]

> [!INFO] Durée indicative
> 60 minutes.

## Objectifs

- concevoir un plan d’adressage hiérarchique et optimisé ;
- appliquer la méthode VLSM ;
- déterminer le préfixe adapté à chaque besoin ;
- identifier réseau, masque, plage d’hôtes et broadcast.

## Énoncé

Une entreprise dispose du bloc principal :

> **192.168.10.0/24**

Elle doit créer les réseaux suivants :

| Département ou liaison | Nombre d’adresses hôtes nécessaires | Remarque |
|---|---:|---|
| Technique | 50 | Réseau utilisateur |
| Direction | 25 | Une imprimante comprise |
| Comptabilité | 12 | Réseau utilisateur |
| Support | 10 | Réseau utilisateur |
| Lien inter-routeur | 2 | Liaison point à point |

## Travail demandé

### Partie A — Préparer l’allocation

1. Classez les besoins du plus grand au plus petit.
2. Pour chacun, ajoutez les adresses réservées au réseau et au broadcast.
3. Choisissez la puissance de 2 immédiatement supérieure.
4. Déduisez le préfixe CIDR.

| Besoin | Hôtes + réserves | Taille retenue | Préfixe |
|---|---:|---:|---:|
| Technique |  |  |  |
| Direction |  |  |  |
| Comptabilité |  |  |  |
| Support |  |  |  |
| Inter-routeur |  |  |  |

### Partie B — Construire le plan VLSM

Allouez les sous-réseaux à la suite, en commençant par le besoin le plus grand.

| Réseau | Préfixe | Masque | Première IP | Dernière IP | Broadcast |
|---|---:|---|---|---|---|
| Technique |  |  |  |  |  |
| Direction |  |  |  |  |  |
| Comptabilité |  |  |  |  |  |
| Support |  |  |  |  |  |
| Inter-routeur |  |  |  |  |  |

### Partie C — Contrôler

1. Vérifiez qu’aucun bloc ne se chevauche.
2. Vérifiez que chaque bloc contient suffisamment d’adresses.
3. Indiquez la première adresse encore disponible après les allocations.
4. Calculez le nombre d’adresses restées libres.

## Mise en pratique Packet Tracer

1. Représentez les cinq réseaux.
2. Utilisez la première ou la dernière adresse utilisable comme passerelle.
3. Configurez au moins un poste dans chaque département.
4. Configurez les interfaces des routeurs.
5. Vérifiez la configuration avec :

```text
show ip interface brief
show ip route
```

## Questions

1. Pourquoi faut-il commencer par le plus grand réseau ?
2. Quel gaspillage aurait produit un `/24` par département ?
3. Pourquoi un `/30` convient-il à une liaison point à point IPv4 classique ?
4. Quelle différence existe entre FLSM et VLSM ?

> [!TIP] Ressource complémentaire
> [Adresses IPv4 et calcul des masques de sous-réseaux — IT-Connect](https://www.it-connect.fr/adresses-ipv4-et-le-calcul-des-masques-de-sous-reseaux/)
