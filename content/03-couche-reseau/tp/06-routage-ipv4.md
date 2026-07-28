---
title: "TP Packet Tracer : routage IPv4 de base"
tags:
  - fondamentaux-reseaux
  - tp
  - packet-tracer
  - routage
---

# TP Packet Tracer — Routage IPv4 de base

> Chapitre associé : [[03-couche-reseau/03-couche-reseau|Couche réseau]]

> [!INFO] Durée indicative
> 60 à 75 minutes.

## Objectifs

- interconnecter plusieurs réseaux avec un routeur Cisco ;
- configurer les interfaces, adresses et passerelles ;
- lire les routes directement connectées ;
- vérifier la connectivité inter-LAN.

## Scénario

Trois réseaux locaux doivent communiquer :

| Réseau | Département | Adresse réseau | Nombre de PC |
|---|---|---|---:|
| LAN 1 | Administration | `192.168.10.0/24` | 2 |
| LAN 2 | Technique | `192.168.20.0/24` | 2 |
| LAN 3 | Comptabilité | `192.168.30.0/24` | 2 |

Un routeur relie directement les trois LAN.

## Travail demandé

### Partie A — Construire la topologie

1. Placez un routeur possédant au moins trois interfaces Ethernet.
2. Ajoutez trois switches.
3. Reliez chaque switch à une interface différente du routeur.
4. Ajoutez deux PC par LAN.

### Partie B — Concevoir le plan d’adressage

Utilisez `.254` comme adresse de passerelle dans chaque LAN.

| Équipement | Interface | Adresse IP | Masque | Passerelle |
|---|---|---|---|---|
| R1 | G0/0 |  |  | — |
| R1 | G0/1 |  |  | — |
| R1 | G0/2 |  |  | — |
| PC-A1 | NIC |  |  |  |
| PC-A2 | NIC |  |  |  |
| PC-T1 | NIC |  |  |  |
| PC-T2 | NIC |  |  |  |
| PC-C1 | NIC |  |  |  |
| PC-C2 | NIC |  |  |  |

### Partie C — Configurer le routeur

1. Configurez chaque interface.
2. Activez chaque interface avec `no shutdown`.
3. Vérifiez leur état :

```text
show ip interface brief
```

4. Configurez les postes et leur passerelle.
5. Testez d’abord chaque poste vers sa passerelle.

### Partie D — Vérifier le routage

1. Testez un `ping` entre deux postes de LAN différents.
2. Affichez la table :

```text
show ip route
```

3. Relevez les routes marquées `C` et `L`.
4. En mode Simulation, observez les adresses MAC et IP sur deux liaisons successives.

| Élément observé | Avant le routeur | Après le routeur |
|---|---|---|
| IP source |  |  |
| IP destination |  |  |
| MAC source |  |  |
| MAC destination |  |  |

## Dépannage

En cas d’échec, vérifiez dans cet ordre :

1. l’état des câbles et interfaces ;
2. l’adresse et le masque du poste ;
3. la passerelle du poste ;
4. l’adresse de l’interface du routeur ;
5. la table de routage.

## Questions

1. Pourquoi chaque interface du routeur appartient-elle à un réseau distinct ?
2. Pourquoi faut-il une passerelle par défaut sur les PC ?
3. Que signifient `C` et `L` dans la table Cisco ?
4. Qu’arrive-t-il si une interface reste en `shutdown` ?
5. Quelles informations changent à chaque liaison et lesquelles restent identiques de bout en bout ?

## Extension — Router-on-a-stick

Ajoutez un VLAN `BACKUP` utilisant `192.168.99.0/24` sur le lien du LAN Administration :

1. créez le VLAN sur le switch ;
2. transformez le lien vers R1 en trunk ;
3. créez une sous-interface `G0/0.99` ;
4. utilisez `encapsulation dot1Q 99` ;
5. ajoutez un poste de sauvegarde et testez le routage inter-VLAN.

> [!TIP] Aide Cisco
> Consultez [[Ressources/cisco-packet-tracer-commandes|la fiche pratique Cisco CLI]].
