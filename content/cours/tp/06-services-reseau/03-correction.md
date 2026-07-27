# TP 06 - DHCP, DNS et web - Correction

## Version debutant

### Ce qui doit fonctionner

- Les clients recoivent automatiquement une IP du pool DHCP.
- Les clients connaissent la passerelle et le DNS.
- Le nom `intra.local` est resolu vers `192.168.10.10`.

### Reponses attendues

1. DHCP sert a distribuer automatiquement la configuration IP.
2. DNS sert a traduire un nom de domaine ou un nom local en adresse IP.
3. Un nom est plus facile a memoriser qu'une IP.

## Version avancee

### Resultat attendu

Un client bien configure doit pouvoir :

- obtenir une IP du bon reseau
- joindre le serveur par IP
- joindre le serveur par nom
- afficher la page web de test

### Analyse des cas

- Cas 1 : `169.254.x.x` indique souvent l'absence de reponse DHCP.
- Cas 2 : si l'IP directe fonctionne mais pas le nom, le probleme est probablement DNS.

## Point a retenir

L'ordre logique est souvent :

1. obtenir une IP
2. resoudre un nom
3. contacter le bon service applicatif
