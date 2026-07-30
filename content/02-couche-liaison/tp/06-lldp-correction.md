---
title: Correction 06 - Découverte des voisins avec LLDP
publier: true
---

# TP 06 - Correction

> [!TIP] Ressource de la correction
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/02-couche-liaison/tp/06-lldp-correction.md" download>Télécharger cette correction en Markdown</a>


> Correction du TP : [[06-lldp]]

## Partie 1 - Activation de LLDP

### S1

```text
enable
configure terminal
hostname S1
lldp run
end
```

### S2

```text
enable
configure terminal
hostname S2
lldp run
end
```

Vérification :

```text
show lldp
```

Le résultat doit indiquer que LLDP est actif et afficher les temporisations d’émission et de conservation des informations.

> [!TIP] Attente
> Après l’activation, attendre quelques secondes avant d’afficher les voisins afin de laisser les équipements échanger leurs annonces.

---

## Partie 2 - Découverte automatique

Sur S1 :

```text
show lldp neighbors
show lldp neighbors detail
```

S1 doit identifier S2. Sur S2, les mêmes commandes doivent permettre d’identifier S1.

La vue résumée fournit notamment :

- l’identifiant du voisin ;
- l’interface locale ;
- la durée de conservation ;
- les capacités du voisin ;
- le port distant.

La vue détaillée peut également fournir le nom du système, une description et des informations de management.

### Combien de voisins sont découverts ?

Chaque switch découvre **un équipement voisin distinct** : l’autre switch.

Avec la topologie LACP du TP précédent, le même voisin peut apparaître sur les deux interfaces physiques `Gi0/1` et `Gi0/2`. La commande peut donc afficher deux entrées LLDP, mais elles correspondent toutes les deux au même équipement.

### Désactivation pour vérification

```text
configure terminal
no lldp run
end
```

Après expiration des informations, le voisin disparaît. LLDP peut être réactivé avec :

```text
configure terminal
lldp run
end
```

> [!NOTE] Conclusion
> LLDP est un protocole standard de découverte de couche 2. Il facilite l’inventaire, la documentation des connexions et le diagnostic sans transporter le trafic utilisateur.
