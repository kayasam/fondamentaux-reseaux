# TP 1 – Projet : Réseau de la mairie de Bourg

### Cahier des charges

La mairie de Bourg souhaite modéliser son **réseau interne** dans Cisco Packet Tracer.

Le bâtiment comprend **3 salles principales**, chacune disposant de son propre **switch**.  
Les salles doivent être reliées entre elles et à un **switch coeur de réseau** lui meme relié à un **routeur principal**, qui assurera plus tard la sortie vers Internet.

---

### Description des salles

|Salle|Nom / Couleur|Équipements présents|Particularités|
|---|---|---|---|
|**Salle Rouge**|Accueil|2 PC fixes, 1 ordinateur portable, 1 imprimante|Connectés à un switch local|
|**Salle Bleue**|Bureau du Maire|1 PC fixe, 1 ordinateur portable|Connectés à un switch local|
|**Salle Verte**|Informatique|3 serveurs (Web, Fichier, Mail) + 1 switch|Reliée aux autres salles|

---

### Consignes de réalisation

- Créez le **réseau complet** de la mairie selon la description des trois salles. 
- Faites attention au **choix du matériel** : sélectionnez des modèles adaptés aux besoins de chaque salle.
- Les **liaisons entre équipements réseau** (switch ↔ switch, switch ↔ switch (coeur)) doivent être réalisées en **GigabitEthernet**.
- Les **équipements terminaux** (PC, imprimantes, serveurs, etc.) doivent être connectés en **FastEthernet**.
- Nommez clairement chaque équipement et chaque salle.
- Aucune configuration IP n’est demandée pour ce TP : concentrez-vous sur la **couche physique** et le **câblage**.
- Sauvegardez votre travail sous :  
    **`TP2_Mairie_Nom.Prénom.pkt`**
---

### Tableau à compléter

|Nom de l’équipement|Type|Modèle choisi|Rôle / explication|Relié à (nom + port)|
|---|---|---|---|---|
|…|…|…|…|…|

_(À remplir directement dans vos notes ou sur une feuille annexe.)_

---

### Aide

- Les **ports FastEthernet (Fa)** servent généralement aux **postes utilisateurs** et aux **périphériques**.
    
- Les **ports GigabitEthernet (Gi)** sont souvent utilisés pour les **liaisons entre équipements réseau** (switch ↔ routeur, switch ↔ switch).
    
- Vérifiez les **voyants** dans Packet Tracer :  
    🟢 = lien actif 🟠 = initialisation 🔴 = problème de câble ou de port.
    
- Pensez à nommer et organiser votre schéma pour qu’il reste **lisible** et **réaliste**.
