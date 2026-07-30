---
title: 06. Sécurité réseau
---

# Sécurité réseau et contrôle des accès

> [!TIP] Ressources du chapitre
> - <a class="chapter-resource chapter-resource--download" href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/06-securite-et-acces.md" download>Télécharger le cours en Markdown</a>
> - [[06-securite-et-acces/tp/index|Exercices pratiques]]
> - [[06-securite-et-acces/note-nat|Note complémentaire sur le NAT]]
> - [[Ressources/cisco-packet-tracer-commandes|Fiche pratique Cisco CLI]]

Un réseau fonctionnel n'est pas automatiquement un réseau sûr. Chaque service accessible crée une possibilité d'usage légitime, mais aussi une **surface d'attaque**.

La sécurité ne repose donc pas sur un produit unique. Elle combine :

- la réduction des services exposés ;
- la segmentation des réseaux ;
- le filtrage des flux ;
- le chiffrement des communications ;
- l'authentification et l'autorisation ;
- la journalisation et la surveillance.

![security-vue-ensemble.svg](Ressources/images/security-vue-ensemble.svg)

> [!NOTE] Objectifs
> À la fin de ce chapitre, vous saurez distinguer NAT et filtrage, lire une politique de pare-feu, expliquer DMZ, proxy, VPN et 802.1X, puis diagnostiquer un accès refusé sans désactiver la sécurité au hasard.

---

## 6.1 — Risque et défense en profondeur

La sécurité commence par quatre mots différents :

|Notion|Question|Exemple|
|---|---|---|
|**Actif**|Que veut-on protéger ?|données, serveur, disponibilité du réseau|
|**Menace**|Qu'est-ce qui pourrait causer un dommage ?|attaquant, erreur, panne, logiciel malveillant|
|**Vulnérabilité**|Quelle faiblesse pourrait être exploitée ?|mot de passe faible, service non corrigé|
|**Risque**|Quelle est la vraisemblance et l'impact du scénario ?|vol de données ou interruption du service|

Les protections cherchent principalement à préserver :

- la **confidentialité** : seules les personnes autorisées lisent les données ;
- l'**intégrité** : les modifications non autorisées sont empêchées ou détectées ;
- la **disponibilité** : le service reste utilisable lorsque nécessaire.

La **défense en profondeur** combine plusieurs contrôles. Si une protection échoue, les suivantes limitent encore l'attaque.

![security-risque-defense.svg](Ressources/images/security-risque-defense.svg)

> [!IMPORTANT]
> Aucun contrôle n'est parfait. Une sauvegarde protège la disponibilité des données, mais ne remplace ni le pare-feu, ni les correctifs, ni l'authentification.

### Moindre privilège et refus par défaut

Deux principes guident les règles :

- accorder uniquement les accès nécessaires au travail ;
- refuser ce qui n'a pas été explicitement autorisé.

Une architecture **Zero Trust** ajoute l'idée qu'un emplacement « dans le LAN » ne suffit pas à rendre un utilisateur ou un équipement digne de confiance. Chaque accès à une ressource doit être évalué selon l'identité, le contexte et la politique.

> [!INFO] Référence officielle
> [NIST SP 800-207 — Zero Trust Architecture](https://www.nist.gov/publications/zero-trust-architecture-0)

---

## 6.2 — NAT et PAT : traduire, pas sécuriser

Le **NAT** modifie des adresses IP lors du passage d'un paquet. Le **PAT**, aussi appelé NAPT ou NAT overload, traduit également les ports afin que plusieurs flux partagent une même adresse.

Il faut distinguer deux classifications :

- **SNAT / DNAT** indiquent quelle adresse est modifiée ;
- **statique / dynamique / PAT** indiquent comment la correspondance est créée.

![security-nat-pat.svg](Ressources/images/security-nat-pat.svg)

### SNAT et PAT en sortie

Un poste privé contacte Internet :

```text
192.168.1.10:51500
       ↓ PAT
198.51.100.20:61001
```

Le routeur conserve une table permettant de traduire la réponse dans l'autre sens.

### DNAT et publication

Une règle de redirection peut modifier la destination :

```text
198.51.100.20:443
       ↓ DNAT
192.168.50.10:443
```

Cette traduction rend le service atteignable, mais **n'indique pas à elle seule qui devrait être autorisé**.

> [!WARNING] NAT n'est pas un pare-feu
> L'absence de correspondance entrante peut réduire l'exposition accidentelle, mais c'est une conséquence du fonctionnement. La politique de sécurité doit être exprimée par des règles de filtrage explicites.

> [!NOTE] Masquerade sous Linux
> `MASQUERADE` est une forme pratique de SNAT qui prend automatiquement l'adresse de l'interface de sortie, utile lorsque cette adresse peut changer.

> [!INFO] Référence officielle
> [RFC 3022 — Traditional NAT](https://www.rfc-editor.org/info/rfc3022/)

---

## 6.3 — ACL et pare-feu : décider quels flux passent

Une **ACL** est une liste de règles autorisant ou refusant du trafic selon des champs comme les adresses, le protocole et les ports.

Un **pare-feu** met en œuvre une politique de sécurité entre des hôtes ou des zones. Selon sa technologie, il peut examiner :

- les adresses IP et les ports ;
- le protocole et le sens du flux ;
- l'état d'une connexion ;
- l'interface ou la zone ;
- parfois l'utilisateur ou le protocole applicatif.

![security-parefeu-regles.svg](Ressources/images/security-parefeu-regles.svg)

### Filtrage sans état et avec état

- Un filtre **stateless** examine chaque paquet selon les règles, sans mémoriser la connexion.
- Un pare-feu **stateful** maintient une table d'état et reconnaît les paquets appartenant à une communication déjà autorisée.

Cela permet généralement d'autoriser une connexion sortante et son trafic de réponse sans ouvrir indistinctement toutes les connexions entrantes.

### Lire une règle

Une règle complète répond au minimum à :

```text
zone source → zone destination
adresse source → adresse destination
protocole + port
action
journalisation éventuelle
```

Exemple :

```text
ADMIN → SERVEURS
10.10.10.0/24 → 10.20.0.10
TCP/22
AUTORISER + JOURNALISER
```

> [!IMPORTANT] Ordre des règles
> Sur de nombreux équipements, la première règle correspondante décide. Une règle générale placée avant une règle précise peut donc produire un résultat inattendu.

> [!TIP]
> Une politique lisible indique le besoin métier dans son commentaire, utilise des objets nommés et se termine par un refus explicite ou implicite documenté.

> [!INFO] Référence officielle
> [NIST SP 800-41 Rev. 1 — Guidelines on Firewalls and Firewall Policy](https://csrc.nist.gov/pubs/sp/800/41/r1/final)

---

## 6.4 — Segmenter le réseau et construire une DMZ

La segmentation sépare les équipements selon leur rôle ou leur niveau de confiance :

- postes utilisateurs ;
- serveurs internes ;
- administration ;
- invités ;
- objets connectés ;
- services exposés.

Un VLAN crée une séparation de couche 2. Le trafic entre VLAN passe par un équipement de couche 3, où des ACL ou un pare-feu peuvent appliquer la politique.

Une **DMZ** est une zone destinée aux services qui doivent recevoir des connexions depuis un réseau moins fiable, souvent Internet.

![security-segmentation-dmz.svg](Ressources/images/security-segmentation-dmz.svg)

Une politique minimale peut être :

|Flux|Décision|
|---|---|
|Internet → serveur web DMZ en HTTPS|Autorisé|
|Internet → LAN interne|Refusé|
|DMZ → base de données interne sur le port nécessaire|Autorisé de façon précise|
|DMZ → reste du LAN|Refusé|
|Administration → serveur DMZ en SSH|Autorisé depuis le réseau d'administration|

> [!WARNING]
> Une DMZ ne rend pas le serveur sûr. Elle limite surtout les déplacements possibles si ce serveur est compromis.

> [!IMPORTANT]
> Un VLAN seul ne constitue pas une politique de sécurité. Sans contrôle inter-VLAN, la segmentation peut seulement déplacer les équipements dans des domaines de diffusion différents.

---

## 6.5 — Proxy direct et reverse proxy

Un proxy termine une communication puis en ouvre une autre. Il agit donc comme intermédiaire applicatif.

![security-proxy.svg](Ressources/images/security-proxy.svg)

### Forward proxy

Placé côté clients, il peut :

- contrôler les sorties web ;
- authentifier les utilisateurs ;
- journaliser les destinations ;
- appliquer des politiques ;
- parfois mettre des réponses en cache.

### Reverse proxy

Placé devant les serveurs, il peut :

- publier une adresse unique ;
- terminer TLS ;
- répartir la charge ;
- masquer l'organisation des serveurs internes ;
- appliquer des limites et des contrôles applicatifs.

> [!IMPORTANT]
> Un proxy n'est pas automatiquement un dispositif de sécurité complet. Sa valeur dépend de sa configuration, de ses mises à jour, des journaux et des contrôles réellement activés.

---

## 6.6 — VPN : protéger un trafic entre deux points

Un **VPN** crée une association protégée à travers un réseau non maîtrisé. Il apporte généralement confidentialité, intégrité et authentification des extrémités.

![security-vpn.svg](Ressources/images/security-vpn.svg)

### Accès distant

Un utilisateur établit un tunnel entre son équipement et une passerelle VPN d'entreprise. La politique détermine ensuite les ressources accessibles.

### Site à site

Deux passerelles relient des réseaux distants. Les machines peuvent communiquer sans exécuter individuellement un client VPN.

### Tunnel complet ou split tunneling

- **Tunnel complet** : le trafic du client passe par l'entreprise ;
- **split tunneling** : seul le trafic destiné aux ressources définies passe dans le VPN.

Le split tunneling peut réduire la charge et la latence, mais il exige une politique claire : le poste utilise simultanément le réseau local et le réseau d'entreprise.

> [!WARNING]
> Un VPN protège le trajet jusqu'à son extrémité. Il ne corrige pas une machine infectée et n'autorise pas automatiquement l'utilisateur à toutes les ressources.

Protocoles ou solutions courants : IPsec/IKEv2, TLS VPN, OpenVPN et WireGuard. Ils n'ont pas tous la même architecture ni les mêmes mécanismes.

> [!INFO] Référence officielle
> [RFC 4301 — Security Architecture for IPsec](https://www.rfc-editor.org/info/rfc4301/)

---

## 6.7 — Identifier, authentifier et autoriser

Trois questions doivent rester distinctes :

- **identification** : « qui prétendez-vous être ? » ;
- **authentification** : « comment le prouvez-vous ? » ;
- **autorisation** : « quelles actions pouvez-vous effectuer ? ».

Le modèle **AAA** ajoute la traçabilité :

- **Authentication** : vérifier l'identité ;
- **Authorization** : décider les permissions ;
- **Accounting** : enregistrer les événements d'accès.

![security-aaa-8021x.svg](Ressources/images/security-aaa-8021x.svg)

### MFA

Une authentification multifacteur combine des facteurs de catégories différentes :

- quelque chose que l'on **connaît** ;
- quelque chose que l'on **possède** ;
- quelque chose que l'on **est**.

Deux mots de passe ne constituent donc pas deux facteurs différents.

### 802.1X et RADIUS

802.1X contrôle l'accès à un port filaire ou Wi-Fi avant d'accorder le service réseau :

1. le **supplicant** demande l'accès ;
2. le switch ou point d'accès joue l'**authenticator** ;
3. le serveur d'authentification, souvent RADIUS, accepte ou refuse ;
4. le réseau peut ensuite appliquer un VLAN ou une politique.

> [!INFO] Références officielles
> [IEEE 802.1X-2020 — Port-Based Network Access Control](https://standards.ieee.org/ieee/802.1X/7345/) · [RFC 2865 — RADIUS](https://www.rfc-editor.org/info/rfc2865/) · [NIST SP 800-63-4 — Digital Identity Guidelines](https://www.nist.gov/publications/nist-sp-800-63-4-digital-identity-guidelines)

---

## 6.8 — Sécuriser le Wi-Fi

Un réseau radio peut être reçu au-delà des murs. Il faut donc protéger l'accès et les données sans compter sur la discrétion du signal.

![security-wifi.svg](Ressources/images/security-wifi.svg)

|Mode|Principe|Contexte|
|---|---|---|
|WPA2/WPA3-Personal|Secret partagé|domicile ou petit réseau|
|WPA2/WPA3-Enterprise|Authentification individuelle, souvent 802.1X/RADIUS|entreprise|
|Réseau invité|Zone isolée avec politique limitée|visiteurs|

Bonnes pratiques :

- préférer WPA3 lorsque tous les équipements le prennent correctement en charge ;
- utiliser un secret robuste en mode Personal ;
- éviter un même secret partagé par toute une grande organisation ;
- isoler les invités et les équipements peu fiables ;
- désactiver les standards anciens et vulnérables ;
- vérifier le certificat du serveur d'authentification en mode Enterprise.

> [!WARNING]
> Masquer le SSID ou filtrer les adresses MAC ne remplace pas WPA2/WPA3. Ces informations peuvent être observées ou usurpées.

---

## 6.9 — Menaces et protections complémentaires

Une menace n'est pas liée à une seule couche. Il faut choisir des contrôles adaptés au scénario.

![security-menaces-protections.svg](Ressources/images/security-menaces-protections.svg)

|Scénario|Effet recherché|Protections possibles|
|---|---|---|
|Hameçonnage|Voler des identifiants|sensibilisation, MFA résistante au phishing, filtrage|
|Service vulnérable|Exécuter du code ou voler des données|correctifs, réduction de surface, isolation|
|Usurpation ARP|Intercepter du trafic local|segmentation, protections du switch, chiffrement|
|Scan de ports|Découvrir les services exposés|réduire l'exposition, filtrer, surveiller|
|Déni de service|Épuiser une ressource|limitation, capacité, protection amont|
|Équipement non autorisé|Accéder au réseau|802.1X, contrôle physique, inventaire|

### IDS et IPS

- un **IDS** détecte et alerte ;
- un **IPS** peut bloquer automatiquement certains événements.

Ils complètent le pare-feu, mais génèrent parfois des faux positifs et nécessitent une politique de surveillance.

> [!TIP] Réduire la surface d'attaque
> Désactiver un service inutile est souvent préférable à l'exposer puis tenter de le protéger avec plusieurs règles.

---

## 6.10 — Journaliser et diagnostiquer un accès refusé

La sécurité doit produire des traces exploitables :

- règle appliquée ;
- source et destination ;
- protocole et port ;
- action autorisée ou refusée ;
- identité lorsque disponible ;
- date, équipement et contexte.

![security-diagnostic.svg](Ressources/images/security-diagnostic.svg)

### Méthode

1. définir précisément le flux attendu ;
2. vérifier le service et son adresse d'écoute ;
3. suivre le routage et les zones traversées ;
4. vérifier NAT avant et après traduction ;
5. lire les règles dans leur ordre réel ;
6. consulter les journaux ;
7. tester à nouveau après une modification limitée.

Exemple de flux attendu :

```text
Source : 10.10.10.25
Destination : 10.20.0.10
Transport : TCP
Port : 443
Zone : UTILISATEURS → SERVEURS
```

### Interpréter quelques cas

|Observation|Piste|
|---|---|
|Aucun paquet n'atteint le pare-feu|route, VLAN ou équipement source|
|Paquet refusé avec une règle identifiée|objet, ordre ou politique de la règle|
|Paquet autorisé mais aucune réponse|service, route retour ou pare-feu de l'hôte|
|DNAT correct mais serveur injoignable|adresse interne, écoute ou filtrage DMZ|
|VPN établi mais ressource inaccessible|routes annoncées, ACL, DNS ou autorisation|
|802.1X refusé|identité, méthode EAP, certificat, RADIUS ou politique|

> [!WARNING]
> Désactiver entièrement le pare-feu pour « tester » modifie trop de paramètres et peut exposer la machine. Préférez les journaux, la capture et une règle temporaire très ciblée.

---

## 6.11 — Construire une politique cohérente

![security-synthese.svg](Ressources/images/security-synthese.svg)

Une politique simple peut suivre cet ordre :

1. inventorier les actifs et les flux nécessaires ;
2. segmenter par rôle et niveau de confiance ;
3. refuser les flux non justifiés ;
4. authentifier les utilisateurs et équipements ;
5. chiffrer les communications sensibles ;
6. maintenir les systèmes et réduire les services ;
7. journaliser, surveiller et tester ;
8. préparer sauvegardes et réponse aux incidents.

> [!SUCCESS] À retenir
> - La sécurité protège confidentialité, intégrité et disponibilité.
> - NAT traduit ; le pare-feu filtre.
> - La segmentation limite l'exposition et les déplacements entre zones.
> - Une DMZ isole les services publiés du réseau interne.
> - Un VPN protège un trajet, sans remplacer l'autorisation ni la sécurité du poste.
> - AAA, MFA, 802.1X et RADIUS contrôlent les identités et les accès.
> - Les journaux permettent de comprendre un refus sans supprimer les protections.
> - La défense en profondeur associe plusieurs contrôles complémentaires.

Ce dernier chapitre ferme la progression : transmettre les bits, livrer les trames, router les paquets, joindre les applications, utiliser les services puis **contrôler qui peut accéder à quoi**.
