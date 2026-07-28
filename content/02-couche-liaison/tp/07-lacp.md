---
title: "TP Packet Tracer : agrégation de liens LACP"
tags:
  - fondamentaux-reseaux
  - tp
  - packet-tracer
  - lacp
---

# TP Packet Tracer — Agrégation de liens LACP

> Chapitre associé : [[02-couche-liaison/02-couche-liaison|Couche liaison]]

> [!INFO] Durée indicative
> 45 minutes.

## Objectifs

- agréger plusieurs liens Ethernet entre deux switches ;
- utiliser LACP en mode active ;
- transporter un VLAN dans un port-channel ;
- vérifier l’état du groupe et tester sa tolérance à la perte d’un lien.

## Topologie

| Équipement | Adresse IP | VLAN | Connexion |
|---|---|---:|---|
| PC1 | `192.168.10.1/24` | 10 | S1 Fa0/10 |
| PC2 | `192.168.10.2/24` | 10 | S2 Fa0/10 |
| S1 | — | 10 | Gi0/1 et Gi0/2 vers S2 |
| S2 | — | 10 | Gi0/1 et Gi0/2 vers S1 |

## Travail demandé

### Partie A — Préparer le réseau

1. Reliez les deux switches par deux liens GigabitEthernet.
2. Créez le VLAN 10 sur chaque switch.
3. Configurez Fa0/10 en mode access dans le VLAN 10.
4. Vérifiez localement les VLAN.

### Partie B — Créer le port-channel

Sur chaque switch :

1. sélectionnez Gi0/1 et Gi0/2 avec `interface range` ;
2. ajoutez-les au groupe 1 en mode LACP `active` ;
3. configurez `port-channel 1` en trunk ;
4. autorisez le VLAN 10.

Commandes utiles :

```text
interface range gigabitEthernet0/1 - 2
channel-group 1 mode active
interface port-channel 1
switchport mode trunk
switchport trunk allowed vlan 10
```

### Partie C — Vérifier

```text
show etherchannel summary
show interfaces port-channel 1
show interfaces trunk
```

1. Vérifiez que les interfaces sont membres du même groupe.
2. Testez un `ping` entre PC1 et PC2.
3. Débranchez un des deux liens physiques.
4. Testez de nouveau la communication.

## Questions

1. Quel est le rôle du port-channel ?
2. Pourquoi les interfaces membres doivent-elles avoir des configurations compatibles ?
3. Quelle différence existe entre `mode active` et `mode on` ?
4. Que prouve le test après la perte d’un lien ?

> [!NOTE] Standard
> LACP est normalisé aujourd’hui par IEEE 802.1AX. L’ancienne référence IEEE 802.3ad reste fréquemment rencontrée dans les documentations.
