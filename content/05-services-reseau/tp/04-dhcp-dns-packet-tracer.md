# TP 6.2 — DHCP et DNS sur le LAN Administration

> [!TIP] Ressource du TP
> - <a href="https://kayasam.github.io/fondamentaux-reseaux/telechargements/05-services-reseau/tp/04-dhcp-dns-packet-tracer.md" download>Télécharger ce TP en Markdown</a>


## Objectif

Configurer un **serveur** dans le **LAN Administration** pour fournir :

- des adresses IP via **DHCP**,
- un service de **résolution DNS** interne.
    
---

## Consignes

1. Sur le **LAN Administration**, ajoute un **serveur** connecté au switch du VLAN correspondant.
    
    - Adresse IP fixe : `192.168.10.10`
        
    - Passerelle : `192.168.10.254`
        
2. Active sur ce serveur :
    
    - le **service DHCP**
        
    - le **service DNS**
        
3. Dans le service DHCP :
    
    - Garde le pool existant
        
    - Adresse réseau : `192.168.10.0/24`
        
    - Passerelle : `192.168.10.254`
        
    - DNS : `192.168.10.10`
        
    - Plage : `192.168.10.50` à `192.168.10.100`
        
4. Dans le service DNS :
    
    - Ajoute un enregistrement :  
        `serveur.local → 192.168.10.10`
        
5. Ajoute un **PC** dans le même LAN Administration.
    
    - Configure-le en **DHCP**.
        
    - Vérifie qu’il reçoit une IP correcte et le DNS.
        
6. Depuis ce PC :
    
    - Teste la **connexion** au serveur (ping `serveur.local`).
