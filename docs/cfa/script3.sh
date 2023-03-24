#!/bin/bash

for valeur in 1 2 3 a b c "4 5 6" "d e f" ; do echo $valeur ; done
for n in `seq 1 5` ; do touch fichier$n ; done
for n in * ; do echo $n ; done
for (( n=10 ; n<=20 ; n=n+2 )) ; do echo $n ; done
set `date` ; for n ; do echo $n ; done