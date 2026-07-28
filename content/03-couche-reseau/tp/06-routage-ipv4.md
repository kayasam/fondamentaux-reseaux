# TP 4.7 — Routage IPv4 de base

##  Commandes utiles

```
show ip interface brief
show ip route
```

---

## Objectifs

- Interconnecter plusieurs réseaux IP à l’aide d’un **routeur Cisco**.
- Configurer les interfaces, les adresses et les passerelles.
- Vérifier la **table de routage** et la **connectivité inter-LAN**.
    

---

## Scénario

Trois réseaux locaux doivent communiquer entre eux :

|Réseau|Département|Adresse réseau|Nombre de PC|
|---|---|---|---|
|LAN 1|Administration|192.168.10.0 /24|2|
|LAN 2|Technique|192.168.20.0 /24|2|
|LAN 3|Comptabilité|192.168.30.0 /24|2|

Un seul routeur relie ces trois LAN.

---

## Étapes à réaliser

### 1️ Construisez la topologie

- Placez **un routeur** et **trois switchs**.
    
- Reliez chaque switch à une interface différente du routeur.
    
- Ajoutez **deux PC** par réseau.
    

Pourquoi un routeur peut-il relier plusieurs réseaux différents ?

---

### 2️ Plan d’adressage

- Chaque LAN utilise un **/24 distinct**.
    
- Choisissez l’adresse de **passerelle** pour chaque réseau (souvent .254).
    
- Attribuez les adresses IP à compléter :
    

|Équipement|Interface|Adresse IP|Masque|Passerelle|
|---|---|---|---|---|
|**R1**|G0/0||||
|**R1**|G0/1||||
|**R1**|G0/2||||
|**PC-A1 / A2**|—||||
|**PC-T1 / T2**|—||||
|**PC-C1 / C2**|—||||

---

### 3️ Configuration

- Configurez les interfaces du routeur avec les adresses prévues.
    
- Vérifiez leur état avec :
    
    ```
    show ip interface brief
    ```
    
- Configurez les IP et **passerelles** sur chaque PC.
    
- Testez d’abord les pings **locaux** (PC ↔ routeur du même réseau).
    

---

### 4️ Vérification du routage

- Essayez un **ping** entre deux PC de réseaux différents.
    
- Si cela échoue :
    
    - vérifiez les masques,
        
    - les passerelles,
        
    - et l’état des interfaces.
        
- Affichez ensuite la **table de routage** du routeur :
    
    ```
    show ip route
    ```
    
    → combien de réseaux y voyez-vous ? que signifie la lettre **C** et **L** ?
    

---


## Questions de réflexion

1. Quelle différence entre un **switch** et un **routeur** ?
    
2. Pourquoi faut-il une **passerelle par défaut** sur chaque PC ?
    
3. Que représente la table `show ip route` ?
    
4. Qu’arrive-t-il si une interface du routeur est désactivée ?
    

---

## À retenir

- Le **switch** connecte les hôtes d’un même LAN (couche 2).
    
- Le **routeur** connecte des **réseaux IP différents** (couche 3).
    
- Chaque interface du routeur = **un réseau distinct**.
    
- Les pings entre LAN prouvent que le **routage IP** fonctionne.
    


## Extension : VLAN de sauvegarde

L’administrateur souhaite maintenant ajouter un VLAN BACKUP sur le même câble que le LAN 1 – Administration.

1. Créez un réseau de sauvegarde dédié (par exemple 192.168.99.0/24).

2. Configurez le switch du LAN 1 pour permettre la coexistence des deux réseaux sur le même lien.

Indice : il faut creer des sous interfaces (voir aide CLI au debut du doc)

3. Le routeur devra pouvoir communiquer simultanément avec les deux VLANs.

4. Ajoutez un PC de sauvegarde dans ce VLAN et testez la communication.

https://hedgedoc.dawan.fr/qrE77VtfQf6Wiqgvz4YaHQ
