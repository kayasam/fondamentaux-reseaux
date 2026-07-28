---
title: "TP Packet Tracer : services DHCP et DNS"
tags:
  - fondamentaux-reseaux
  - tp
  - packet-tracer
  - dhcp
  - dns
---

# TP Packet Tracer — Services DHCP et DNS

> Chapitre associé : [[05-services-reseau/05-services-reseau|Couche applicative]]

> [!INFO] Durée indicative
> 45 minutes.

## Objectifs

- configurer un serveur DHCP dans Packet Tracer ;
- fournir automatiquement une passerelle et un serveur DNS ;
- créer un enregistrement DNS interne ;
- vérifier séparément adressage, connectivité et résolution de noms.

## Scénario

Le LAN Administration utilise `192.168.10.0/24`. Sa passerelle est `192.168.10.254`.

Un serveur doit fournir :

- les adresses IPv4 par DHCP ;
- la résolution du nom `serveur.local`.

## Paramètres

| Élément | Valeur |
|---|---|
| Adresse du serveur | `192.168.10.10/24` |
| Passerelle | `192.168.10.254` |
| Adresse du DNS | `192.168.10.10` |
| Plage DHCP | `192.168.10.50` à `192.168.10.100` |
| Nom DNS | `serveur.local` |
| Adresse associée | `192.168.10.10` |

## Travail demandé

### Partie A — Installer le serveur

1. Ajoutez un serveur dans le LAN Administration.
2. Configurez son adresse statique, son masque et sa passerelle.
3. Testez sa communication avec la passerelle.

### Partie B — Configurer DHCP

Dans l’onglet **Services > DHCP** :

1. activez le service ;
2. configurez le réseau `192.168.10.0/24` ;
3. indiquez la passerelle `192.168.10.254` ;
4. indiquez le DNS `192.168.10.10` ;
5. définissez l’adresse de départ `192.168.10.50` ;
6. limitez le nombre d’utilisateurs afin de ne pas dépasser `.100`.

### Partie C — Configurer DNS

Dans **Services > DNS** :

1. activez le service ;
2. ajoutez un enregistrement de type A :

```text
serveur.local → 192.168.10.10
```

### Partie D — Configurer et tester le client

1. Ajoutez un PC dans le même LAN.
2. Sélectionnez la configuration DHCP.
3. Relevez les paramètres reçus.

| Paramètre reçu | Valeur |
|---|---|
| Adresse IPv4 |  |
| Masque |  |
| Passerelle |  |
| DNS |  |

4. Testez dans cet ordre :

```text
ipconfig /all
ping 192.168.10.10
ping serveur.local
nslookup serveur.local
```

## Analyse en mode Simulation

1. Filtrez DHCP et DNS.
2. Renouvelez le bail du client.
3. Repérez les quatre messages DORA.
4. Lancez ensuite `ping serveur.local`.
5. Identifiez la requête DNS qui précède les paquets ICMP.

## Questions

1. Pourquoi le serveur doit-il conserver une adresse fixe ?
2. Quels paramètres le client reçoit-il par DHCP ?
3. Pourquoi tester l’adresse IP avant le nom DNS ?
4. Que se passe-t-il si l’adresse du DNS distribuée est incorrecte ?
5. Quelle différence existe entre le service DHCP et le service DNS ?
