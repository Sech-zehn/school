!!!note "MAJ le 26/10/2022"

# Sécurité linux

!!!warning "Rappel: J'utilise une distribution Bullseye. Les informations de cette page peuvent différer pour d'autres distributions."

## Bidouillages de base


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

