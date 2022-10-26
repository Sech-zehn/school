!!!note "MAJ le 26/10/2022"

# Sécurité linux

!!!warning "La description complète sera faite ultérieurement."

!!!tip "Affichage d'un fichier zippé"
    On peut utiliser `zdcat`!

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
