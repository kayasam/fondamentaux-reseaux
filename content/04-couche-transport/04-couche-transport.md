---
title: 04. Couche transport
---

# Couche 4 : la couche transport

> [!TIP] Ressources du chapitre
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/04-couche-transport/04-couche-transport-interactif.html" target="_blank">Ouvrir le cours interactif</a>
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/04-couche-transport.md" download>Télécharger ce cours en Markdown</a>
> - [[04-couche-transport/tp/01-debutant|TP débutant]]
> - [[04-couche-transport/tp/02-avance|TP avancé]]

Les paquets IP étudiés au chapitre 3 savent trouver leur chemin entre réseaux, mais ils ne savent pas quelle **application** les attend. La couche transport (L4) résout ce problème grâce aux **numéros de ports** et choisit entre livraison fiable (TCP) ou rapide (UDP).

La couche Transport assure le **transfert des données entre deux applications** situées sur des machines différentes. Elle gère la segmentation, la fiabilité et le multiplexage via les **ports**.

---

## 4.1 Rôle de la couche Transport

La couche 4 :
- **segmente** les données en unités transportables,
- **identifie les applications** via les numéros de port,
- choisit entre **fiabilité** (TCP) et **rapidité** (UDP) selon le besoin.

Une **socket** = adresse IP + port. Exemple : `192.168.1.10:80` identifie un serveur web.

---

## 4.2 UDP — User Datagram Protocol

**UDP** envoie des données sans établir de connexion et sans vérification de réception.

**Avantages :** faible latence, overhead minimal, débit maximal.  
**Inconvénients :** pas de garantie de livraison, pas d'ordre assuré, pas de retransmission.

|Application|Pourquoi UDP ?|
|---|---|
|Streaming vidéo/audio|Quelques pertes acceptables, latence prioritaire|
|Jeux en ligne|Vitesse avant fiabilité|
|DNS|Requêtes courtes, réponse rapide|
|VoIP (téléphonie IP)|La latence est critique|

### Structure d'un datagramme UDP

|Champ|Rôle|
|---|---|
|Port source|Application émettrice|
|Port destination|Application réceptrice|
|Longueur|Taille du message|
|Checksum|Vérification d'intégrité|

---

## 4.3 TCP — Transmission Control Protocol

**TCP** garantit que les données arrivent **dans l'ordre**, **sans perte** et **sans erreur**.

### Établissement de connexion (handshake à 3 étapes)

```
Client        →  SYN          →  Serveur
Client        ←  SYN-ACK      ←  Serveur
Client        →  ACK          →  Serveur
              [connexion établie]
```

![ch3-tcp-handshake.svg](Ressources/images/ch3-tcp-handshake.svg)

### Fermeture de connexion (4 étapes)

Une fois l'échange terminé, chaque côté ferme sa moitié de connexion :

```
Client        →  FIN          →  Serveur
Client        ←  ACK          ←  Serveur
Client        ←  FIN          ←  Serveur
Client        →  ACK          →  Serveur
              [connexion fermée]
```

Après le dernier ACK, le client passe en état **TIME_WAIT** (quelques secondes) pour s'assurer que le serveur a bien reçu le message avant de libérer les ressources.

### Mécanismes clés

- **Numéros de séquence** : réassemblage des paquets dans l'ordre.
- **Acquittements (ACK)** : chaque segment reçu est confirmé.
- **Fenêtre glissante** : contrôle du débit pour éviter la saturation.
- **Retransmission** : si un paquet n'est pas acquitté, il est renvoyé.

|Application|Pourquoi TCP ?|
|---|---|
|Web (HTTP/HTTPS)|La page doit être complète|
|Email (SMTP, IMAP)|Aucune perte tolérée|
|Transfert de fichiers|Intégrité et ordre essentiels|
|SSH|Connexion fiable indispensable|

---

## 4.4 Numéros de ports

Un **port** identifie une application sur une machine. Plage : **0 à 65535**.

|Plage|Type|Usage|
|---|---|---|
|0 – 1023|Ports bien connus|Services standards (HTTP, SSH…)|
|1024 – 49151|Ports enregistrés|Applications définies par les éditeurs|
|49152 – 65535|Ports dynamiques|Utilisés temporairement par les clients|

### Ports standards à connaître

|Service|Proto|Port|
|---|---|---|
|HTTP|TCP|80|
|HTTPS|TCP|443|
|SSH|TCP|22|
|FTP|TCP|21|
|DNS|UDP/TCP|53|
|DHCP|UDP|67/68|
|SMTP|TCP|25|
|RDP|TCP|3389|

> [!info]
> Un serveur **écoute** sur un port fixe (ex. 443) ; le client utilise un **port temporaire** (ex. 51324) pour la réponse. La session est identifiée par le quadruplet : IP src, port src, IP dst, port dst.

---

## 4.5 Diagnostic de la couche Transport

### Outils

**`netstat`** — affiche les connexions actives et les ports ouverts :
```bash
netstat -an       # Toutes les connexions avec ports et états
netstat -tulnp    # Linux : ports en écoute + processus associés
```

**`ss`** (Linux) — version moderne et plus rapide de netstat :
```bash
ss -tulnp
```

**`telnet` / `nc`** — teste si un port est accessible :
```bash
telnet 192.168.1.10 80   # Teste le port 80 sur la cible
nc -zv 192.168.1.10 443  # Test TCP rapide
```

### États TCP courants

|État|Signification|
|---|---|
|LISTEN|Le service attend des connexions|
|ESTABLISHED|Connexion active|
|TIME_WAIT|Fermeture en cours (attente)|
|SYN_SENT|Demande de connexion envoyée|
|CLOSE_WAIT|Le pair distant a fermé la connexion|

> [!info]
> Un port en état **LISTEN** mais inaccessible depuis l'extérieur indique souvent un pare-feu. Un **TIME_WAIT** excessif peut trahir une charge serveur élevée.

---

## 4.6 Transition vers les services applicatifs

À ce stade, on sait :
- adresser une machine en IP,
- acheminer les paquets jusqu'à elle,
- distinguer les applications grâce aux ports,
- choisir entre **TCP** et **UDP**.

La question suivante devient donc naturelle :

**quels services utilisent réellement ces mécanismes ?**

Le chapitre suivant répond à cela avec :
- **DHCP** pour obtenir une configuration réseau,
- **DNS** pour traduire un nom en IP,
- **HTTP/HTTPS** pour le web,
- puis quelques autres protocoles applicatifs courants.

---

> [!success] Résumé du chapitre 4
> - La couche Transport relie des **applications** via des **sockets** (IP + port).
> - **UDP** : rapide, sans fiabilité — idéal pour la voix, la vidéo et les requêtes DNS.
> - **TCP** : fiable, ordonné, avec acquittements — indispensable pour le web, l'email et les fichiers.
> - Les **ports** identifient les services ; certains sont standardisés (80 HTTP, 443 HTTPS, 22 SSH…).
> - La couche transport prépare le terrain pour les **services applicatifs** vus au chapitre 5.
