---
title: "05 - Agrégation de liens LACP"
---

# TP 05 - Agrégation de liens (LACP)

###  Commandes utilisables

```
enable
configure terminal
vlan <id>
name <nom>
interface <type><numéro>
channel-group <id> mode <active|on>
interface port-channel <id>
switchport mode <access|trunk>
switchport access vlan <id>
switchport trunk allowed vlan <id>
show vlan brief
show interfaces port-channel <id>
show etherchannel summary
copy running-config startup-config
```

---

##  Objectifs

- Mettre en œuvre une **agrégation de liens Ethernet** entre deux switchs.
    
- Utiliser le protocole **LACP (IEEE 802.3ad)**.
    

---

###  Table d’adressage

|Nom|Type|Adresse IP|VLAN|Ports connectés|
|---|---|---|---|---|
|**S1**|Switch|N/A|VLAN 10|Gi0/1 – Gi0/2 (agrégation)|
|**S2**|Switch|N/A|VLAN 10|Gi0/1 – Gi0/2 (agrégation)|
|**PC1**|PC|192.168.10.1 /24|VLAN 10|S1 Fa0/10|
|**PC2**|PC|192.168.10.2 /24|VLAN 10|S2 Fa0/10|

---

## Consignes

### 1️ Mise en place du réseau

- Montez le réseau selon la table d’adressage.
    
- Les deux switchs sont reliés par **deux liens GigabitEthernet**.
    
- Les PC appartiennent au **même VLAN (10)** et sont connectés sur `Fa0/10`.
    

### 2️ Création du VLAN et des ports access

- Créez le **VLAN 10** sur chaque switch.
    
- Affectez les ports `Fa0/10` au VLAN 10.
    
- Vérifiez que les ports appartiennent bien au VLAN avec la commande appropriée.
    


---

### 3️ Mise en place de l’agrégation LACP

- Agrégez les ports `Gi0/1` et `Gi0/2` de chaque switch dans un même **port-channel**.
    
- Utilisez le **mode LACP (active)** pour la négociation automatique.
    
- Configurez le port-channel pour transporter le VLAN 10 (mode trunk).
    
- Vérifiez le statut du port-channel et des interfaces membres.

---
