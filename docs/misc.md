!!!note "MAJ le 14/09/2022 à 20h"

# Page misc

Tu trouveras ici toutes les informations que je n'ai pas pu catégoriser.
Elles n'ont pas d'ordre particulier et ont le meilleur titre que j'ai pu trouver.
Le meilleur moyen de trouver ce que tu cherches est probablement la barre de recherche.

## Iptables

???abstract "Principe"
    Iptables est un utilitaire qui permet de filtrer les paquets.
    Il est principalement utilisé comme firewall.

    !!!info "Cet utilitaire est obsolète."
        Tout le monde est passé sur `nftables`, sauf le prof.

    Quand un paquet est contrôlé, il est d'abord placé dans une des chaines INPUT, OUTPUT ou FORWARD en fonction de sa provenance et de sa destination.

    Pour chaque chaine, on peut placer des tests qui vont s'appliquer aux paquets.
    On peut décider quoi faire avec le paquet en fonction du résultat du test.
    Les tests sont exécutés dans l'ordre d'apparition dans la chaine jusqu'à ce qu'une décision soit prise vis-à-vis du paquet.

    On peut aussi créer d'autres chaines pour garder la configuration propre.

???abstract "Arguments"
    Voici une petite liste d'arguments pour les règles:

    | Argument | Description | Exemple |
    |---|---|---|
    |`-A`|"Append" soit "ajouter à la fin de".| `iptables -A INPUT -J ACCEPT`|
    |`-I`|"Insert" soit "insérer [au début]".| `iptables -I INPUT -s frolov.eu -J ACCEPT`|
    |`-J`|"Jump". Permet "d'envoyer" le paquet vers une décision: ACCEPT, DROP, RETURN ou LOG (y'en à d'autres mais osef) ou vers une autre chaine |`iptables -A INPUT -J ACCEPT`|
    |`-p`|"protocole". tcp/udp/icmp/all |`iptables -A INPUT -p udp -J DROP`|
    |`-dport`|"destination port". Filtre en fonction du port cible |`iptables -A INPUT -dport ssh -J DROP`|
    |`-s`|"source", soit d'où vient le paquet|`iptables -A INPUT -s frolov.eu -J ACCEPT` |
    |`-d`|"destination", soit où va le paquet|`iptables -A INPUT -d !localhost -J LOG`|

    Arguments de gestion:

    |Argument|Description|
    |---|---|
    |`-L `|Lister |
    |`-F`|Flush |
    |`-N`|Créer une nouvelle chaine |

???abstract "Modules"
     - `owner`: permet de vérifier l'utilisateur qui envoie le paquet.
         - Utilisation: `-m owner --uid-owner [utilisateur]`
     - `limit`: permet de changer la valeur d'un test en fonction de la quantité de paquets reçus par unité de temps.
         - Utilisation: `-m limit --limit n/[unité]` où [unité] peut être `s`, `m`, `h` etc.
     - `state`: permet de vérifier l'état de la connexion dont proovient le paquet.
         - Utilisation: `-m state --state NEW/ESTABLISHED/RELATED/INVALID`


## Contenu vraiment aléatoire

???abstract "Pour ne pas galérer avec GCC et VSCode"
    [Aller ici](https://code.visualstudio.com/docs/cpp/config-mingw)

???abstract "Arrêter une recherche DNS sauvage"
      - ++ctrl+shift+9++ pour arrêter la recherche sauvage,
      - `conf t > no IP domain-lookup` pour prévenir les recherches futures.

???abstract "Adresse manuelle remplacée par APIPA sous Windows"
     Quand on définit une IP manuelle pour sa carte ethernet sous Windows,
     il est possible que l'IP choisie soit considérée comme "secondaire", et que la vraie adresse de la carte soit APIPA.

     Dans ce cas, il semblerait que désinstaller puis réinstaller la carte ethernet concernée règle le problème.

     Celà dit, ca ne fonctionne pas toujours et je n'ai pas encore trouvé d'informations fiables sur ce sujet.

!!!abstract "Mes `.bashrc`"
    Avantage de mes `.bashrc` par rapport à ceux par défaut:

     - [x] Prompt coloré qui rappelle le niveau de privilèges,
     - [x] Des alias pratiques comme "ll" pour `ls -l` et "la" pour `ls -l -a`.

    ???abstract "`.bashrc` utilisateur"
        ```title="/home/[utilisateur]/.bashrc"
        # ~/.bashrc: executed by bash for non-login shells.
        # see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
        # for examples

        # If not running interactively, don't do anything
        case $- in
            *i*) ;;
            *) return;;
        esac

        # don't put duplicate lines or lines starting with space in the history.
        # See bash for more options
        HISTCONTROL=ignoreboth

        # append to the history file, don't overwrite it
        shopt -s histappend

        # for setting history length see HISTSIZE and HISTFILESIZE in bash
        HISTSIZE=1000
        HISTFILESIZE=2000

        # check the window size after each command and, if necessary,
        # update the values of LINES and COLUMNS.
        shopt -s checkwinsize

        # If set, the pattern "**" used in a pathname expansion context will
        # match all files and zero or more directories and subdirectories.
        #shopt -s globstar

        # make less more friendly for non-text input files, see lesspipe
        #[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

        # set variable identifying the chroot you work in (used in the prompt below)
        if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
            debian_chroot=$(cat /etc/debian_chroot)
        fi

        # set a fancy prompt (non-color, unless we know we "want" color)
        case "$TERM" in
            xterm-color|*-256color) color_prompt=yes;;
        esac

        # uncomment for a colored prompt, if the terminal has the capability; turned
        # off by default to not distract the user: the focus in a terminal window
        # should be on the output of commands, not on the prompt
        force_color_prompt=yes

        if [ -n "$force_color_prompt" ]; then
            if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
                # We have color support; assume it's compliant with Ecma-48
                # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
                # a case would tend to support setf rather than setaf.)
                color_prompt=yes
            else
                color_prompt=
            fi
        fi

        if [ "$color_prompt" = yes ]; then
            PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
            #
        else
            PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
        fi
        unset color_prompt force_color_prompt

        # If this is an xterm set the title to user@host:dir
        case "$TERM" in
        xterm*|rxvt*)
            PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
            ;;
        *)
            ;;
        esac

        # enable color support of ls and also add handy aliases
        if [ -x /usr/bin/dircolors ]; then
            test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
            alias ls='ls --color=auto'
            alias dir='dir --color=auto'
            alias vdir='vdir --color=auto'

            alias grep='grep --color=auto'
            alias fgrep='fgrep --color=auto'
            alias egrep='egrep --color=auto'
        fi

        # colored GCC warnings and errors
        export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

        # some more ls aliases
        alias ll='ls -l'
        alias la='ls -l -A'
        #alias l='ls -CF'

        # Alias definitions.
        # You may want to put all your additions into a separate file like
        # ~/.bash_aliases, instead of adding them here directly.
        # See /usr/share/doc/bash-doc/examples in the bash-doc package.

        if [ -f ~/.bash_aliases ]; then
            . ~/.bash_aliases
        fi

        # enable programmable completion features (you don't need to enable
        # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
        # sources /etc/bash.bashrc).
        if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
        fi
        ```

    ???abstract "`.bashrc` root"
        ```title="/root/.bashrc"
        # ~/.bashrc: executed by bash for non-login shells.
        # see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
        # for examples

        # If not running interactively, don't do anything
        case $- in
            *i*) ;;
            *) return;;
        esac

        # don't put duplicate lines or lines starting with space in the history.
        # See bash for more options
        HISTCONTROL=ignoreboth

        # append to the history file, don't overwrite it
        shopt -s histappend

        # for setting history length see HISTSIZE and HISTFILESIZE in bash
        HISTSIZE=1000
        HISTFILESIZE=2000

        # check the window size after each command and, if necessary,
        # update the values of LINES and COLUMNS.
        shopt -s checkwinsize

        # If set, the pattern "**" used in a pathname expansion context will
        # match all files and zero or more directories and subdirectories.
        #shopt -s globstar

        # make less more friendly for non-text input files, see lesspipe
        #[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

        # set variable identifying the chroot you work in (used in the prompt below)
        if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
            debian_chroot=$(cat /etc/debian_chroot)
        fi

        # set a fancy prompt (non-color, unless we know we "want" color)
        case "$TERM" in
            xterm-color|*-256color) color_prompt=yes;;
        esac

        # uncomment for a colored prompt, if the terminal has the capability; turned
        # off by default to not distract the user: the focus in a terminal window
        # should be on the output of commands, not on the prompt
        force_color_prompt=yes

        if [ -n "$force_color_prompt" ]; then
            if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
                # We have color support; assume it's compliant with Ecma-48
                # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
                # a case would tend to support setf rather than setaf.)
                color_prompt=yes
            else
                color_prompt=
            fi
        fi

        if [ "$color_prompt" = yes ]; then
            PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
            #
        else
            PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
        fi
        unset color_prompt force_color_prompt

        # If this is an xterm set the title to user@host:dir
        case "$TERM" in
        xterm*|rxvt*)
            PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
            ;;
        *)
            ;;
        esac

        # enable color support of ls and also add handy aliases
        if [ -x /usr/bin/dircolors ]; then
            test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
            alias ls='ls --color=auto'
            alias dir='dir --color=auto'
            alias vdir='vdir --color=auto'

            alias grep='grep --color=auto'
            alias fgrep='fgrep --color=auto'
            alias egrep='egrep --color=auto'
        fi

        # colored GCC warnings and errors
        export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

        # some more ls aliases
        alias ll='ls -l'
        alias la='ls -l -A'
        #alias l='ls -CF'

        # Alias definitions.
        # You may want to put all your additions into a separate file like
        # ~/.bash_aliases, instead of adding them here directly.
        # See /usr/share/doc/bash-doc/examples in the bash-doc package.

        if [ -f ~/.bash_aliases ]; then
            . ~/.bash_aliases
        fi

        # enable programmable completion features (you don't need to enable
        # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
        # sources /etc/bash.bashrc).
        if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
        fi
        ```
