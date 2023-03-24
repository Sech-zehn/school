#!/bin/bash

fonction1() { clear ; ls ; pwd ; }
function fonction2 {
clear
ls ; pwd
}

#Visualiser la définition d'une fonction :
#declare -f fonction1
#typeset -f fonction2 → préférer « declare »
#Supprimer une fonction : unset -f fonction2