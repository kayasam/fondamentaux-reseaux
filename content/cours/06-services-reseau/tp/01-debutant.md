# TP 06 - DHCP et DNS - Version debutant
> Chapitre associé : [[06-services-reseau]]

## Objectifs

- Configurer un poste en DHCP
- Comprendre le role de DNS
- Verifier qu'un service de nom fonctionne

## Contexte

Sur un petit LAN, un serveur doit fournir :

- des adresses IP via DHCP
- la resolution de noms via DNS

## Materiel

- 1 routeur ou passerelle
- 1 switch
- 1 serveur
- 2 PC clients

## Plan d'adressage conseille

| Equipement | Adresse |
|---|---|
| Serveur | 192.168.10.10/24 |
| Passerelle | 192.168.10.254/24 |
| Pool DHCP | 192.168.10.50 a 192.168.10.100 |
| DNS distribue | 192.168.10.10 |

## Travail demande

### Partie 1 - Configurer le serveur

1. Attribue une IP fixe au serveur.
2. Active le service DHCP.
3. Cree un pool pour le reseau `192.168.10.0/24`.
4. Renseigne :
   - la passerelle
   - le DNS
   - la plage d'adresses

### Partie 2 - Configurer DNS

Ajoute un enregistrement :

`intra.local -> 192.168.10.10`

### Partie 3 - Configurer les clients

1. Mets les deux PC en DHCP.
2. Verifie l'adresse recue.
3. Teste :
   - ping vers la passerelle
   - ping vers le serveur
   - ping vers `intra.local`

## Questions

1. A quoi sert DHCP ?
2. A quoi sert DNS ?
3. Pourquoi un nom est-il plus pratique qu'une adresse IP pour l'utilisateur ?
