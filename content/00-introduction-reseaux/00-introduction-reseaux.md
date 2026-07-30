---
title: 00. Introduction aux réseaux
---

# Chapitre 0 : introduction aux réseaux

> [!TIP] Ressources du chapitre
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/00-introduction-reseaux/00-introduction-reseaux-interactif.html" target="_blank">Ouvrir le cours interactif</a>
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/00-introduction-reseaux.md" download>Télécharger ce cours en Markdown</a>
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/00-introduction-reseaux/schema-osi-encapsulation.html" target="_blank">Explorer le schéma OSI interactif</a>
> - [[00-introduction-reseaux/tp/01-debutant|TP débutant]]
> - [[00-introduction-reseaux/tp/02-avance|TP avancé]]

> [!NOTE] Objectifs
> À la fin de ce chapitre, vous saurez identifier les éléments d'un réseau, distinguer LAN et WAN, comparer les principales architectures et topologies, replacer un protocole dans le modèle OSI et expliquer l'encapsulation d'un message.

Lorsque vous ouvrez un site web, votre navigateur ne communique pas directement avec « Internet ». Le message traverse une succession d'éléments : interface réseau, point d'accès ou switch, routeur, réseau de l'opérateur, puis serveur distant. Chacun joue un rôle précis et applique des règles communes.

![ch1-vue-ensemble.svg](Ressources/images/ch1-vue-ensemble.svg)

> [!TIP] Fil conducteur
> Pour comprendre un échange réseau, posez toujours cinq questions : **qui communique**, **par quel support**, **avec quelle adresse**, **selon quel protocole** et **par quel chemin** ?

---

## 0.1 — Qu'est-ce qu'un réseau ?

Un **réseau informatique** est un ensemble d'équipements reliés afin d'échanger des données et de partager des ressources.

Pour qu'une communication soit possible, il faut au minimum :

- deux **hôtes**, par exemple un PC et un serveur ;
- un **support**, par exemple un câble cuivre, une fibre ou des ondes radio ;
- des **interfaces réseau** pour émettre et recevoir ;
- des **protocoles**, c'est-à-dire des règles comprises par les deux extrémités.

### Les éléments à reconnaître

|Élément|Rôle|Exemple|
|---|---|---|
|**Hôte** ou terminal|Produit ou consomme des données|PC, téléphone, serveur, imprimante|
|**Interface réseau**|Relie un équipement au réseau|Carte Ethernet, interface Wi-Fi|
|**Support**|Transporte le signal|Cuivre, fibre, ondes radio|
|**Switch**|Relie les équipements d'un même réseau local|Switch d'entreprise|
|**Point d'accès**|Relie les clients Wi-Fi au réseau local|Borne Wi-Fi|
|**Routeur**|Relie plusieurs réseaux et choisit un chemin|Box Internet, routeur d'agence|
|**Service réseau**|Répond à un besoin applicatif|Web, DNS, messagerie|

> [!IMPORTANT]
> Un **switch** fait principalement circuler les données dans un réseau local. Un **routeur** permet de passer d'un réseau à un autre. Cette distinction guidera toute la formation.

### Flux et ressources partagées

Un réseau peut transporter :

- des données : fichiers, pages web, sauvegardes ;
- de la voix : téléphonie sur IP ;
- de la vidéo : visioconférence, streaming ;
- des commandes : impression, supervision, objets connectés.

Ces flux n'ont pas les mêmes contraintes. Une sauvegarde tolère généralement un petit délai ; une conversation audio supporte mal les retards irréguliers.

---

## 0.2 — Étendue d'un réseau : du PAN au WAN

Les sigles PAN, LAN, MAN et WAN décrivent une **étendue générale**, pas une distance normalisée au mètre près.

![ch1-etendues.svg](Ressources/images/ch1-etendues.svg)

|Type|Signification|Étendue typique|Exemple|
|---|---|---|---|
|**PAN**|Personal Area Network|Autour d'une personne|Smartphone relié à un casque Bluetooth|
|**LAN**|Local Area Network|Logement, salle ou bâtiment|Réseau d'une PME|
|**MAN**|Metropolitan Area Network|Campus ou agglomération|Interconnexion de sites municipaux|
|**WAN**|Wide Area Network|Région, pays ou monde|Réseau inter-agences, Internet|

Un **WLAN** est un LAN utilisant une technologie sans fil, généralement le Wi-Fi. Un même LAN peut donc mélanger des connexions Ethernet et Wi-Fi.

### Internet n'est pas le Web

- **Internet** est l'interconnexion mondiale de nombreux réseaux autonomes utilisant notamment IP.
- Le **Web** est un service qui fonctionne sur Internet, principalement avec HTTP ou HTTPS.
- La messagerie, le DNS, le VPN et la téléphonie IP utilisent aussi Internet sans être « le Web ».

> [!NOTE]
> Internet n'est pas dirigé par un routeur central unique. Les opérateurs et les organisations interconnectent leurs réseaux et échangent des informations de routage.

---

## 0.3 — Architectures de communication

Le mot **architecture** décrit ici la manière dont les rôles sont répartis entre les équipements.

![ch1-architecture.svg](Ressources/images/ch1-architecture.svg)

### Client-serveur

Un **client** initie une demande ; un **serveur** fournit une ressource ou un service.

```text
Navigateur  ── requête HTTPS ──>  Serveur web
Navigateur  <─── réponse HTML ──  Serveur web
```

Cette architecture facilite la centralisation des données, des sauvegardes, des droits et des mises à jour. Elle crée aussi une dépendance au serveur : sa disponibilité doit être prévue.

### Pair-à-pair

Dans une architecture **pair-à-pair** ou **P2P**, chaque participant peut demander et fournir des ressources. Elle convient à certains échanges distribués, mais le contrôle et les sauvegardes sont souvent plus difficiles à centraliser.

> [!TIP] Ne pas confondre
> **Client** et **serveur** désignent des rôles pendant un échange. Une même machine peut être cliente d'un service et serveuse pour un autre.

---

## 0.4 — Topologies : comment les équipements sont reliés

La **topologie physique** décrit les connexions réelles. La **topologie logique** décrit la manière dont les données circulent. Elles ne sont pas toujours identiques.

![ch1-topologies.svg](Ressources/images/ch1-topologies.svg)

|Topologie|Principe|Avantage|Limite|
|---|---|---|---|
|**Bus**|Tous les hôtes partagent un même support|Peu de câblage|Une rupture peut affecter tout le segment|
|**Anneau**|Chaque nœud est relié au suivant|Circulation structurée|Une coupure doit être contournée pour maintenir le service|
|**Étoile**|Chaque hôte rejoint un équipement central|Panne d'un câble généralement isolée|L'équipement central est critique|
|**Maillée**|Plusieurs chemins relient les nœuds|Redondance élevée|Coût et administration plus importants|

Dans un LAN Ethernet moderne, la topologie physique est généralement une **étoile autour d'un switch**. Dans un réseau étendu, plusieurs chemins peuvent former un maillage afin de résister aux pannes.

> [!WARNING]
> Ajouter des liens redondants sans mécanisme de contrôle peut créer des boucles. Ce problème et le protocole STP seront étudiés au chapitre 2.

---

## 0.5 — Protocoles, services et modèles

Un **protocole** définit les règles d'un échange : format des messages, ordre des étapes et comportement attendu. Un **service** répond à un besoin de l'utilisateur en s'appuyant sur un ou plusieurs protocoles.

|Besoin|Protocole ou mécanisme|Rôle simplifié|
|---|---|---|
|Obtenir une configuration réseau|**DHCP**|Fournit notamment une adresse IP et une passerelle|
|Résoudre un nom|**DNS**|Associe un nom à une adresse IP|
|Consulter un site|**HTTP / HTTPS**|Échange les ressources du Web|
|Transporter de manière fiable|**TCP**|Contrôle la livraison et l'ordre des données|
|Acheminer entre réseaux|**IP**|Porte les adresses logiques source et destination|
|Livrer dans un LAN Ethernet|**Ethernet**|Transporte des trames entre interfaces locales|

> [!TIP] Analogie
> Un service est le besoin rendu, comme « consulter un site ». Les protocoles sont les règles utilisées pour le satisfaire, comme HTTPS, TCP, IP et Ethernet.

### Pourquoi utiliser un modèle en couches ?

Un échange réel mobilise plusieurs protocoles en même temps. Les modèles en couches séparent leurs responsabilités pour :

- apprendre une notion sans devoir tout étudier simultanément ;
- faire évoluer une technologie sans remplacer tout le réseau ;
- localiser plus facilement une panne ;
- permettre l'interopérabilité entre constructeurs.

Le modèle **OSI** comporte sept couches. Il sert surtout de modèle de référence et de vocabulaire commun.

![ch1-osi-modele.svg](Ressources/images/ch1-osi-modele.svg)

|N°|Couche OSI|Question principale|Exemples|PDU|
|---:|---|---|---|---|
|7|Application|Quel service est utilisé ?|HTTP, DNS, SMTP|Données|
|6|Présentation|Sous quel format ?|Encodage, compression, chiffrement|Données|
|5|Session|Comment maintenir le dialogue ?|Ouverture et suivi de session|Données|
|4|Transport|Quelle application et quelle fiabilité ?|TCP, UDP, ports|Segment ou datagramme|
|3|Réseau|Comment atteindre un autre réseau ?|IPv4, IPv6, ICMP, routeur|Paquet|
|2|Liaison|Comment livrer sur le lien local ?|Ethernet, Wi-Fi, MAC, switch|Trame|
|1|Physique|Comment transporter les bits ?|Cuivre, fibre, radio|Bits|

**PDU** signifie *Protocol Data Unit* : c'est le nom donné à l'unité de données manipulée par une couche.

### Modèle TCP/IP et modèle OSI

Dans la pratique, Internet est généralement décrit avec le modèle **TCP/IP**, plus compact.

|Modèle TCP/IP|Correspondance OSI|Exemples|
|---|---|---|
|Application|7, 6 et 5|HTTP, DNS, DHCP|
|Transport|4|TCP, UDP|
|Internet|3|IP, ICMP|
|Accès réseau|2 et 1|Ethernet, Wi-Fi, fibre|

> [!NOTE]
> Un protocole réel ne se laisse pas toujours enfermer parfaitement dans une seule case. Les modèles sont des outils pour raisonner, pas la description d'un logiciel exécutant obligatoirement sept étapes séparées.

---

## 0.6 — Encapsulation : du message aux bits

Quand un navigateur envoie une requête, chaque couche ajoute les informations nécessaires à son rôle. Ce mécanisme s'appelle l'**encapsulation**.

```text
Application   Données : requête HTTPS
Transport     [en-tête TCP | données]
Réseau        [en-tête IP  | segment TCP]
Liaison       [en-tête Ethernet | paquet IP | contrôle]
Physique      01010110... transmis sous forme de signal
```

À la réception, chaque couche lit puis retire les informations qui la concernent : c'est la **désencapsulation**.

![ch7-encapsulation.svg](Ressources/images/ch7-encapsulation.svg)

### Ce que chaque information permet

|Information|Question résolue|
|---|---|
|Port TCP ou UDP|À quelle application remettre les données ?|
|Adresse IP|Quelle machine finale doit recevoir le paquet ?|
|Adresse MAC|À quelle interface livrer la trame sur ce lien ?|
|Signal|Comment transporter les bits sur le support ?|

> [!IMPORTANT]
> Sur un trajet routé, la trame et les adresses MAC sont recréées à chaque liaison. Les adresses IP source et destination restent normalement celles des extrémités ; la traduction NAT, étudiée au chapitre 6, est une exception.

---

## 0.7 — Mesurer la qualité d'une communication

Dire qu'un réseau est « rapide » ne suffit pas. Plusieurs mesures décrivent son comportement.

|Mesure|Définition|Effet visible|
|---|---|---|
|**Débit utile**|Quantité de données réellement transmise par seconde|Durée d'un téléchargement|
|**Latence**|Temps nécessaire pour aller d'une extrémité à l'autre|Temps de réaction|
|**Gigue** (*jitter*)|Variation de la latence|Voix ou vidéo irrégulière|
|**Perte de paquets**|Données qui n'atteignent pas la destination|Coupures, retransmissions|
|**Disponibilité**|Capacité du service à rester accessible|Continuité de service|

La **bande passante** représente une capacité théorique ou nominale. Le débit utile est généralement plus faible, car le média peut être partagé et les protocoles ajoutent leurs propres informations.

La **QoS** (*Quality of Service*) permet de traiter certains flux en priorité. Elle ne crée pas de bande passante, mais peut protéger une visioconférence lorsqu'un lien est chargé.

---

## 0.8 — Diagnostiquer avec les couches

Le modèle OSI fournit une méthode de diagnostic. On peut partir du support et remonter progressivement :

1. **Physique** : l'équipement est-il alimenté, le voyant de lien est-il actif ?
2. **Liaison** : l'interface est-elle associée au bon réseau local ou au bon VLAN ?
3. **Réseau** : l'adresse IP, le préfixe et la passerelle sont-ils corrects ?
4. **Transport** : le port du service est-il joignable ?
5. **Application** : le nom est-il résolu et le service répond-il correctement ?

|Symptôme|Première piste|Couche associée|
|---|---|---:|
|Aucun voyant sur le port|Câble, interface, alimentation|1|
|Des postes d'un VLAN ne communiquent pas|Configuration du switch ou du VLAN|2|
|Le LAN fonctionne, mais pas le réseau distant|Adresse, passerelle ou routage|3|
|Le ping répond, mais pas le site web|Port, pare-feu ou service web|4 à 7|
|L'adresse IP répond, mais pas le nom|Résolution DNS|7|

> [!TIP] Méthode
> Modifier une seule chose à la fois, refaire le test, puis noter le résultat. Un diagnostic fiable repose sur des observations, pas sur une succession de changements au hasard.

---

## 0.9 — Parcours de la formation

Les chapitres suivent le trajet des données, du signal physique jusqu'aux services et à leur protection.

|Chapitre|Question directrice|
|---|---|
|**0 — Introduction**|Quels éléments et quels modèles décrivent une communication ?|
|**1 — Couche physique**|Comment les bits deviennent-ils un signal ?|
|**2 — Couche liaison**|Comment une trame circule-t-elle dans le réseau local ?|
|**3 — Couche réseau**|Comment adresser les interfaces et choisir un chemin ?|
|**4 — Couche transport**|Comment joindre une application et gérer la fiabilité ?|
|**5 — Services réseau**|Comment fonctionnent DNS, DHCP et les services applicatifs ?|
|**6 — Sécurité et accès**|Comment filtrer, traduire et protéger les communications ?|

---

## Vérification rapide

Avant de passer au chapitre suivant, vous devez pouvoir répondre à ces questions :

1. Quelle différence faites-vous entre un switch et un routeur ?
2. Pourquoi Internet et le Web ne sont-ils pas synonymes ?
3. À quelles couches appartiennent une adresse MAC, une adresse IP et un port TCP ?
4. Dans quel ordre obtient-on données, segment, paquet, trame et bits ?
5. Pourquoi une bonne bande passante ne garantit-elle pas une bonne visioconférence ?

> [!SUCCESS] À retenir
> - Un réseau relie des **hôtes** par des supports et des équipements intermédiaires.
> - Un **switch** relie principalement les équipements d'un LAN ; un **routeur** relie des réseaux.
> - LAN et WAN décrivent des étendues ; Internet est une interconnexion mondiale de réseaux.
> - Les architectures client-serveur et pair-à-pair répartissent différemment les rôles.
> - Le modèle OSI sépare la communication en sept couches et fournit une méthode de diagnostic.
> - L'encapsulation transforme les données en segment, paquet, trame puis bits.
> - Débit, latence, gigue et perte de paquets décrivent des aspects différents de la qualité réseau.
