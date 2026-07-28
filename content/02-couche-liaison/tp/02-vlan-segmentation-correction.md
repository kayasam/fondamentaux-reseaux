---
title: Correction 02 - VLAN et segmentation
publier: true
---

# TP 02 - Correction

> Correction du TP : [[02-vlan-segmentation]]

## Partie 1 - Câblage

Les quatre PC sont reliés au switch 2960 :

| Poste | Port du switch |
|---|---|
| PC-ADMIN-1 | `Fa0/1` |
| PC-ADMIN-2 | `Fa0/2` |
| PC-TECH-1 | `Fa0/23` |
| PC-TECH-2 | `Fa0/24` |

Des câbles cuivre droit peuvent être utilisés entre les PC et le switch.

---

## Partie 2 - Adressage

| Poste | Adresse IPv4 | Masque |
|---|---|---|
| PC-ADMIN-1 | `192.168.10.11` | `255.255.255.0` |
| PC-ADMIN-2 | `192.168.10.12` | `255.255.255.0` |
| PC-TECH-1 | `192.168.20.11` | `255.255.255.0` |
| PC-TECH-2 | `192.168.20.12` | `255.255.255.0` |

La passerelle peut rester vide : aucun routage inter-VLAN n’est configuré dans ce TP.

---

## Partie 3 - Configuration du switch

```text
enable
configure terminal

vlan 10
 name ADMIN

vlan 20
 name TECH

interface range fa0/1 - 2
 switchport mode access
 switchport access vlan 10
 no shutdown

interface range fa0/23 - 24
 switchport mode access
 switchport access vlan 20
 no shutdown

end
copy running-config startup-config
```

Vérification :

```text
show vlan brief
```

Résultat attendu :

- `Fa0/1` et `Fa0/2` apparaissent dans le VLAN 10 `ADMIN` ;
- `Fa0/23` et `Fa0/24` apparaissent dans le VLAN 20 `TECH`.

---

## Partie 4 - Tests

| Test | Résultat attendu |
|---|---|
| PC-ADMIN-1 vers PC-ADMIN-2 | Réussi |
| PC-TECH-1 vers PC-TECH-2 | Réussi |
| Un poste ADMIN vers un poste TECH | Échec |

Le premier ping peut perdre une requête pendant la résolution ARP.

Après les échanges :

```text
show mac address-table
```

Le switch doit avoir appris les adresses MAC sur les quatre ports access, dans leur VLAN respectif.

---

## Partie 5 - Réponses

### 1. Pourquoi le ping entre deux VLAN différents échoue-t-il ?

Chaque VLAN forme un domaine de broadcast et un réseau logique distinct. Un switch de couche 2 ne route pas les paquets entre le VLAN 10 et le VLAN 20.

### 2. Quel équipement faut-il ajouter ?

Il faut un équipement capable de faire du routage :

- un routeur avec une configuration « router-on-a-stick » ;
- ou un switch multicouche avec des interfaces VLAN.

> [!NOTE] Conclusion
> Les ports access transportent un seul VLAN. La communication au sein d’un VLAN est commutée ; la communication entre VLAN nécessite du routage.
