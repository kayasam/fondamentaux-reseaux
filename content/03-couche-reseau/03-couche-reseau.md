---
title: 03. Couche réseau
---

# Couche 3 : la couche réseau

> [!TIP] Ressources du chapitre
> - <a class="chapter-resource chapter-resource--download" href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/03-couche-reseau.md" download>Télécharger le cours en Markdown</a>
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/03-couche-reseau/03-couche-reseau-interactif.html" target="_blank">Ouvrir le cours interactif</a>
> - [[03-couche-reseau/tp/index|Exercices pratiques]]
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/ressources/jeux/03-couche-reseau-jeu.html" target="_blank">Jeu de révision : SIGNAL — Niveau 3</a>
> - [[Ressources/cisco-packet-tracer-commandes|Fiche pratique Cisco CLI]]

Les trames Ethernet étudiées au chapitre 2 circulent dans un réseau local. Pour atteindre un autre réseau, il faut une adresse logique et des équipements capables de choisir un chemin : c'est le rôle de la **couche réseau**.

Ce chapitre réunit les bases et les notions avancées de couche 3 dans une progression unique : **IPv4**, **CIDR**, **VLSM**, **paquet IP**, **passerelle**, **routage statique et dynamique**, **ICMP**, **IPv6** et un aperçu de **MPLS**.

![ch4-vue-ensemble.svg](Ressources/images/ch4-vue-ensemble.svg)

> [!NOTE] Objectifs
> À la fin de ce chapitre, vous saurez lire un plan d'adressage, déterminer si une destination est locale ou distante, interpréter une table de routage et expliquer les rôles d'OSPF, BGP, ICMP et IPv6.

---

## 3.1 — Comprendre une adresse IPv4

Une adresse IPv4 contient **32 bits**, regroupés en quatre octets écrits en décimal :

```text
11000000.10101000.00000001.00101010
   192  .   168  .    1   .    42
```

Une adresse seule ne suffit pas. Le **préfixe CIDR** indique où se termine la partie réseau et où commence la partie hôte.

Exemple : `192.168.1.42/24`

- `192.168.1` identifie ici le réseau ;
- `42` identifie l'interface dans ce réseau ;
- le réseau correspondant est `192.168.1.0/24`.

![ch4-ipv4-adresse.svg](Ressources/images/ch4-ipv4-adresse.svg)

### Adresses privées et adresses particulières

Les plages privées sont réutilisables dans les réseaux internes, mais ne sont pas annoncées directement sur Internet.

|Plage privée|Préfixe|Exemple d'usage|
|---|---:|---|
|`10.0.0.0` à `10.255.255.255`|`10.0.0.0/8`|Grande organisation|
|`172.16.0.0` à `172.31.255.255`|`172.16.0.0/12`|Réseau d'entreprise|
|`192.168.0.0` à `192.168.255.255`|`192.168.0.0/16`|PME, domicile, laboratoire|

Quelques adresses à reconnaître :

|Adresse ou plage|Rôle|
|---|---|
|`127.0.0.1`|Loopback : la machine communique avec elle-même|
|`169.254.0.0/16`|Adresse locale automatique lorsqu'aucune configuration IPv4 n'est obtenue|
|`0.0.0.0`|Adresse non spécifiée|
|`255.255.255.255`|Broadcast limité au réseau local|

> [!INFO] Références officielles
> [RFC 791 — Internet Protocol](https://www.rfc-editor.org/info/rfc791/) · [RFC 1918 — Address Allocation for Private Internets](https://www.rfc-editor.org/info/rfc1918/)

### Et les anciennes classes A, B et C ?

Les classes sont un **repère historique**. Les réseaux modernes utilisent CIDR : un réseau commençant par `10` n'est pas automatiquement configuré en `/8`, et un réseau commençant par `192` n'est pas automatiquement un `/24`.

---

## 3.2 — CIDR, masque et sous-réseaux

Le suffixe `/n` indique le nombre de bits réservés au réseau :

- `/24` : 24 bits réseau et 8 bits hôte ;
- `/26` : 26 bits réseau et 6 bits hôte ;
- `/30` : 30 bits réseau et 2 bits hôte.

Le masque `255.255.255.0` est une autre écriture de `/24`.

### Calculer la capacité

Pour un préfixe IPv4 classique :

```text
bits hôte         = 32 - préfixe
adresses totales  = 2^(bits hôte)
hôtes utilisables = adresses totales - 2
```

Les deux adresses retirées sont généralement :

- la première, qui identifie le **réseau** ;
- la dernière, qui sert de **broadcast**.

|Préfixe|Masque|Adresses totales|Hôtes utilisables|
|---:|---|---:|---:|
|`/24`|`255.255.255.0`|256|254|
|`/25`|`255.255.255.128`|128|126|
|`/26`|`255.255.255.192`|64|62|
|`/27`|`255.255.255.224`|32|30|
|`/28`|`255.255.255.240`|16|14|
|`/30`|`255.255.255.252`|4|2|

> [!NOTE]
> La règle « moins 2 » est adaptée aux exercices d'initiation et aux sous-réseaux IPv4 ordinaires. Des cas particuliers existent, notamment les liens `/31`.

### Découper un `/24` en quatre `/26`

Emprunter 2 bits à la partie hôte produit `2² = 4` sous-réseaux. Chaque `/26` contient 64 adresses.

![ch4-cidr-sous-reseaux.svg](Ressources/images/ch4-cidr-sous-reseaux.svg)

|Réseau|Première IP hôte|Dernière IP hôte|Broadcast|
|---|---|---|---|
|`192.168.1.0/26`|`192.168.1.1`|`192.168.1.62`|`192.168.1.63`|
|`192.168.1.64/26`|`192.168.1.65`|`192.168.1.126`|`192.168.1.127`|
|`192.168.1.128/26`|`192.168.1.129`|`192.168.1.190`|`192.168.1.191`|
|`192.168.1.192/26`|`192.168.1.193`|`192.168.1.254`|`192.168.1.255`|

> [!TIP] Trouver les bornes
> Pour un `/26`, le pas est de **64** : les réseaux commencent à 0, 64, 128 et 192. L'adresse précédant le réseau suivant est le broadcast.

> [!INFO] Référence officielle
> [RFC 4632 — Classless Inter-domain Routing](https://www.rfc-editor.org/info/rfc4632/)

---

## 3.3 — VLSM : adapter la taille au besoin

Découper tout un réseau en blocs identiques est simple, mais peut gaspiller des adresses. **VLSM** (*Variable Length Subnet Masking*) permet d'utiliser plusieurs préfixes dans un même plan d'adressage.

La méthode :

1. classer les besoins du plus grand au plus petit ;
2. choisir le plus petit sous-réseau capable de contenir chaque besoin ;
3. attribuer les blocs dans l'ordre, sans chevauchement ;
4. conserver les espaces restants pour une extension future.

Exemple dans `192.168.50.0/24` :

|Segment|Besoin|Préfixe retenu|Réseau|
|---|---:|---:|---|
|Utilisateurs|60 hôtes|`/26` : 62 hôtes|`192.168.50.0/26`|
|Administration|28 hôtes|`/27` : 30 hôtes|`192.168.50.64/27`|
|Serveurs|12 hôtes|`/28` : 14 hôtes|`192.168.50.96/28`|
|Lien entre routeurs|2 hôtes|`/30` : 2 hôtes|`192.168.50.112/30`|

![ch4-vlsm.svg](Ressources/images/ch4-vlsm.svg)

> [!WARNING]
> Un plan VLSM se construit toujours du plus grand besoin vers le plus petit. Sinon, un petit bloc placé trop tôt peut empêcher l'attribution d'un grand bloc contigu.

---

## 3.4 — Unicast, broadcast, multicast et ARP

|Mode|Destination|Exemple|
|---|---|---|
|**Unicast**|Un destinataire|Un client contacte un serveur|
|**Broadcast**|Tous les hôtes du LAN|Requête ARP ou découverte DHCP|
|**Multicast**|Un groupe abonné|OSPF, diffusion vers plusieurs récepteurs|

![ch4-modes-diffusion.svg](Ressources/images/ch4-modes-diffusion.svg)

Un routeur ne transfère normalement pas les broadcasts du LAN. Chaque sous-réseau constitue donc un **domaine de broadcast** distinct.

### Rappel : obtenir la MAC du prochain saut

IPv4 choisit une destination avec une adresse IP, mais Ethernet livre la trame avec une adresse MAC :

- destination locale : ARP recherche la MAC du destinataire ;
- destination distante : ARP recherche la MAC de la passerelle ;
- la table ARP évite de répéter la découverte à chaque paquet.

![ch3-arp.svg](Ressources/images/ch3-arp.svg)

```bash
# Linux
ip neigh show

# Windows
arp -a
```

> [!NOTE]
> ARP a été détaillé au chapitre 2. Il ne traverse pas les routeurs et ne résout que les adresses du réseau local.

> [!INFO] Référence officielle
> [RFC 826 — Address Resolution Protocol](https://www.rfc-editor.org/info/rfc826/)

---

## 3.5 — Le paquet IP

IP encapsule les données de la couche transport dans un **paquet**. Pour comprendre le routage, quelques champs suffisent.

|Champ|Rôle|
|---|---|
|Version|Indique IPv4 ou IPv6|
|IP source|Adresse de l'émetteur|
|IP destination|Adresse du destinataire final|
|TTL|Diminue de 1 à chaque routeur ; le paquet est supprimé à 0|
|Protocole|Indique le contenu : ICMP, TCP, UDP…|
|Données|Segment TCP, datagramme UDP ou message ICMP|

![ch4-paquet-ip.svg](Ressources/images/ch4-paquet-ip.svg)

> [!IMPORTANT] Ce qui change pendant le trajet
> Les adresses MAC sont remplacées à chaque liaison. Les adresses IP source et destination restent normalement celles des extrémités ; une traduction NAT, étudiée au chapitre 6, constitue une exception.

IP fournit un service **sans connexion** et **au mieux** : il ne garantit ni l'arrivée, ni l'ordre, ni l'absence de doublon. La fiabilité éventuelle est assurée par les protocoles supérieurs.

---

## 3.6 — Passerelle et routage statique

Avant d'envoyer un paquet, un poste compare l'IP de destination avec son propre réseau :

- même sous-réseau : livraison directe ;
- autre sous-réseau : livraison de la trame à la **passerelle par défaut**.

![ch4-passerelle.svg](Ressources/images/ch4-passerelle.svg)

La passerelle n'est pas « Internet » : c'est simplement le routeur capable de faire sortir le paquet du réseau local.

### Comment un routeur choisit-il une route ?

Le routeur :

1. lit l'IP de destination ;
2. cherche les routes compatibles dans sa table ;
3. conserve la route au **préfixe le plus long**, donc la plus précise ;
4. transmet le paquet par l'interface indiquée ou vers un prochain saut.

|Destination|Prochain saut|Interface|Origine|
|---|---|---|---|
|`192.168.1.0/24`|Directement connecté|`eth0`|Connectée|
|`10.20.0.0/16`|`192.168.1.254`|`eth0`|Statique|
|`10.20.30.0/24`|`192.168.1.253`|`eth0`|OSPF|
|`0.0.0.0/0`|`192.168.1.1`|`eth0`|Défaut|

Pour `10.20.30.42`, la route `/24` gagne sur la `/16` et la `/0`.

![ch4-table-routage.svg](Ressources/images/ch4-table-routage.svg)

Une **route statique** est saisie par un administrateur. Elle est prévisible et adaptée aux petits réseaux, mais elle ne s'adapte pas seule à une panne.

```bash
# Linux
ip route show

# Windows
route print
```

> [!TIP] Lire `0.0.0.0/0`
> La route par défaut correspond à toutes les destinations, mais elle est la moins précise. Elle n'est utilisée que lorsqu'aucune meilleure route n'existe.

---

## 3.7 — Routage dynamique : RIP, OSPF et BGP

Dans un réseau plus grand, saisir et corriger toutes les routes à la main devient difficile. Un protocole de routage dynamique permet aux routeurs :

- de s'annoncer des réseaux accessibles ;
- de calculer des chemins ;
- de retirer une route devenue indisponible ;
- d'en choisir une autre lorsque la topologie change.

![ch4-routage-dynamique.svg](Ressources/images/ch4-routage-dynamique.svg)

|Protocole|Idée principale|Usage typique|
|---|---|---|
|**RIP**|Choisit selon le nombre de sauts|Apprentissage et anciens petits réseaux|
|**OSPF**|Calcule le coût des chemins à partir d'une carte du réseau|Réseau interne d'entreprise|
|**BGP**|Échange des préfixes et applique des politiques entre systèmes autonomes|Internet, opérateurs, grandes organisations|

### OSPF : choisir un chemin dans l'entreprise

Avec OSPF, chaque routeur construit une vue de la topologie de sa zone puis calcule les meilleurs chemins. La métrique est un **coût** : le nombre de sauts n'est donc pas le seul critère.

![ch4-ospf.svg](Ressources/images/ch4-ospf.svg)

Dans un grand réseau, OSPF peut être divisé en **zones**. La zone 0 forme le cœur logique, mais ce niveau de conception dépasse l'objectif de ce chapitre.

<iframe width="560" height="315" src="https://www.youtube.com/embed/XBPK-6zrLZ8?si=IUIKZOL6uKEk8uGL" title="Introduction au routage dynamique" frameborder="0" allowfullscreen></iframe>

> [!INFO] Référence officielle
> [RFC 2328 — OSPF Version 2](https://www.rfc-editor.org/info/rfc2328/)

### BGP : échanger des routes entre organisations

Internet est composé de réseaux administrés indépendamment, appelés **systèmes autonomes** ou **AS**. BGP annonce les préfixes joignables entre ces AS et applique des politiques de routage.

![ch4-bgp.svg](Ressources/images/ch4-bgp.svg)

> [!NOTE]
> OSPF cherche un chemin à l'intérieur d'une organisation. BGP échange des routes entre organisations. Dire que BGP choisit simplement « le chemin le plus court » serait trompeur : les politiques comptent beaucoup.

> [!INFO] Référence officielle
> [RFC 4271 — Border Gateway Protocol 4](https://www.rfc-editor.org/info/rfc4271/)

---

## 3.8 — ICMP, ping et traceroute

**ICMP** transporte des messages de contrôle et d'erreur liés à IP. Il ne garantit pas qu'une application fonctionne, mais il aide à localiser un problème.

### Ping

`ping` envoie généralement un message **Echo Request** et attend un **Echo Reply**. Il teste une réponse IP et mesure le délai aller-retour.

```bash
ping 192.168.1.1
ping 8.8.8.8
ping example.com
```

### Traceroute

`traceroute` envoie des paquets avec des TTL croissants :

1. TTL 1 : le premier routeur le décrémente à 0 et répond ;
2. TTL 2 : le deuxième routeur répond ;
3. le processus continue jusqu'à la destination ou jusqu'à la limite.

```bash
# Linux et macOS
traceroute example.com

# Windows
tracert example.com
```

![ch4-icmp.svg](Ressources/images/ch4-icmp.svg)

### Diagnostic progressif

|Test|Ce qu'il vérifie principalement|
|---|---|
|`ping 127.0.0.1`|Pile IP locale|
|`ping` de sa propre IP|Configuration de l'interface|
|`ping` de la passerelle|Accès au LAN et à la passerelle|
|`ping 8.8.8.8`|Routage vers Internet|
|`ping example.com`|Routage et résolution DNS|
|`traceroute` / `tracert`|Étapes visibles du chemin|

> [!WARNING]
> L'absence de réponse à `ping` ne prouve pas que la machine est arrêtée : ICMP peut être filtré. À l'inverse, un ping réussi ne prouve pas qu'un service web ou SSH fonctionne.

> [!INFO] Référence officielle
> [RFC 792 — Internet Control Message Protocol](https://www.rfc-editor.org/info/rfc792/)

---

## 3.9 — IPv6 : adresser durablement les réseaux

IPv4 offre environ 4,3 milliards d'adresses, ce qui est insuffisant pour attribuer durablement une adresse publique unique à tous les équipements. IPv6 utilise **128 bits**.

|Caractéristique|IPv4|IPv6|
|---|---|---|
|Taille|32 bits|128 bits|
|Écriture|`192.0.2.10`|`2001:db8::10`|
|Broadcast|Existe|Remplacé par des usages multicast|
|Résolution locale|ARP|Neighbor Discovery|
|Configuration|Manuelle ou DHCP|Manuelle, SLAAC ou DHCPv6|

### Lire et simplifier une adresse

Une adresse IPv6 contient huit groupes hexadécimaux de 16 bits.

Deux simplifications sont possibles :

1. supprimer les zéros placés au début d'un groupe ;
2. remplacer **une seule** suite continue de groupes `0000` par `::`.

```text
2001:0db8:0000:0000:0000:0000:0000:0001
2001:db8:0:0:0:0:0:1
2001:db8::1
```

![ch4-ipv6-adresse.svg](Ressources/images/ch4-ipv6-adresse.svg)

### Reconnaître les principales portées

|Type|Préfixe ou adresse|Portée|
|---|---|---|
|Global unicast|`2000::/3`|Routable sur Internet|
|Link-local|`fe80::/10`|Lien local uniquement|
|Unique local|`fc00::/7`|Usage interne|
|Multicast|`ff00::/8`|Groupe de destinataires|
|Loopback|`::1`|Machine locale|

![ch4-ipv6-portees.svg](Ressources/images/ch4-ipv6-portees.svg)

> [!IMPORTANT]
> Une interface IPv6 possède souvent plusieurs adresses en même temps, par exemple une link-local et une global unicast. C'est normal.

### SLAAC : se configurer grâce au routeur

Avec **SLAAC**, le routeur annonce notamment le préfixe du réseau. Le poste forme alors une adresse, vérifie qu'elle n'est pas déjà utilisée et apprend une route par défaut. DHCPv6 peut compléter cette configuration selon le réseau.

![ch4-slaac.svg](Ressources/images/ch4-slaac.svg)

> [!INFO] Références officielles
> [RFC 8200 — IPv6](https://www.rfc-editor.org/info/rfc8200/) · [RFC 4862 — Stateless Address Autoconfiguration](https://www.rfc-editor.org/info/rfc4862/)

---

## 3.10 — MPLS : aperçu d'un réseau opérateur

**MPLS** (*Multiprotocol Label Switching*) est surtout rencontré dans les réseaux d'opérateurs. À l'entrée du réseau MPLS, un équipement associe le paquet à une classe de trafic et ajoute un **label**. Les équipements du cœur utilisent ensuite ce label pour le faire progresser sur un chemin appelé **LSP**.

![ch4-mpls.svg](Ressources/images/ch4-mpls.svg)

Trois opérations suffisent pour comprendre le principe :

- **push** : ajouter un label à l'entrée ;
- **swap** : remplacer le label dans le cœur ;
- **pop** : retirer le label à la sortie.

MPLS peut servir à construire des services VPN opérateur et à maîtriser certains chemins. Ce n'est ni un VLAN étendu ni, à lui seul, un mécanisme de chiffrement.

> [!INFO] Référence officielle
> [RFC 3031 — Multiprotocol Label Switching Architecture](https://www.rfc-editor.org/info/rfc3031/)

---

> [!SUCCESS] À retenir
> - L'adresse IP et le préfixe identifient un réseau et une interface.
> - CIDR découpe l'espace d'adressage ; VLSM adapte chaque bloc au besoin.
> - Une destination locale est livrée directement ; une destination distante passe par la passerelle.
> - Un routeur choisit la route compatible la plus précise.
> - Les routes peuvent être connectées, statiques ou apprises dynamiquement.
> - OSPF sert principalement au routage interne ; BGP échange des routes entre systèmes autonomes.
> - ICMP aide au diagnostic avec `ping` et `traceroute`.
> - IPv6 utilise 128 bits, plusieurs portées d'adresse et peut s'autoconfigurer avec SLAAC.
> - MPLS transporte des paquets à l'aide de labels dans les réseaux d'opérateurs.
