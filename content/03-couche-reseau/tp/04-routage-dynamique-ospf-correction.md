---
title: Correction 04 - Routage dynamique OSPF et IPv6
publier: true
---

# TP 04 - Correction

> [!TIP] Ressource de la correction
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/03-couche-reseau/tp/04-routage-dynamique-ospf-correction.md" download>Télécharger cette correction en Markdown</a>


> Correction du TP : [[04-routage-dynamique-ospf]]

## Topologie retenue

Trois routeurs en triangle : chaque routeur a un LAN local et un lien point-à-point vers chacun des deux autres.

```text
        R1 (LAN 192.168.10.0/24)
        /                    \
 192.168.100.0/30        192.168.100.8/30
      /                          \
R2 (LAN 192.168.20.0/24) ---- R3 (LAN 192.168.30.0/24)
        192.168.100.4/30
```

## Plan d'adressage

| Équipement | Interface | Adresse IP | Masque |
|---|---|---|---|
| R1 | G0/0 (LAN) | 192.168.10.254 | /24 |
| R1 | G0/1 (vers R2) | 192.168.100.1 | /30 |
| R1 | G0/2 (vers R3) | 192.168.100.9 | /30 |
| R2 | G0/0 (LAN) | 192.168.20.254 | /24 |
| R2 | G0/1 (vers R1) | 192.168.100.2 | /30 |
| R2 | G0/2 (vers R3) | 192.168.100.5 | /30 |
| R3 | G0/0 (LAN) | 192.168.30.254 | /24 |
| R3 | G0/1 (vers R2) | 192.168.100.6 | /30 |
| R3 | G0/2 (vers R1) | 192.168.100.10 | /30 |

## Configuration des interfaces

```text
! R1
enable
configure terminal

interface g0/0
 ip address 192.168.10.254 255.255.255.0
 no shutdown

interface g0/1
 ip address 192.168.100.1 255.255.255.252
 no shutdown

interface g0/2
 ip address 192.168.100.9 255.255.255.252
 no shutdown
end
```

```text
! R2
enable
configure terminal

interface g0/0
 ip address 192.168.20.254 255.255.255.0
 no shutdown

interface g0/1
 ip address 192.168.100.2 255.255.255.252
 no shutdown

interface g0/2
 ip address 192.168.100.5 255.255.255.252
 no shutdown
end
```

```text
! R3
enable
configure terminal

interface g0/0
 ip address 192.168.30.254 255.255.255.0
 no shutdown

interface g0/1
 ip address 192.168.100.6 255.255.255.252
 no shutdown

interface g0/2
 ip address 192.168.100.10 255.255.255.252
 no shutdown
end
```

## Configuration OSPF

Un seul processus OSPF (`1`), toutes les interfaces dans l'**area 0**.

```text
! R1
router ospf 1
 network 192.168.10.0 0.0.0.255 area 0
 network 192.168.100.0 0.0.0.3 area 0
 network 192.168.100.8 0.0.0.3 area 0
```

```text
! R2
router ospf 1
 network 192.168.20.0 0.0.0.255 area 0
 network 192.168.100.0 0.0.0.3 area 0
 network 192.168.100.4 0.0.0.3 area 0
```

```text
! R3
router ospf 1
 network 192.168.30.0 0.0.0.255 area 0
 network 192.168.100.4 0.0.0.3 area 0
 network 192.168.100.8 0.0.0.3 area 0
```

```text
end
copy running-config startup-config
```

> [!TIP] Wildcard mask
> OSPF utilise un masque inversé : `/30` (255.255.255.252) devient `0.0.0.3`, `/24` (255.255.255.0) devient `0.0.0.255`.

## Vérifications attendues

```text
show ip ospf neighbor
```

Sur chaque routeur, les **2 autres routeurs** doivent apparaître à l'état `FULL`.

```text
show ip route
```

Chaque routeur doit voir les 2 LAN distants en `O` (OSPF), en plus de ses réseaux `C`/`L` connectés.

```text
ping 192.168.20.1
ping 192.168.30.1
```

Depuis un PC du LAN 1, les pings vers les LAN 2 et 3 doivent aboutir.

## Partie 4 - Changement de topologie

```text
! sur R1
configure terminal
interface g0/1
 shutdown
end
```

- `show ip ospf neighbor` sur R1 ne montre plus que R3 en voisin direct.
- `show ip route` : la route vers le LAN 2 (192.168.20.0/24) reste apprise, mais reconvergée via R3 (chemin R1 → R3 → R2).
- Les pings inter-LAN continuent de passer après quelques secondes de reconvergence, grâce au lien redondant R1-R3-R2.

Rétablissement :

```text
configure terminal
interface g0/1
 no shutdown
end
```

## Partie 5 - IPv6

1. Deux differences importantes : taille d'adressage (32 bits vs 128 bits) et absence de broadcast en IPv6 (remplacé par du multicast/Neighbor Discovery).
2. Le NAT est moins central en IPv6 car l'espace d'adressage est assez vaste pour donner une adresse globale unique à chaque équipement, sans avoir besoin de masquer un parc derrière une seule IP publique.
3. Exemple d'adresse IPv6 valide : `2001:db8::1`.

## Points a retenir

- OSPF automatise l'apprentissage des routes à partir d'une carte de la topologie (aucune route statique saisie à la main).
- Le wildcard mask des commandes `network` est l'inverse du masque de sous-réseau.
- La reconvergence dépend de l'existence d'un chemin alternatif dans la topologie (ici le maillage triangulaire).
- IPv6 apporte un espace d'adressage immense et se passe du NAT dans la plupart des usages.

## À vérifier pendant la correction

- Erreur fréquente : oublier un lien dans une commande `network` OSPF → le voisin correspondant n'apparaît jamais dans `show ip ospf neighbor`.
- Vérifier que la wildcard mask correspond bien au **masque réel de l'interface**, pas un copier-coller d'une autre ligne.
- Si aucun lien redondant n'est câblé (topologie en chaîne au lieu du triangle), couper un lien isole réellement un LAN : c'est un résultat valide à condition que l'élève l'explique.
