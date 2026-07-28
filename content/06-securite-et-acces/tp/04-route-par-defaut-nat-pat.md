# TP 5.5 – Route par défaut et NAT (PAT)

## Objectifs

- Configurer une route statique par défaut.
- Vérifier le fonctionnement d’un routage simple.
- Mettre en place un NAT avec surcharge (PAT).
- Tester la traduction d’adresses avec un ping ou une requête web.

## Commandes utiles à connaître avant de commencer

Avant de commencer le TP, voici les commandes essentielles que vous utiliserez :

### Route par défaut

- Pour créer une route par défaut vers un prochain saut :
    
    ```
    ip route 0.0.0.0 0.0.0.0 <adresse_next-hop>
    ```
    


### NAT (PAT)

- Pour déclarer une interface comme étant du côté interne :
    
    ```
    ip nat inside
    ```
    
- Pour déclarer une interface comme étant du côté externe :
    
    ```
    ip nat outside
    ```
    
- Pour créer une ACL permettant un réseau privé :
    
    ```
    access-list <num> permit <réseau> <wildcard>
    ```
    
- Pour activer la traduction NAT avec surcharge :
    
    ```
    ip nat inside source list <num> interface <interface_externe> overload
    ```
    

### Vérifications

- Pour afficher la table NAT :
    
    ```
    show ip nat translations
    ```
    
- Pour vérifier le statut du NAT :
    
    ```
    show ip nat statistics
    ```
    
- Pour vérifier les interfaces :
    
    ```
    show ip interface brief
    ```
    
- Pour vérifier la table de routage :
    
    ```
    show ip route
    ```

---



## Table d’adressage

| Machine      | Adresse IP / Masque      | Interface        | Relié à                    |
|--------------|---------------------------|------------------|-----------------------------|
| R1           | 100.100.100.1 /30         | G0/0             | R2 |
| R1           | 80.80.80.254 /24          | G0/1             | SRV-WEB |
| R2           | 100.100.100.2 /30         | G0/0             | R1                          |
| R2           | 192.168.30.254 /24        | G0/1             | S1        |
| PC1          | 192.168.30.1 /24          | NIC              | S1          |
| PC2          | 192.168.30.2 /24          | NIC              | S1          |
| S1           | 192.168.30.3 /24          |               | R1, PC1, PC2          |
| SRV-WEB | 80.80.80.80 /24  | NIC              | R1         |


---

## Partie 1 – Configuration des interfaces

1. Configurer les interfaces de chaque matériel
2. Sur un PC du LAN, tester un ping vers 100.100.100.1.
3. Observer et noter le résultat.

---

## Partie 2 – Route statique par défaut

1. Sur R2, ajouter une route par défaut pointant vers 100.100.100.1.
2. Vérifier la table de routage.
3. Sur un PC du LAN, tester un ping vers 100.100.100.1.
4. Observer et noter le résultat.

---


## Partie 4 – Mise en place du NAT (PAT)

Sur R2 :

1. Déclarer l’interface LAN comme interface inside.
2. Déclarer l’interface externe (vers R1) comme interface outside.
3. Créer une ACL permettant le trafic du réseau 192.168.30.0/24.
4. Activer la traduction NAT  via l’interface externe.

Une fois terminé, vérifier la configuration.

---

## Partie 5 – Tests de fonctionnement

1. Depuis un PC du LAN, effectuer un ping vers une adresse externe.
2. Depuis un PC du LAN, accéder à un serveur web sur le réseau externe (port 80).
3. Sur R2, afficher la table NAT.
4. Identifier au moins deux lignes correspondant à vos tests.
5. Indiquer ce que représentent les colonnes « inside local », « inside global », « outside local » et « outside global ».
    

---

## Partie 6 – Questions

1. Explique la différence entre une route statique et une route par défaut.
2. Pourquoi un réseau privé ne peut-il pas accéder directement à un réseau externe sans NAT ?
3. Qu’est-ce que permet le NAT avec surcharge (PAT) ?
4. Quel est l’intérêt des numéros de ports dans le cadre du PAT ?
5. Comment vérifier que le NAT fonctionne correctement sur le routeur ?
6. À quoi sert la commande permettant d’afficher la table NAT ?



---
