# TP 4.2 — Plan d’adressage avec VLSM

> [!TIP] Ressource du TP
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/03-couche-reseau/tp/02-plan-adressage-vlsm.md" download>Télécharger ce TP en Markdown</a>


## Objectifs

- Concevoir un plan d’adressage **hiérarchique et optimisé**.
- Appliquer la méthode du **VLSM** (Variable Length Subnet Mask). 
- Identifier pour chaque sous-réseau : le réseau, le masque, la plage d’hôtes et le broadcast.
    

---

## Énoncé

Votre entreprise dispose du réseau principal :

> **192.168.10.0 /24**

et doit le diviser selon les besoins suivants :

|Département|Nombre de machines|Remarques|
|---|---|---|
|Direction|25|1 imprimante réseau comprise|
|Comptabilité|12|—|
|Technique|50|—|
|Support|10|—|
|Lien inter-routeur|2|connexion point-à-point entre deux sites|

**Travail demandé :**

1. Déterminez le **masque** nécessaire pour chaque réseau.
    
2. Classez les besoins du **plus grand au plus petit**.
    
3. Créez votre **plan d’adressage complet**.
    


Site de IT-Connect:
https://www.it-connect.fr/adresses-ipv4-et-le-calcul-des-masques-de-sous-reseaux/

---
