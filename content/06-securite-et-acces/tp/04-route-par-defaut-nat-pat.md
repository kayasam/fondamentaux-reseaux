---
title: "TP Packet Tracer : route par défaut et NAT/PAT"
tags:
  - fondamentaux-reseaux
  - tp
  - packet-tracer
  - nat
  - pat
---

# TP Packet Tracer — Route par défaut et NAT/PAT

> Chapitres associés : [[03-couche-reseau/03-couche-reseau|Couche réseau]] et [[06-securite-et-acces/06-securite-et-acces|Sécurité et accès réseau]]

> [!INFO] Durée indicative
> 75 minutes.

## Objectifs

- configurer une route statique par défaut ;
- distinguer réseau interne et réseau externe ;
- mettre en place un NAT avec surcharge ;
- observer les traductions d’adresses et de ports.

## Topologie et adressage

| Équipement | Interface | Adresse IP | Connexion |
|---|---|---|---|
| R1 | G0/0 | `100.100.100.1/30` | R2 |
| R1 | G0/1 | `80.80.80.254/24` | SRV-WEB |
| R2 | G0/0 | `100.100.100.2/30` | R1 |
| R2 | G0/1 | `192.168.30.254/24` | S1 |
| PC1 | NIC | `192.168.30.1/24` | S1 |
| PC2 | NIC | `192.168.30.2/24` | S1 |
| S1 | VLAN 1 | `192.168.30.3/24` | R2, PC1, PC2 |
| SRV-WEB | NIC | `80.80.80.80/24` | R1 |

Passerelles :

- PC1 et PC2 : `192.168.30.254` ;
- SRV-WEB : `80.80.80.254`.

## Partie A — Configurer les interfaces

1. Construisez la topologie.
2. Configurez toutes les adresses et passerelles.
3. Activez les interfaces des routeurs.
4. Vérifiez :

```text
show ip interface brief
show ip route
```

5. Depuis PC1, testez `100.100.100.1`.

## Partie B — Ajouter la route par défaut

Sur R2, configurez une route par défaut vers R1 :

```text
ip route 0.0.0.0 0.0.0.0 100.100.100.1
```

1. Vérifiez la table de routage.
2. Retestez `100.100.100.1`.
3. Testez `80.80.80.80`.
4. Expliquez pourquoi la route de retour reste importante.

## Partie C — Préparer le serveur Web

1. Activez HTTP sur SRV-WEB.
2. Vérifiez sa page depuis un équipement du réseau externe.
3. Conservez le serveur dans le réseau `80.80.80.0/24`.

## Partie D — Configurer PAT sur R2

1. Déclarez G0/1 comme interface interne :

```text
interface gigabitEthernet0/1
ip nat inside
```

2. Déclarez G0/0 comme interface externe :

```text
interface gigabitEthernet0/0
ip nat outside
```

3. Autorisez le réseau privé avec une ACL standard :

```text
access-list 1 permit 192.168.30.0 0.0.0.255
```

4. Activez la surcharge :

```text
ip nat inside source list 1 interface gigabitEthernet0/0 overload
```

## Partie E — Tester et observer

Depuis PC1 et PC2 :

1. envoyez des `ping` vers une adresse externe ;
2. ouvrez la page Web de `80.80.80.80` ;
3. générez plusieurs connexions simultanées.

Sur R2 :

```text
show ip nat translations
show ip nat statistics
show access-lists
```

Relevez au moins deux traductions :

| Protocole | Inside local | Inside global | Outside local | Outside global |
|---|---|---|---|---|
|  |  |  |  |  |
|  |  |  |  |  |

## Questions

1. Quelle différence existe entre une route statique précise et une route par défaut ?
2. Que représente l’adresse `inside local` ?
3. Que représente l’adresse `inside global` ?
4. Comment plusieurs postes partagent-ils la même adresse externe ?
5. Quel rôle jouent les ports dans PAT ?
6. NAT remplace-t-il un pare-feu ? Justifiez.
7. Quelle commande permet de vérifier les traductions actives ?

> [!TIP] Aide Cisco
> Consultez [[Ressources/cisco-packet-tracer-commandes|la fiche pratique Cisco CLI]] et [[06-securite-et-acces/note-nat|la note NAT]].
