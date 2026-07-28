---
title: "01 - Hub, switch et duplex"
---

# TP 01 - Hub vs switch et notions de duplex

## Objectifs

- Observer les différences de comportement entre un **hub** et un **switch**.
- Comprendre les notions de **collision**, **flooding** et **table MAC**.
- Mettre en évidence les effets du **duplex half/full** sur la transmission.
    

---

## Partie 1 – Hub (couche 1)

Mettre en place un petit réseau de trois postes reliés à un **hub**.  
Attribuer des adresses IP dans le même réseau.  
Effectuer plusieurs échanges simultanés (`ping` entre PC).  
Analyser le trafic en **mode Simulation** et déduire le fonctionnement du hub.  
Noter la présence de **diffusion globale** et de **collisions** sur le support.

---

## Partie 2 – Switch (couche 2)

Reproduire le même scénario avec un **switch**.  
Observer la différence de comportement :

- trames initialement diffusées, puis dirigées uniquement vers les ports concernés ;
    
- construction de la **table MAC** au fil des échanges.
    

Comparer le domaine de collision avec celui du hub et conclure sur les performances obtenues.

---

## Partie 3 – Mode duplex

Relier deux **switchs** entre eux.  
Configurer manuellement un désaccord de duplex :

- Switch A : `duplex full`
    
- Switch B : `duplex half`
    

Contrôler l’état du lien et observer les erreurs sur les interfaces (`show interfaces`).  
Analyser l’impact d’un **mauvais appairage de duplex** sur les performances.  
Repasser ensuite en **full duplex** des deux côtés et constater la disparition des erreurs.

---
