# Note — NAT, pour aller plus loin

> [!info]
> L'explication de référence (SNAT/DNAT, statique/dynamique/PAT, masquerade) vit maintenant dans **[[06-securite-et-acces#7.1 NAT / PAT]]**. Cette note ne garde que la méthode d'analyse et des exemples travaillés, pour s'entraîner une fois le cours lu.

---

## Mini-méthode pour analyser un cas NAT

Face à une configuration NAT, pose toujours ces questions dans l'ordre :

1. Le trafic va dans quel sens ?
2. Est-ce que l'adresse source change ?
3. Est-ce que l'adresse destination change ?
4. Est-ce que les ports changent aussi ?
5. La correspondance est-elle fixe, dynamique ou créée à la volée ?

Exemple :

```text
192.168.1.10:51500 -> 8.8.8.8:53
devient
80.12.45.20:62000 -> 8.8.8.8:53
```

Analyse :

- l'adresse source change : **SNAT**,
- le port source change aussi : **PAT**,
- plusieurs machines peuvent partager `80.12.45.20`,
- c'est le NAT de sortie classique.

---

## Trois exemples typiques

### Exemple 1 — Un PC sort vers Internet

Cas le plus courant : box Internet.

```text
PC privé                         Box / routeur                      Internet

192.168.1.10:51000  ───────>  80.12.45.20:62001  ───────>  site web:443
```

Type : direction **SNAT**, mapping **PAT**, langage courant « NAT de sortie ».

### Exemple 2 — Publier un serveur web interne

```text
Internet                         Box / routeur                       LAN

client ───> 80.12.45.20:80 ───> [ DNAT ] ───> 192.168.1.50:80
```

Type : direction **DNAT**, usage **port forwarding**, objectif : rendre un service interne joignable depuis l'extérieur.

### Exemple 3 — Donner une IP publique dédiée à un serveur

```text
Serveur interne                  IP publique dédiée

192.168.1.50      <──────────>   80.12.45.20
```

Type : mapping **NAT statique 1:1** — sens sortant : peut faire du **SNAT statique** ; sens entrant : peut faire du **DNAT statique**.

> [!note]
> C'est pour ça qu'il ne faut pas dire « NAT statique = SNAT ». Un mapping statique peut servir dans les deux sens — voir l'avertissement dans [[06-securite-et-acces#7.1 NAT / PAT]].
