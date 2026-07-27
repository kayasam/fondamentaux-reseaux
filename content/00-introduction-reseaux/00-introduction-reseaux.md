---
title: 00. Introduction aux réseaux
---

# Introduction aux réseaux

> [!TIP] Ressources du chapitre
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/00-introduction-reseaux/00-introduction-reseaux-interactif.html" target="_blank">Ouvrir le cours interactif</a>
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/00-introduction-reseaux.md" download>Télécharger ce cours en Markdown</a>
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/00-introduction-reseaux/schema-osi-encapsulation.html" target="_blank">Explorer le schéma OSI interactif</a>
> - [[00-introduction-reseaux/tp/01-debutant|TP débutant]]
> - [[00-introduction-reseaux/tp/02-avance|TP avancé]]

## 0.1 Présentation générale

Un **réseau informatique** est un ensemble d'équipements reliés pour échanger des données et partager des ressources, à l'aide de **protocoles** (règles communes de communication).

Un réseau permet de :
- partager des fichiers, imprimantes ou Internet,
- accéder à des services communs (web, messagerie, ERP),
- relier des sites distants via Internet ou VPN.

> [!info]
> Internet n'est pas un système centralisé : c'est un ensemble de réseaux indépendants qui utilisent un langage commun, le **protocole IP**.

### Historique simplifié

<iframe width="560" height="315" src="https://www.youtube.com/embed/5ee6W1ODvFU?si=5raNg_0tJszQocIz" title="YouTube video player" frameborder="0" allowfullscreen></iframe>

|Année|Événement|
|---|---|
|1969|ARPANET — premier réseau inter-universités|
|1971|Premier e-mail (Ray Tomlinson)|
|1983|Naissance d'Internet avec TCP/IP|
|1989|Invention du Web (Tim Berners-Lee)|
|1993|Premier navigateur grand public (Mosaic)|
|1997|Apparition du Wi-Fi|
|2012|Déploiement généralisé de la 4G|
|2022|IA générative grand public (ChatGPT)|

[Frise interactive](https://view.genially.com/5ce93e682763660f3077fbc2/horizontal-infographic-timeline-snthistoireinternet)

### Types de flux transportés

Les réseaux véhiculent des **données**, de la **voix** (VoIP), de la **vidéo** (streaming) et des **commandes** (IoT). Cela impose des débits élevés, une faible latence et une **QoS** adaptée selon l'usage.

> [!info]
> La **QoS** (*Quality of Service*) consiste à prioriser certains flux sur le réseau (ex. la voix passe avant un téléchargement) pour garantir une latence stable là où c'est critique.

---

## 0.2 Utilisateurs et besoins

Les utilisateurs (personnes ou machines) se connectent pour :
- échanger des informations (mails, fichiers),
- accéder à Internet ou à des applications métiers,
- travailler à distance (VPN, télétravail),
- gérer des équipements connectés (IoT).

|Utilisateur|Besoin|Exemple|
|---|---|---|
|Employé de bureau|Accès aux fichiers partagés|Serveur de fichiers Windows|
|Développeur|Base de données distante|PostgreSQL, MySQL|
|Télétravailleur|Connexion sécurisée|VPN|
|Objet connecté|Transfert automatisé|Capteur IoT → cloud|

### Services réseau indispensables

- **DNS** : traduit un nom (ex. google.com) en adresse IP *(→ section 6.3)*
- **DHCP** : attribue automatiquement une adresse IP *(→ section 6.2)*
- **HTTP/HTTPS** : navigation web *(→ section 6.4)*
- **SMTP/IMAP** : messagerie *(→ section 6.5)*
- **FTP/SFTP** : transfert de fichiers *(→ section 6.5)*

---

## 0.3 Étendues des réseaux

<iframe width="560" height="315" src="https://www.youtube.com/embed/c0Xj09s5hYA?si=9SB7DfBIeXyB4iml" title="YouTube video player" frameborder="0" allowfullscreen></iframe>

![ch1-etendues.svg](Ressources/images/ch1-etendues.svg)

|Type|Signification|Portée|Exemple|
|---|---|---|---|
|**PAN**|Personal Area Network|Quelques mètres|Bluetooth smartphone ↔ casque|
|**LAN**|Local Area Network|Même bâtiment|Réseau d'entreprise, box Internet|
|**MAN**|Metropolitan Area Network|Une ville|Réseau inter-sites d'une mairie|
|**WAN**|Wide Area Network|National / mondial|Internet, VPN entre agences|

Internet est un **WAN mondial** qui interconnecte des millions de **LAN**.

---

## 0.4 Architectures et topologies

### Architecture

- **Client/serveur** : un serveur central fournit des services à plusieurs clients. Exemple : serveur de fichiers partagé.
- **Pair-à-pair (P2P)** : chaque appareil peut être client et serveur simultanément.

![ch1-architecture.svg](Ressources/images/ch1-architecture.svg)

### Topologies

![ch1-topologies.svg](Ressources/images/ch1-topologies.svg)

|Topologie|Avantages|Inconvénients|
|---|---|---|
|**Bus**|Simple, peu coûteux|Si le câble casse, tout s'arrête|
|**Anneau**|Transmission ordonnée|Peu tolérant aux pannes|
|**Étoile**|Facile à gérer, isolable|Dépendance au switch central|
|**Maillée**|Très fiable, redondance|Coûteux et complexe|

La **topologie en étoile** est la norme dans les réseaux modernes grâce aux switches.

---

## 0.5 Modèle OSI — aperçu et encapsulation

<iframe width="560" height="315" src="https://www.youtube.com/embed/26jazyc7VNk?si=PMMvw7zPM986JnwO" title="YouTube video player" frameborder="0" allowfullscreen></iframe>

Le modèle **OSI** découpe les communications réseau en **7 couches**, chacune avec un rôle précis.

![ch1-osi-modele.svg](Ressources/images/ch1-osi-modele.svg)

|N°|Couche|Rôle|PDU|
|---|---|---|---|
|7|Application|Interface utilisateur (HTTP, DNS…)|Données|
|6|Présentation|Format, encodage, chiffrement|Données|
|5|Session|Gestion du dialogue|Données|
|4|Transport|Transmission fiable (TCP/UDP)|Segment|
|3|Réseau|Routage des paquets (IP)|Paquet|
|2|Liaison|Transmission locale (Ethernet)|Trame|
|1|Physique|Signal électrique ou sans fil|Bits|

### Encapsulation

Quand une application envoie un message, chaque couche **ajoute ses propres en-têtes** (encapsulation). À l'arrivée, les en-têtes sont retirés dans l'ordre inverse.

```
Envoi :    HTTP → [TCP] → [IP] → [Ethernet] → signal
Réception: signal → Ethernet → IP → TCP → HTTP
```

![ch7-encapsulation.svg](Ressources/images/ch7-encapsulation.svg)

> [!info]
> Le modèle OSI est aussi un outil de **diagnostic** : localiser une panne (couche 1 = câble, couche 3 = routage, couche 7 = application).

---

## 0.6 Parcours de la formation

Le fil logique de cette formation est volontairement progressif :

|Chapitre|Idée centrale|
|---|---|
|**1 — Introduction**|Comprendre le vocabulaire, l'OSI et les grandes familles de réseaux|
|**2 — Physique**|Voir comment les bits circulent sur un support|
|**3 — Liaison**|Comprendre le LAN, Ethernet, MAC, switch et VLAN|
|**4 — Réseau : bases**|Maîtriser IPv4, CIDR, passerelle, routage simple et ICMP|
|**5 — Transport**|Comprendre TCP, UDP, ports et outils de diagnostic|
|**6 — Services réseau**|Voir DHCP, DNS, HTTP/HTTPS et les services applicatifs|
|**7 — Réseau : avancé**|Approfondir ARP, multicast, routage dynamique, IPv6, MPLS|
|**8 — Sécurité et accès**|Assembler NAT, pare-feu, proxy, DMZ, VPN et authentification|

Tu peux donc suivre le dossier de haut en bas sans te poser de question : chaque chapitre s'appuie sur le précédent.

---

> [!success] Résumé du chapitre 0
> - Un réseau relie des machines pour partager des ressources, en utilisant des **protocoles**.
> - Les étendues varient du **PAN** (Bluetooth) au **WAN** (Internet).
> - La **topologie en étoile** est la plus répandue grâce aux switches.
> - Le **modèle OSI** décompose les échanges en 7 couches pour faciliter compréhension et diagnostic.
