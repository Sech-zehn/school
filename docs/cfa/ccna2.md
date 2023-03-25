# CCNA 2

## Intro

L'objectif de cette page est de noter les choses importantes a retenir du cours.
Cette page a donc le même structure que le cours Cisco, mais les chapitres inintéressants sont manquants.

## 1 - Configuration de base des périphériques

### 1.1.1 - Séquence de démarrage du commutateur

 - Étape 1: Tout d'abord, le commutateur charge un programme auto-test de mise sous tension (POST) stocké dans la ROM. POST vérifie le sous-système CPU. Il teste le processeur, la DRAM et la partie du périphérique flash qui constitue le système de fichiers flash.
 - Étape 2: Le commutateur exécute ensuite le bootloader. Le chargeur de démarrage (boot loader) est un petit programme stocké dans la ROM qui est exécuté immédiatement après la fin de POST.
 - Étape 3: Le boot loader effectue une initialisation de bas niveau du CPU. Il initialise les registres du processeur qui contrôlent l'emplacement auquel la mémoire physique est mappée, la quantité de mémoire et sa vitesse.
 - Étape 4: Le boot loader initialise le système de fichiers flash sur la carte système.
 - Étape 5: Finalement, le chargeur de démarrage localise et charge dans la mémoire une image par défaut du logiciel du système d'exploitation IOS et donne le contrôle du commutateur à l'IOS.


### 1.1.4 - Récupération après une panne de système

Le chargeur de démarrage est accessible via une connexion à la console en suivant ces étapes :

 - Étape 1. Connectez un PC par un câble de console au port de console du commutateur. Configurez le logiciel d'émulation de terminal pour le connecter au commutateur.
 - Étape 2. Débranchez le cordon d'alimentation du commutateur.
 - Étape 3. Rebranchez le cordon d'alimentation au commutateur et, dans les 15 secondes qui suivent, appuyez sur le bouton Mode et maintenez-le enfoncé pendant que la LED du système clignote encore en vert.
 - Étape 4. Continuez à appuyer sur le bouton Mode jusqu'à ce que le voyant lumineux du système devienne brièvement orange puis vert fixe ; puis relâchez le bouton Mode.
 - Étape 5. L’invite switch: apparaît dans le logiciel d'émulation de terminal sur le PC.

Pour obtenir le chemin du BOOT:
```
set
```

Pour visualiser les répertoires et fichiers flash:
```
dir flash
```

Pour modifier le chemin du BOOT:
```
BOOT=flash:<chemin>
```

### 1.1.6 - Exemple de configuration pour contrôle a distance

!!! tip "SVI = Switch Virtual Interface"
    Il s'agit de l'interface de management a distance

```
conf t
ip default-gateway 172.17.99.1
int vlan 99
ip address 172.17.99.11 255.255.255.0
ipv6 address 2001:db8:acad:99::1/64
no shut
show ip interface brief
show ipv6 interface brief
end
wr
```

###
