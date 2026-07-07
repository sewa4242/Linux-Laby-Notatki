# system-check.sh - Linux Health Check Script #
Prosty skrypt Bash wykonujący podstawowy health check systemu Linux.
## Cel projektu ##
Celem skryptu jest szybkie zebranie najważniejszych informacji o stanie systemu, oraz przećwiczenie programowania w bashu i automatyzacji podstawowej diagnostyki.
## Zakres działania ##
Skrypt sprawdza:

- obciążenie cpu
- informacja o systemie (czas działania,distro,kernel)
- pamięć RAM
- przestrzeń dyskową
- łączność sieciową 
- działanie DNS
- status wybranych usług systemowych
- podstawowe informacje z logów
- końcowe podsumowanie OK/UWAGA

## Ograniczenia obecnej wersji ##
Skrypt jest prostym narzędziem edukacyjnym i ma kilka ograniczeń:
- został przetestowany na maszynie wirtualnej Ubuntu Server z jednym głównym dyskiem,
- sekcja dysku  wymaga poprawy przy większej liczbie dysków lub partycji,
- sprawdzanie usług opiera się na prostym wykrywaniu statusu usługi,

## Wykorzystane narzędzia i komendy ##
W labie wykorzystałem narzędzia takie jak:

- date
- whoami
- hostname
- lsb_release
- uname
- uptime
- mpstat
- free
- df
- ls
- ip
- ping
- systemctl
- journalctl
- grep
- awk
- instrukcje warunkowe if/else
- operatory logiczne &&

## Przykładowy wynik działania ##

 ===== INFO =====
 Data: Tue Jul  7 06:35:17 PM CEST 2026
 Użytkownik: seweryn
 Host: ubuntumachine
 System: Ubuntu26.04LTS
 Kernel: 7.0.0-27-generic
 ===== CZAS PRACY / OBCIĄŻENIE ====
 Czas działania systemu: 8minutes
 Obciążenie CPU: 3.47
 ==== RAM ====
 Łączna ilość pamięci RAM: 3398 M
 Łączna ilość dostępnej użytkowej pamięci RAM: 2080 M
 ==== DYSK ====
 Podłączone dyski: /dev/sda
 wolne miejsce na dysku: 33908 MiB
 zajęte miejsce na dysku: 4040 MiB
 ==== SIEĆ ====
 IP urządzenia: 192.168.50.231/24
 Brama domyślna: 192.168.50.1
 Interfejs sieciowy: enp0s3
 Test bramy: OK
 Test DNS: OK
 Test łączności po adresie IP: OK
 ==== USŁUGI ====
 Usługa SSH: aktywna
 Usługa apache: aktywna
 Usługa rozwiązywania nazw doemnowych: aktywna
 ==== LOGI ====
 Liczba błędów systemowych z aktaulnego rozruchu: 4
 Nieudane próby logowania za pomocą SSH: 0
 ==== PODSUMOWANIE ====
CPU:OK
DYSK:OK
 RAM:OK
 INTERNET:OK
 DNS:OK
 USŁUGI:OK
