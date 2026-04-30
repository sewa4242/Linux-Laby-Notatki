#!/bin/bash
#Purpose: Learn how work condition if/then/fi in script
#Usage: ./hello_if.sh
#Level: Linux Essentials practice 

 
echo " Podaj swoje imię "
read NAME
if [ "$NAME" = "Seweryn" ]
then 
echo " Witaj adminstratorze " 
fi

