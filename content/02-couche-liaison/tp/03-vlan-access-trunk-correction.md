---
title: "Correction 03 - VLAN : ports access et trunk"
publier: true
---

# TP 03 - Correction

> [!TIP] Ressource de la correction
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/02-couche-liaison/tp/03-vlan-access-trunk-correction.md" download>Télécharger cette correction en Markdown</a>


> Correction du TP : [[03-vlan-access-trunk]]

## Partie A - VLAN de base en mode access

### Configuration de S1

```text
enable
configure terminal

vlan 10
 name BLEU
vlan 20
 name VERT

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

### Vérification

```text
show vlan brief
show mac address-table
```

Résultats attendus :

- PC-BLEU-1 communique avec PC-BLEU-2 ;
- PC-VERT-1 communique avec PC-VERT-2 ;
- les communications entre VLAN 10 et VLAN 20 échouent ;
- après les pings, les adresses MAC apparaissent dans le VLAN et sur le port correspondants.

Le switch apprend l’adresse MAC source des trames. Il ne transfère toutefois jamais directement une trame d’un VLAN vers un autre.

---

## Partie B - VLAN sur plusieurs switchs

Les VLAN 10 et 20 doivent être créés sur les deux switchs. Le trunk transporte les trames des deux VLAN entre S1 et S2.

### Configuration complémentaire de S1

```text
enable
configure terminal

interface gi0/1
 switchport mode trunk
 switchport trunk allowed vlan 10,20
 no shutdown

end
copy running-config startup-config
```

### Configuration de S2

```text
enable
configure terminal

vlan 10
 name BLEU
vlan 20
 name VERT

interface fa0/1
 switchport mode access
 switchport access vlan 10
 no shutdown

interface fa0/23
 switchport mode access
 switchport access vlan 20
 no shutdown

interface gi0/1
 switchport mode trunk
 switchport trunk allowed vlan 10,20
 no shutdown

end
copy running-config startup-config
```

### Vérification du trunk

Sur les deux switchs :

```text
show interfaces trunk
show vlan brief
```

La sortie de `show interfaces trunk` doit indiquer :

- `Gi0/1` en mode trunk ;
- l’encapsulation 802.1Q ;
- les VLAN 10 et 20 autorisés et actifs.

### Résultats des tests

| Test | Résultat attendu |
|---|---|
| PC-BLEU-1 vers PC-BLEU-3 | Réussi |
| PC-VERT-1 vers PC-VERT-3 | Réussi |
| Un PC BLEU vers un PC VERT | Échec |

### Rôle des modes

- Un port **access** relie généralement un poste et transporte un seul VLAN.
- Un port **trunk** relie généralement des équipements réseau et transporte plusieurs VLAN grâce à l’étiquetage 802.1Q.

> [!TIP] Diagnostic
> Si deux postes du même VLAN ne communiquent pas entre les switchs, vérifier d’abord la présence du VLAN sur les deux équipements, l’état du trunk et la liste des VLAN autorisés.
