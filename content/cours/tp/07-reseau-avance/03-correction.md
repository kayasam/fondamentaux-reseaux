# TP 07 - Routage dynamique et notions avancees - Correction

## Version debutant

### ARP

ARP sert a retrouver l'adresse MAC correspondant a une adresse IP sur le reseau local.

### Hotes utilisables

| Reseau | Hotes utilisables |
|---|---|
| /30 | 2 |
| /29 | 6 |
| /28 | 14 |
| /27 | 30 |

### Types d'adresses

| Adresse | Type |
|---|---|
| 192.168.1.10 | IPv4 |
| 2001:db8::1 | IPv6 |
| fe80::1 | IPv6 |
| 10.0.0.5 | IPv4 |

### Pourquoi IPv6

IPv6 a ete cree parce que l'espace d'adressage IPv4 est limite et ne suffit plus a long terme.

## Version avancee

### Attendu principal

Le protocole de routage dynamique doit permettre d'apprendre automatiquement les reseaux distants.

### Verifications attendues

- des voisins OSPF visibles
- des routes apprises dans `show ip route`
- des pings inter-LAN qui fonctionnent

### Si un lien tombe

Le but est d'observer que le reseau peut recalculer un chemin alternatif si la topologie le permet.

## Points a retenir

- ARP relie IP et MAC sur le LAN
- VLSM optimise l'espace IPv4
- OSPF automatise l'apprentissage des routes
- IPv6 apporte un espace d'adressage immense
