---
title: Quiz final — Fondamentaux réseaux
publier: true
---

# Quiz final — Fondamentaux réseaux

> [!TIP] Version interactive
> [Ouvrir le quiz HTML](quiz-final.html) — progression sauvegardée, score et corrigé après validation.

**Nom et prénom :** ____________________

**Date :** ____________________

- **40 questions**, avec **une seule bonne réponse** par question.
- **Durée conseillée : 50 minutes.**
- **Barème :** 1 point par bonne réponse ; 0 point pour une réponse fausse, absente ou multiple. Total : **40 points**. Note sur 20 : total ÷ 2.
- Répondez sans consulter le cours. Un brouillon est autorisé pour les calculs d’adressage.
- Reportez la lettre choisie dans la grille. Les questions couvrent les sept chapitres de la formation.

---

## Question 1

Dans une architecture client-serveur, quel rôle joue le client ?

- **A.** Il attribue obligatoirement les adresses IP.
- **B.** Il choisit les routes entre les réseaux.
- **C.** Il initie une demande auprès d’un service.
- **D.** Il fournit toujours toutes les ressources du réseau.

---

## Question 2

Des postes sont chacun reliés par un câble à un switch central. Quelle est la topologie physique ?

- **A.** Un anneau.
- **B.** Un bus.
- **C.** Un maillage complet.
- **D.** Une étoile.

---

## Question 3

Quel ordre décrit l’encapsulation d’un message applicatif transporté par TCP sur Ethernet ?

- **A.** Bits → trame → paquet → segment → données.
- **B.** Données → trame → segment → paquet → bits.
- **C.** Données → segment → paquet → trame → bits.
- **D.** Données → paquet → segment → bits → trame.

---

## Question 4

Lors d’un appel audio, le délai varie fortement d’un paquet au suivant. Quelle mesure décrit cette variation ?

- **A.** La bande passante nominale.
- **B.** La disponibilité.
- **C.** La gigue.
- **D.** Le débit utile.

---

## Question 5

Une liaison doit relier deux bâtiments distants de 300 mètres dans un environnement fortement perturbé électromagnétiquement. Quel support est le plus adapté ?

- **A.** Un câble cuivre non blindé posé près des moteurs.
- **B.** Une fibre optique avec des équipements adaptés à la distance.
- **C.** Un unique câble Cat 5e de 300 mètres.
- **D.** Un unique câble Cat 6a de 300 mètres.

---

## Question 6

Pour une liaison Ethernet cuivre standard à 1 Gbit/s en Cat 5e, quelle longueur maximale du canal est généralement retenue ?

- **A.** 10 mètres, cordons compris.
- **B.** 100 mètres, cordons compris.
- **C.** 300 mètres, cordons compris.
- **D.** 1 000 mètres, cordons compris.

---

## Question 7

Que permet une liaison Ethernet en full-duplex ?

- **A.** Doubler automatiquement la longueur maximale du câble.
- **B.** Émettre uniquement quand le destinataire se tait.
- **C.** Partager un domaine de collision comme avec un hub.
- **D.** Émettre et recevoir simultanément.

---

## Question 8

Un poste ne présente aucun voyant de lien Ethernet. Quelle vérification est prioritaire ?

- **A.** Vider le cache du navigateur.
- **B.** Contrôler le câble, les connecteurs, le port et l’alimentation des équipements.
- **C.** Modifier le serveur DNS du poste.
- **D.** Changer la route par défaut.

---

## Question 9

Comment un switch Ethernet apprend-il les adresses de sa table MAC ?

- **A.** En associant toutes les MAC à son port de liaison montante.
- **B.** En lisant uniquement l’adresse IP destination.
- **C.** En interrogeant systématiquement un serveur DNS.
- **D.** En lisant l’adresse MAC source des trames reçues et leur port d’entrée.

---

## Question 10

Quel est l’objectif principal de STP dans un réseau de switches comportant des liens redondants ?

- **A.** Éviter les boucles de couche 2 en bloquant logiquement certains chemins.
- **B.** Chiffrer les trames entre switches.
- **C.** Attribuer une adresse IP à chaque switch.
- **D.** Remplacer les VLAN par des sous-réseaux IPv6.

---

## Question 11

Quel est l’effet principal de la création de deux VLAN distincts sur un switch ?

- **A.** Augmenter automatiquement le débit des interfaces.
- **B.** Chiffrer automatiquement les échanges entre les postes.
- **C.** Séparer les domaines de diffusion de couche 2.
- **D.** Permettre tous les échanges inter-VLAN sans routeur.

---

## Question 12

Un lien entre deux switches doit transporter les VLAN 10, 20 et 30. Quel mode convient à ce lien ?

- **A.** Un port access affecté uniquement au VLAN 20.
- **B.** Un port access affecté uniquement au VLAN 10.
- **C.** Un port désactivé dans tous les VLAN.
- **D.** Un trunk autorisant les VLAN concernés.

---

## Question 13

Quel est le rôle de LACP ?

- **A.** Négocier l’agrégation de plusieurs liens physiques en un lien logique.
- **B.** Authentifier les utilisateurs sur le Wi-Fi.
- **C.** Éviter les boucles en choisissant un root bridge.
- **D.** Découvrir l’adresse IP d’un serveur DNS.

---

## Question 14

Quel protocole standard permet à un équipement de découvrir ses voisins directement connectés et leurs ports ?

- **A.** DHCP.
- **B.** OSPF.
- **C.** NTP.
- **D.** LLDP.

---

## Question 15

Laquelle de ces adresses appartient à une plage IPv4 privée ?

- **A.** 192.169.1.10.
- **B.** 11.0.0.10.
- **C.** 172.32.5.10.
- **D.** 172.20.5.10.

---

## Question 16

Quel masque décimal correspond au préfixe IPv4 /26 ?

- **A.** 255.255.255.192.
- **B.** 255.255.255.0.
- **C.** 255.255.255.128.
- **D.** 255.255.255.224.

---

## Question 17

Combien d’adresses hôtes sont utilisables dans un sous-réseau IPv4 /27 classique, en excluant réseau et broadcast ?

- **A.** 32.
- **B.** 14.
- **C.** 30.
- **D.** 62.

---

## Question 18

Quelle est l’adresse réseau du poste 192.168.10.77/26 ?

- **A.** 192.168.10.128.
- **B.** 192.168.10.76.
- **C.** 192.168.10.0.
- **D.** 192.168.10.64.

---

## Question 19

Avec un plan VLSM, quel est le sous-réseau IPv4 le plus petit permettant d’attribuer une adresse à 50 interfaces, hors réseau et broadcast ?

- **A.** Un /27.
- **B.** Un /26.
- **C.** Un /25.
- **D.** Un /28.

---

## Question 20

Un poste IPv4 Ethernet veut joindre un serveur situé hors de son sous-réseau. Une route par défaut est configurée et le cache ARP est vide. Quelle MAC cherche-t-il par ARP ?

- **A.** La MAC du dernier routeur avant le serveur distant.
- **B.** La MAC de sa passerelle sur le réseau local.
- **C.** La MAC du serveur distant à travers Internet.
- **D.** La MAC du résolveur DNS, quel que soit le flux.

---

## Question 21

Une table de routage contient 0.0.0.0/0 via R1, 10.0.0.0/8 via R2 et 10.20.0.0/16 via R3. Quelle route est choisie pour 10.20.4.8 ?

- **A.** Les trois routes sont utilisées simultanément.
- **B.** 0.0.0.0/0 via R1.
- **C.** 10.0.0.0/8 via R2.
- **D.** 10.20.0.0/16 via R3.

---

## Question 22

Dans OSPF, quel critère sert à comparer les chemins pour atteindre une destination ?

- **A.** Le coût cumulé du chemin.
- **B.** L’ordre alphabétique des interfaces.
- **C.** Le plus grand nombre de sauts.
- **D.** Le nombre de caractères du nom du routeur.

---

## Question 23

Quelle affirmation sur IPv6 est correcte ?

- **A.** Une adresse IPv6 contient 64 bits et nécessite systématiquement du NAT.
- **B.** Une adresse IPv6 contient 32 bits et utilise ARP.
- **C.** Une adresse IPv6 contient 128 bits et le protocole n’utilise pas de broadcast.
- **D.** Une adresse IPv6 contient 48 bits et correspond à une adresse MAC.

---

## Question 24

À quoi sert principalement un numéro de port TCP ou UDP ?

- **A.** À identifier le service ou le point de communication applicatif sur un hôte.
- **B.** À définir le masque de sous-réseau.
- **C.** À identifier le câble branché au switch.
- **D.** À remplacer l’adresse IP de destination.

---

## Question 25

Quelle séquence établit normalement une connexion TCP ?

- **A.** SYN → SYN-ACK → ACK.
- **B.** ACK → SYN → FIN.
- **C.** FIN → FIN-ACK → SYN.
- **D.** SYN → FIN → ACK.

---

## Question 26

Quelle affirmation décrit UDP ?

- **A.** Il retransmet systématiquement les datagrammes perdus.
- **B.** Il interdit aux applications d’ajouter des mécanismes de fiabilité.
- **C.** Il établit une connexion par SYN, SYN-ACK et ACK.
- **D.** Il transporte des datagrammes sans garantir lui-même leur livraison ni leur ordre.

---

## Question 27

Un serveur répond au ping, mais son service HTTPS sur TCP/443 reste inaccessible. Quelle conclusion est justifiée ?

- **A.** Le serveur DNS est forcément responsable.
- **B.** Tous les services du serveur fonctionnent forcément.
- **C.** La réponse ICMP ne prouve pas que le port TCP/443 est accessible ni que le service fonctionne.
- **D.** Le câble réseau du serveur est nécessairement débranché.

---

## Question 28

Dans quel ordre se déroule l’attribution initiale d’un bail DHCPv4 selon DORA ?

- **A.** Offer → Discover → Acknowledge → Request.
- **B.** Discover → Request → Offer → Acknowledge.
- **C.** Discover → Offer → Request → Acknowledge.
- **D.** Request → Acknowledge → Discover → Offer.

---

## Question 29

Un client DHCP se trouve dans un autre sous-réseau IPv4 que le serveur. Quel mécanisme permet de transmettre ses demandes initiales sans étendre le VLAN ?

- **A.** Un relais DHCP sur l’équipement de couche 3.
- **B.** Une simple entrée dans la table MAC.
- **C.** Une règle STP sur le poste.
- **D.** Un enregistrement DNS MX.

---

## Question 30

Quel type d’enregistrement DNS associe un nom à une adresse IPv6 ?

- **A.** PTR.
- **B.** AAAA.
- **C.** A.
- **D.** MX.

---

## Question 31

Un poste joint un serveur par son adresse IP, mais la résolution de son nom échoue. Quel service examiner en priorité ?

- **A.** DNS.
- **B.** LACP.
- **C.** STP.
- **D.** NAT statique.

---

## Question 32

Quel mécanisme protège le canal de communication HTTPS ?

- **A.** DHCP, qui signe tous les contenus web.
- **B.** DNS, qui chiffre automatiquement les pages.
- **C.** TLS, avec vérification de l’identité du serveur à l’aide de son certificat.
- **D.** HTTP seul, grâce au code de statut 200.

---

## Question 33

Un serveur web renvoie le statut HTTP 404. Que signifie ce résultat ?

- **A.** La connexion TCP n’a jamais pu être établie.
- **B.** La ressource demandée n’a pas été trouvée.
- **C.** Le câble du client est forcément coupé.
- **D.** Le serveur DNS n’a pas répondu.

---

## Question 34

Plusieurs postes privés partagent une même adresse IPv4 publique pour leurs connexions sortantes. Quel mécanisme distingue leurs flux au niveau de la traduction ?

- **A.** Le PAT, en utilisant notamment les numéros de ports.
- **B.** DNS, en créant un nom par connexion.
- **C.** STP, en bloquant un lien par poste.
- **D.** LLDP, en annonçant les ports du switch.

---

## Question 35

Qu’apporte un pare-feu stateful par rapport à un simple filtrage sans état ?

- **A.** Il supprime le besoin de routage entre réseaux.
- **B.** Il remplace tous les certificats TLS.
- **C.** Il autorise automatiquement tout le trafic entrant.
- **D.** Il suit l’état des communications et reconnaît leur trafic de réponse.

---

## Question 36

Sur un pare-feu appliquant la première règle correspondante, on place : 1. autoriser tout trafic de 10.0.0.0/24 vers toute destination ; 2. refuser TCP/22 de 10.0.0.0/24 vers 10.1.0.10. Que devient une nouvelle connexion TCP/22 de 10.0.0.5 vers 10.1.0.10 ?

- **A.** Elle est refusée car les deux règles s’annulent.
- **B.** Elle est autorisée par la règle 1.
- **C.** Elle est refusée par la règle 2.
- **D.** Elle est autorisée uniquement si le port source vaut aussi 22.

---

## Question 37

Pourquoi placer un serveur web public dans une DMZ avec des flux vers le LAN strictement filtrés ?

- **A.** Pour rendre inutile l’authentification des administrateurs.
- **B.** Pour limiter l’accès au réseau interne si le serveur exposé est compromis.
- **C.** Pour supprimer le besoin de mises à jour du serveur.
- **D.** Pour autoriser automatiquement tous les accès depuis Internet vers le LAN.

---

## Question 38

Une entreprise souhaite relier les réseaux de deux agences à travers Internet par un tunnel protégé entre leurs passerelles. Quelle solution correspond à ce besoin ?

- **A.** Un VPN site à site.
- **B.** Une agrégation LACP sur chaque imprimante.
- **C.** Un simple trunk 802.1Q entre les postes.
- **D.** Un enregistrement DNS CNAME.

---

## Question 39

Quel couple constitue deux facteurs d’authentification de catégories différentes ?

- **A.** Un mot de passe et un second mot de passe.
- **B.** Un mot de passe et une clé de sécurité physique.
- **C.** Un code PIN et une question secrète.
- **D.** Deux réponses à des questions secrètes.

---

## Question 40

Dans une infrastructure 802.1X avec RADIUS, quel rôle joue généralement le switch ou le point d’accès ?

- **A.** Le serveur DNS, qui attribue les droits.
- **B.** Le serveur DHCP, qui vérifie le mot de passe.
- **C.** L’authenticator, qui contrôle l’accès et relaie les échanges d’authentification.
- **D.** Le supplicant, qui représente le poste demandant l’accès.

---

## Grille de réponses

| Question | Réponse | Question | Réponse | Question | Réponse | Question | Réponse |
|---:|:---:|---:|:---:|---:|:---:|---:|:---:|
| 1 | | 11 | | 21 | | 31 | |
| 2 | | 12 | | 22 | | 32 | |
| 3 | | 13 | | 23 | | 33 | |
| 4 | | 14 | | 24 | | 34 | |
| 5 | | 15 | | 25 | | 35 | |
| 6 | | 16 | | 26 | | 36 | |
| 7 | | 17 | | 27 | | 37 | |
| 8 | | 18 | | 28 | | 38 | |
| 9 | | 19 | | 29 | | 39 | |
| 10 | | 20 | | 30 | | 40 | |
