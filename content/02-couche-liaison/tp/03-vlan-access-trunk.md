---
title: "03 - VLAN : ports access et trunk"
---

# TP 3.1 — VLAN de base (mode access)

> [!TIP] Ressource du TP
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/02-couche-liaison/tp/03-vlan-access-trunk.md" download>Télécharger ce TP en Markdown</a>


### Table d’adressage

|Nom|Type|Adresse IP|VLAN|Port connecté|
|---|---|---|---|---|
|**S1**|Switch|N/A|VLAN 10 (Bleu)|Fa0/1 – Fa0/2|
||||VLAN 20 (Vert)|Fa0/23 – Fa0/24|
|**PC-BLEU-1**|PC|192.168.10.1 /24|VLAN 10 (Bleu)|Fa0/1|
|**PC-BLEU-2**|PC|192.168.10.2 /24|VLAN 10 (Bleu)|Fa0/2|
|**PC-VERT-1**|PC|192.168.20.1 /24|VLAN 20 (Vert)|Fa0/23|
|**PC-VERT-2**|PC|192.168.20.2 /24|VLAN 20 (Vert)|Fa0/24|

---

### Consignes

1. Mettez en place le réseau et affectez les IP selon la table ci-dessus.
    
2. Créez les VLANs nécessaires sur le switch et attribuez les ports correspondants.
    
3. Vérifiez la configuration (commande de votre choix).
    
4. Testez la communication entre PC d’un même VLAN et entre VLANs différents.
    
5. Observez la table d’adresses MAC du switch :
    
    - Que constatez-vous après plusieurs échanges ?
        
    - Pourquoi un PC du VLAN 10 ne communique-t-il pas avec un du VLAN 20 ?
        

💡 _Indice_ : un **port access** n’appartient qu’à un **seul VLAN**.

---

# TP 3.2 — VLANs sur plusieurs switchs (mode trunk)

### Table d’adressage

|Nom|Type|Adresse IP|VLAN|Port connecté|
|---|---|---|---|---|
|**S1**|Switch|N/A|VLAN 10 (Bleu)|Fa0/1 – Fa0/2|
||||VLAN 20 (Vert)|Fa0/23 – Fa0/24|
||||Lien trunk|Gi0/1 (vers S2 Gi0/1)|
|**S2**|Switch|N/A|VLAN 10 (Bleu)|Fa0/1 – Fa0/2|
||||VLAN 20 (Vert)|Fa0/23 – Fa0/24|
||||Lien trunk|Gi0/1 (vers S1 Gi0/1)|
|**PC-BLEU-3**|PC|192.168.10.3 /24|VLAN 10 (Bleu)|S2 Fa0/1|
|**PC-VERT-3**|PC|192.168.20.3 /24|VLAN 20 (Vert)|S2 Fa0/23|

---

### Consignes

1. Reprenez le réseau du TP précédent.
    
2. Ajoutez un second switch (S2) et connectez-le à S1 via un lien **GigabitEthernet**.
    
3. Faites en sorte que les VLAN 10 et 20 puissent être **propagés** entre S1 et S2.
    
    > _Indice_ : il faudra un lien spécial capable de transporter plusieurs VLANs.
    
4. Vérifiez la configuration de ce lien et les VLANs autorisés.
    
5. Ajoutez les deux nouveaux PC sur S2 et testez la communication :
    
    - entre VLAN 10 des deux switchs ;
        
    - entre VLAN 20 des deux switchs ;
        
    - entre VLANs différents.
        
6. Concluez : quel est le rôle du mode **trunk** par rapport au mode **access** ?
    

💡 _Indice_ : Observez le comportement de la commande qui affiche les VLANs actifs ou les liens trunk.

---
