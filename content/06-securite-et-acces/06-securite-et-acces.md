---
title: 06 — Sécurité et accès réseau
---

# Chapitre 6 — Sécurité et accès réseau

> [!TIP] Ressources du chapitre
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/06-securite-et-acces/06-securite-et-acces-interactif.html" target="_blank">Ouvrir le cours interactif</a>
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/06-securite-et-acces.md" download>Télécharger ce cours en Markdown</a>
> - [[06-securite-et-acces/tp/01-debutant|TP débutant]]
> - [[06-securite-et-acces/tp/02-avance|TP avancé]]
> - [[06-securite-et-acces/note-nat|Note complémentaire sur le NAT]]

Une fois les bases du fonctionnement réseau posées, il faut répondre à une autre question : **comment contrôler, protéger et segmenter les accès** ?

Ce chapitre rassemble les mécanismes transverses que l'on rencontre très vite en entreprise : **NAT/PAT**, **pare-feu**, **proxy**, **DMZ**, **VPN** et **authentification réseau**.

---

## 6.1 NAT / PAT

Le **NAT** (*Network Address Translation*) est une famille de mécanismes qui **modifient une adresse IP** dans un paquet. Il permet à un réseau privé de communiquer avec Internet, et de publier des services internes.

Pour ne pas confondre les termes, il faut le classer selon **deux axes indépendants** :

1. **Quelle adresse est traduite ?** → la source ou la destination.
2. **Comment se fait la correspondance ?** → fixe, dynamique, ou avec les ports.

### Axe 1 — SNAT et DNAT (la direction)

**SNAT** (*Source NAT*) traduit l'**adresse source**. C'est le cas d'une machine interne qui sort vers Internet :

```text
192.168.1.10  ──[ SNAT ]──►  80.12.45.20
  source privée                source publique
```

**DNAT** (*Destination NAT*) traduit l'**adresse destination**. C'est le cas d'un accès depuis Internet vers un serveur interne (port forwarding) :

```text
Client Internet ──[ DNAT ]──►  192.168.1.50
   vers 80.12.45.20:80            serveur web interne
```

### Axe 2 — statique, dynamique, PAT (le type de correspondance)

|Type|Mapping|Usage typique|
|---|---|---|
|**NAT statique**|1 IP privée ↔ 1 IP publique, fixe|Serveur en DMZ avec IP publique dédiée|
|**NAT dynamique**|N IP privées → pool d'IP publiques, temporaire|Entreprise disposant de plusieurs IP publiques|
|**PAT** (*Port Address Translation*, ou NAT overload)|N IP privées → 1 IP publique, différenciées par le **port**|Box Internet, routeurs, Hyper-V, VMware…|

Exemple de PAT — plusieurs machines partagent une seule IP publique grâce aux ports :

```text
192.168.1.10:51500  ─┐
192.168.1.11:51501  ─┼──[ PAT ]──►  80.12.45.20:61001 / :61002 / :61003
192.168.1.12:51502  ─┘
```

> [!warning] SNAT ≠ NAT statique
> Ce sont deux classifications différentes. **SNAT/DNAT** décrivent la **direction** (quelle adresse change). **Statique/dynamique/PAT** décrivent le **type de correspondance**. Le PAT est d'ailleurs la forme de SNAT la plus courante.

### Masquerade — le cas Linux

Le **masquerade** n'est pas une nouvelle catégorie : c'est une façon pratique de faire du **SNAT automatiquement** sous Linux, en réutilisant l'adresse de l'interface de sortie plutôt qu'une IP fixée à la main.

```bash
# SNAT classique : adresse publique écrite explicitement
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source 80.12.45.20

# Masquerade : Linux prend automatiquement l'adresse de eth0
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```

Utile quand l'IP externe peut changer : box en DHCP, PPPoE, VM ou routeur de lab.

> [!tip] Dans le langage courant
> Quand on dit « activer le NAT » sur une box, un routeur, Hyper-V ou VMware, c'est presque toujours du **PAT** qui est utilisé : toutes les machines partagent une seule IP externe via des ports différents.

> [!info]
> NAT n'est **pas un mécanisme de sécurité** à lui seul, même s'il réduit l'exposition directe des machines internes. C'est le **pare-feu** qui filtre réellement le trafic.

---

## 6.2 Pare-feu

<iframe width="560" height="315" src="https://www.youtube.com/embed/6Swt51w3EjY?si=50Hhqq4t2pxfzkBG" title="YouTube video player" frameborder="0" allowfullscreen></iframe>

Le **pare-feu** filtre le trafic selon des règles basées sur :
- l'IP source et destination,
- le port,
- le protocole,
- le sens du trafic.

Il peut être :
- **matériel** : appliance, routeur, boitier dédié,
- **logiciel** : Windows Firewall, `iptables`, `nftables`.

### Exemples de règles

- autoriser le web sortant (`80` et `443`)
- bloquer le RDP depuis Internet
- autoriser SSH seulement depuis un sous-réseau d'administration

---

## 6.3 Proxy

<iframe width="560" height="315" src="https://www.youtube.com/embed/MpP02aZPSNQ?si=maEgH3UBc8gr3nLq" title="YouTube video player" frameborder="0" allowfullscreen></iframe>

Un **proxy** s'intercale entre l'utilisateur et Internet.

Ses rôles les plus fréquents :
- filtrer les accès,
- mettre en cache certains contenus,
- journaliser les connexions,
- masquer les postes internes.

---

## 6.4 DMZ — Publier sans exposer tout le LAN

<iframe width="560" height="315" src="https://www.youtube.com/embed/mY-TvNXFHl0?si=WlwaVF_UsjlMw4u5" title="YouTube video player" frameborder="0" allowfullscreen></iframe>

Une **DMZ** (*zone démilitarisée*) est une zone intermédiaire entre Internet et le réseau interne.

On y place les serveurs qui doivent être visibles depuis l'extérieur :
- serveur web,
- serveur mail,
- reverse proxy,
- parfois serveur VPN.

![ch8-dmz-vpn.svg](Ressources/images/ch8-dmz-vpn.svg)

### Pourquoi une DMZ ?

Si un serveur exposé est compromis, l'attaquant n'arrive pas directement sur le réseau interne. La DMZ sert donc de **zone tampon**.

---

## 6.5 VPN — Accès distant sécurisé

Un **VPN** (*Virtual Private Network*) crée un **tunnel chiffré** entre deux points.

### Deux grands usages

|Type|Description|Exemple|
|---|---|---|
|**Accès distant**|Un utilisateur rejoint le réseau d'entreprise|Télétravail|
|**Site-à-site**|Deux réseaux sont reliés en permanence|Agence A ↔ Agence B|

### Protocoles fréquents

|Protocole|Caractéristiques|
|---|---|
|**IPSec**|Très utilisé en entreprise|
|**OpenVPN**|Flexible, open source|
|**WireGuard**|Moderne, simple, performant|
|**L2TP/IPSec**|Souvent présent sur des environnements historiques|

---

## 6.6 Authentification et chiffrement

Un bon réseau ne se contente pas de transporter des paquets. Il doit aussi vérifier **qui** accède à **quoi**.

|Mécanisme|Rôle|
|---|---|
|**Certificats**|Prouver l'identité d'un serveur ou d'un utilisateur|
|**HTTPS / TLS**|Chiffrer les échanges web|
|**SSH**|Accès distant chiffré|
|**WPA2/WPA3-Enterprise**|Authentification Wi-Fi forte|
|**RADIUS**|Centraliser l'authentification réseau|

### Menaces à connaître

|Niveau|Exemple d'attaque|Protection typique|
|---|---|---|
|Application|Phishing, injection|HTTPS, filtrage, bonnes pratiques|
|Transport|Scan de ports, SYN flood|Pare-feu, limitation|
|Réseau|Usurpation IP|ACL, anti-spoofing|
|Liaison|ARP spoofing|Segmentation, inspection ARP|
|Physique|Branchement sauvage, écoute|Contrôle d'accès, chiffrement|

---

> [!success] Résumé du chapitre 6
> - **NAT/PAT** relie les réseaux privés à Internet ; **SNAT/DNAT** = la direction, **statique/dynamique/PAT** = le type de correspondance.
> - Le **pare-feu** applique des règles de contrôle du trafic.
> - Le **proxy** agit comme intermédiaire de filtrage et de journalisation.
> - La **DMZ** permet d'exposer des services tout en protégeant le réseau interne.
> - Le **VPN** ouvre un accès distant chiffré.
> - L'**authentification** et le **chiffrement** complètent la sécurité à tous les niveaux.
