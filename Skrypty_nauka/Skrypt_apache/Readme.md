#Analiza logów Apache (grep)
#Cel laba:

Celem tego laba jest stworzenie prostego skryptu bash, który za pomocą narzędzia grep:

wyszukuje w pliku access.log linie z kodami 404 oraz 200

zlicza, ile razy dany kod odpowiedzi wystąpił

zapisuje wynik do plików tekstowych

informuje użytkownika o wyniku działania skryptu

#Opis działania skryptu:
Przeszukuje plik /var/log/apache2/access.log w poszukiwaniu kodu 404

Zlicza wystąpienia i zapisuje wynik do pliku errors.txt

Informuje użytkownika, czy błędy 404 zostały znalezione

Przeszukuje ten sam log pod kątem kodu 200

Zlicza wystąpienia i zapisuje wynik do pliku logowania.txt

Informuje użytkownika o poprawnej komunikacji z serwerem

#Narzędzia którę wykorzystałem: bash/grep/wc -l/potok (|)
