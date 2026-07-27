# TP 03 - VLAN, trunk et STP - Version avancee
> Chapitre associé : [[03-couche-liaison]]

## Objectifs

- Etendre des VLAN sur plusieurs switches
- Configurer un trunk 802.1Q
- Observer le fonctionnement de STP ou RSTP
- Diagnostiquer une erreur de segmentation

## Contexte

Tu dois construire un petit reseau de campus avec :

- 3 switches
- 2 VLAN utilisateurs
- 1 lien redondant entre switches

## Exigences

- VLAN 10 : `ADMIN`
- VLAN 20 : `TECH`
- Les VLAN doivent circuler entre les switches via des trunks
- La topologie doit contenir une redondance pour observer STP

## Travail demande

### Partie 1 - Topologie

1. Construis trois switches en triangle.
2. Place au moins :
   - 2 PC dans le VLAN 10
   - 2 PC dans le VLAN 20
3. Repartis les postes sur au moins deux switches differents.

### Partie 2 - Configuration

Configure :

- les VLAN sur tous les switches
- les ports utilisateurs en access
- les liens inter-switch en trunk

### Partie 3 - STP

1. Verifie quel switch devient root bridge.
2. Identifie le port bloque.
3. Coupe un des liens actifs.
4. Observe la reconvergence.

### Partie 4 - Incident volontaire

Choisis une erreur parmi les suivantes puis diagnostique-la :

- trunk absent sur un lien
- VLAN 20 non cree sur un switch
- port PC affecte au mauvais VLAN

Tu dois :

1. decrire le symptome
2. indiquer la commande de verification
3. corriger

## Commandes utiles

```text
show vlan brief
show interfaces trunk
show spanning-tree
show mac address-table
```
