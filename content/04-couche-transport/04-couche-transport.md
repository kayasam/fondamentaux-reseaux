---
title: 04. Couche transport
---

# Couche 4 : la couche transport

> [!TIP] Ressources du chapitre
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/04-couche-transport/04-couche-transport-interactif.html" target="_blank">Ouvrir le cours interactif</a>
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/04-couche-transport.md" download>Télécharger ce cours en Markdown</a>
> - [[04-couche-transport/tp/01-debutant|TP débutant]]
> - [[04-couche-transport/tp/02-avance|TP avancé]]

Au chapitre précédent, la couche réseau a permis d'acheminer un paquet IP jusqu'à la **bonne machine**. Il reste cependant une question : à quelle application faut-il remettre les données ?

Un serveur peut faire fonctionner simultanément un site web, un service SSH et un serveur DNS. La couche transport utilise les **numéros de port** pour atteindre le bon programme et propose principalement deux protocoles :

- **TCP**, qui fournit un flux d'octets fiable et ordonné ;
- **UDP**, qui transporte des datagrammes indépendants avec peu de mécanismes.

![transport-vue-ensemble.svg](Ressources/images/transport-vue-ensemble.svg)

> [!NOTE] Objectifs
> À la fin de ce chapitre, vous saurez expliquer le rôle des ports, différencier TCP et UDP, lire un échange TCP simple et diagnostiquer l'accessibilité d'un service.

> [!TIP] Vidéo (5 min) — Ports et protocoles
> Un résumé visuel avant d'entrer dans le détail, par Cookie Connecté :
>
> https://www.youtube.com/watch?v=YSl6bordSh8

---

## 4.1 — De la machine à l'application

Chaque couche répond à une question différente :

|Couche|Question|Information principale|
|---|---|---|
|Liaison|Quel équipement sur la liaison locale ?|Adresse MAC|
|Réseau|Quelle machine faut-il atteindre ?|Adresse IP|
|Transport|À quelle application remettre les données ?|Numéro de port|

Prenons une connexion HTTPS :

```text
192.168.1.20:53142  →  203.0.113.10:443
```

- `203.0.113.10` identifie le serveur ;
- `443` désigne le service HTTPS ;
- `53142` est un port temporaire choisi par le client pour cette communication.

![transport-processus-a-processus.svg](Ressources/images/transport-processus-a-processus.svg)

> [!IMPORTANT]
> Une adresse IP identifie une interface réseau. Un port identifie un point de communication utilisé par une application sur cette machine.

---

## 4.2 — Ports, sockets et multiplexage

Un numéro de port est codé sur **16 bits** : sa valeur est donc comprise entre `0` et `65535`.

Le système d'exploitation associe les communications aux applications :

- les données reçues sur `TCP/443` sont remises au serveur HTTPS ;
- les données reçues sur `TCP/22` sont remises au serveur SSH ;
- les données reçues sur `UDP/53` sont remises au service DNS utilisant UDP.

Ce partage d'une même adresse IP entre plusieurs applications s'appelle le **multiplexage**.

![transport-ports-multiplexage.svg](Ressources/images/transport-ports-multiplexage.svg)

### Point d'extrémité et connexion

Dans ce cours, on utilisera le terme **socket réseau** pour désigner un point d'extrémité composé d'une adresse IP, d'un protocole de transport et d'un port :

```text
TCP 192.168.1.20:53142
```

Une connexion TCP est distinguée des autres grâce à quatre valeurs :

```text
IP source + port source + IP destination + port destination
```

Lorsque l'on ajoute le protocole de transport, on parle souvent du **quintuplet d'un flux**.

![transport-quadruplet.svg](Ressources/images/transport-quadruplet.svg)

> [!NOTE]
> Deux clients peuvent contacter simultanément le même serveur sur le port `443`. Leurs adresses ou leurs ports source étant différents, le serveur sait à quelle connexion appartient chaque réponse.

---

## 4.3 — Segmentation et encapsulation

Une application peut produire davantage de données que le réseau ne peut en transporter en une seule fois. La couche transport prépare ces données avant de les confier à IP :

- TCP présente à l'application un **flux d'octets** et le répartit en segments ;
- UDP reçoit des messages indépendants et conserve leurs limites sous forme de datagrammes ;
- chaque segment TCP ou datagramme UDP est encapsulé dans un paquet IP ;
- le paquet IP est ensuite encapsulé dans une trame adaptée à la liaison.

![transport-segmentation-encapsulation.svg](Ressources/images/transport-segmentation-encapsulation.svg)

L'exemple ci-dessus segmente un seul flux TCP. En réalité, un poste encapsule simultanément plusieurs protocoles applicatifs (certains sur TCP, d'autres sur UDP), et la machine distante effectue l'opération inverse : elle **décapsule** en remontant les couches.

![transport-encapsulation-bidirectionnelle.svg](Ressources/images/transport-encapsulation-bidirectionnelle.svg)

> [!IMPORTANT] Ne pas confondre les unités
> - **Données** à la couche application ;
> - **segment** avec TCP ;
> - **datagramme** avec UDP ;
> - **paquet** à la couche IP ;
> - **trame** à la couche liaison.

> [!NOTE]
> TCP adapte normalement la taille de ses segments au chemin. Une application UDP doit éviter les datagrammes inutilement grands, car la fragmentation IP augmente le risque de perdre tout le datagramme.

---

## 4.4 — UDP : transporter des datagrammes

**UDP** (*User Datagram Protocol*) est un protocole sans établissement de connexion. L'application fournit un message ; UDP ajoute un petit en-tête puis remet le datagramme à IP.

UDP :

- conserve les limites de chaque message ;
- ne confirme pas la réception ;
- ne remet pas les datagrammes dans l'ordre ;
- ne retransmet pas automatiquement un datagramme perdu ;
- ne réalise pas lui-même de contrôle de flux ou de congestion.

![transport-datagramme-udp.svg](Ressources/images/transport-datagramme-udp.svg)

L'en-tête UDP mesure seulement **8 octets** :

|Champ|Taille|Rôle|
|---|---:|---|
|Port source|16 bits|Identifie l'application émettrice|
|Port destination|16 bits|Identifie l'application destinataire|
|Longueur|16 bits|Taille de l'en-tête et des données|
|Checksum|16 bits|Détecte certaines altérations|

### Quand UDP est-il pertinent ?

|Situation|Pourquoi UDP peut convenir ?|
|---|---|
|DNS|Échanges généralement courts ; l'application peut réessayer|
|Voix et visioconférence|Une donnée arrivée trop tard peut être moins utile qu'une donnée perdue|
|Jeux en ligne|Les mises à jour récentes peuvent remplacer les anciennes|
|DHCP|Le client doit communiquer avant de disposer d'une configuration IP complète|

> [!WARNING]
> UDP ne signifie ni « forcément rapide » ni « réservé au temps réel ». L'application doit gérer elle-même les fonctions dont elle a besoin.

> [!NOTE] Pour aller plus loin
> En IPv4, un checksum UDP nul peut indiquer qu'il n'a pas été calculé. En IPv6, le checksum UDP est normalement obligatoire.

> [!INFO] Référence officielle
> [RFC 768 — User Datagram Protocol](https://www.rfc-editor.org/info/rfc768/)

---

## 4.5 — Choisir entre TCP et UDP

La bonne question n'est pas « quel protocole est le plus rapide ? », mais **quels services l'application attend-elle du transport ?**

![transport-tcp-vs-udp.svg](Ressources/images/transport-tcp-vs-udp.svg)

|Besoin|TCP|UDP|
|---|---:|---:|
|Établissement préalable d'une connexion|Oui|Non|
|Livraison fiable et ordonnée|Oui|Non|
|Conservation des limites des messages|Non : flux d'octets|Oui : datagrammes|
|Retransmission intégrée|Oui|Non|
|Contrôle de flux et de congestion|Oui|Non dans UDP lui-même|
|En-tête minimal|20 octets sans option|8 octets|

### Un cas moderne : QUIC

HTTP/3 n'utilise pas directement TCP. Il utilise **QUIC**, un protocole fiable et sécurisé transporté dans des datagrammes UDP.

Cela montre qu'une application peut employer UDP comme support tout en ajoutant :

- de la fiabilité ;
- des flux ordonnés ;
- un contrôle de congestion ;
- un établissement de connexion sécurisé.

> [!INFO] Référence officielle
> [RFC 9000 — QUIC: A UDP-Based Multiplexed and Secure Transport](https://www.rfc-editor.org/info/rfc9000/)

---

## 4.6 — TCP : établir une connexion

**TCP** (*Transmission Control Protocol*) fournit aux applications un **flux d'octets fiable, bidirectionnel et ordonné**.

TCP ne conserve pas les limites des messages écrits par l'application. Si une application effectue deux écritures, le destinataire peut lire les octets en une ou plusieurs fois : c'est le protocole applicatif qui doit reconnaître ses messages.

### L'en-tête d'un segment TCP

![transport-entete-tcp.svg](Ressources/images/transport-entete-tcp.svg)

Les champs les plus utiles pour débuter sont :

|Champ|Rôle|
|---|---|
|Ports source et destination|Identifient les applications|
|Numéro de séquence|Indique la position des octets transportés|
|Numéro d'acquittement|Indique le prochain octet attendu|
|Drapeaux|Pilotent la connexion : SYN, ACK, FIN, RST…|
|Fenêtre|Indique la quantité de données que le récepteur peut accepter|
|Checksum|Vérifie l'intégrité du segment|

### Le handshake en trois étapes

Avant l'échange de données, les deux extrémités établissent la connexion :

1. le client envoie `SYN` avec son numéro de séquence initial ;
2. le serveur répond `SYN-ACK` avec son propre numéro et acquitte celui du client ;
3. le client répond `ACK`.

![transport-handshake.svg](Ressources/images/transport-handshake.svg)

Le handshake permet notamment :

- de vérifier que les deux sens de communication fonctionnent ;
- de synchroniser les numéros de séquence ;
- de négocier des options TCP ;
- de créer l'état de la connexion sur les deux machines.

> [!INFO] Référence officielle
> [RFC 9293 — Transmission Control Protocol](https://www.rfc-editor.org/info/rfc9293/)

---

## 4.7 — Séquences, ACK et retransmissions

TCP numérote les **octets** du flux. Le numéro d'acquittement indique le **prochain octet attendu**.

Si le serveur reçoit correctement les octets `1000` à `1499`, il peut répondre :

```text
ACK = 1500
```

Cela signifie : « j'ai reçu tout ce qui précède `1500` ; envoie-moi la suite ».

![transport-sequence-ack.svg](Ressources/images/transport-sequence-ack.svg)

Les acquittements sont généralement **cumulatifs** : un seul `ACK` peut confirmer plusieurs segments reçus.

### Que se passe-t-il lorsqu'un segment est perdu ?

TCP peut détecter une perte grâce à un délai d'attente ou à des acquittements indiquant toujours le même octet attendu. L'émetteur retransmet alors les données manquantes.

![transport-retransmission.svg](Ressources/images/transport-retransmission.svg)

> [!IMPORTANT]
> TCP ne rend pas le réseau incapable de perdre des paquets. Il masque une partie de ces pertes à l'application grâce aux acquittements et aux retransmissions. S'il ne peut pas rétablir la communication, il signale l'échec de la connexion.

---

## 4.8 — Fenêtre, contrôle de flux et congestion

Attendre un ACK après chaque petit segment utiliserait mal le réseau. TCP autorise donc plusieurs segments à être **en transit simultanément** : c'est le principe de la fenêtre glissante.

Deux limites différentes interviennent :

- le **contrôle de flux** protège le récepteur qui annonce l'espace qu'il peut encore accepter ;
- le **contrôle de congestion** adapte l'envoi à l'état estimé du réseau.

![transport-fenetre-controles.svg](Ressources/images/transport-fenetre-controles.svg)

La quantité réellement envoyée sans acquittement dépend de la limite la plus contraignante.

> [!TIP] Image mentale
> Le contrôle de flux demande : « le destinataire peut-il suivre ? ». Le contrôle de congestion demande : « le réseau peut-il suivre ? ».

> [!INFO] Référence officielle
> [RFC 5681 — TCP Congestion Control](https://www.rfc-editor.org/info/rfc5681/)

---

## 4.9 — Fermer une connexion et lire les états TCP

TCP est **bidirectionnel** : chaque extrémité ferme séparément son sens d'émission. Une fermeture classique utilise donc deux échanges `FIN` / `ACK`.

![transport-fermeture-etats.svg](Ressources/images/transport-fermeture-etats.svg)

Après le dernier ACK, l'extrémité qui termine activement la connexion peut rester en **TIME_WAIT**. Cela permet notamment de retransmettre le dernier ACK et d'éviter qu'un ancien segment retardé soit confondu avec une nouvelle connexion.

### États courants

|État|Interprétation|
|---|---|
|`LISTEN`|Le service attend une connexion|
|`SYN_SENT`|Une demande a été envoyée ; la réponse n'est pas encore reçue|
|`SYN_RECEIVED`|Une demande a été reçue ; le handshake se poursuit|
|`ESTABLISHED`|La connexion est établie|
|`FIN_WAIT`|La fermeture active est en cours|
|`CLOSE_WAIT`|Le pair a fermé ; l'application locale doit encore fermer|
|`TIME_WAIT`|La fermeture est terminée mais la connexion reste temporairement mémorisée|

> [!WARNING]
> La présence de connexions en `TIME_WAIT` est normale. Leur nombre doit être interprété avec le volume et la durée habituels des connexions, pas comme une panne automatique.

---

## 4.10 — Plages de ports et services connus

L'IANA répartit les ports en trois grandes plages :

![transport-plages-ports.svg](Ressources/images/transport-plages-ports.svg)

|Plage|Nom IANA|Utilisation|
|---|---|---|
|`0–1023`|System Ports|Services standards et privilégiés|
|`1024–49151`|User Ports|Services et applications enregistrés|
|`49152–65535`|Dynamic/Private Ports|Ports temporaires ou usages privés|

Quelques associations courantes :

|Service|Transport|Port habituel|
|---|---|---:|
|SSH|TCP|22|
|SMTP|TCP|25|
|DNS|UDP et TCP|53|
|DHCP serveur/client|UDP|67 / 68|
|HTTP|TCP|80|
|HTTPS sur TCP|TCP|443|
|RDP|TCP et UDP selon les fonctions|3389|

> [!IMPORTANT]
> Un numéro de port ne prouve pas quelle application circule réellement. Un service peut écouter sur un port non standard et une autre application peut utiliser un port habituellement associé à HTTPS ou DNS.

> [!NOTE]
> Le port temporaire réellement choisi par un système dépend de sa configuration. La plage dynamique IANA n'impose pas à tous les systèmes d'exploitation d'utiliser exactement la même plage locale.

> [!INFO] Référence officielle
> [IANA — Service Name and Transport Protocol Port Number Registry](https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml)

---

## 4.11 — Diagnostiquer une communication de couche 4

Un `ping` réussi prouve qu'un échange ICMP est possible avec la machine. Il ne prouve pas qu'un serveur web écoute sur `TCP/443`.

Le diagnostic doit progresser du service local vers le client distant :

![transport-diagnostic.svg](Ressources/images/transport-diagnostic.svg)

### 1. Vérifier les ports en écoute

Sous Linux :

```bash
ss -lntup
```

Sous Windows PowerShell :

```powershell
Get-NetTCPConnection -State Listen
Get-NetUDPEndpoint
```

Il faut vérifier :

- le numéro de port ;
- le protocole TCP ou UDP ;
- l'adresse locale d'écoute ;
- le processus associé.

`127.0.0.1:8080` n'est accessible que depuis la machine locale, contrairement à une écoute sur l'adresse réseau du serveur.

### 2. Tester depuis le client

Sous Linux :

```bash
nc -vz 203.0.113.10 443
curl -I https://203.0.113.10
```

Sous Windows PowerShell :

```powershell
Test-NetConnection 203.0.113.10 -Port 443
```

### 3. Observer les échanges

Filtres Wireshark utiles :

```text
tcp.port == 443
tcp.flags.syn == 1
udp.port == 53
```

### Interpréter quelques résultats

|Observation|Piste principale|
|---|---|
|Aucun port local en écoute|Service arrêté, mal configuré ou mauvais port|
|Écoute uniquement sur `127.0.0.1`|Mauvaise adresse d'écoute pour un accès distant|
|`SYN` envoyé, aucune réponse|Filtrage, routage, NAT ou serveur injoignable|
|Réponse `RST`|Machine joignable mais aucun service n'accepte cette connexion|
|Handshake réussi puis erreur|Chercher dans le protocole applicatif, TLS ou l'application|
|Nombreux `CLOSE_WAIT` persistants|L'application locale ne ferme peut-être pas ses sockets|

> [!TIP] Méthode
> Distinguez toujours : **service démarré**, **port en écoute**, **adresse d'écoute**, **accessibilité réseau**, puis **réponse applicative**.

---

## 4.12 — Choisir et raisonner

![transport-choisir.svg](Ressources/images/transport-choisir.svg)

Pour choisir ou reconnaître un transport, posez les questions dans cet ordre :

1. faut-il recevoir tous les octets dans l'ordre ?
2. une donnée ancienne reste-t-elle utile si elle arrive en retard ?
3. l'application sait-elle gérer les pertes ou les retransmissions ?
4. faut-il conserver les limites de chaque message ?
5. le protocole applicatif impose-t-il déjà TCP, UDP ou QUIC ?

> [!SUCCESS] À retenir
> - La couche transport assure une communication **de processus à processus**.
> - Les **ports** permettent à plusieurs applications de partager une même adresse IP.
> - TCP fournit un **flux d'octets fiable et ordonné** grâce aux séquences, ACK et retransmissions.
> - UDP transporte des **datagrammes indépendants** et laisse davantage de responsabilités à l'application.
> - Le contrôle de flux protège le récepteur ; le contrôle de congestion protège le réseau.
> - Un diagnostic couche 4 vérifie le service, le port, l'adresse d'écoute et les échanges observés.

Le chapitre suivant étudie les services applicatifs qui utilisent ces transports : DNS, DHCP, HTTP/HTTPS et d'autres protocoles courants.
