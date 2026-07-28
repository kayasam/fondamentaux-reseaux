---
title: Fiche pratique Cisco CLI pour Packet Tracer
aliases:
  - Commandes Cisco Packet Tracer
  - Aide Cisco IOS
tags:
  - fondamentaux-reseaux
  - cisco
  - packet-tracer
  - cli
---

# Fiche pratique Cisco CLI — Switch et routeur

> [!TIP] Utilisation
> Gardez cette fiche ouverte pendant les TP Packet Tracer. Commencez par identifier l’invite affichée : elle indique le mode IOS actif et les commandes disponibles.

---

## 1 — Modes d’accès Cisco IOS

|Mode|Invite de commande|Exemple|Description|
|---|---|---|---|
|**Utilisateur**|`Switch>` ou `Router>`|`Switch>`|Accès basique (lecture seule)|
|**Privilégié (enable)**|`Switch#`|`Switch#`|Commandes avancées, diagnostic|
|**Configuration globale**|`Switch(config)#`|`Switch(config)#`|Configuration du système|
|**Interface**|`Switch(config-if)#`|`Switch(config-if)#`|Config d’un port (Ethernet, VLAN...)|
|**VLAN**|`Switch(config-vlan)#`|`Switch(config-vlan)#`|Gestion des VLANs|
|**Routeur (sous-processus)**|`Router(config-router)#`|`Router(config-router)#`|Config d’un protocole de routage|

---

## 2 — Commandes de base

|Action|Commande|Exemple|
|---|---|---|
|Entrer en mode privilégié|`enable`|`Switch> enable`|
|Revenir au mode précédent|`exit`|—|
|Sauvegarder la configuration|`write` ou `copy running-config startup-config`|—|
|Voir la configuration active|`show running-config`|—|
|Voir la configuration sauvegardée|`show startup-config`|—|
|Redémarrer le périphérique|`reload`|—|
|Afficher la date|`show clock`|—|
|Modifier le nom du périphérique|`hostname Nom`|`Switch(config)# hostname SW1`|

---

## 3 — Configuration réseau de base

### Sur un **switch**

```bash
Switch# configure terminal
Switch(config)# interface vlan 1
Switch(config-if)# ip address 192.168.10.2 255.255.255.0
Switch(config-if)# no shutdown
Switch(config-if)# exit
Switch(config)# ip default-gateway 192.168.10.1
```

### Sur un **routeur**

```bash
Router# configure terminal
Router(config)# interface gigabitEthernet0/0
Router(config-if)# ip address 192.168.1.1 255.255.255.0
Router(config-if)# no shutdown
Router(config-if)# exit
```

> [!info]
> Sur Cisco, les interfaces sont **désactivées par défaut** (`shutdown`).
> Il faut toujours faire `no shutdown` pour activer un port.

---

## 4 — Configuration des VLAN (switch)

```bash
Switch# configure terminal
Switch(config)# vlan 10
Switch(config-vlan)# name Utilisateurs
Switch(config-vlan)# exit
Switch(config)# interface fastEthernet0/1
Switch(config-if)# switchport mode access
Switch(config-if)# switchport access vlan 10
Switch(config-if)# exit
```

Afficher les VLANs :

```bash
Switch# show vlan brief
```

---

## 5 — Configuration des trunks

```bash
Switch(config)# interface gigabitEthernet0/1
Switch(config-if)# switchport mode trunk
Switch(config-if)# switchport trunk allowed vlan 10,20,30
```

Afficher les trunks :

```bash
Switch# show interfaces trunk
```

---

## 6 — Agrégation de liens avec LACP

> [!NOTE] Standard
> LACP est défini aujourd’hui par IEEE 802.1AX. La référence historique IEEE 802.3ad reste encore couramment utilisée.

Sur deux switchs reliés par plusieurs liens :

```bash
Switch(config)# interface range gigabitEthernet0/1 - 2
Switch(config-if-range)# channel-group 1 mode active
Switch(config-if-range)# exit
Switch(config)# interface port-channel 1
Switch(config-if)# switchport mode trunk
Switch(config-if)# switchport trunk allowed vlan 10,20
```

Afficher les agrégations :

```bash
Switch# show etherchannel summary
```

---

## 7 — Spanning Tree Protocol

STP évite les boucles de couche 2 en élisant un **root bridge** puis en plaçant certains ports redondants dans un état qui ne transmet pas les trames utilisateur.

### Afficher l’arbre STP

```bash
Switch# show spanning-tree
Switch# show spanning-tree vlan 10
```

Dans le résultat, vérifiez :

| Élément | Signification |
|---|---|
| `Root ID` | Identité du root bridge |
| `Bridge ID` | Identité du switch interrogé |
| `Root` | Meilleur port de ce switch vers le root bridge |
| `Desg` | Port désigné chargé de transmettre sur le segment |
| `Altn` | Chemin alternatif actuellement bloqué |
| `FWD` | Le port transmet les trames |
| `BLK` ou `Discarding` | Le port ne transmet pas les trames utilisateur |

> [!TIP] Reconnaître le root bridge
> Si la ligne `This bridge is the root` apparaît, le switch interrogé est le root bridge.

### Choisir volontairement le root bridge

Méthode simplifiée :

```bash
Switch(config)# spanning-tree vlan 10 root primary
```

Configurer un root secondaire :

```bash
Switch(config)# spanning-tree vlan 10 root secondary
```

Configurer directement la priorité :

```bash
Switch(config)# spanning-tree vlan 10 priority 24576
```

La priorité doit être un multiple de `4096`. Le switch possédant le **Bridge ID le plus faible** devient root bridge.

### Modifier le coût d’un port

```bash
Switch(config)# interface gigabitEthernet0/1
Switch(config-if)# spanning-tree vlan 10 cost 10
```

Un coût plus faible rend le chemin plus attractif pour STP.

### Accélérer l’activation d’un port utilisateur

```bash
Switch(config)# interface fastEthernet0/10
Switch(config-if)# switchport mode access
Switch(config-if)# spanning-tree portfast
Switch(config-if)# spanning-tree bpduguard enable
```

> [!WARNING] PortFast
> Activez PortFast uniquement sur un port relié à un équipement terminal. Ne l’utilisez pas sur une liaison entre switches. BPDU Guard protège le port en le désactivant s’il reçoit une BPDU inattendue.

### Diagnostic rapide

```bash
Switch# show spanning-tree summary
Switch# show spanning-tree interface gigabitEthernet0/1 detail
```

> [!TIP] Mise en pratique
> Le [[cours/02-couche-liaison/tp/04-vlan-trunk-stp|TP avancé de couche liaison]] permet d’observer l’élection du root bridge et le blocage d’un lien redondant.

---

## 8 — Routage sur un routeur ou un switch de couche 3

### Activer le routage

```bash
Switch(config)# ip routing
```

### Créer des sous-interfaces pour inter-VLAN

```bash
Router(config)# interface gigabitEthernet0/0.10
Router(config-subif)# encapsulation dot1Q 10
Router(config-subif)# ip address 192.168.10.1 255.255.255.0
Router(config-subif)# no shutdown
```

Afficher la table de routage :

```bash
Router# show ip route
```

---

## 9 — Découverte et diagnostic

|Action|Commande|Commentaire|
|---|---|---|
|Voir les interfaces|`show interfaces status`|État, vitesse, VLAN|
|Statistiques d’une interface|`show interfaces gigabitEthernet0/1`|Paquets, erreurs, duplex|
|Vérifier LLDP/CDP|`show lldp neighbors` / `show cdp neighbors`|Voisins directs|
|Ping vers une IP|`ping 192.168.1.1`|Test de connectivité|
|Résolution ARP|`show arp`|Associe IP ↔ MAC|
|Table MAC|`show mac address-table`|Apprentissage des adresses MAC|
|Version du système|`show version`|Modèle, licence, IOS|

---

## 10 — Gestion des mots de passe

```bash
Switch(config)# enable secret admin123
Switch(config)# line console 0
Switch(config-line)# password cisco
Switch(config-line)# login
Switch(config-line)# exit
```

---

## 11 — Sauvegarde et restauration

|Action|Commande|
|---|---|
|Sauvegarder la conf actuelle|`copy running-config startup-config`|
|Charger la conf sauvegardée|`copy startup-config running-config`|
|Effacer la configuration|`erase startup-config` + `reload`|
