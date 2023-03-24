!!!note "MAJ le 26/10/2022"

# Sécurité linux

!!!warning "Rappel: J'utilise une distribution Bullseye. Les informations de cette page peuvent différer pour d'autres distributions."

## Bidouillages de base

!!!tip "Exécuter une commande déjà utilisée"
    `!numéro`

!!!tip "Affichage d'un fichier zippé"
    On peut utiliser `zdcat`!

!!!tip "Redirection de la sortie"
    On peut rediriger la sortie d'un programme vers l'entrée d'un autre en utilisant `|`.<br>
    Par exemple: `cat fichier | grep recherche` redirige la sortie de `cat` vers `grep`.

### Outils de recherche

 - Awk permet de chercher des chaines grâce à un langage presque aussi puissant que le C.
     - Utilisation `awk -F "séparateur" -v variable

!!!abstract "Outils de recherche"
     - `awk`
     - `find`
     - `grep`

!!!abstract "Commandes sur les fichiers"
     - Compter: `wc`
     - Comparaison: `diff`
     - Intégrité: ` md5sum`
     - Tri: `sort`  et ` unikq`

!!!abstract "Exemples"
    ```bash
    cat /var/log/syslog | grep 185.125.190.58 |  awk '{print $1 " " $2 }' | uniq
    grep -E -o "([0-9]{1,3}[.]){3}[0-9]{1,3}" /var/log/syslog
    cat /var/log/syslog | grep -E "([0-9]{1,3}[.]){3}[0-9]{1,3}" |  awk '{print $1 " " $2 }' | uniq
    ```

!!!abstract "Outils de conversion"
     - `Tr`
     - `Sed` (regex) permet de remplacer du texte
     - `$[]; $(())` (calcul)

!!!abstract "Outils d'archive et de compression"
     - Archive
         - `zip`
         - `tar`
     - Compression
         - `gzip`
         - `bzip2`

!!!abstract "Liens"
     - Lien physique: `ln document lien`
     - Lien symbolique: `ln -s document lien`

!!!abstract "Shells"
     - Vérification des shells:
         - `/etc/shells`
         - `/bin/*sh`
     - Vérification du shell utilisé
         - `ps`
         - `$0`
         - `$SHELL`

!!!abstract "Vérification de la distrib"
     - Red-Hat:
         - `/etc/lsb-release`
         - `/etc/redhat-release`
     - Debian:
         - `/etc/issue`
         - `/etc/debian_version/bin/*sh`

    Commandes:
    ```
    lsb_release -a
    lsb_release -ds
    uname -a
    ```

!!!abstreact "Permissions"
     - `useradd`
     - `usermod`
     - `passwd`
     - `userdel`
     - `groupadd`
     - `groupmod`
     - `groupdel`
     - `gpasswd`
     - `groups`
     - `newgrp`
     - `chmod`
     - `chown`
     - `chgrp`
     - `unmask`

## PAM

Pluguable Auth Module
```
apt install libpam-google-autghenticator
vim /etc/pam.d/common-auth
    auth required pam_google_authenticator.so
google-authenticator
```

stdin1 = clavier
stdout1 = ecran
stdout2 = erreur, écran

On peut mettre 1 ou 2 devant ">" pour rediriger la sortie vers quelque part (/dev/null ou un fichier par exemple)

ecraser fichier >
ajouter au fichier >>
Mettre en entrée <
stdout 2>
stdout + stderr &>
stderr sur stdput 2>&1

combinaisons possibles

tee permet de lire stdin et écrire dans plusieures sorties
ex: tail /var/log/syslog | tee fichier.txt

programme daemon processus thread script fonction service application

top pour voir les processus
top -U tim

## Gestion des processus

arriere plan: &. Nohup pour pas que la commande crève avec le bash
mettre en pause: ctfr Z
passer en background: bg
frontground: fg
jobs ps pstree free top
fuser sdparm hdparm lsof
sar iostat mpstat pidstat vmstat

recharger conf: sighup
arret brutal sigkill
terminer gentiement 

créer zombie: (sleep 1 & exec /bin/sleep 100)&

priorité d'accès au processeur: nice pour lancer avec une prio custom et renice pour redéfinir plus tard
0 par défaut, -20 est très méchant et 19 est très gentil

exec permet de remplacer le bash par le processus qu'on lance

## Exécution

|| exécuter la commande 2 si la 1 est morte 
&& exécuter la commande 2 si la 1 est morte 
(?)

## Variables d'environnement

HOME: répertoire utilisateur
PWD: répertoire courant
PATH: chemins d'accès aux exécutables
SHELL: shell utilis" pour la connexion
...

## Matériel
processeur:
 - /proc/cpuinfo
 - lscpu
Ram:
 - /proc/meminfo
 - free
stockage:
 - /dev/sd[a-z][1-9]
 - /dev/fd[0, 1]
 - /dev/hd* et /dev/sr0
 - /dev/

## Partitions et systèmes de fichier

Pas de getion de droit d'accès chez Windows

## Ajoutr d'un disque

lsblk
fdisk /dev/sdb
n
p
1
enter enter
w
mkfs -t ext4 /dev/sdb1
mount -t ext4 /dev/sdb1 /home/tim/test
lsblk -fe 7
dans /etc/fstab: UUID=eabce7c2-7ad9-42f9-a6cf-2a0bc99e1bbe /home/tim/test ext4 defaults 0 2

umount /dev/sdb1
sudo shred -v -n 1 /dev/sdb
apt install cryptsetup
cryptsetup luksFormat /dev/sdb
cryptsetup --type luks open /dev/sdb victor
mkfs -t ext4 /dev/mapper/victor
cryptsetup luksDump /dev/sdb
mount -v /dev/mapper/victor   /home/victor/TEST
cryptsetup status victor
cryptsetup close victor
cryptsetup --type luks open /dev/sdb victor

editer /etc/crypttab
victor /dev/sdb none luks

editer /etc/fstab
UUID=b7e4c3f1-402f-4f34-83bf-db69369dd30b /home/victor/TEST ext4 defaults 0 2

## Séquence d'amorcage bas niveau

bios:
Post
detection matos
recherche sectgeur amorcage
chargeur d'amorcage:
mbr
grub stage 2
kernel:
Initrd
ramfs
détection matos
montaged /


```title="Pour bypass qqe chose en cas de pepin"
Maintenir la touche Shift enfoncé au démarrage de la machine
Pressé « e »
You need to modify it or change it from “read-only” mode to “read-write” mode. Find the line beginning with “Linux.” Look for ro and change it to rw. Add init=/bin/bash at the end of the line, attention au clavier anglaise éhhé
F10
démarrer
Mount –n – o remount,rw /
Monter le systéme defichier de la racine 
Passwd root
Reinitialize de root
Passwd victor
Réinitialise le password de l’utilisateur Victor
Exec /sbin/init
Sort du shell et reboot
```

https://memo-linux.com/securiser-lacces-et-le-demarrage-du-grub-par-mot-de-passe/


grub:
/etc/default/grub

## Scripting bash

#!/bin/bash

echo "premiere var " $1
echo "commande passe " $0
echo "all var " $@
echo "nombre d'argument " $#

-------------------------

$0 : nom de la commande
$n : argument n
$# : nombre d’argument
$* : valeur des arguments
$@ : tablleau

$? : code retour
$$ : pid shell
variable=$(commande)


## Sites de doc

tldp.org
abs.traduc.org
