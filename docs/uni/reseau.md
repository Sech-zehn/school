!!!note "MAJ le 14/09/2022 à 17h30"

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

## TD4

!!!info "`iptables` est obsolète et Netfilter déconseille de l'utiliser."

!!!tip "J'ai fait un [memo sur la page misc](/misc/#iptables) avec principe, commandes et modules!"

### Prise en main

Supprimer la règle d'une chaine:

```
iptables -D [chaine] [règle]
```

Supprimer toutes les règles d'une chaine:

```
iptables -F [chaine]
```

Supprimer une chaine:

```bash
iptables -X [chaine] # (1)
```

1. Attention, on ne peut pas supprimer les "chaines originales" (INPUT, FORWARD, OUTPUT etc).

!!!fail "Je n'ai pas de machine RedHat, et `iptables` n'a pas de fichier de configuration."
    Le contenu de `/etc/sysconfig/iptable` restera donc un mystère.

`iptables`n'est pas reconnu en tant que service, donc la commande `service iptables` ne passera pas, mais la commande suivante est déjà très informative:

```
iptables --help
```

On peut aussi regarder le man si on l'a téléchargé.

### Filtrage de ports

!!!warning "Cette section n'a pas été vérifiée."

```bash
iptables -A INPUT -p tcp --dport 22 -J DROP
iptables -I INPUT -p tcp --dport 22 -s n.n.n.n -J ACCEPT # (1)
iptables -F
iptables -N ssh
iptables -A INPUT -p tcp --dport 22 -J ssh
iptables -A ssh -s n.n.n.n -J ACCEPT
iptables -A ssh -J DROP
```

1. `-I` permet de placer la règle en haut de l'ordre d'exécution.

#### Exercice 1

```
iptables -A INPUT -p tcp --dport 22 -s n.n.n.n -J ACCEPT
iptables -A INPUT -p tcp --dport 25 -s n.n.n.n -J ACCEPT
iptables -A INPUT -p tcp --dport 22 -J LOG "SSH interdit"
iptables -A INPUT -J DROP
```

#### Exercice 2

```
iptables -A OUTPUT -p all --dport 80 -J DROP
iptables -A OUTPUT -p all --dport 443 -J DROP
```

Affin de trier les utilisateurs, on doit utiliser le module `owner`:

```
iptables -I OUTPUT -p all --dport 80 -m owner --uid-owner root -J ACCEPT
iptables -I OUTPUT -p all --dport 443 -m owner --uid-owner root -J ACCEPT
```

#### Exercice 3

Il faut utiliser le module `limit`:

```
iptables -I INPUT -p icmp -m limit --limit 10/s -J ACCEPT
```

### Suivi de connexion (conntrack)

!!!warning "Cette section n'a pas été vérifiée."

```
iptables -F
modeprobe ip_conntrack_ftp
iptables -A INPUT -J DROP
ftp
passive
open 192.198.n.n
exit
iptables -I INPUT -p tcp --sport 21 -m state --state ESTABLISHED -J ACCEPT
ftp
passive
open 192.198.n.n
n
n
ls
```

## TD5

??abstract "`repeteur.c`"
    ```c
    /*
    * Fichier 'repeteur.c' utilise pour le TD 5 de programmation IP.
    * Le programme 'repeteur' est un programme demon "repetant" tout
    * ce qu'on lui dit.  Il tourne sur le port 6666 et reste � l'ecoute
    * d'une eventuelle connexion.
    *
    * Historique
    *    1999/10/15 : dntt : creation
    */

    #include <unistd.h>
    #include <stdlib.h>
    #include <sys/stat.h>
    #include <string.h>
    #include <stdio.h>

    #include <sys/types.h>
    #include <sys/socket.h>
    #include <sys/wait.h>
    #include <netinet/in.h>
    #include <netdb.h>
    #include <syslog.h>

    #include <signal.h>

    #define MAXLEN  1024
    #define PORT_REPETEUR 6666
    #define NB_CONN_MAX 5

    void demon () ;

    void repeter (int socket_cliente) ;
    int lecture_socket (int socket_cliente, char *buf) ;


    /************************************************************************
    *
    * Fonction principale :
    * On cree le demon en dupliquant le processus afin de detacher le
    * programme du processus pere
    *
    ************************************************************************/
    int main ()
    {
        switch (fork ())
        {
            case -1 :
                perror ("*** erreur : fork impossible : demon non cree") ;
                exit (1) ;

            case 0 :
            /*
            * Ce processus fils est celui qui deviendra le demon.
            * Ingredients pour en faire un vrai et bon demons :
            */
            /* 1 - On cree une nouvelle session. Pas de terminal de controle */
                setsid () ;

            /* 2 - le repertoire courant est change a la racine afin de ne pas
            *     causer de probleme lors de demontage eventuel de partition
            */
            chdir ("/") ;

            /* 3 - Le masque sur les droits lors de creation de fichiers */
            umask (0) ;

            /* 4 - Comme c'est un demon qui est lance et qui est "detache" du
            *     term, l'entree, la sortie et l'erreur standard n'ont pas de
            *     terminal ou s'afficher. On peut donc les fermer.
            */
                close (0) ;
            close (1) ;
            close (2) ;


            /* 6 - On lance le demon proprement dit */
                demon () ;

            /* 7 - Si le demon s'arrete, alors on sort du processus fils. Le
            *     programme est alors termine. */
                exit (1) ;

            default :
            /* Le processus pere est tue. On rend la main au shell appelant. */
                exit (0) ;
        }
        return 0 ;
    }

    /************************************************************************
    *
    * Le programme 'demon'
    *
    * Structure
    *           sockaddr_in : /usr/include/netinet/in.h
    *
    *
    *
    ************************************************************************/
    void demon ()
    {
        int socket_ecoute ;
        int socket_cliente ;
        int valeur_retour ;
        int salong ;
        int opt = 1 ;
        struct sockaddr_in monadr, sonadr ;
        int status ;


        /*
        * Creation de la socket d'ecoute
        */
        socket_ecoute = socket (PF_INET, SOCK_STREAM, 0) ;

        /*
        * Modification des options associees a la socket d'ecoute.
        */
        setsockopt (socket_ecoute, SOL_SOCKET, SO_REUSEADDR, (char *) &opt, \
            sizeof (opt)) ;

        /*
        * Initialisation des parametres internet de la socket d'ecoute.
        */
        bzero ((char *) &monadr, sizeof monadr) ;
        monadr.sin_family = AF_INET ;
        monadr.sin_port = htons (PORT_REPETEUR) ;
        monadr.sin_addr.s_addr = INADDR_ANY ;
        valeur_retour = bind (socket_ecoute, (struct sockaddr *) &monadr, \
                (int) sizeof monadr) ;

        /*
        * Socket mise en position d'ecoute ('listen'). On specifie aussi le
        * nombre de connexions simultanees acceptees.
        */
        valeur_retour = listen (socket_ecoute, NB_CONN_MAX) ;

        /**
        * Le demon tourne indefiniment a l'ecoute d'eventuelles connections
        * 'accept'
        * Lorsqu'un client se connecte, une socket est cree (socket_cliente).
        * on duplique le processus et le processus fils prend en charge
        * cette socket par la fonction 'repeter'.
        */
        while (1)
        {
            salong = sizeof sonadr ;

            socket_cliente = accept (socket_ecoute, (struct sockaddr *) &sonadr, \
                                    (socklen_t *) &salong) ;

        switch (fork ())
            {
            case -1 :
            break ;

            case 0 :
                    repeter (socket_cliente) ;
                    close (socket_cliente) ;
            kill (getpid(),SIGTERM);

            default :
            waitpid (-1, &status, WNOHANG);
                    close (socket_cliente) ;
            }
        }
    }

    /************************************************************************
    *
    * La fonction qui repete
    *
    *
    *
    ************************************************************************/
    void repeter (int socket_cliente)
    {
        int nb_lu ;
        char buf [MAXLEN] ;

        while ((nb_lu = lecture_socket (socket_cliente, buf)) > 0)
        {
        /* Si probleme de lecture sur la socket (fermee brutalement
        * par exemple) */
        if (nb_lu == -1 || nb_lu == 0)
        {
            return ;
        }

        /* On repete ce qui a ete dit et on renvoie au client */
        write (socket_cliente, buf, nb_lu) ;
        }
    }

    int lecture_socket (int socket_cliente, char *buf)
    {
        int nb_lu  ;

        nb_lu = read (socket_cliente, buf, MAXLEN)  ;
        return (nb_lu) ;
    }
    ```


???abstract "`makefile`"
    ```make
    #
    # Makefile pour 'repeter.c'
    #
    # 1999/10/15 : dntt : creation
    #

    all : repeteur


    CC = gcc
    OPT = -O -Wall -pedantic -g -DCORRECTION

    .SUFFIXES: .o .c
    .c.o :
	    ${CC} -c ${OPT} $*.c

    OBJ = repeteur.c \

    repeteur : repeteur.o
	    ${CC} ${OPT}  repeteur.o -o repeteur

    ```


### Exercice 1

```
./repeteur
telnet
open
localhost 6666
Salut mdrrrrrrrrr
```

### Exercice 2

