# TP 06 - DHCP, DNS et web - Version avancee
> Chapitre associé : [[06-services-reseau]]

## Objectifs

- Deployer plusieurs services applicatifs coherents
- Distinguer un probleme DHCP d'un probleme DNS
- Tester HTTP une fois les services en place

## Contexte

Un petit service informatique veut fournir a ses utilisateurs :

- une configuration IP automatique
- un nom interne pour le serveur
- une page web de test

## Travail demande

### Partie 1 - Services

Sur un serveur unique, configure :

- DHCP
- DNS
- HTTP

Le serveur garde l'IP fixe `192.168.30.10/24`.

### Partie 2 - DHCP

Le serveur doit distribuer :

- IP du reseau `192.168.30.0/24`
- passerelle `192.168.30.254`
- DNS `192.168.30.10`

### Partie 3 - DNS

Ajoute les enregistrements suivants :

- `web.local -> 192.168.30.10`
- `srv.local -> 192.168.30.10`

### Partie 4 - HTTP

Active le service web et personnalise la page d'accueil avec un texte simple, par exemple :

`Serveur de test du LAN Administration`

### Partie 5 - Validation

Depuis un client en DHCP :

1. releve l'IP recue
2. teste `ping web.local`
3. ouvre `http://web.local`

### Partie 6 - Diagnostic

Explique la difference entre ces deux cas :

- Cas 1 : le client recoit une IP `169.254.x.x`
- Cas 2 : le client recoit une bonne IP, mais `web.local` ne s'ouvre pas alors que `ping 192.168.30.10` fonctionne
