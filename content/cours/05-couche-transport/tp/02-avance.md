# TP 05 - TCP, UDP et diagnostic - Version avancee
> Chapitre associé : [[05-couche-transport]]

## Objectifs

- Lire un schema de communication client / serveur
- Interpreter des etats TCP
- Choisir des outils de diagnostic adaptes

## Contexte

Un technicien observe les symptomes suivants :

- un utilisateur n'ouvre plus un site en HTTPS
- le `ping` vers le serveur repond
- le `telnet` ou `nc` vers le port 443 echoue

## Travail demande

### Partie 1 - Raisonnement

1. Pourquoi le probleme ne semble-t-il pas relever de la couche 3 pure ?
2. Pourquoi la couche 4 est-elle suspecte ?

### Partie 2 - Etats TCP

Explique en une phrase chaque etat :

| Etat | Explication |
|---|---|
| LISTEN | |
| ESTABLISHED | |
| SYN-SENT | |
| TIME-WAIT | |

### Partie 3 - Outils

Associe chaque besoin a l'outil le plus adapte :

| Besoin | Outil |
|---|---|
| Voir les ports ouverts localement | |
| Tester l'ouverture du port 443 d'un serveur | |
| Voir les connexions TCP actives | |
| Verifier si un nom est resolu en IP | |

### Partie 4 - Mini-etude

Voici deux cas :

- Cas A : un site ne s'ouvre pas, mais `ping` et `nslookup` fonctionnent, et `nc -zv serveur 443` echoue
- Cas B : `nslookup` echoue, mais le `ping` vers l'IP du serveur fonctionne

Pour chaque cas, indique :

1. la couche la plus suspecte
2. le composant probablement en cause
3. une action de verification
