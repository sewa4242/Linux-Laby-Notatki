#!/bin/bash
	sudo grep -iE "404" /var/log/apache2/access.log > /dev/null
if [ "$?" = "0" ]
	then
echo "Znaleziono w logach błędy 404. Policzono linie w których występuje błąd oraz zapisano go do pliku errors.txt"
sudo grep -iE  "404" /var/log/apache2/access.log | wc -l > /home/u1/Dokumentacja/Skrypty_nauka/Skrypt_apache/errors.txt
	else
echo "Brak błędu 404"
rm -f  /home/u1/Dokumentacja/Skrypty_nauka/Skrypt_apache/errors.txt
fi

	sudo grep -iE "200" /var/log/apache2/access.log > /dev/null
if [ "$?" = "0" ]
	then
echo "Serwer prawidłowo się komunikuje"
sudo grep -iE  "200" /var/log/apache2/access.log | wc -l > /home/u1/Dokumentacja/Skrypty_nauka/Skrypt_apache/logowania.txt
	else
echo "Serwer ma problem z prawidłową komunikacją" 
rm -f   /home/u1/Dokumentacja/Skrypty_nauka/Skrypt_apache/logowania.txt
fi 
