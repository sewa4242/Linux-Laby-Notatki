# net_triage.sh
## Cel projektu
Stworzenie prostego skryptu Bash  diagnozującego podstawowe problemy siecowe hosta.
Skrypt ten: 
1. Sprawdza czy istnieje brama sieciowa 
2. Próbuje nawiązać połączenie z bramą sieciową 
3. Sprawdza rozwiązywanie nazw domen
4. Sprawdza czy port HTTP jest w trybie listen 
5. Czy usługa apache prawidłowo działa 
------------------------------------------------------------------------------------------
## Scenariusz:
Host nie ma dostępu do internetu / nie potrafi nawiząć komunikacji z inną siecią.
## Etapy działania:
### ETAP 1 - ROUTING
Sprawdzenie czy istnieje brama sieciowa.
Próba nawiąznia z nią komunikacji. Jeśli komunikacja jest poprawna przejście do następnego etapu.
Wyświetlenie jasnego komunikatu.
### ETAP2 - DNS
Czy usługa odpowiedzialna za rozwiązywanie nazw domeny działa.
Jeśli DNS działa --> komunikat o poprawnym działaniu. Przejście do następnego etapu.
Jeśli DNS nie działa ---> komunikat o błędnym działaniu. Wyłączenie skryptu.
### ETAP 3 - PORT
Sprawdzenie czy port usługi HTTP jest w stanie listen.
Jeśli port nasłuchuje, przejście do następnego etapu skryptu.
Jeśli nie, wyłączenie skryptu.
### ETAP 4 - USŁUGA HTTP
Sprawdzenie czy serwer apache odpowie na zapytanie.
Jeśli tak: komunikat oraz zakończenie całego skryptu.
Jeśli Nie: komunikat oraz zakończenie całego skryptu. 

## Narzędzia użyte w skrypcie
- ip route – sprawdzenie bramy sieciowej
- ping – test łączności z bramą i domeną
- ss – sprawdzenie portów w stanie LISTEN
- curl – sprawdzenie odpowiedzi usługi HTTP
- grep / awk – filtrowanie danych z poleceń

## Testowanie skryptu 
Skrypt został przetestowany w różnych scenariuszach:

- zatrzymanie usługi Apache w celu sprawdzenia reakcji na brak portu HTTP
- sprawdzenie działania DNS poprzez zatrzymanie usługi systemd-resolved
- weryfikacja poprawnego wykrycia bramy sieciowej
