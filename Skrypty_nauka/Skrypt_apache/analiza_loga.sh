#!/bin/bash
	sudo grep -iE "404" /var/log/apache2/access.log | wc -l > /home/u1/Dokumentacja/Skrypty_nauka/Skrypt_apache/errors.txt
if [ "$?" = "0" ]
then
	echo "Znaleziono komunikaty o błędzie 404. Plik z liczbą wystąpień został utworzony"

else
	echo "Brak błędów"
fi

	sudo grep -iE "200" /var/log/apache2/access.log | wc -l > /home/u1/Dokumentacja/Skrypty_nauka/Skrypt_apache/logwania.txt
if [ "$?" = "0" ]
then
	echo "Serwer prawidłowo się komunikuje"

else
	echo "Serwer nie odpowiada na próbę komunikacji"
	exit 0
fi
