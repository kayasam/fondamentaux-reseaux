# TP 4.2 simplifié — Comprendre les plages IP et les broadcast

> [!TIP] Ressource du TP
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/03-couche-reseau/tp/01-plages-ipv4.md" download>Télécharger ce TP en Markdown</a>


### Objectif

- Comprendre ce qu’est un **réseau**, une **plage d’hôtes** et un **broadcast**
    
- Savoir **lire un masque CIDR** (/24, /25, /26…)
    
- Calculer **facilement** :
    
    - Adresse réseau
        
    - Première IP
        
    - Dernière IP
        
    - Broadcast
        

---

## 1. Rappel simple

Un réseau IP contient toujours :

- **Adresse réseau** → première adresse (non utilisable)
    
- **Plage d’hôtes** → utilisables
    
- **Broadcast** → dernière adresse (non utilisable)
    

👉 Règle simple :

```
Réseau = première adresse
Broadcast = dernière adresse
Hôtes = tout ce qu’il y a entre les deux
```

---

## 2. Méthode simplifiée (à appliquer à chaque fois)

### Étape 1 — Identifier le masque

|CIDR|Masque|Nombre IP|Hôtes utilisables|
|---|---|---|---|
|/24|255.255.255.0|256|254|
|/25|255.255.255.128|128|126|
|/26|255.255.255.192|64|62|
|/27|255.255.255.224|32|30|
|/28|255.255.255.240|16|14|
|/29|255.255.255.248|8|6|
|/30|255.255.255.252|4|2|

---

### Étape 2 — Trouver le “pas”

👉 Le **pas** = taille du bloc

Exemples :

- /24 → pas de 256
    
- /25 → pas de 128
    
- /26 → pas de 64
    
- /27 → pas de 32
    
- /28 → pas de 16
    
- /29 → pas de 8
    
- /30 → pas de 4
    

---

### Étape 3 — Découper

On ajoute le pas :

Exemple en /26 :

```
0 → 64 → 128 → 192 → 256
```

---

## 3. Exercice 1 (guidé)

### Réseau :

**192.168.10.0 /26**

### Étape 1 — Taille

- /26 → 64 adresses
    
- 62 utilisables
    

### Étape 2 — Découpage

```
192.168.10.0
192.168.10.64
192.168.10.128
192.168.10.192
```

---

### Compléter :

|Réseau|Première IP|Dernière IP|Broadcast|
|---|---|---|---|
|192.168.10.0|?|?|?|
|192.168.10.64|?|?|?|

👉 Aide :

- Broadcast = juste avant le réseau suivant
    
- Première IP = réseau + 1
    
- Dernière IP = broadcast - 1
    

---

## 4. Exercice 2 (semi-guidé)

### Réseau :

**192.168.10.0 /27**

### Étape 1 — Taille

- 32 adresses
    

### Étape 2 — Pas

- 32
    

### Étape 3 — Découpage

```
192.168.10.0
192.168.10.32
192.168.10.64
192.168.10.96
```

---

### Compléter :

|Réseau|Première IP|Dernière IP|Broadcast|
|---|---|---|---|
|192.168.10.0|?|?|?|
|192.168.10.32|?|?|?|
|192.168.10.64|?|?|?|

---

## 5. Exercice 3 (autonomie)

### Réseau :

**192.168.10.0 /28**

👉 Faire :

1. Trouver le pas
    
2. Découper
    
3. Compléter le tableau
    

|Réseau|Première IP|Dernière IP|Broadcast|
|---|---|---|---|
|192.168.10.0|?|?|?|
|192.168.10.16|?|?|?|
|192.168.10.32|?|?|?|

---

## 6. Astuce importante (à retenir)

Toujours penser :

```
Réseau = début du bloc
Broadcast = fin du bloc
Hôtes = entre les deux
```

---
