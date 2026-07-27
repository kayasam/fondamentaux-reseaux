# Fondamentaux réseaux — Organisation des chapitres

Chaque dossier de chapitre rassemble :

- le cours Markdown ;
- le cours HTML interactif ;
- le TP débutant ;
- le TP avancé ;
- la correction conservée dans le coffre du formateur.

## Chapitres

| Chapitre | Thème | Dossier |
|---|---|---|
| 1 | Introduction, topologies et modèle OSI | `01-introduction-reseaux/` |
| 2 | Couche physique | `02-couche-physique/` |
| 3 | Couche liaison | `03-couche-liaison/` |
| 4 | Couche réseau, adressage et routage | `04-couche-reseau/` |
| 5 | Couche transport | `05-couche-transport/` |
| 6 | Services réseau | `06-services-reseau/` |
| 7 | Sécurité et accès réseau | `07-securite-et-acces/` |

Les anciens TP du chapitre « réseau avancé » sont maintenant rangés dans :

`04-couche-reseau/tp/reseau-avance/`

## Publier une correction

Les corrections possèdent ce frontmatter :

```yaml
---
publier: false
---
```

Elles restent ainsi dans le coffre du formateur, mais ne sont envoyées ni sur le site public ni dans l'archive ZIP des élèves.

Pour rendre une correction publique après un TP :

1. ouvrir son fichier `03-correction.md` ;
2. remplacer `publier: false` par `publier: true` ;
3. lancer `Publier les cours.cmd`.

Pour la masquer de nouveau, remettre `publier: false` puis republier.
