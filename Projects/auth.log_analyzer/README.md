# auth_log_analyzer.sh 
## Cel projektu 
Stworzenie prostego skryptu Bash analizującego log systemowy /var/log/auth.log w celu wykrycia podejrzanych prób logowania SSH.
Skrypt automatyzuje analizę logów i pozwala szybko ustalić:
1. łączną liczbę nieudanych prób logowania SSH
2. z jakiego adresu IP pochodziło najwięcej prób logowania
3. na które konto użytkownika najczęściej próbowano się zalogować
Skrypt symuluje sytuację pracy administratora systemu lub analityka SOC, który chce szybko sprawdzić czy serwer jest celem ataku typu SSH brute force.
## Scenariusz:
Administrator zauważa zwiększoną aktywność w logach systemowych i chce sprawdzić:
1. ile było nieudanych prób logowania SSH
2. z jakich adresów IP pochodziły próby logowania
3. które konto użytkownika było najczęściej atakowane
Zamiast ręcznie przeszukiwać logi systemowe, administrator uruchamia skrypt analizujący log.
## Etapy działania:
### ETAP 1 – Wykrycie nieudanych logowań SSH
Skrypt przeszukuje plik /var/log/auth.log w poszukiwaniu wpisów zawierających: Failed password
Wyniki są dodatkowo filtrowane tak, aby uwzględniać tylko wpisy procesu sshd.
### ETAP 2 - Zliczenie wszystkich prób logowania
Skrypt oblicza łączną liczbę nieudanych logowań SSH.
Podczas analizy uwzględniany jest również wpis systemowy:
message repeated X times
Wpis ten oznacza, że dana wiadomość pojawiła się wielokrotnie w logu.
Przykład:
Failed password for user from 192.168.1.10
message repeated 2 times
Oznacza to 3 rzeczywiste próby logowania, mimo że w logu widoczne są tylko dwie linie.

Dlatego skrypt:
1. zlicza standardowe wpisy Failed password

2. odczytuje liczbę powtórzeń z wpisów message repeated

3. sumuje oba wyniki w celu uzyskania rzeczywistej liczby prób logowania
### ETAP 3 - Najczęstszy adres IP
Skrypt analizuje adresy IP pojawiające się w logach nieudanych logowań.
1. Adresy IP są:
2. wyodrębniane z logu
3. sortowane
4. zliczane
Analiza ta nie uwzględnia wpisów typu: message repeated X times
Wpisy te są pomijane w celu uproszczenia analizy i zachowania spójnej struktury danych w pipeline.
Oznacza to, że w niektórych przypadkach wynik może być zaniżony, ponieważ wpis message repeated może reprezentować wiele prób logowania z tego samego adresu IP.
W środowisku produkcyjnym należałoby rozszerzyć analizę tak, aby również uwzględniała liczbę powtórzeń z tych wpisów.
### ETAP 4 - Najczęściej atakowany użytkownik
Na podstawie wpisów Failed password skrypt określa, na które konto użytkownika najczęściej próbowano się zalogować.

Podobnie jak w przypadku adresów IP:
1. wyodrębniana jest nazwa użytkownika
2. wyniki są sortowane
3. zliczana jest liczba prób logowania

## Narzędzia użyte w skrypcie

Skrypt wykorzystuje standardowe narzędzia systemów Linux:
1. grep – filtrowanie wpisów logów
2. awk – wyodrębnianie konkretnych pól z logów
3. sort – sortowanie danych
4. uniq -c – zliczanie powtarzających się wartości
5. bash arithmetic – operacje arytmetyczne w skrypcie
6. read – rozdzielenie danych na zmienne

## Testowanie skryptu
Skrypt był testowany na maszynie wirtualnej z systemem Ubuntu poprzez:
1. wykonywanie wielokrotnych nieudanych prób logowania SSH
2. analizę wygenerowanych wpisów w pliku /var/log/auth.log
3. weryfikację poprawnego wykrywania:
4. liczby prób logowania
5. adresów IP
6. najczęściej atakowanego użytkownika
## Wnioski 
Podczas analizy logów systemowych należy pamiętać, że:
1. jedna linia logu nie zawsze oznacza jedno zdarzenie
2. wpisy typu message repeated X times mogą zaniżać wynik prostego zliczania linii
