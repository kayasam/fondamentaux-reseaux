---
title: Index des protocoles et notions réseau
cssclasses:
  - revision-index
aliases:
  - Index de révision réseau
  - Protocoles et ports réseau
tags:
  - fondamentaux-reseaux
  - revision
  - protocoles
  - ports
---

# Index des protocoles et notions réseau

> [!TIP] Version interactive
> [Ouvrir l’index dynamique](index-protocoles-et-notions-interactif.html) pour rechercher, filtrer, trier, créer des favoris ou lancer une carte de révision aléatoire.

Cette note rassemble le vocabulaire étudié dans la formation **Fondamentaux Réseaux**. Elle sert d’aide-mémoire dans Obsidian et de point d’entrée vers les chapitres.

## Comment utiliser cet index

- partir d’un **nom** ou d’un **acronyme** inconnu ;
- retrouver rapidement le **port** d’un service ;
- relier chaque notion à sa **couche** et à son **chapitre** ;
- masquer la colonne « Rôle » pour s’interroger ;
- utiliser l’index HTML pour combiner plusieurs filtres.

> [!NOTE] Couche applicative
> Dans ce cours d’initiation, les couches OSI 5, 6 et 7 sont regroupées sous le nom **couche applicative**. Cela permet de rester proche du modèle TCP/IP réellement employé.

---

## Vue d’ensemble des couches

| Couche étudiée | Unité de données | Rôle principal | Exemples |
|---|---|---|---|
| Couche applicative | Données / message | Fournir un service aux applications | HTTP, DNS, DHCP, SSH |
| Couche 4 — Transport | Segment TCP / datagramme UDP | Relier les applications avec des ports | TCP, UDP, QUIC |
| Couche 3 — Réseau | Paquet IP | Adresser et router entre réseaux | IPv4, IPv6, ICMP, OSPF |
| Couche 2 — Liaison | Trame | Livrer sur le lien local | Ethernet, MAC, VLAN, STP |
| Couche 1 — Physique | Bits | Transporter un signal | Cuivre, fibre, ondes radio |

Le mouvement des données peut se retenir ainsi :

```text
Données → segment/datagramme → paquet → trame → bits
                          encapsulation →

Bits → trame → paquet → segment/datagramme → données
                        ← décapsulation
```

---

## Protocoles et services

### Couche 2 — Liaison

| Nom | Rôle à retenir | Port | Chapitre |
|---|---|---:|---|
| **Ethernet — IEEE 802.3** | Définit notamment le format des trames d’un réseau local filaire | — | [[../02-couche-liaison/02-couche-liaison\|Couche liaison]] |
| **ARP** | Résout une adresse IPv4 en adresse MAC sur le réseau local | — | [[../02-couche-liaison/02-couche-liaison\|Couche liaison]] |
| **STP — IEEE 802.1D** | Évite les boucles entre switches en bloquant certains chemins | — | [[../02-couche-liaison/02-couche-liaison\|Couche liaison]] |
| **RSTP — IEEE 802.1w** | Fait converger l’arbre plus rapidement que STP | — | [[../02-couche-liaison/02-couche-liaison\|Couche liaison]] |
| **LACP — IEEE 802.1AX** | Agrège plusieurs liens physiques en une liaison logique | — | [[../02-couche-liaison/02-couche-liaison\|Couche liaison]] |
| **LLDP — IEEE 802.1AB** | Annonce l’identité et les capacités d’un équipement à ses voisins directs | — | [[../02-couche-liaison/02-couche-liaison\|Couche liaison]] |
| **CDP** | Découvre les voisins directs dans un environnement Cisco | — | [[../02-couche-liaison/02-couche-liaison\|Couche liaison]] |
| **Wi-Fi — IEEE 802.11** | Définit les réseaux locaux sans fil | — | [[../02-couche-liaison/02-couche-liaison\|Couche liaison]] |

### Couche 3 — Réseau

| Nom | Rôle à retenir | Transport ou numéro IP | Chapitre |
|---|---|---:|---|
| **IPv4** | Adresse et route les paquets avec des adresses sur 32 bits | IP | [[../03-couche-reseau/03-couche-reseau\|Couche réseau]] |
| **IPv6** | Adresse et route avec des adresses sur 128 bits | IP | [[../03-couche-reseau/03-couche-reseau\|Couche réseau]] |
| **ICMP** | Transporte les messages de contrôle et d’erreur utilisés notamment par `ping` | Directement dans IP | [[../03-couche-reseau/03-couche-reseau\|Couche réseau]] |
| **ICMPv6** | Assure le contrôle d’IPv6 et participe à la découverte des voisins | Directement dans IPv6 | [[../03-couche-reseau/03-couche-reseau\|Couche réseau]] |
| **RIP** | Échange des routes avec le nombre de sauts comme métrique | UDP 520 | [[../03-couche-reseau/03-couche-reseau\|Couche réseau]] |
| **OSPF** | Calcule les meilleurs chemins à partir de l’état des liens | Protocole IP 89 | [[../03-couche-reseau/03-couche-reseau\|Couche réseau]] |
| **BGP** | Échange des routes entre systèmes autonomes sur Internet | TCP 179 | [[../03-couche-reseau/03-couche-reseau\|Couche réseau]] |
| **IPsec** | Protège des paquets IP et sert souvent aux VPN site à site | ESP 50, AH 51, IKE UDP 500/4500 | [[../06-securite-et-acces/06-securite-et-acces\|Sécurité et accès]] |

### Couche 4 — Transport

| Nom | Rôle à retenir | Particularité | Chapitre |
|---|---|---|---|
| **TCP** | Transporte un flux de façon fiable, ordonnée et connectée | Acquittements, retransmissions, fenêtre | [[../04-couche-transport/04-couche-transport\|Couche transport]] |
| **UDP** | Transporte des datagrammes avec très peu de surcharge | Pas de connexion ni de garantie intégrée | [[../04-couche-transport/04-couche-transport\|Couche transport]] |
| **QUIC** | Fournit un transport sécurisé et multiflux au-dessus d’UDP | Utilisé par HTTP/3, souvent sur UDP 443 | [[../04-couche-transport/04-couche-transport\|Couche transport]] |

### Couche applicative

| Nom | Rôle à retenir | Transport | Port(s) usuel(s) |
|---|---|---|---:|
| **DHCP** | Attribuer automatiquement la configuration IPv4 | UDP | **67/68** |
| **DHCPv6** | Fournir des paramètres IPv6 | UDP | **546/547** |
| **DNS** | Résoudre les noms et publier des informations de domaine | UDP et TCP | **53** |
| **DoT** | Chiffrer le DNS dans TLS | TCP | **853** |
| **DoH** | Transporter le DNS dans HTTPS | TCP ou QUIC | **443** |
| **HTTP** | Échanger les ressources du Web | TCP | **80** |
| **HTTPS** | Protéger HTTP avec TLS | TCP ou QUIC | **443** |
| **SSH** | Administrer une machine à distance de façon chiffrée | TCP | **22** |
| **SFTP** | Transférer des fichiers dans une session SSH | TCP | **22** |
| **FTP** | Transférer des fichiers sans chiffrement natif | TCP | **21** pour le contrôle |
| **SMTP** | Envoyer ou soumettre des courriels | TCP | **25/587** |
| **IMAP** | Consulter et synchroniser les courriels conservés sur le serveur | TCP | **143/993** |
| **POP3** | Télécharger simplement les courriels depuis le serveur | TCP | **110/995** |
| **SMB** | Partager des fichiers et imprimantes | TCP | **445** |
| **NTP** | Synchroniser l’heure | UDP | **123** |
| **SNMP** | Superviser des équipements et recevoir leurs notifications | UDP | **161/162** |
| **RDP** | Ouvrir une session graphique distante Windows | TCP et UDP | **3389** |
| **RADIUS** | Centraliser l’authentification, l’autorisation et la comptabilité | UDP | **1812/1813** |
| **OpenVPN** | Créer un VPN fondé sur TLS | UDP ou TCP | **1194** usuel |
| **WireGuard** | Créer un VPN moderne fondé sur UDP et des clés publiques | UDP | **51820** usuel |

> [!WARNING] Un port ne suffit pas à identifier un service
> Un administrateur peut déplacer un service sur un autre port. Le numéro aide au diagnostic, mais il faut aussi vérifier le protocole de transport, le processus en écoute et le contenu réel des échanges.

---

## Ports essentiels à mémoriser

| Port | Transport | Service | Moyen mnémotechnique ou usage |
|---:|---|---|---|
| **22** | TCP | SSH, SFTP | Administration et fichiers sécurisés |
| **25** | TCP | SMTP | Transport de courrier entre serveurs |
| **53** | UDP/TCP | DNS | Résolution de noms |
| **67/68** | UDP | DHCPv4 | Serveur 67, client 68 |
| **80** | TCP | HTTP | Web non chiffré |
| **110/995** | TCP | POP3/POP3S | Réception simple des courriels |
| **123** | UDP | NTP | Synchronisation de l’heure |
| **143/993** | TCP | IMAP/IMAPS | Courriels synchronisés |
| **161/162** | UDP | SNMP | Requête 161, trap 162 |
| **179** | TCP | BGP | Échange de routes Internet |
| **443** | TCP/UDP | HTTPS, HTTP/3, DoH | Web chiffré |
| **445** | TCP | SMB | Partage Windows |
| **520** | UDP | RIP | Routage à vecteur de distance |
| **853** | TCP | DoT | DNS chiffré dans TLS |
| **1812/1813** | UDP | RADIUS | Authentification, puis comptabilité |
| **3389** | TCP/UDP | RDP | Bureau distant Windows |

---

## Notions fondamentales

### Introduction et modèles

| Notion | Définition courte |
|---|---|
| **Protocole** | Ensemble de règles précisant le format, l’ordre et le sens des messages |
| **Modèle OSI** | Modèle pédagogique en sept couches |
| **Modèle TCP/IP** | Modèle pratique à quatre couches utilisé sur Internet |
| **Encapsulation** | Ajout des en-têtes quand les données descendent la pile |
| **Décapsulation** | Lecture puis retrait des en-têtes à la réception |
| **LAN** | Réseau limité à une zone locale |
| **WAN** | Réseau reliant des zones éloignées |
| **Unicast** | Un émetteur vers un destinataire |
| **Broadcast** | Un émetteur vers tous les hôtes du domaine de diffusion |
| **Multicast** | Un émetteur vers un groupe de destinataires |
| **Client-serveur** | Le client demande, le serveur fournit |
| **Pair à pair — P2P** | Chaque pair peut fournir et consommer une ressource |

### Couche physique

| Notion | À retenir |
|---|---|
| **Débit** | Nombre de bits transmis par seconde |
| **Latence** | Temps de parcours d’une donnée |
| **Atténuation** | Affaiblissement du signal avec la distance |
| **Interférence** | Perturbation pouvant dégrader le signal |
| **UTP** | Paire torsadée sans blindage supplémentaire |
| **STP** | Paire torsadée blindée |
| **Fibre multimode — MMF** | Courtes distances, cœur large, coût généralement inférieur dans un bâtiment |
| **Fibre monomode — SMF** | Longues distances, cœur fin, liaisons intersites ou opérateur |
| **Full-duplex** | Émission et réception simultanées, sans collision sur un lien commuté |
| **CSMA/CD** | Détection des collisions de l’ancien Ethernet partagé |

### Couche liaison

| Notion | À retenir |
|---|---|
| **Trame** | PDU de couche 2 ; le champ FCS ferme la trame Ethernet |
| **Adresse MAC** | Identifiant local généralement codé sur 48 bits |
| **FCS** | Détecte une altération de la trame grâce au CRC |
| **Table MAC** | Associe une adresse MAC à un port de switch et à un VLAN |
| **VLAN** | Domaine de diffusion logique |
| **Port access** | Transporte un seul VLAN côté poste |
| **Lien trunk** | Transporte plusieurs VLAN entre équipements |
| **Tag 802.1Q** | Identifie le VLAN dans une trame circulant sur un trunk |
| **Routage inter-VLAN** | Fait communiquer des VLAN grâce à la couche 3 |
| **SSID** | Nom logique visible du réseau Wi-Fi |
| **BSSID** | Adresse MAC d’une radio de point d’accès |
| **CSMA/CA** | Tente d’éviter les collisions sur le média radio |

### Couche réseau

| Notion | À retenir |
|---|---|
| **Adresse IPv4** | Adresse logique sur 32 bits |
| **Adresse IPv6** | Adresse logique sur 128 bits |
| **Masque / préfixe** | Sépare la partie réseau de la partie hôte |
| **CIDR** | Écrit la longueur du préfixe sous la forme `/n` |
| **Sous-réseau** | Ensemble d’adresses partageant le même préfixe |
| **VLSM** | Utilise des tailles de sous-réseaux différentes selon les besoins |
| **Passerelle par défaut** | Routeur auquel un hôte remet un paquet destiné à un autre réseau |
| **Table de routage** | Liste les préfixes connus et leur prochain saut |
| **Route par défaut** | Route utilisée faute de correspondance plus précise |
| **TTL / Hop Limit** | Empêche un paquet de boucler indéfiniment |
| **SLAAC** | Autoconfiguration d’une adresse IPv6 à partir des annonces du routeur |
| **APIPA** | Adresse IPv4 `169.254.0.0/16` choisie après un échec DHCP |

### Couche transport

| Notion | À retenir |
|---|---|
| **Port** | Identifie une application dans un hôte ; valeur de 0 à 65535 |
| **Socket** | Association d’une adresse IP, d’un transport et d’un port |
| **Segment TCP** | PDU de TCP |
| **Datagramme UDP** | PDU d’UDP |
| **Three-way handshake** | `SYN → SYN-ACK → ACK` |
| **SEQ** | Repère les octets afin de les remettre dans l’ordre |
| **ACK** | Confirme le prochain octet attendu |
| **Fenêtre glissante** | Régule la quantité de données non acquittées |
| **Contrôle de congestion** | Adapte l’envoi à l’état estimé du réseau |
| **Multiplexage** | Permet à plusieurs applications de partager la pile réseau grâce aux ports |
| **LISTEN** | Un service TCP attend une nouvelle connexion |
| **ESTABLISHED** | Une connexion TCP est établie |
| **TIME-WAIT** | L’ancien échange TCP reste temporairement mémorisé après la fermeture |

### Couche applicative

| Notion | À retenir |
|---|---|
| **DORA** | `Discover → Offer → Request → Acknowledge`, échange DHCPv4 initial |
| **Bail DHCP** | Durée pendant laquelle la configuration est attribuée au client |
| **Relais DHCP** | Transporte les demandes DHCP entre sous-réseaux |
| **Résolveur DNS** | Recherche la réponse pour le client et utilise souvent un cache |
| **TTL DNS** | Durée de conservation d’une réponse dans le cache |
| **A** | Nom vers adresse IPv4 |
| **AAAA** | Nom vers adresse IPv6 |
| **CNAME** | Alias vers un nom canonique |
| **MX** | Serveur de messagerie d’un domaine |
| **PTR** | Adresse IP vers nom lors de la résolution inverse |
| **URL** | Schéma, hôte, port éventuel, chemin et paramètres d’une ressource |
| **Code HTTP 2xx** | Succès |
| **Code HTTP 3xx** | Redirection |
| **Code HTTP 4xx** | Erreur du côté de la requête cliente |
| **Code HTTP 5xx** | Erreur du côté serveur |
| **TLS** | Apporte chiffrement, intégrité et authentification par certificat |

---

## Équipements

| Équipement | Couche principale | Décision ou fonction |
|---|---:|---|
| **Répéteur** | 1 | Régénère ou retransmet le signal |
| **Hub** | 1 | Répète les bits reçus sur tous les autres ports |
| **Switch** | 2 | Choisit un port à partir de sa table MAC |
| **Point d’accès** | 2 | Relie les clients Wi-Fi au LAN filaire |
| **Routeur** | 3 | Choisit un prochain saut à partir de sa table de routage |
| **Pare-feu** | 3 à 7 | Autorise ou bloque des flux selon une politique |
| **Proxy** | Applicative | Agit comme intermédiaire pour un client ou un serveur |

> [!TIP] La couche indique la fonction observée
> Un équipement moderne peut remplir plusieurs rôles. Un switch multicouche commute en couche 2 et route en couche 3 ; un pare-feu peut aussi analyser les protocoles applicatifs.

---

## Sécurité et contrôle d’accès

| Notion | Définition courte |
|---|---|
| **CIA** | Confidentialité, intégrité et disponibilité |
| **Moindre privilège** | N’accorder que les droits strictement nécessaires |
| **AAA** | Authentification, autorisation et traçabilité |
| **MFA** | Combiner au moins deux catégories de facteurs |
| **NAT** | Traduire une adresse IP |
| **PAT** | Traduire aussi les ports pour partager une adresse publique |
| **SNAT** | Modifier la source, généralement à la sortie |
| **DNAT** | Modifier la destination, notamment pour publier un service |
| **Filtrage stateless** | Évaluer chaque paquet indépendamment |
| **Filtrage stateful** | Mémoriser l’état des connexions |
| **ACL** | Liste ordonnée de règles d’autorisation et de refus |
| **Segmentation** | Séparer les ressources en zones avec des flux contrôlés |
| **DMZ** | Isoler les services exposés du réseau interne |
| **VPN d’accès distant** | Relier un utilisateur nomade au réseau de l’organisation |
| **VPN site à site** | Relier deux réseaux au travers d’un tunnel |
| **802.1X** | Contrôler l’accès Ethernet ou Wi-Fi avant d’autoriser le trafic normal |
| **RADIUS** | Centraliser la décision AAA pour les accès réseau |
| **WPA2/WPA3 Personal** | Authentifier le Wi-Fi avec un secret partagé |
| **WPA2/WPA3 Enterprise** | Authentifier individuellement via 802.1X et RADIUS |
| **IDS** | Détecter et alerter |
| **IPS** | Détecter et bloquer en ligne |
| **Zero Trust** | Ne jamais faire confiance implicitement, toujours vérifier |

---

## Outils de diagnostic

| Outil | Question à laquelle il répond | Exemple |
|---|---|---|
| `ipconfig /all` | Quelle est la configuration complète de ce poste Windows ? | `ipconfig /all` |
| `ip addr` | Quelles adresses possède ce poste Linux ? | `ip addr` |
| `ip route` | Quelle route sera utilisée ? | `ip route` |
| `ip neigh` / `arp -a` | Quelle adresse MAC correspond à cette IP locale ? | `ip neigh` |
| `ping` | La destination répond-elle à ICMP ? Quelle est la latence ? | `ping 192.168.1.1` |
| `traceroute` / `tracert` | Par quels routeurs le trafic semble-t-il passer ? | `tracert example.org` |
| `ss -lntup` | Quels sockets et ports sont en écoute sous Linux ? | `ss -lntup` |
| `netstat -ano` | Quelles connexions et quels processus existent sous Windows ? | `netstat -ano` |
| `nslookup` | Le DNS renvoie-t-il une réponse ? | `nslookup example.org` |
| `dig` | Quel enregistrement, serveur et TTL le DNS renvoie-t-il ? | `dig example.org A` |
| `Resolve-DnsName` | Quelle réponse DNS obtient PowerShell ? | `Resolve-DnsName example.org` |
| `Test-NetConnection` | Le port TCP distant est-il accessible depuis Windows ? | `Test-NetConnection example.org -Port 443` |
| `curl` | Que répond réellement le service HTTP ? | `curl -I https://example.org` |
| `openssl s_client` | Quel certificat et quelle négociation TLS sont présentés ? | `openssl s_client -connect example.org:443` |
| **Wireshark** | Que contiennent réellement les trames et paquets échangés ? | Filtre `dns`, `tcp.port == 443`, `arp`… |

---

## Confusions fréquentes

| Ne pas confondre | Différence essentielle |
|---|---|
| **Débit / latence** | Le débit est une quantité par seconde ; la latence est un délai |
| **Adresse MAC / adresse IP** | La MAC sert sur le lien local ; l’IP identifie logiquement une source et une destination routables |
| **Switch / routeur** | Le switch commute des trames dans un LAN ; le routeur transfère des paquets entre réseaux |
| **ARP / DNS** | ARP résout IPv4 vers MAC localement ; DNS résout principalement un nom vers une information |
| **VLAN / sous-réseau IP** | Le VLAN segmente la couche 2 ; le sous-réseau segmente l’adressage de couche 3 |
| **TCP / UDP** | TCP intègre fiabilité et ordre ; UDP privilégie la simplicité et laisse ces choix à l’application |
| **Port / protocole** | Le port identifie une application TCP ou UDP ; un protocole définit les règles de l’échange |
| **HTTP / HTTPS** | HTTPS est HTTP protégé par TLS |
| **SFTP / FTPS** | SFTP fonctionne avec SSH ; FTPS est FTP protégé par TLS |
| **NAT / pare-feu** | NAT traduit ; le pare-feu filtre. L’un ne remplace pas l’autre |
| **IDS / IPS** | L’IDS alerte ; l’IPS peut bloquer |
| **SSID / BSSID** | Le SSID est le nom du réseau Wi-Fi ; le BSSID identifie généralement une radio par une MAC |

---

## Questions flash

1. Quelle PDU le switch manipule-t-il ?
2. Pourquoi le FCS se trouve-t-il à la fin de la trame ?
3. Que fait un hôte lorsque la destination n’est pas dans son sous-réseau ?
4. Pourquoi ARP ne sert-il pas à retrouver la MAC du serveur distant sur Internet ?
5. Quelles garanties TCP ajoute-t-il par rapport à UDP ?
6. Que représentent les ports source et destination ?
7. Pourquoi DNS utilise-t-il UDP **et** TCP ?
8. Quelle différence existe entre DHCP, SLAAC et APIPA ?
9. À quoi servent les enregistrements A, AAAA, CNAME, MX et PTR ?
10. Pourquoi NAT n’est-il pas un mécanisme de sécurité suffisant ?
11. Quelle différence existe entre un port access et un lien trunk ?
12. Quand choisir un VPN d’accès distant ou un VPN site à site ?

> [!SUCCESS] Méthode de révision
> Choisir dix fiches dans l’index interactif. Pour chacune, donner sans regarder : sa couche, son rôle, son transport et son port éventuel. Vérifier ensuite dans le chapitre lié.
