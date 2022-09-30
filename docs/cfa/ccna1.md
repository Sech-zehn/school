!!!note "MAJ le 30/09/2022"

# Rappels Cisco

!!!abstract "Modes de commande"

     | Mode | Accès | Description |
     |---|---|---|
     |Utilisateur|  | Mode de base. Il sert à rien.|
     |Privilégié| `en`|Permet de sauvegarder la conf et de passer dans les autres modes.|
     |Configuration globale|`conf t`|Permet de faire la plupart des actions de configuration globale|
     |Configuration de ligne|`line [interface] [n]`| Permet de configurer les ports console, aux, telnet et SSH| 
     |Configuration d'iterface|`int [interface]`| Permet de configurer les interfaces réseau.|

```title="Configuration des mots de passe"
en
conf t
hostname S2
line console 0
password [mot de passe]
login
exit
enable password [mot de passe]
enable secret [secret]
service password-encryption
```

```title="Banière MOTD"
en
conf t
banner motd "This is a secure system. Authorized Access Only!"
```

```title="Travail avec les configurations"
en
sh run
sh start
wr
```

```title="Interface virtuelle"
en
conf t
int vlan 1
ip address [ip] [masque]
no shut
```
