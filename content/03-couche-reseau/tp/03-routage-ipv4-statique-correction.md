---
title: Correction 03 - Routage IPv4 statique
publier: true
---

# TP 03 - Correction

> [!TIP] Ressource de la correction
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/03-couche-reseau/tp/03-routage-ipv4-statique-correction.md" download>Télécharger cette correction en Markdown</a>


> Correction du TP : [[03-routage-ipv4-statique]]

## Plan d'adressage

| Équipement | Interface | Adresse IP | Masque | Passerelle |
|---|---|---|---|---|
| R1 | G0/0 | 192.168.10.254 | /24 | — |
| R1 | G0/1 | 192.168.20.254 | /24 | — |
| R1 | G0/2 | 192.168.30.254 | /24 | — |
| PC-A1 / A2 | — | 192.168.10.1 / .2 | /24 | 192.168.10.254 |
| PC-T1 / T2 | — | 192.168.20.1 / .2 | /24 | 192.168.20.254 |
| PC-C1 / C2 | — | 192.168.30.1 / .2 | /24 | 192.168.30.254 |

## Configuration

```text
enable
configure terminal

interface g0/0
 ip address 192.168.10.254 255.255.255.0
 no shutdown

interface g0/1
 ip address 192.168.20.254 255.255.255.0
 no shutdown

interface g0/2
 ip address 192.168.30.254 255.255.255.0
 no shutdown

end
copy running-config startup-config
```

Vérification :

```text
show ip interface brief
show ip route
```

## Réponses aux questions de réflexion

1. **Switch vs routeur** : le switch commute des trames au sein d'un même réseau (couche 2, adresses MAC) ; le routeur achemine des paquets entre réseaux IP différents (couche 3, adresses IP).
2. **Pourquoi une passerelle par défaut** : sans elle, un PC ne sait envoyer des trames qu'à des hôtes de son propre sous-réseau. La passerelle est le point de sortie vers les réseaux distants.
3. **`show ip route`** : affiche la table de routage — les réseaux connus du routeur, comment ils ont été appris (`C` connecté, `L` local, `S` statique, `O`/`R`/`B` dynamique selon le protocole), l'interface de sortie et l'éventuel prochain saut.
4. **Interface désactivée** : la route associée disparaît de la table ; le réseau devient injoignable pour les autres LAN, et `show ip interface brief` affiche l'interface en `down/down` (ou `administratively down` si coupée manuellement).

Dans `show ip route`, on doit voir 3 réseaux directement connectés (un par LAN), chacun avec une ligne `C` (réseau connecté) et une ligne `L` (adresse locale de l'interface elle-même, en /32).

## Extension : VLAN de sauvegarde

1. Créer le réseau `192.168.99.0/24` dédié au VLAN BACKUP.
2. Sur le switch du LAN 1, créer le VLAN 99 et passer le port relié au routeur en trunk :

```text
vlan 99
 name BACKUP

interface gi0/1
 switchport mode trunk
 switchport trunk allowed vlan 10,99
```

3. Sur R1, remplacer l'interface physique G0/0 par deux sous-interfaces (routeur sur un bras) :

```text
interface g0/0.10
 encapsulation dot1Q 10
 ip address 192.168.10.254 255.255.255.0

interface g0/0.99
 encapsulation dot1Q 99
 ip address 192.168.99.254 255.255.255.0

interface g0/0
 no shutdown
```

4. Ajouter le PC de sauvegarde en `192.168.99.x/24`, passerelle `192.168.99.254`, sur un port access VLAN 99. Tester le ping vers ce PC depuis les autres LAN : la communication passe par le routage inter-VLAN sur R1, tout en restant dans deux domaines de broadcast séparés.

## À vérifier pendant la correction

- Les élèves confondent souvent passerelle du PC et adresse de l'interface routeur : bien vérifier que chaque PC pointe vers l'IP du routeur **de son propre LAN**.
- Un ping local qui échoue avant même le routage indique généralement un mauvais masque ou une interface encore `shutdown`.
- Sur l'extension, l'erreur la plus fréquente est d'oublier `no shutdown` sur l'interface physique parente (les sous-interfaces restent down sinon).
