---
title: "Correction : TCP, UDP et diagnostic"
publier: true
---

# TP 04 - TCP, UDP et diagnostic - Correction

> [!TIP] Ressource de la correction
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/04-couche-transport/tp/03-correction.md" download>Télécharger cette correction en Markdown</a>

> Chapitre associé : [[04-couche-transport]]
> Correction des TP : [version débutant](01-debutant.md) et [version avancée](02-avance.md)

## Version debutant

### Tableau attendu

| Service | Port | TCP / UDP |
|---|---|---|
| HTTP | 80 | TCP |
| HTTPS | 443 | TCP |
| DNS | 53 | UDP, parfois TCP |
| DHCP | 67/68 | UDP |
| SSH | 22 | TCP |
| SMTP | 25 | TCP |

### Classement attendu

| Cas | TCP | UDP |
|---|---|---|
| Navigation web | X | |
| DNS | | X |
| VoIP | | X |
| Transfert de fichier fiable | X | |
| Streaming temps reel | | X |

### Lecture de sortie

1. La connexion web securisee est `...:443 ESTABLISHED`.
2. Le service en ecoute est la ligne `LISTENING` sur le port `22`.
3. La ligne UDP sur le port `68` evoque un client DHCP.

## Version avancee

### Analyse du cas HTTPS

Si le `ping` fonctionne, la connectivite IP de base existe deja. Si le port `443` ne repond pas, on suspecte plutot :

- un filtrage pare-feu
- un service web arrete
- un probleme de couche transport ou application

### Etats TCP

| Etat | Explication |
|---|---|
| LISTEN | Le service attend des connexions entrantes |
| ESTABLISHED | La connexion est active |
| SYN-SENT | Le client a demarre l'ouverture de connexion |
| TIME-WAIT | La connexion vient d'etre fermee et le systeme attend avant liberation complete |

### Outils attendus

| Besoin | Outil |
|---|---|
| Voir les ports ouverts localement | `netstat` ou `ss` |
| Tester l'ouverture du port 443 | `telnet` ou `nc` |
| Voir les connexions TCP actives | `netstat` ou `ss` |
| Verifier un nom en IP | `nslookup` ou `dig` |

### Mini-etude

- Cas A : couche 4 ou 7, verifier le port 443, le service web ou le pare-feu
- Cas B : couche 7, verifier le DNS
