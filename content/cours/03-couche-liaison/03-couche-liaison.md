---
title: 03 — Couche liaison
---

# Chapitre 3 — Couche 2 : la liaison de données

> [!TIP] Ressources du chapitre
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/cours/03-couche-liaison/03-couche-liaison-interactif.html" target="_blank">Ouvrir le cours interactif</a>
> - [[cours/03-couche-liaison/tp/01-debutant|TP débutant]]
> - [[cours/03-couche-liaison/tp/02-avance|TP avancé]]

> [!NOTE] Objectifs
> Comprendre comment les bits deviennent des trames, comment un switch choisit un port et comment les VLAN, STP et LACP structurent un réseau local.

La couche physique transporte des bits. La **couche liaison** organise ces bits en **trames** et les fait circuler entre les équipements d'un même réseau local.

Elle répond à quatre questions :

- qui émet et qui doit recevoir la trame ?
- où le switch doit-il envoyer cette trame ?
- comment détecter une trame endommagée ?
- comment organiser et protéger le réseau local ?

![ch3-vue-ensemble.svg](Ressources/images/ch3-vue-ensemble.svg)

> [!TIP] Limite de la couche 2
> Une adresse MAC permet de communiquer dans un réseau local. Pour atteindre un autre réseau, il faut passer par une passerelle et utiliser la couche 3.

---

## 3.1 — La trame Ethernet

<iframe width="560" height="315" src="https://www.youtube.com/embed/NNtotn5AG2U?si=ZOU-1rWPDrrmUiEq" title="La trame Ethernet" frameborder="0" allowfullscreen></iframe>

Ethernet ne transmet pas un flux sans structure : il regroupe les informations dans une **trame**. Cette trame encapsule généralement un paquet IPv4, IPv6 ou ARP.

|Champ|Taille|Rôle|
|---|---:|---|
|Préambule + SFD|8 octets|Synchroniser le récepteur et annoncer le début|
|MAC destination|6 octets|Identifier le destinataire local|
|MAC source|6 octets|Identifier l'émetteur local|
|EtherType|2 octets|Indiquer le protocole transporté : IPv4, IPv6, ARP…|
|Données|46 à 1 500 octets|Transporter le paquet de couche 3|
|FCS|4 octets|Détecter une corruption avec un contrôle CRC|

![ch3-trame-ethernet.svg](Ressources/images/ch3-trame-ethernet.svg)

> [!NOTE] Taille d'une trame
> De l'adresse MAC destination au FCS, une trame Ethernet mesure normalement entre **64 et 1 518 octets**. Le préambule et le SFD ne sont pas comptés. Un tag VLAN ajoute 4 octets.

Si le FCS calculé à la réception ne correspond pas au FCS de la trame, celle-ci est considérée comme corrompue et supprimée. Ethernet ne demande pas lui-même sa retransmission : un protocole supérieur, par exemple TCP, pourra s'en charger.

> [!INFO] Pour aller plus loin
> [IEEE 802.3 — groupe de travail Ethernet (site officiel)](https://ieee802.org/3/)

---

## 3.2 — Les adresses MAC

<iframe width="560" height="315" src="https://www.youtube.com/embed/7ln7oYIS-n0?si=aaYBsivQlPeIUiti" title="Les adresses MAC" frameborder="0" allowfullscreen></iframe>

Une adresse MAC Ethernet classique contient **48 bits**, soit 6 octets écrits en hexadécimal :

![ch3-adresse-mac.svg](Ressources/images/ch3-adresse-mac.svg)

- l'**OUI** identifie généralement le constructeur ;
- la partie **NIC** distingue l'interface ;
- une adresse MAC peut aussi être définie localement, virtualisée ou modifiée.

> [!WARNING]
> Une adresse MAC n'est pas une preuve d'identité : elle peut être changée ou usurpée. Elle sert d'adresse de livraison locale, pas de mécanisme de sécurité.

### Trois types de destination

|Type|Destinataire|Comportement du switch|Exemple|
|---|---|---|---|
|**Unicast**|Une interface|Envoi vers un port si la destination est connue|`C8:5A:CF:06:8C:67`|
|**Broadcast**|Toutes les interfaces du VLAN|Diffusion sur tous les ports du VLAN, sauf le port d'entrée|`FF:FF:FF:FF:FF:FF`|
|**Multicast**|Un groupe d'interfaces|Diffusion ou traitement optimisé selon le switch|`01:00:5E:xx:xx:xx`|

Afficher les adresses MAC :

```bash
# Linux
ip link show
```

```powershell
# cmd
ipconfig /all

# Windows PowerShell
Get-NetAdapter | Select-Object Name, MacAddress, Status
```

### De l'adresse IP à l'adresse MAC

Une application connaît généralement une adresse IP, mais Ethernet doit construire une trame avec une adresse MAC de destination. **ARP** permet de découvrir la MAC correspondant à une adresse IPv4 dans le réseau local.

Si la destination se trouve dans un autre réseau, la machine ne cherche pas la MAC du serveur distant : elle utilise la MAC de sa **passerelle par défaut**.

![ch3-arp.svg](Ressources/images/ch3-arp.svg)

> Le déroulement complet d'ARP et les risques d'ARP spoofing seront étudiés au chapitre 7.

---

## 3.3 — Le switch et sa table MAC

Un switch ne connaît pas la topologie dès son démarrage. Il construit progressivement une **table MAC**, aussi appelée table CAM, en observant les trames reçues.

### Apprentissage et transmission

Pour chaque trame, le switch suit cette logique :

1. il mémorise la **MAC source** et le port d'entrée ;
2. il recherche la **MAC destination** dans sa table ;
3. si la destination est connue, il transmet uniquement vers le port associé ;
4. si elle est inconnue, il effectue un **flooding** dans le LAN ;
5. les entrées inutilisées disparaissent après un délai de vieillissement.

![ch3-switch-apprentissage.svg](Ressources/images/ch3-switch-apprentissage.svg)

> [!NOTE] Le flooding n'est pas toujours un broadcast
> Un **broadcast** est décidé par l'émetteur avec l'adresse `FF:FF:FF:FF:FF:FF`. Un **unknown unicast** vise une seule MAC, mais le switch le diffuse temporairement parce qu'il ne sait pas encore où elle se trouve.

### Hub et switch

|Équipement|Décision|Domaine de collision|Duplex|
|---|---|---|---|
|**Hub**|Répète les bits sur tous les ports|Un domaine partagé|Half-duplex|
|**Switch**|Analyse les MAC et choisit un port|Un domaine par port|Full-duplex|

Un switch **non managé** fonctionne sans configuration. Un switch **managé** permet notamment de configurer les VLAN, STP, LACP, la supervision et la sécurité des ports.

---

## 3.4 — Boucles réseau et Spanning Tree

### Pourquoi ajouter des liens redondants ?

Deux liens entre switches peuvent assurer la continuité de service : si un câble tombe, l'autre reste disponible. Mais Ethernet ne possède pas de compteur équivalent au TTL d'IP. Une trame de broadcast prise dans une boucle peut donc circuler indéfiniment.

Une boucle de couche 2 peut provoquer :

- une **tempête de broadcast** ;
- des trames reçues plusieurs fois ;
- une table MAC qui change continuellement de port ;
- la saturation des liens et des processeurs des switches.

### STP supprime la boucle logique

Le **Spanning Tree Protocol** conserve la redondance physique tout en bloquant logiquement les chemins excédentaires :

1. les switches élisent un **root bridge** ;
2. chaque switch choisit son meilleur chemin vers la racine ;
3. un port redondant est placé dans un état qui ne transfère pas les trames ;
4. si le lien actif tombe, STP peut activer le chemin de secours.

![ch3-stp.svg](Ressources/images/ch3-stp.svg)

> [!TIP] STP ou RSTP ?
> **RSTP** est l'évolution moderne de STP. Il réagit généralement en quelques secondes, alors que le STP historique peut demander plusieurs dizaines de secondes.

> [!WARNING]
> STP protège contre les boucles ; il ne remplace pas une conception correcte. Le root bridge doit être choisi volontairement sur les switches structurants.

---

## 3.5 — Segmenter avec les VLAN

<iframe width="560" height="315" src="https://www.youtube.com/embed/Eh9INNkMM4I?si=36Y_npl6rMxiXSWw" title="Les VLAN" frameborder="0" allowfullscreen></iframe>

Un **VLAN** crée plusieurs réseaux locaux logiques sur une même infrastructure physique. Chaque VLAN forme un **domaine de broadcast distinct**.

Exemple :

|VLAN|Nom|Équipements|
|---:|---|---|
|10|Administration|Postes et imprimantes administratives|
|20|Technique|Postes des techniciens|
|30|Invités|Wi-Fi des visiteurs|

### Ports access et trunk

- un port **access** appartient à un seul VLAN ; le poste envoie et reçoit des trames ordinaires, sans tag ;
- un port **trunk** transporte plusieurs VLAN entre équipements réseau ;
- sur un trunk, **[IEEE 802.1Q](https://1.ieee802.org/maintenance/p802-1q-rev/)** ajoute un tag contenant notamment l'identifiant du VLAN.

![ch3-vlan.svg](Ressources/images/ch3-vlan.svg)

> [!NOTE]
> Les identifiants de VLAN vont de 1 à 4 094 dans l'usage courant. Le VLAN 1 existe par défaut, mais il est préférable de créer des VLAN dédiés aux utilisateurs et à l'administration.

### Faire communiquer deux VLAN

Deux machines placées dans des VLAN différents sont dans deux réseaux logiques différents, même si elles sont branchées sur le même switch. Leur communication nécessite du **routage inter-VLAN** :

```text
VLAN 10 ─┐
         ├── routeur ou switch de couche 3 ── règles de filtrage
VLAN 20 ─┘
```

> [!WARNING]
> Un VLAN apporte de la segmentation, mais pas automatiquement une politique de sécurité. Le routeur ou le pare-feu doit contrôler les échanges autorisés entre les VLAN.

---

## 3.6 — Agréger des liens avec LACP

L'agrégation regroupe plusieurs liens Ethernet physiques dans une seule interface logique. **LACP** négocie automatiquement cette agrégation entre les deux équipements.

![ch3-lacp.svg](Ressources/images/ch3-lacp.svg)

### Deux intérêts

- **capacité totale** : plusieurs communications peuvent être réparties entre les liens ;
- **redondance** : si un membre tombe, les autres continuent de transporter le trafic.

> [!WARNING] Deux liens de 1 Gbit/s ne donnent pas 2 Gbit/s à une seule copie
> LACP répartit généralement les **flux** selon un calcul de hachage. Un flux unique reste habituellement sur un seul lien de 1 Gbit/s, mais plusieurs flux peuvent utiliser les 2 Gbit/s cumulés.

|Protocole|Type|Compatibilité|
|---|---|---|
|**LACP**|Standard [IEEE 802.1AX](https://standards.ieee.org/ieee/802.1AX/6768/), historiquement 802.3ad|Multiconstructeur|
|**PAgP**|Propriétaire Cisco|Principalement Cisco|

Les ports membres doivent avoir une configuration cohérente : vitesse, duplex, VLAN autorisés et paramètres de trunk.

---

## 3.7 — Découvrir ses voisins avec LLDP et CDP

LLDP et CDP permettent à un équipement d'annoncer périodiquement son identité à ses voisins **directement connectés**.

|Protocole|Type|Compatibilité|
|---|---|---|
|**LLDP**|Standard [IEEE 802.1AB](https://standards.ieee.org/ieee/802.1AB/11787/)|Multiconstructeur|
|**CDP**|Propriétaire Cisco|Équipements Cisco|

Ils peuvent annoncer :

- le nom et le modèle de l'équipement ;
- le port local et le port distant ;
- les capacités de l'équipement ;
- certaines informations de VLAN ou de téléphonie.

![ch3-lldp-cdp.svg](Ressources/images/ch3-lldp-cdp.svg)

```text
Switch A, port 24 ───── port 1, Switch B
       └── LLDP révèle automatiquement ce voisin ──┘
```

> [!TIP]
> LLDP aide à documenter le câblage réel. Il ne découvre que le voisin immédiat et ne remplace pas un outil complet de supervision.

---

## 3.8 — Le Wi-Fi à la couche liaison

Les fréquences, la portée et les interférences ont été étudiées en **section 2.3**. À la couche 2, le Wi-Fi utilise lui aussi des trames et des adresses MAC, mais le média radio est partagé.

### Infrastructure et point d'accès

En mode **infrastructure**, les clients s'associent à un point d'accès :

- le **SSID** est le nom visible du réseau Wi-Fi ;
- le **BSSID** identifie généralement une radio du point d'accès avec une adresse MAC ;
- le point d'accès agit comme un pont entre le réseau radio et le réseau Ethernet.

Le mode **ad hoc**, sans point d'accès, existe mais reste peu utilisé dans les réseaux d'entreprise.

![ch3-wifi-infrastructure.svg](Ressources/images/ch3-wifi-infrastructure.svg)

> [!INFO] Pour aller plus loin
> [IEEE 802.11 — groupe de travail des réseaux locaux sans fil (site officiel)](https://www.ieee802.org/11/)

### CSMA/CA plutôt que CSMA/CD

Une station Wi-Fi ne peut pas écouter correctement le canal pendant qu'elle émet. Elle cherche donc à **éviter** les collisions au lieu de les détecter :

1. elle écoute le canal ;
2. si le canal est occupé, elle attend ;
3. elle choisit un délai aléatoire ;
4. elle émet lorsque son compteur arrive à zéro ;
5. le destinataire confirme la réception avec un acquittement.

![ch3-csmaca.svg](Ressources/images/ch3-csmaca.svg)

> [!NOTE]
> Tous les clients d'une même radio partagent le temps d'antenne. Un client lent peut donc consommer beaucoup de temps sans transmettre beaucoup de données.

---

> [!SUCCESS] Résumé du chapitre 3
> - La couche 2 organise les bits en **trames** adressées avec des **adresses MAC**.
> - Le switch apprend les MAC sources et choisit un port ; une destination inconnue provoque un **flooding** temporaire.
> - **STP/RSTP** bloque les chemins redondants qui créeraient une boucle et réactive un secours en cas de panne.
> - Un **VLAN** constitue un domaine de broadcast distinct ; un trunk transporte plusieurs VLAN avec 802.1Q.
> - La communication entre VLAN nécessite un équipement de couche 3 et des règles de filtrage.
> - **LACP** augmente la capacité pour plusieurs flux et maintient le service si un lien membre tombe.
> - Le Wi-Fi emploie **CSMA/CA** pour limiter les collisions sur le média radio partagé.
