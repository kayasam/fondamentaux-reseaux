# Publier les cours depuis le coffre Obsidian

Le coffre Obsidian reste la source officielle :

`C:\Users\kayaw\Nextcloud\Obsidian\CoffreSam\Formations\fondamentaux-reseaux`

## Publication rapide

1. Terminer les modifications dans Obsidian et attendre la synchronisation Nextcloud.
2. Ouvrir `D:\Projet-git\fondamentaux-reseaux-web`.
3. Double-cliquer sur `Publier les cours.cmd`.
4. Saisir un message décrivant la modification, ou appuyer sur Entrée.
5. Confirmer la publication avec `O`.

Le script :

- synchronise `cours` et `Ressources/images` avec le projet web ;
- exclut les fichiers Excalidraw ;
- adapte les liens d'images pour Quartz sans modifier le coffre ;
- affiche le résumé des changements ;
- crée le commit et l'envoie sur GitHub.

GitHub reconstruit ensuite automatiquement le site et l'archive Obsidian.

Site : <https://kayasam.github.io/fondamentaux-reseaux/>
