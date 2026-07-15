#!/bin/bash

        DEFAULT=$(ip route | grep "default")
if [ "$?" = 1 ]
then
	echo "Nie znaleziono bramy sieciowej "
	exit 1
fi
	DEFAULT=$(ip route | grep "default" | awk '{print $3}')
if [ -n "$DEFAULT" ]
then
	ping -w 3 "$DEFAULT" 
	RESULT=$?
	echo " Znaleziono oraz przeprowadzono test łączności z bramą $RESULT " 
else
	echo "Nie udało się przeprowadzić testu łączności z brama kod błędu $RESULT "
	exit 1
fi
	ping -w 3 google.com
	if [ "$?" = "0" ]
then
	echo "Tłumaczenie nazwy domeny działa poprawnie, wynik komendy: $?"
else
	echo "Tłumaczenie nazwy domeny się nie powiodło, wynik komendy: $?"
fi
if  ss -lnt | grep ":80"
then
	echo "Port http jest w trybie listen $?"

else
	echo "Port http NIE jest w trybie listen"
	exit 1
fi

if curl 192.168.50.80
then
	echo "Usługa apache działa poprawnie"
	exit 0
else
	echo "Usługa apache nie odpowiada na komunikację"
	exit 1
fi

