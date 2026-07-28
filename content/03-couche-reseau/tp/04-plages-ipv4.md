---
title: "TP guidé : plages IPv4 et broadcast"
tags:
  - fondamentaux-reseaux
  - tp
  - ipv4
  - sous-reseaux
---

# TP guidé — Comprendre les plages IPv4 et le broadcast

> Chapitre associé : [[03-couche-reseau/03-couche-reseau|Couche réseau]]

> [!INFO] Durée indicative
> 45 minutes.

## Objectifs

- distinguer adresse réseau, plage d’hôtes et adresse de broadcast ;
- lire les préfixes CIDR de `/24` à `/30` ;
- trouver la taille et le pas d’un bloc ;
- calculer la première et la dernière adresse utilisables.

## Rappel

Un sous-réseau IPv4 contient :

- l’**adresse réseau**, première adresse du bloc ;
- les **adresses hôtes**, situées entre les deux extrémités ;
- l’**adresse de broadcast**, dernière adresse du bloc.

```text
Adresse réseau | Première IP ... Dernière IP | Broadcast
```

## Tableau de référence

| CIDR | Masque | Nombre total d’adresses | Hôtes utilisables |
|---:|---|---:|---:|
| `/24` | `255.255.255.0` | 256 | 254 |
| `/25` | `255.255.255.128` | 128 | 126 |
| `/26` | `255.255.255.192` | 64 | 62 |
| `/27` | `255.255.255.224` | 32 | 30 |
| `/28` | `255.255.255.240` | 16 | 14 |
| `/29` | `255.255.255.248` | 8 | 6 |
| `/30` | `255.255.255.252` | 4 | 2 |

## Méthode

### Étape 1 — Trouver la taille du bloc

Pour les préfixes du tableau, la taille du bloc est le nombre total d’adresses.

### Étape 2 — Trouver le pas

Le pas correspond à la taille du bloc :

```text
/26 → pas de 64 → 0, 64, 128, 192
/27 → pas de 32 → 0, 32, 64, 96, ...
/28 → pas de 16 → 0, 16, 32, 48, ...
```

### Étape 3 — Déduire les adresses

```text
Broadcast   = adresse précédant le réseau suivant
Première IP = adresse réseau + 1
Dernière IP = broadcast - 1
```

## Exercice A — Guidé

Travaillez sur `192.168.10.0/26`.

1. Combien le bloc contient-il d’adresses ?
2. Quel est le pas ?
3. Quels sont les débuts des quatre sous-réseaux ?
4. Complétez le tableau.

| Réseau | Première IP | Dernière IP | Broadcast |
|---|---|---|---|
| `192.168.10.0/26` |  |  |  |
| `192.168.10.64/26` |  |  |  |
| `192.168.10.128/26` |  |  |  |
| `192.168.10.192/26` |  |  |  |

## Exercice B — Semi-guidé

Travaillez sur `192.168.10.0/27`.

1. Déterminez la taille du bloc.
2. Déterminez le pas.
3. Complétez les trois premières lignes.

| Réseau | Première IP | Dernière IP | Broadcast |
|---|---|---|---|
| `192.168.10.0/27` |  |  |  |
| `192.168.10.32/27` |  |  |  |
| `192.168.10.64/27` |  |  |  |

## Exercice C — Autonomie

Travaillez sur `192.168.10.0/28`.

1. Trouvez le pas.
2. Identifiez tous les sous-réseaux du `/24`.
3. Complétez les trois premières lignes.

| Réseau | Première IP | Dernière IP | Broadcast |
|---|---|---|---|
| `192.168.10.0/28` |  |  |  |
| `192.168.10.16/28` |  |  |  |
| `192.168.10.32/28` |  |  |  |

## Vérification facultative

Utilisez Packet Tracer pour configurer deux PC avec des adresses calculées :

1. deux adresses du même sous-réseau doivent communiquer directement ;
2. deux adresses de sous-réseaux différents nécessitent un routeur ;
3. une adresse réseau ou de broadcast ne doit pas être attribuée à un poste.

> [!TIP] À retenir
> Réseau = début du bloc · Broadcast = fin du bloc · Hôtes = adresses situées entre les deux.
