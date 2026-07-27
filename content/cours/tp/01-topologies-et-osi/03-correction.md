# TP 01 - Topologies et modele OSI - Correction

## Elements attendus

### Roles des equipements

| Equipement | Role attendu |
|---|---|
| PC fixe | Poste client utilise par l'utilisateur |
| Imprimante reseau | Peripherique partage accessible sur le reseau |
| Borne Wi-Fi | Permet l'acces sans fil au LAN |
| Box / routeur Internet | Relie le LAN a Internet et fait souvent NAT, DHCP et routage |
| Cable RJ45 | Support physique cuivre pour transmettre les bits |

### Topologie attendue

La reponse correcte la plus classique est une **topologie en etoile** :

- les postes filaires et l'imprimante sont relies a un switch
- la borne Wi-Fi est reliee au switch
- la box ou le routeur est relie au switch
- les postes Wi-Fi passent par le point d'acces

### Correspondance OSI

| Situation | Couche OSI |
|---|---|
| Un signal circule dans un cable cuivre | 1 - Physique |
| Une trame est envoyee a une adresse MAC | 2 - Liaison |
| Un paquet IP traverse un routeur | 3 - Reseau |
| Une page web est demandee a un serveur | 7 - Application |
| Une connexion fiable est etablie entre deux machines | 4 - Transport |

## Reponses types

### Pourquoi l'etoile est courante

Parce qu'elle est simple a administrer, facile a etendre, et qu'une panne sur un cable utilisateur n'arrete pas tout le reseau.

### Difference switch / routeur

- Un **switch** connecte des machines dans un meme LAN et travaille surtout en couche 2.
- Un **routeur** relie plusieurs reseaux IP et travaille surtout en couche 3.

### Internet comme reseau de reseaux

Internet relie des milliers de reseaux independants qui communiquent avec des protocoles communs, surtout IP.

## Diagnostic OSI attendu

| Incident | Couche probable | Verification |
|---|---|---|
| Cable debranche | 1 | Etat du lien, LED, branchement |
| Pas d'adresse IP | 7 ou 3 selon l'angle, souvent service DHCP | Verification DHCP, `ipconfig`, bail |
| Ping passerelle OK mais site web KO | 7 ou 3 | DNS, route par defaut, acces Internet |
| Certificat invalide | 6 ou 7 | Verifier HTTPS, certificat, date |
| Deux PC d'un meme service ne communiquent pas dans le meme VLAN | 2 | VLAN, ports access, trunk |

## Point pedagogique

Le modele OSI sert surtout de **grille de lecture** :

- il aide a classer les problemes
- il facilite la communication entre techniciens
- il structure l'apprentissage des protocoles
