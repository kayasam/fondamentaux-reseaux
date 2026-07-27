---
title: 05. Couche application
---

# Couche application : les services réseau

> [!TIP] Ressources du chapitre
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/05-services-reseau/05-services-reseau-interactif.html" target="_blank">Ouvrir le cours interactif</a>
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/05-services-reseau.md" download>Télécharger ce cours en Markdown</a>
> - [[05-services-reseau/tp/01-debutant|TP débutant]]
> - [[05-services-reseau/tp/02-avance|TP avancé]]

Les couches précédentes permettent de transmettre des données jusqu'au bon programme. La couche application définit maintenant **ce que les programmes se disent** et comment ils rendent un service à l'utilisateur.

Lorsqu'un élève ouvre `https://cours.example`, plusieurs services coopèrent :

1. **DHCP** a fourni la configuration réseau du poste ;
2. **DNS** recherche l'adresse IP associée au nom ;
3. TCP ou QUIC établit une communication avec le serveur ;
4. **TLS** sécurise l'échange HTTPS ;
5. **HTTP** demande et transporte la ressource web.

![application-vue-ensemble.svg](Ressources/images/application-vue-ensemble.svg)

> [!NOTE] Objectifs
> À la fin de ce chapitre, vous saurez expliquer le rôle de DHCP, DNS, HTTP et TLS, lire leurs échanges essentiels et diagnostiquer un service applicatif étape par étape.

---

## 5.1 — Où se trouve la couche application ?

Dans le modèle OSI, les fonctions proches de l'utilisateur sont réparties sur trois couches :

|Couche OSI|Idée principale|Exemples|
|---|---|---|
|7 — Application|Fournir un service réseau au programme|HTTP, DNS, DHCP, SMTP, SSH|
|6 — Présentation|Représenter et protéger les données|formats, encodage, compression, chiffrement|
|5 — Session|Organiser et maintenir un dialogue|état d'une session, reprise, synchronisation|

Le modèle TCP/IP regroupe généralement ces fonctions dans une seule **couche application**. Dans les réseaux réels, un protocole ne correspond pas toujours parfaitement à une seule case du modèle OSI.

![application-couches-hautes.svg](Ressources/images/application-couches-hautes.svg)

### Client, serveur et protocole

Un **client** demande un service. Un **serveur** attend les demandes et fournit les réponses. Le **protocole applicatif** définit les messages qu'ils comprennent.

![application-client-serveur.svg](Ressources/images/application-client-serveur.svg)

> [!IMPORTANT]
> « Client » et « serveur » décrivent des rôles pendant un échange. Une même machine peut héberger plusieurs serveurs et exécuter simultanément des applications clientes.

---

## 5.2 — Le parcours complet d'un accès web

Quand le navigateur reçoit une URL, il ne contacte pas immédiatement le serveur web. Plusieurs dépendances doivent fonctionner dans l'ordre.

![application-parcours-web.svg](Ressources/images/application-parcours-web.svg)

Prenons l'URL :

```text
https://cours.example:443/reseaux/index.html
```

|Partie|Valeur|Rôle|
|---|---|---|
|Schéma|`https`|Protocole et protection attendus|
|Hôte|`cours.example`|Nom du serveur à résoudre|
|Port|`443`|Service de destination, implicite ici|
|Chemin|`/reseaux/index.html`|Ressource demandée|

Une panne apparente du « site web » peut donc venir :

- de la configuration IP ;
- du DNS ;
- du transport ;
- de TLS ou du certificat ;
- de HTTP ou de l'application web.

---

## 5.3 — DHCP : obtenir une configuration IPv4

**DHCP** (*Dynamic Host Configuration Protocol*) fournit automatiquement les paramètres nécessaires à un poste IPv4.

Il peut distribuer :

- une adresse IPv4 ;
- un masque de sous-réseau ;
- une passerelle par défaut ;
- un ou plusieurs serveurs DNS ;
- un nom de domaine ;
- une durée de **bail** ;
- d'autres options selon le réseau.

![application-dhcp-configuration.svg](Ressources/images/application-dhcp-configuration.svg)

DHCPv4 utilise UDP :

- port `68` côté client ;
- port `67` côté serveur.

### DORA : obtenir un nouveau bail

Un client qui ne connaît pas encore son réseau ne peut pas toujours contacter directement le serveur. Les premiers messages peuvent donc être diffusés en broadcast.

1. **DHCPDISCOVER** : le client recherche des serveurs DHCP ;
2. **DHCPOFFER** : un serveur propose une configuration ;
3. **DHCPREQUEST** : le client demande officiellement l'offre choisie ;
4. **DHCPACK** : le serveur confirme le bail.

![application-dhcp-dora.svg](Ressources/images/application-dhcp-dora.svg)

> [!NOTE]
> DORA est un moyen mnémotechnique décrivant l'attribution initiale en DHCPv4. Le protocole comprend d'autres messages : renouvellement, refus, libération ou information complémentaire.

### Étendue, réservation et bail

Le serveur DHCP ne choisit pas une adresse au hasard dans tout le réseau :

- une **étendue** définit la plage distribuable ;
- une **exclusion** retire certaines adresses de cette plage ;
- une **réservation** associe une configuration à un client identifié ;
- le **bail** limite dans le temps l'utilisation de l'adresse ;
- le client tente normalement de renouveler le bail avant son expiration.

Lorsque le serveur se trouve sur un autre sous-réseau, un **relais DHCP** transmet les messages entre le client et le serveur.

![application-dhcp-bail-relai.svg](Ressources/images/application-dhcp-bail-relai.svg)

### En l'absence de DHCP

Certains systèmes IPv4 peuvent choisir automatiquement une adresse **link-local** dans `169.254.0.0/16`, souvent appelée APIPA sous Windows.

Cette adresse peut permettre des échanges directs avec d'autres machines du même lien, mais elle n'est pas routée comme une adresse normale et ne fournit pas à elle seule une passerelle ou un DNS.

> [!TIP] Indice de diagnostic
> Une adresse `169.254.x.x` indique généralement qu'aucun bail IPv4 utilisable n'a été obtenu. Il faut vérifier le serveur, le VLAN, le relais DHCP et le chemin des broadcasts.

> [!NOTE] Et en IPv6 ?
> IPv6 peut utiliser SLAAC, DHCPv6 ou les deux. Le processus DORA présenté ici concerne DHCPv4.

> [!INFO] Références officielles
> [RFC 2131 — DHCPv4](https://www.rfc-editor.org/info/rfc2131/) · [RFC 3927 — IPv4 Link-Local](https://www.rfc-editor.org/info/rfc3927/) · [RFC 9915 — DHCPv6](https://www.rfc-editor.org/info/rfc9915/)

---

## 5.4 — DNS : trouver des informations à partir d'un nom

Le **DNS** (*Domain Name System*) est une base de données distribuée et hiérarchique. Il ne se limite pas à « traduire un nom en IP » : il stocke différents types d'informations associés aux noms de domaine.

Pour obtenir l'adresse de `www.example.com`, l'application interroge généralement le résolveur de son système, qui contacte un **résolveur récursif**.

![application-dns-resolution.svg](Ressources/images/application-dns-resolution.svg)

### Résolveur récursif, serveurs autoritaires et cache

Si la réponse n'est pas déjà en cache, le résolveur peut parcourir la hiérarchie :

1. un serveur **racine** indique les serveurs du domaine de premier niveau ;
2. le serveur du TLD `.com` indique les serveurs autoritaires de `example.com` ;
3. le serveur **autoritaire** fournit l'enregistrement demandé ;
4. le résolveur met temporairement la réponse en cache.

![application-dns-hierarchie-cache.svg](Ressources/images/application-dns-hierarchie-cache.svg)

La durée de conservation dépend notamment du **TTL** de l'enregistrement. Un changement DNS peut donc ne pas être visible immédiatement sur tous les résolveurs.

> [!IMPORTANT]
> Le serveur récursif cherche une réponse pour le client. Le serveur autoritaire publie les données officielles d'une zone. Ce sont deux rôles différents, même si un même logiciel peut être configuré pour plusieurs rôles.

### Lire un nom de domaine

Dans `www.formation.example.` :

- `.` représente la racine DNS ;
- `example` est le domaine de premier niveau ;
- `formation` est un sous-domaine ;
- `www` est ici le nom de l'hôte ou du service.

Le nom complet terminé par le point racine est un **FQDN** (*Fully Qualified Domain Name*).

### Enregistrements courants

![application-dns-enregistrements.svg](Ressources/images/application-dns-enregistrements.svg)

|Type|Rôle|Exemple simplifié|
|---|---|---|
|`A`|Associer un nom à une IPv4|`web.example. → 192.0.2.20`|
|`AAAA`|Associer un nom à une IPv6|`web.example. → 2001:db8::20`|
|`CNAME`|Créer un alias vers un autre nom|`www.example. → web.example.`|
|`MX`|Désigner les serveurs de messagerie|`example. → mail.example.`|
|`NS`|Désigner les serveurs d'une zone|`example. → ns1.example.`|
|`PTR`|Effectuer une résolution inverse|`192.0.2.20 → web.example.`|
|`TXT`|Publier du texte ou des politiques|vérification de domaine, SPF…|

> [!NOTE]
> Un enregistrement `MX` désigne un **nom de serveur**, pas directement une adresse IP. Ce nom doit ensuite être résolu avec un enregistrement `A` ou `AAAA`.

### Transport et confidentialité DNS

Le DNS classique utilise le port `53` en UDP et en TCP. TCP n'est pas réservé aux seuls transferts de zone : il peut également transporter des requêtes ordinaires.

Des variantes chiffrées existent, notamment :

- **DoT** : DNS over TLS ;
- **DoH** : DNS over HTTPS.

Ces variantes protègent l'échange vers le résolveur choisi, mais elles ne rendent pas automatiquement toute réponse DNS digne de confiance.

> [!INFO] Références officielles
> [RFC 1034 — DNS Concepts and Facilities](https://www.rfc-editor.org/info/rfc1034/) · [RFC 1035 — DNS Implementation and Specification](https://www.rfc-editor.org/info/rfc1035/) · [RFC 8484 — DNS over HTTPS](https://www.rfc-editor.org/info/rfc8484/)

---

## 5.5 — HTTP : demander une ressource

**HTTP** (*Hypertext Transfer Protocol*) est un protocole applicatif de type **requête/réponse**. Le client demande une action sur une ressource ; le serveur renvoie un statut, des en-têtes et éventuellement un contenu.

![application-http-requete-reponse.svg](Ressources/images/application-http-requete-reponse.svg)

Exemple HTTP/1.1 simplifié :

```http
GET /reseaux/index.html HTTP/1.1
Host: cours.example
Accept: text/html
```

Réponse possible :

```http
HTTP/1.1 200 OK
Content-Type: text/html
Content-Length: 1250

<!doctype html>
...
```

### Méthodes

|Méthode|Intention habituelle|
|---|---|
|`GET`|Lire une représentation d'une ressource|
|`HEAD`|Obtenir seulement les en-têtes|
|`POST`|Soumettre des données ou déclencher un traitement|
|`PUT`|Créer ou remplacer une ressource à l'URI indiquée|
|`PATCH`|Modifier partiellement une ressource|
|`DELETE`|Demander la suppression d'une ressource|

Le serveur et l'application décident ensuite quelles opérations sont autorisées.

### Familles de codes de statut

![application-http-methodes-codes.svg](Ressources/images/application-http-methodes-codes.svg)

|Famille|Sens|Exemples|
|---|---|---|
|`1xx`|Information provisoire|`100 Continue`|
|`2xx`|Requête traitée avec succès|`200 OK`, `201 Created`|
|`3xx`|Redirection ou cache|`301 Moved Permanently`, `304 Not Modified`|
|`4xx`|La requête ne peut pas être satisfaite telle quelle|`400`, `401`, `403`, `404`|
|`5xx`|Le serveur ou un intermédiaire échoue|`500`, `502`, `503`|

> [!TIP] Pour diagnostiquer
> Un code HTTP prouve que la communication a atteint un serveur HTTP capable de répondre. Un `404` n'est donc pas une panne réseau : le serveur indique qu'il ne trouve pas la ressource demandée.

### HTTP est sans état

Chaque requête HTTP possède une signification qui peut être comprise indépendamment. Les applications web ajoutent cependant de l'état grâce à des mécanismes comme :

- les cookies ;
- les jetons ;
- les identifiants de session ;
- une base de données côté serveur.

### HTTP/1.1, HTTP/2 et HTTP/3

Les grandes versions conservent les mêmes principes de méthodes, ressources et statuts, mais leur transport diffère :

- HTTP/1.1 utilise généralement TCP ;
- HTTP/2 multiplexe plusieurs échanges sur une connexion TCP ;
- HTTP/3 utilise QUIC au-dessus d'UDP.

> [!INFO] Références officielles
> [RFC 9110 — HTTP Semantics](https://www.rfc-editor.org/info/rfc9110/) · [RFC 9114 — HTTP/3](https://www.rfc-editor.org/info/rfc9114/)

---

## 5.6 — HTTPS et TLS : protéger le canal

**HTTPS** correspond à HTTP utilisé dans un canal sécurisé par **TLS**.

TLS apporte principalement :

- la **confidentialité** : le contenu est chiffré ;
- l'**intégrité** : une modification du trafic est détectée ;
- l'**authentification du serveur** : le client vérifie l'identité présentée ;
- éventuellement, l'authentification du client par certificat.

![application-https-tls.svg](Ressources/images/application-https-tls.svg)

### Le rôle du certificat

Pendant l'établissement TLS, le serveur présente généralement une chaîne de certificats. Le client vérifie notamment :

- que le certificat correspond au nom demandé ;
- qu'il est dans sa période de validité ;
- qu'il mène à une autorité de certification reconnue ;
- que les signatures de la chaîne sont valides.

![application-certificat.svg](Ressources/images/application-certificat.svg)

> [!WARNING]
> Le cadenas HTTPS signifie que le canal est protégé et que l'identité présentée a été vérifiée selon les règles du certificat. Il ne garantit pas que le contenu du site est honnête, sans erreur ou sans logiciel malveillant.

> [!IMPORTANT]
> TLS protège les données en transit entre les extrémités TLS. Il ne protège pas un poste client compromis, un serveur piraté ou les données après leur déchiffrement par l'application.

> [!INFO] Référence officielle
> [RFC 9846 — TLS 1.3](https://www.rfc-editor.org/info/rfc9846/)

---

## 5.7 — Autres services applicatifs courants

Il est plus utile de classer les protocoles par service que d'apprendre une longue liste de ports isolés.

![application-protocoles-courants.svg](Ressources/images/application-protocoles-courants.svg)

|Besoin|Protocole|Transport et port habituels|Remarque|
|---|---|---|---|
|Envoyer un courriel entre serveurs|SMTP|TCP/25|Transport de messages|
|Soumettre un courriel|SMTP Submission|TCP/587|Authentification utilisateur habituelle|
|Synchroniser une boîte mail|IMAP / IMAPS|TCP/143 ou 993|993 utilise TLS implicitement|
|Télécharger une boîte mail|POP3 / POP3S|TCP/110 ou 995|Moins orienté synchronisation|
|Administrer en ligne de commande|SSH|TCP/22|Canal chiffré|
|Transférer via SSH|SFTP|TCP/22|Protocole différent de FTP|
|Partager des fichiers Windows|SMB|TCP/445|Fichiers et imprimantes|
|Synchroniser l'heure|NTP|UDP/123|L'heure correcte aide les journaux et certificats|
|Superviser des équipements|SNMP|UDP/161 et 162|Préférer SNMPv3 lorsque la sécurité compte|
|Bureau distant Windows|RDP|TCP et UDP/3389|Transport variable selon les fonctions|

### FTP, FTPS et SFTP ne sont pas synonymes

- **FTP** est un protocole historique utilisant plusieurs connexions ;
- **FTPS** ajoute TLS à FTP ;
- **SFTP** est un protocole de transfert fourni par SSH.

> [!WARNING]
> Les ports indiqués sont des valeurs habituelles, pas une preuve du protocole réellement présent. Un administrateur peut choisir un autre port.

---

## 5.8 — Encapsulation d'une requête applicative

Une requête HTTP n'est pas envoyée directement sous forme de signal. Chaque couche ajoute son propre en-tête avant la transmission.

![application-encapsulation.svg](Ressources/images/application-encapsulation.svg)

À l'émission :

```text
Requête HTTP
  → données TLS
    → segment TCP
      → paquet IP
        → trame Ethernet ou Wi-Fi
          → signal
```

À la réception, le serveur retire les informations dans l'ordre inverse puis remet la requête à l'application web.

> [!NOTE]
> Avec HTTP/3, QUIC et UDP remplacent TCP dans cette chaîne. Le principe général d'encapsulation reste le même.

---

## 5.9 — Diagnostiquer un service applicatif

Le diagnostic doit suivre les dépendances dans l'ordre. Tester uniquement `ping` ne suffit pas.

![application-diagnostic.svg](Ressources/images/application-diagnostic.svg)

### 1. Vérifier la configuration reçue

Sous Windows :

```powershell
ipconfig /all
```

Sous Linux :

```bash
ip address
ip route
resolvectl status
```

Contrôlez l'adresse, le préfixe, la passerelle et les serveurs DNS.

### 2. Tester le DNS

Sous Windows PowerShell :

```powershell
Resolve-DnsName cours.example
```

Sous Windows ou Linux :

```bash
nslookup cours.example
```

Avec `dig` :

```bash
dig cours.example A
dig cours.example AAAA
dig @192.0.2.53 cours.example
```

### 3. Tester le port puis HTTP

Sous Windows :

```powershell
Test-NetConnection cours.example -Port 443
```

Avec `curl` :

```bash
curl -I https://cours.example
curl -v https://cours.example
```

`-I` affiche les en-têtes de réponse. `-v` montre davantage d'étapes, notamment la connexion et des informations TLS.

### 4. Examiner TLS

Lorsque OpenSSL est disponible :

```bash
openssl s_client -connect cours.example:443 -servername cours.example
```

L'option `-servername` fournit le nom attendu au serveur TLS, ce qui est important lorsqu'une même adresse IP héberge plusieurs sites.

### Interpréter les résultats

|Résultat|Conclusion ou étape suivante|
|---|---|
|Adresse `169.254.x.x`|Commencer par DHCP et la connectivité locale|
|Connexion par IP réussie mais nom en échec|Examiner DNS|
|Nom résolu mais port fermé|Examiner service, écoute, pare-feu et chemin réseau|
|Erreur de certificat|Examiner le nom, la date, la chaîne de confiance et l'horloge|
|HTTP `404`|La ressource ou le routage applicatif est incorrect|
|HTTP `502` ou `503`|Le frontal répond mais son service amont est indisponible ou saturé|

> [!TIP] Méthode
> Configuration → DNS → transport → TLS → HTTP → application. Arrêtez-vous au premier niveau qui ne fonctionne pas correctement.

---

## 5.10 — Relier les services

![application-synthese.svg](Ressources/images/application-synthese.svg)

Pour afficher une page HTTPS, le poste doit être capable de répondre successivement à ces questions :

1. ai-je une configuration IP utilisable ?
2. quel résolveur DNS dois-je interroger ?
3. quelle adresse correspond au nom demandé ?
4. puis-je joindre le service sur le bon port ?
5. l'identité TLS et le certificat sont-ils acceptés ?
6. quelle réponse HTTP et applicative le serveur renvoie-t-il ?

> [!SUCCESS] À retenir
> - La couche application définit les messages et services visibles par les programmes.
> - DHCP fournit une configuration pour une durée déterminée.
> - DNS est une base distribuée, hiérarchique et mise en cache.
> - HTTP manipule des ressources avec des méthodes et renvoie des codes de statut.
> - TLS protège le canal HTTPS et authentifie généralement le serveur.
> - Un diagnostic efficace suit les dépendances de la configuration jusqu'à l'application.

Le chapitre suivant étudie comment contrôler et protéger ces accès : filtrage, segmentation, authentification, VPN et exposition sécurisée des services.
