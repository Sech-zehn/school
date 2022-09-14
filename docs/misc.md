!!!note "MAJ le 14/09/2022 à 15h"

# Page misc

Tu trouveras ici toutes les informations que je n'ai pas pu catégoriser.
Elles n'ont pas d'ordre particulier et ont le meilleur titre que j'ai pu trouver.
Le meilleur moyen de trouver ce que tu cherches est probablement la barre de recherche.

???abstract "Arrêter une recherche DNS sauvage"
      - ++ctrl+shift+9++ pour arrêter la recherche sauvage,
      - `conf t > no IP domain-lookup` pour prévenir les recherches futures.

???abstract "Adresse manuelle remplacée par APIPA sous Windows"
     Quand on définit une IP manuelle pour sa carte ethernet sous Windows,
     il est possible que l'IP choisie soit considérée comme "secondaire", et que la vraie adresse de la carte soit APIPA.

     Dans ce cas, il semblerait que désinstaller puis réinstaller la carte ethernet concernée règle le problème.

     Celà dit, ca ne fonctionne pas toujours et je n'ai pas encore trouvé d'informations fiables sur ce sujet.
