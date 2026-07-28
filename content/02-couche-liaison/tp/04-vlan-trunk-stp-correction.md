---
title: Correction 04 - VLAN, trunk et STP
publier: true
---

# TP 04 - Correction

> Correction du TP : [[04-vlan-trunk-stp]]

## Partie 1 - Topologie

Les trois switchs S1, S2 et S3 forment un triangle. Chaque liaison inter-switch utilise un port GigabitEthernet disponible.

Exemple :

```text
S1 Gi0/1 -------- Gi0/1 S2
S2 Gi0/2 -------- Gi0/1 S3
S3 Gi0/2 -------- Gi0/2 S1
```

Les postes d’un même VLAN doivent être répartis sur plusieurs switchs afin de valider les trunks.

---

## Partie 2 - Configuration

### Configuration commune aux trois switchs

```text
enable
configure terminal

vlan 10
 name ADMIN
vlan 20
 name TECH

interface range gi0/1 - 2
 switchport mode trunk
 switchport trunk allowed vlan 10,20
 no shutdown

end
copy running-config startup-config
```

Les ports des PC sont ensuite configurés selon leur service.

Exemple pour un poste ADMIN sur `Fa0/1` :

```text
configure terminal
interface fa0/1
 switchport mode access
 switchport access vlan 10
 no shutdown
end
```

Exemple pour un poste TECH sur `Fa0/23` :

```text
configure terminal
interface fa0/23
 switchport mode access
 switchport access vlan 20
 no shutdown
end
```

Vérifications :

```text
show vlan brief
show interfaces trunk
```

---

## Partie 3 - Observation de STP

```text
show spanning-tree
```

Pour observer un VLAN précis :

```text
show spanning-tree vlan 10
show spanning-tree vlan 20
```

### Résultats attendus

- un switch est élu **root bridge** ;
- tous les ports du root bridge sont normalement designated et forwarding ;
- sur les autres switchs, un chemin est retenu vers le root bridge ;
- au moins un port redondant est placé en blocking ou discarding pour casser la boucle.

Le root bridge est le switch qui possède le plus petit Bridge ID :

1. priorité STP la plus faible ;
2. puis, en cas d’égalité, adresse MAC la plus faible.

Les rôles et ports exacts dépendent des adresses MAC attribuées par Packet Tracer.

### Test de reconvergence

Après avoir coupé un lien actif :

```text
configure terminal
interface gi0/1
 shutdown
end
```

STP recalcule la topologie. Un port précédemment bloqué peut passer en forwarding. Quelques pings peuvent être perdus pendant la reconvergence.

Rétablissement :

```text
configure terminal
interface gi0/1
 no shutdown
end
```

---

## Partie 4 - Incident volontaire

| Incident | Symptôme | Vérification | Correction |
|---|---|---|---|
| Trunk absent | Les postes d’un même VLAN ne communiquent pas entre les switchs | `show interfaces trunk` | Configurer `switchport mode trunk` |
| VLAN 20 absent | Le VLAN 10 fonctionne, mais pas le VLAN 20 sur le switch concerné | `show vlan brief` | Créer et nommer le VLAN 20 |
| Mauvais VLAN access | Le poste est isolé des postes attendus | `show vlan brief` ou `show interfaces fa0/x switchport` | Réaffecter le port au bon VLAN |

Exemple de correction d’un trunk :

```text
configure terminal
interface gi0/1
 switchport mode trunk
 switchport trunk allowed vlan 10,20
 no shutdown
end
```

Exemple de correction d’un port access :

```text
configure terminal
interface fa0/1
 switchport mode access
 switchport access vlan 10
end
```

> [!WARNING] À retenir
> Il ne faut pas désactiver STP pour « réparer » une liaison bloquée. Le blocage protège le réseau contre une boucle de couche 2 et une tempête de broadcast.
