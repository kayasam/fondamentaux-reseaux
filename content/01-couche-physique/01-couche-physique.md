---
title: 01. Couche physique
---

# Couche 1 : la couche physique

> [!TIP] Ressources du chapitre
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/01-couche-physique/01-couche-physique-interactif.html" target="_blank">Ouvrir le cours interactif</a>
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/01-couche-physique.md" download>Télécharger ce cours en Markdown</a>
> - [[01-couche-physique/tp/01-debutant|TP débutant]]
> - [[01-couche-physique/tp/02-avance|TP avancé]]

> [!NOTE] Objectifs
> Identifier les principaux supports de transmission, choisir un média adapté et reconnaître une panne de couche 1.

La couche physique transforme une suite de **bits** en un signal capable de circuler sur un support :

- signal électrique dans le cuivre ;
- impulsions lumineuses dans la fibre ;
- ondes radio dans l'air.

Elle définit aussi les connecteurs, les fréquences, le codage du signal, le débit et les distances maximales. Elle ne connaît ni les adresses IP, ni les adresses MAC, ni les applications.

![ch2-vue-ensemble.svg](Ressources/images/ch2-vue-ensemble.svg)

> [!TIP] Réflexe de diagnostic
> Avant d'analyser les adresses ou les protocoles, vérifier la couche 1 : alimentation, voyants, câble, connecteur, portée et qualité du signal.

---

## 1.1 — Les supports en cuivre

<iframe width="560" height="315" src="https://www.youtube.com/embed/oOwnV9LkYBY?si=arav6-Eh4IiXm7QS" title="Les câbles Ethernet" frameborder="0" allowfullscreen></iframe>

### Le câble à paires torsadées

Un câble Ethernet en cuivre contient **quatre paires de fils torsadés**. La torsade réduit la diaphonie, c'est-à-dire les perturbations produites par les autres paires.

Le connecteur est couramment appelé **RJ45**. Techniquement, Ethernet utilise un connecteur **8P8C** : huit positions et huit contacts.

### Blindage des câbles

|Marquage|Protection|Usage typique|
|---|---|---|
|**U/UTP**|Aucun blindage|Bureaux, environnement peu perturbé|
|**F/UTP**|Feuille autour des quatre paires|Protection générale|
|**U/FTP**|Chaque paire est blindée|Environnement perturbé|
|**S/FTP**|Tresse générale et blindage de chaque paire|Protection élevée|

> [!WARNING]
> Un câble blindé n'est efficace que si les connecteurs, les panneaux de brassage et la mise à la terre sont adaptés.

### Catégories courantes

|Catégorie|Débit courant|Distance maximale|Usage|
|---|---:|---:|---|
|**Cat 5e**|1 Gbit/s|100 m|Postes de travail, téléphonie IP|
|**Cat 6**|1 Gbit/s à 100 m ; 10 Gbit/s jusqu'à environ 55 m|100 m|Réseaux d'entreprise|
|**Cat 6a**|10 Gbit/s|100 m|Nouvelles installations|
|**Cat 7**|10 Gbit/s|100 m|Norme ISO/IEC, usage spécifique|
|**Cat 8**|25 ou 40 Gbit/s|30 m|Liaisons courtes en centre de données|

![ch2-cables-comparaison.svg](Ressources/images/ch2-cables-comparaison.svg)

> [!NOTE]
> Les **100 mètres** correspondent généralement à 90 m de câble permanent et 10 m de cordons. Une catégorie plus élevée ne rend pas automatiquement le réseau plus rapide : les cartes réseau et les switches doivent supporter le même débit.

---

## 1.2 — La fibre optique

<iframe width="560" height="315" src="https://www.youtube.com/embed/UwEuUsaiBAk?si=eO_cpM8PXqnvY2by" title="La fibre optique" frameborder="0" allowfullscreen></iframe>

La fibre transporte des impulsions de **lumière**. Elle offre de hauts débits, couvre de longues distances et reste insensible aux perturbations électromagnétiques.

### Monomode et multimode

Le mot **mode** désigne un trajet possible de la lumière dans le cœur de la fibre.

- Dans une fibre **multimode**, plusieurs rayons lumineux suivent des trajets légèrement différents. Ils n'arrivent donc pas exactement au même moment : c'est la **dispersion modale**.
- Dans une fibre **monomode**, le cœur très fin ne laisse passer qu'un mode principal. Le signal se déforme beaucoup moins avec la distance.

Les deux fibres répondent donc à deux besoins différents :

|Type|Intérêt principal|Avantage|Limite|Usage typique|
|---|---|---|---|---|
|**Multimode — MMF**|Relier des équipements proches|Modules optiques généralement moins coûteux|La dispersion limite la distance|Salle informatique, bâtiment, centre de données|
|**Monomode — SMF**|Relier des équipements éloignés|Très longues distances et forte évolutivité|Modules laser généralement plus coûteux|Entre bâtiments, campus étendu, opérateur|

> [!TIP] Comment choisir ?
> - Deux switches dans la même salle ou le même bâtiment : le **multimode** est souvent suffisant et économique.
> - Deux bâtiments séparés de plusieurs kilomètres : choisir le **monomode**.
> - Pour une nouvelle liaison structurante destinée à évoluer longtemps, le monomode peut être retenu même sur une distance plus courte.

> [!WARNING]
> Une fibre multimode doit être associée à des modules multimodes ; une fibre monomode à des modules monomodes. Le connecteur LC peut être utilisé avec les deux : sa forme ne permet pas d'identifier le type de fibre.

La distance réelle dépend du **module optique**, du débit, du type de fibre et du budget optique. Il faut vérifier les caractéristiques des modules installés, par exemple SFP ou SFP+.

### Connecteurs courants

|Connecteur|Reconnaissance|Verrouillage|Usage typique|
|---|---|---|---|
|**ST**|Rond|Baïonnette|Anciennes installations|
|**SC**|Carré|Push-pull|Télécoms, panneaux de brassage|
|**LC**|Petit, avec languette|Push-pull|Switches et centres de données|

![ch2-connecteurs-fibre.svg](Ressources/images/ch2-connecteurs-fibre.svg)

### Choisir entre cuivre et fibre

|Critère|Cuivre|Fibre|
|---|---|---|
|Distance usuelle|Jusqu'à 100 m|Centaines de mètres à plusieurs kilomètres|
|Débit courant|1 à 10 Gbit/s|10 à 400 Gbit/s et plus selon les équipements|
|Perturbations électromagnétiques|Sensible|Insensible|
|Alimentation d'un équipement|Possible avec PoE|Impossible directement|
|Mise en œuvre|Généralement plus simple|Modules et outillage spécifiques|

> [!TIP] Choix rapide
> Utiliser le **cuivre** pour les postes, téléphones et points d'accès. Préférer la **fibre** pour les longues distances, les liaisons entre switches et les environnements fortement perturbés.

---

## 1.3 — Les supports sans fil

Les liaisons sans fil utilisent des **ondes électromagnétiques**. Elles facilitent la mobilité, mais le débit et la portée varient selon la distance, les obstacles, les interférences et le nombre d'utilisateurs.

![ch2-sans-fil.svg](Ressources/images/ch2-sans-fil.svg)

|Technologie|Usage|Portée indicative|Point fort|
|---|---|---:|---|
|**NFC**|Paiement, badge|Quelques centimètres|Très courte portée|
|**Bluetooth**|Casque, clavier, objets connectés|Quelques mètres à plusieurs dizaines de mètres|Faible consommation|
|**Wi-Fi**|Réseau local|Quelques dizaines de mètres|Débit élevé et mobilité locale|
|**4G / 5G**|Accès opérateur|Centaines de mètres à plusieurs kilomètres|Grande couverture|

### Bandes Wi-Fi

|Bande|Avantage|Limite|
|---|---|---|
|**2,4 GHz**|Meilleure portée et traversée des obstacles|Bande encombrée, peu de canaux|
|**5 GHz**|Davantage de canaux et meilleur débit|Portée plus courte|
|**6 GHz**|Large spectre, peu encombré|Portée plus courte, matériel compatible requis|

> [!WARNING] Débit théorique et débit utile
> Le débit annoncé par une norme Wi-Fi est un débit physique maximal. Le débit réellement disponible est plus faible et partagé entre les appareils.

> Le fonctionnement du Wi-Fi en couche liaison — adresses MAC, point d'accès et accès au média — sera étudié au chapitre 2.

---

## 1.4 — Atténuation, bruit et interférences

Trois phénomènes doivent être distingués :

- **atténuation** : le signal perd de la puissance avec la distance ;
- **bruit** : un signal parasite se superpose au signal utile ;
- **diaphonie** : le signal d'une paire de cuivre perturbe une paire voisine.

![ch2-attenuation-emi.svg](Ressources/images/ch2-attenuation-emi.svg)

### Sources fréquentes

- câbles électriques, moteurs, transformateurs et tubes fluorescents ;
- connecteur mal serti, câble plié ou fibre encrassée ;
- murs, structures métalliques et distance pour le Wi-Fi ;
- autres réseaux Wi-Fi, Bluetooth et fours à micro-ondes en 2,4 GHz.

### Actions correctives

- respecter les distances maximales et le rayon de courbure ;
- séparer les câbles réseau des câbles électriques ;
- utiliser un câble blindé ou passer à la fibre ;
- nettoyer et protéger les connecteurs optiques ;
- déplacer le point d'accès ou changer de canal Wi-Fi.

---

## 1.5 — Équipements de couche 1

<iframe width="560" height="315" src="https://www.youtube.com/embed/nv3U7q1P1ao?si=lGk5Swtfpjyr5LtZ" title="Répéteurs et hubs" frameborder="0" allowfullscreen></iframe>

### Répéteur

Un répéteur reçoit un signal affaibli, le **régénère**, puis le retransmet. Il prolonge un segment physique sans comprendre le contenu des données.

### Hub ou concentrateur

Le hub répète les bits reçus vers **tous ses autres ports**. Il ne lit pas les adresses MAC et ne choisit pas le destinataire. Tous les appareils partagent le débit, un seul peut émettre à la fois et tous les ports appartiennent au même domaine de collision.

![ch2-hub-collision.svg](Ressources/images/ch2-hub-collision.svg)

> [!WARNING]
> Le hub est aujourd'hui obsolète. Il a été remplacé par le switch, un équipement de couche 2 capable d'envoyer une trame uniquement vers le bon port.

---

## 1.6 — Half-duplex, full-duplex et CSMA/CD

|Mode|Principe|Exemple|
|---|---|---|
|**Half-duplex**|Émettre ou recevoir, mais pas simultanément|Talkie-walkie, Ethernet avec hub|
|**Full-duplex**|Émettre et recevoir en même temps|Ethernet moderne avec switch|

![ch2-duplex.svg](Ressources/images/ch2-duplex.svg)

### CSMA/CD : gérer les collisions

Sur les anciens réseaux Ethernet partagés, **CSMA/CD** organisait l'accès au support :

1. **Carrier Sense** : la machine écoute le support ;
2. **Multiple Access** : plusieurs machines partagent ce support ;
3. la machine émet si le support semble libre ;
4. **Collision Detection** : en cas de collision, l'émission s'arrête ;
5. chaque machine attend un délai aléatoire avant de réessayer.

![ch2-csmacd.svg](Ressources/images/ch2-csmacd.svg)

Avec un switch et des liaisons full-duplex, chaque port dispose de son propre lien : il n'y a plus de collision et CSMA/CD n'est plus utilisé.

---

## 1.7 — Diagnostiquer une panne de couche 1

1. Vérifier l'alimentation et les voyants de lien.
2. Contrôler l'enfichage des connecteurs.
3. Essayer un autre câble et un autre port.
4. Vérifier la catégorie, la longueur et l'état du câble.
5. Pour la fibre, vérifier le module, le sens émission/réception et la propreté.
6. Pour le Wi-Fi, contrôler la distance, les obstacles et les interférences.

> [!TIP]
> Si le voyant de lien reste éteint avec un câble et un port connus comme fonctionnels, la panne se situe probablement sur l'interface réseau ou son alimentation.

---

> [!SUCCESS] Résumé du chapitre 1
> - La couche physique transporte des **bits** sous forme de signal électrique, lumineux ou radio.
> - Le cuivre est simple et peut fournir du **PoE**, mais une liaison Ethernet est généralement limitée à **100 m**.
> - La fibre couvre de plus longues distances et résiste aux perturbations électromagnétiques.
> - Le sans-fil apporte la mobilité, avec un débit partagé et sensible à l'environnement.
> - L'atténuation, le bruit et la diaphonie dégradent le signal.
> - Le hub fonctionne en half-duplex et crée des collisions ; le switch moderne fonctionne en full-duplex.
