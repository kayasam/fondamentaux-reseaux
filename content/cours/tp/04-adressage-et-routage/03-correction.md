# TP 04 - IPv4, VLSM et routage - Correction

## Version debutant

### Lecture d'adresses

Pour `192.168.10.0/24` :

| Element | Valeur |
|---|---|
| Adresse reseau | `192.168.10.0` |
| Premiere IP utilisable | `192.168.10.1` |
| Derniere IP utilisable | `192.168.10.254` |
| Broadcast | `192.168.10.255` |

Pour `192.168.10.64/26` :

| Element | Valeur |
|---|---|
| Adresse reseau | `192.168.10.64` |
| Premiere IP utilisable | `192.168.10.65` |
| Derniere IP utilisable | `192.168.10.126` |
| Broadcast | `192.168.10.127` |

### Routage simple

Si les postes ont la bonne IP, le bon masque et la bonne passerelle, le ping entre `192.168.10.0/24` et `192.168.20.0/24` doit fonctionner.

## Version avancee

### Exemple de VLSM correct

| Segment | Reseau | CIDR | Premiere IP | Derniere IP | Broadcast |
|---|---|---|---|---|---|
| Administration | `192.168.50.0` | `/26` | `192.168.50.1` | `192.168.50.62` | `192.168.50.63` |
| Comptabilite | `192.168.50.64` | `/27` | `192.168.50.65` | `192.168.50.94` | `192.168.50.95` |
| Support | `192.168.50.96` | `/28` | `192.168.50.97` | `192.168.50.110` | `192.168.50.111` |
| Inter-routeur | `192.168.50.112` | `/30` | `192.168.50.113` | `192.168.50.114` | `192.168.50.115` |

### Pourquoi ces choix

- 50 hotes -> `/26` donne 62 hotes utilisables
- 25 hotes -> `/27` donne 30 hotes utilisables
- 12 hotes -> `/28` donne 14 hotes utilisables
- 2 hotes -> `/30` donne 2 hotes utilisables

### Point de vigilance

Les erreurs les plus frequentes sont :

- oublier la passerelle sur les PC
- mettre un mauvais masque
- ne pas ajouter de route vers les reseaux distants
