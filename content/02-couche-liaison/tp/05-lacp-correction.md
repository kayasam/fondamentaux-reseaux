---
title: Correction 05 - Agrégation de liens LACP
publier: true
---

# TP 05 - Correction

> Correction du TP : [[05-lacp]]

## Partie 1 - Mise en place

Les deux liens physiques relient les mêmes interfaces :

```text
S1 Gi0/1 -------- Gi0/1 S2
S1 Gi0/2 -------- Gi0/2 S2
```

Les PC utilisent :

| Poste | Adresse IPv4 | Connexion |
|---|---|---|
| PC1 | `192.168.10.1/24` | S1 `Fa0/10` |
| PC2 | `192.168.10.2/24` | S2 `Fa0/10` |

---

## Partie 2 - VLAN et ports access

La configuration suivante est appliquée sur S1 et S2 :

```text
enable
configure terminal

vlan 10
 name UTILISATEURS

interface fa0/10
 switchport mode access
 switchport access vlan 10
 no shutdown

end
```

Vérification :

```text
show vlan brief
```

---

## Partie 3 - Agrégation LACP

La même configuration doit être appliquée sur les deux switchs.

```text
configure terminal

interface range gi0/1 - 2
 channel-group 1 mode active
 no shutdown

interface port-channel 1
 switchport mode trunk
 switchport trunk allowed vlan 10
 no shutdown

end
copy running-config startup-config
```

Le mode `active` utilise LACP pour négocier la formation de l’agrégat.

### Vérification

```text
show etherchannel summary
show interfaces port-channel 1
show interfaces trunk
```

Exemple de résultat attendu :

```text
Group  Port-channel  Protocol  Ports
------+-------------+---------+----------------------------
1      Po1(SU)       LACP      Gi0/1(P) Gi0/2(P)
```

Signification des indicateurs :

- `S` : port-channel de couche 2 ;
- `U` : port-channel utilisé ;
- `P` : interface physique correctement agrégée.

Si une interface apparaît en état `I`, `s` ou ne rejoint pas le groupe, vérifier que les deux extrémités utilisent :

- le même numéro de channel-group ;
- un mode LACP compatible ;
- les mêmes paramètres de trunk et de VLAN ;
- la même vitesse et le même duplex.

### Test de communication

Le ping entre PC1 et PC2 doit réussir :

```text
PC1> ping 192.168.10.2
```

Si un des deux liens physiques est débranché, le port-channel reste disponible grâce au lien restant. Le débit agrégé diminue, mais la communication doit continuer.

> [!NOTE] Conclusion
> LACP regroupe plusieurs liens physiques en un lien logique. STP voit le port-channel comme une seule liaison, ce qui permet la redondance et évite de bloquer l’un des liens membres.
