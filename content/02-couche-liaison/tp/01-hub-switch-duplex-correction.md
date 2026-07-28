---
title: Correction 01 - Hub, switch et duplex
publier: true
---

# TP 01 - Correction

> Correction du TP : [[01-hub-switch-duplex]]

## Partie 1 - Hub

### Adressage possible

| Poste | Adresse IPv4 | Masque |
|---|---|---|
| PC1 | `192.168.1.11` | `255.255.255.0` |
| PC2 | `192.168.1.12` | `255.255.255.0` |
| PC3 | `192.168.1.13` | `255.255.255.0` |

Les trois postes appartiennent au réseau `192.168.1.0/24`. Aucune passerelle n’est nécessaire pour ce test local.

### Résultat attendu

Les trois postes peuvent communiquer, mais le hub répète chaque signal reçu sur tous ses autres ports.

En mode Simulation :

- les trames sont visibles sur l’ensemble des ports ;
- tous les postes partagent le même média ;
- deux émissions simultanées peuvent provoquer une collision ;
- le hub ne possède aucune table d’adresses MAC.

> [!NOTE] Conclusion
> Un hub travaille à la couche 1. Il ne connaît ni les trames ni les adresses MAC : il répète seulement les bits.

---

## Partie 2 - Switch

### Résultat attendu

Au début des échanges, le switch ne connaît pas encore toutes les adresses MAC :

1. il apprend l’adresse MAC source sur le port d’arrivée ;
2. il diffuse les broadcasts et les unicasts dont la destination est inconnue ;
3. après apprentissage, il transmet les unicasts connus uniquement sur le port du destinataire.

Commande de vérification :

```text
enable
show mac address-table
```

Exemple de résultat attendu :

```text
Vlan    Mac Address       Type       Ports
----    -----------       --------   -----
   1    00D0.1111.1111    DYNAMIC    Fa0/1
   1    00D0.2222.2222    DYNAMIC    Fa0/2
   1    00D0.3333.3333    DYNAMIC    Fa0/3
```

Les adresses exactes dépendent des PC utilisés.

### Comparaison

| Critère | Hub | Switch |
|---|---|---|
| Couche | 1 | 2 |
| Apprentissage MAC | Non | Oui |
| Domaine de collision | Un domaine partagé | Un domaine par port |
| Transmission | Tous les ports | Port utile lorsque la destination est connue |
| Duplex habituel | Half-duplex | Full-duplex |

---

## Partie 3 - Désaccord de duplex

Pour rendre le test possible dans Packet Tracer, on peut relier les deux switchs sur `Fa0/24`. Certains modèles n’acceptent pas le half-duplex sur une interface GigabitEthernet.

### Switch A

```text
enable
configure terminal
interface fa0/24
 speed 100
 duplex full
 no shutdown
end
```

### Switch B

```text
enable
configure terminal
interface fa0/24
 speed 100
 duplex half
 no shutdown
end
```

Vérification :

```text
show interfaces fa0/24
```

Résultats possibles :

- débit irrégulier ou plus faible ;
- collisions ou collisions tardives du côté half-duplex ;
- erreurs d’entrée ou erreurs CRC du côté full-duplex ;
- pertes ou délais pendant des échanges simultanés.

Packet Tracer ne simule pas toujours tous les compteurs d’erreur d’un équipement réel. Le point essentiel est que les deux extrémités doivent utiliser les mêmes paramètres.

### Correction du désaccord

```text
configure terminal
interface fa0/24
 duplex full
end
```

La commande est exécutée sur les deux switchs.

Une autre solution consiste à remettre la négociation automatique des deux côtés :

```text
configure terminal
interface fa0/24
 speed auto
 duplex auto
end
```

> [!NOTE] Conclusion
> Un lien full-duplex permet d’émettre et de recevoir simultanément et ne fonctionne pas avec CSMA/CD. Un désaccord de duplex dégrade fortement les performances.
