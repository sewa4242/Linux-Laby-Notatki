1. Sprawdzenie czy usługa Apache działa
	systemctl status apache2 --no-pager
-------------------------------------------
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/apache2.service; enabled; preset: enabled)
     Active: active (running) since Tue 2025-12-23 16:47:28 CET; 5min ago

Wniosek: Tak usługa Apache działa

2. DocumentRoot
	To katalog z którego Apache bierze pliki HTML  
	ls -l /var/www/html = index.html
-------------------------------------------------------
3. Gdzie Apache trzyma konfigurację ( tylko struktura) 
	ls /etc/apache2
	Zobaczysz :
	apache2.conf → główny plik
	sites-available/
	sites-enabled/
	conf-available/
	conf-enabled/

Apache czyta konfigurację z wielu plików 
Site-enabled = aktywne strony
sites-available= dostępne, ale niekoniecznie używane 

4. Opis Apache Dokumentów 
	https://httpd.apache.org/docs/2.4/
5. Nowy DocumentRoot
a) Tworzymy nowy katalog strony:
	sudo mkdir /var/www/testsite
   Tworzenie pliku testowego:
	echo "TEST SITE – Apache works" | sudo tee /var/www/testsite/index.html
b) Konfiguracja strony ls /etc/apache2/sites-enabled = zobaczysz 000-default.conf
   Otwierasz go, szukasz lini DocumentRoot /var/www/html  edytujesz na DocumentRoot /var/www/testsite
d) Sprawdzenie nowej konifguracji 
	sudo apache2ctl configtest  -- Jeśli widzisz Syntax OK możesz przejść do restartowania sudo systemctl reload apache2

krok na koniec sprawdzenie po przez wejście na stronę czy zmiana została wprowadzona

-------------------------------------------------

## Apache – troubleshooting: problem z widokiem strony po zmianie DocumentRoot

### Problem
Po zmianie `DocumentRoot` na nowy katalog i wykonaniu reloadu Apache, przeglądarka nadal wyświetlała domyślną stronę powitalną Apache zamiast nowej treści.
Problemem okazał się cache przeglądrki.
Zapamiętać: Po zmianach, warto sobie sprawdzić działanie serwera po przez narzędzie curl 
-------------------------------------------------
	    curl – narzędzie CLI do komunikacji z serwerem HTTP/HTTPS
1. Sprawdzenie czy serwer odpowiada 
	Sprawdzamy, czy serwer WWW odpwiada na HTTP, bez przeglądraki 
	curl 192.168.50.80  =  Powinniśmy zobaczyć treść strony. Jeśli curl zwraca poprawną odpowiedź, a przeglądarka nie — problem leży po stronie klienta (np. cache), nie serwera Apache. 
2. Tylko nagłówki HTTP (bez treści) 
	 curl -I 192.168.50.80
HTTP/1.1 200 OK --------------- 404/403 - problem z zasobem lub dostępem	500- błąd po stronie serwerwa 
Date: Tue, 06 Jan 2026 12:03:58 GMT
Server: Apache/2.4.58 (Ubuntu) -------- Jaki serwer obsługje stronę 
Last-Modified: Mon, 05 Jan 2026 11:25:43 GMT
ETag: "2c-647a251d71f90"   ------- ETag (Entity Tag) to identyfikator wersji zasobu HTTP   (Odcisk palca pliku) 
Accept-Ranges: bytes
Content-Length: 44
Content-Type: text/html  ----- Jaki typ danych jest zwracany 
3. Symulacja błędu 404 
	curl -i 192.168.50.80/nieistnieje
HTTP/1.1 404 Not Found
Date: Tue, 06 Jan 2026 12:14:46 GMT
Server: Apache/2.4.58 (Ubuntu)
Content-Length: 275
Content-Type: text/html; charset=iso-8859-1
Błąd 404 wynika z tego że najzwyczajniej nie ma takiej podstrony na serwerze 
