# Sécurité des réseaux

## TD0

### Exercice 0

Il parrait que c'est juste `buffer overflow`

### Exercice 1

```
                                       <- A>B 201(15) ack 701 "Echo HACKED"
<- B>A 701(15) ack 216 "Echo HACKED"
-> A>B 201 ack 715
<- B>A 716 ack 216
```

### Exercice 2

1. A enverait un ack a B, qui va imméditement demander un reste de la discussion. 
2. Si on ne détermine pas le SN initial, on ne pourra pas envoyer de messages avc le bon SN et A demandera un reset. 
6. C'est principalement utilisé pour aquérir des iformations sensibles. 

### Exercice 3

1. Si j'ai bien compris, le pirate va demander des MAJ DNS à plein de serveurs en se faisant passer par A. Donc A se prendra plein de réponses longues et sera submergé.
2. La bande passante prise pa l'attaque sera au maximum de (256/27)^745kb/s.

### Exercice 4

1. Dans la phase 1, Mallory DOS Alice.
2. Dans la phase 2, kevin bruteforce le SN entre Alice et Bob.
3. Dans la phase 3, kevin spoof Alice auprès de Bob.

!!!fail "Mais Bob na jamais ack donc on a aucune idée de si ca a marché?!"
    La prof dit que vu que la discussion était courte, le fait qu'il envoie toujours le même ack est pas grave?!
    
### Exercice 5

1. On fait des requêtes DHCP avec une nouvelle mac a chaque fois et on sature la plage DHCP. Comme ca, les vrais clients n'auont pas d'IP attribuée.
2. En spoofan la passerelle.

## TD2

### Exercice 1

 - 1
 - 
D'après Chris: `H` revient deux fois donc c'est ue lettre fréquente, comme E.
On fait donc le masque suivant:
```
ABCDEFGHIJKLMNOPQRSTUVWXYZ
XYZABCDEFGHIJKLMNOPQRSTUVWXYZ
```

Et par chance c'est le bon masque, on obtient:

```
SECRET
```

 - 2 Chaque lettre correspond à une autre lettre de l'alphabet puisqu'on utilise le modulo 26.
 - 3 c


### Exercice 4

 - 1 - On utilise Euclide étendu.  
pgcd(89,phi) = 1
pgcd(89,phi) = u*89 + v*phi
197 = 
