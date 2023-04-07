#!/bin/bash

eval "date;who;pwd"
liste="date;who;pwd" ; echo $liste ; eval $liste
var1="hello"
var2='$var1'
echo $var2
eval echo $var2