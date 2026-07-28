---
title: "06 - Découverte des voisins avec LLDP"
---

# TP 06 - Protocole de découverte LLDP

###  Commandes utilisables

```
lldp run
no lldp run
show lldp
show lldp neighbors
show lldp neighbors detail
hostname <nom>
```

---

##  Objectifs

- Utiliser le protocole **LLDP** pour découvrir automatiquement les voisins réseau.
- Vérifier la détection des liens et des noms d’hôtes via **LLDP**.
- Comprendre son utilité pour la **documentation et le diagnostic**.
    

---

## Consignes

### 1️ Activation de LLDP

- Utilisez la même topologie que le TP 3.5 (S1 ↔ S2).
- Activez **LLDP** sur les deux switchs.
- Vérifiez que le protocole est bien en fonctionnement.

 _Indice :_ la commande `show lldp` indique l’état global du service.

---

### 2️ Découverte automatique

- Affichez les voisins LLDP découverts par chaque switch.

 _Question :_ combien de voisins chaque switch découvre-t-il ?

---
