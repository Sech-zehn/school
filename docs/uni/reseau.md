!!!note "MAJ le 14/09/2022 à 15h"

# Cours de réseaux

!!!info "OS utilisé"
    Tout ce qui suit est fait sous Debian Bullseye en VM.

!!!warning "Configuration de la VM"
    Il faut configurer la VM en mode "bridge" pour faire les TDs en LAN.

    Si tu utilises VirtualBox il faut:

     - Aller dans la config de la VM,
     - Aller dans `Réseau`,
     - Pour l'interface qui sera utilisé pour communiquer avec la LAN, chosir "Mode d'accès réseau:" `Bridge` ou `Accès par pont`.

## TD1

### Exercice 2

```bash title="/etc/network/interfaces"
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/

# The loopback network interface
auto lo
iface lo inet loopback

auto enp0s3
iface enp0s3 inet static
    address 192.168.42.69
    netmask 255.255.255.0
#iface enp0s3 inet dhcp # (1)
```

1. Commenter le paragraphe précédent et décommenter cette ligne pour retourner en DHCP rapidement!


!!!tip "Clique sur les " + " pour plus d'explications"
    Il y en a un à la dernière ligne du bloc précédent.

```
systemctrl restart networking
```

???+note "Si le réseau ne fonctionne pas"
     - Vérifie avec `ip a` que la carte est UP,
        - Si elle est down, `ifup enp0s3`
     - Parfois, il faut rebooter l'ordi.

```
apt install net-tools
netstat -in
```

Sur une VM Debian vierge, on voit:

 - `enp0s3`: carte réseau de la machine. Aucune erreur de chaque type.
 - `lo`: boucle virtuelle sur soi-même. Aucune erreur de chaque type.

### Exercice 3

!!!success "Configuration pérenne faite à l'[exercice 2](#exercice-2)."

### Exercice 4

```
ping 192.168.42.n
```

### Exercice 5

#### Partie 1

```
arp
Adresse                  TypeMap AdresseMat          Indicateurs           Iface
_gateway                 ether   52:54:00:12:35:02   C                     enp0s3
```

#### Partie 2

```
ip neigh flush all
```

#### Partie 3

```
ping 192.168.42.n
arp
```

### Exercice 6

```
apt instal tcpdump
tcpdump
```

Dans un autre terminal:
```
ifconfig
```

!!!fail "Chez moi, la carte reste en MULTICAST"
    D'après l'aide du programme, elle devrait être en PROMISC

### Exercice 7

!!!fail "Obsolète - préférer WireShark"

### Exercice 8

Le changement par rapport au hub est qu'on ne voit que les paquets qui sont destinés à notre hôte.

### Exercice 9

```
ping 192.168.42.255
```

## TD2

### Exercice 2


```bash title="/etc/network/interfaces"
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

auto enp0s3
iface enp0s3 inet static
    address 192.168.1.9/28
    gateway 192.168.1.62 # (1)
#iface enp0s3 inet dhcp
```

1. Nécessaire pour pouvoir communiquer avec d'autres réseaux

```
systemctl restart networking.service
```

### Exercice 3

```
netstat -rn
```

On en déduit que les paquets ne doivent effectuer aucun saut pour atteindre une addresse du même sous-réseau.

### Exercice 4

!!!warning "Je n'ai pas fait cette partie"
    Faudrait vérifier l'exactitude des commandes.

```bash title="Sur le routeur"
conf t
router rip
network 192.168.1.0
network 192.168.2.2
access-list 1 permit any any any # (1)
end
wr
```

1. Par défaut, une ACL implicite interdit tous les clients.

### Exercice 5

#### Partie 1

Il s'aigit de la dernière adresse du réseau.

#### Partie 2

```
ping 192.168.1.63
```

Il semblerait que la passerelle bloque les réponses ou les requêtes car c'est la seule a répondre.

### Exercice 6

Les deux sous-réseaux étant identiques, il serait logique de scinder la plage disponible en deux parts égales grâce à un masque à 25 bits.

#### Partie 1

!!!success "La configuration est basée sur l'[exercice 2](#exercice-2_1)."

#### Partie 2

!!!success "La configuration est basée sur l'[exercice 4](#exercice-4_1)."

### Exercice 7

!!!success "Voir [exercice 5](#exercice-5_1)."

### Exercice 8

!!!warning "A compléter"

## TD3

### Exercice 2

```
ip route flush all
ip route show
ip route add 192.168.1.62 dev enp0s3
ip route add default via 192.168.1.62 dev enp0s3
ip route show
```

!!!warning "Compléter avec WireShark."

### Exercice 3

Le temps de réponse est plus grand quand on envoie une requête ping vers un réseau externe.
Ceci est dû au saut supplémentaire causé par l'ajout du routeur dans le processus de requête.

### Exercice 4

```
netstat -an
```

pour une Debian vierge, seul `tcp 127.0.0.1:631` apparait.
D'après /etc/services, ceci correspond au Intrnet Printing Protocol.

### Exercice 5

```
apt install rwho
rwho -a
```

!!!warning "Analyse des trames à compléter."

### Exercice 6

Telnet utilise le port 23.

### Exercice 7

!!!warning "A compléter."
