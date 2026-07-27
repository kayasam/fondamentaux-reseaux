# TP 03 - VLAN, trunk et STP - Correction

## Version debutant

### Resultats attendus

- Les PC du **VLAN 10** communiquent entre eux.
- Les PC du **VLAN 20** communiquent entre eux.
- Les pings entre **VLAN 10** et **VLAN 20** echouent.

### Pourquoi

Un VLAN cree un **domaine de broadcast distinct**. Sans routeur ou switch couche 3, il n'y a pas de communication inter-VLAN.

### Exemple de configuration

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
interface range fa0/23 - 24
 switchport mode access
 switchport access vlan 20
end
```

## Version avancee

### Trunk attendu

Les liens inter-switch doivent etre en `switchport mode trunk`, avec au minimum les VLAN 10 et 20 autorises.

### STP attendu

Dans une topologie en triangle :

- un switch devient **root bridge**
- un port redondant passe en **blocking** ou equivalent
- si un lien principal tombe, un autre lien peut passer en forwarding apres reconvergence

### Incidents typiques

| Incident | Symptome | Verification | Correction |
|---|---|---|---|
| Trunk absent | Les postes du meme VLAN ne communiquent pas entre switches | `show interfaces trunk` | Passer le port en trunk |
| VLAN absent sur un switch | Un seul cote fonctionne | `show vlan brief` | Creer le VLAN manquant |
| Mauvais VLAN sur un port access | Le poste ne voit pas les bons voisins | `show run interface ...` | Reaffecter le bon VLAN |

## Point a retenir

Le role de la couche 2 n'est pas seulement de transporter des trames :

- elle segmente localement avec les VLAN
- elle evite les boucles avec STP
- elle transporte plusieurs VLAN avec les trunks
