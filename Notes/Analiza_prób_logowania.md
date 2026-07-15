## Analiza logów logowania i użycia sudo (Etapy 1–4)

### Komenda szybkiego wyszukania błędów logowania:
sudo find Incident_LAB/Logi/ -type f -iname "*.log" -exec grep -R -iE "Failed|password|session|accepted|ssh|sudo:|invalid|user" {} + | sudo tee Incident_LAB/Analiza/logowania_suspect.txt > /dev/null

### Wyszukanie sudo:
grep -i "sudo" logowania_suspect.txt > sudo_historia.txt

### Wyszukanie zdarzeń dzisiejszych:
1) grep "$(date +%b\ %e)" logowania_suspect.txt Najprostszy ------ jeśli chcesz szybko sprawdzić format daty :
-Działa gdy format daty w logach to np. Oct 27 albo Oct 7.
-Szybkie, ale dla dni <10 może być problem z liczbą spacji.
2)grep -E "$(date +%b)[[:space:]]+$(date +%e | sed 's/^ *//')" logowania_suspect.txt  ----Odporna wersja (usuwa problem ze spacjami)
3) Krótka testowa komenda (czy w ogóle jest ten miesiąc w pliku) grep "$(date +%b)" logowania_suspect.txt | head -n 10 --- jeśli nic nie zwraca no to nic nie znalazło 
### Format YYYY-MM-DDTHH:MM:SS NP 2025-10-26T11:58:44+01:00
grep typu:
grep "$(date +%F)" log.txt
# date +%F → 2025-10-26

### Raport:
- Brak prób nieautoryzowanych logowań
- Użycie sudo przez użytkownika u1 zgodne z normalnym działaniem
- Brak oznak włamania 



# Analiza podejrzanych logowań SSH (Etap 1–4)

## Cel
Zadanie polegało na analizie logów SSH w celu wykrycia:
- nieudanych prób logowania,
- adresów IP, z których pochodziły próby,
- czasu pierwszego i ostatniego zdarzenia,
- ewentualnych oznak brute-force lub enumeracji kont.

---

## 1) Zebranie logów
Logi analizowane były z plików:
- /var/log/auth.log
- /var/log/auth.log.1
- /var/log/auth.log.*.gz (opcjonalnie)

Podejrzane linie zostały wyfiltrowane na podstawie fraz takich jak:
- "Failed password"
- "authentication failure"
- "Invalid user"
- "PAM"

Wyniki zapisano do: Incident_LAB/Analiza/Wykaz_failed.txt

---

## 2) Wyciągnięcie adresów IP i zliczenie prób
Do wyszukania adresów IPv4 wykorzystano regex: '\d+.\d+.\d+.\d+'

Proces:
- wyciąganie IP,
- sortowanie,
- liczenie wystąpień,
- sortowanie malejąco według liczby prób.

Wynik zapisano do: Incident_LAB/Analiza/ip_counts.txt

Przykładowy wynik: 9 10.0.2.2
Oznacza to 9 nieudanych prób logowania z IP 10.0.2.2.

---

## 3) Analiza czasowa (timeline)
Dla podejrzanego IP przefiltrowano logi:grep -F "10.0.2.2" Wykaz_failed.txt > test_1.txt

Liczba prób:wc -l test_1.txt

Sortowanie chronologicznie: sort test_1.txt > test_1_sorted.txt
Wyciągnięcie pierwszego i ostatniego zdarzenia:
head -n1 test_1_sorted.txt
tail -n1 test_1_sorted.txt

---

## 4) Wyniki analizy
IP: 10.0.2.2  
Liczba prób: 9  
Pierwsza próba: 2025-10-28T10:02:05  
Ostatnia próba: 2025-10-28T10:00:36  
Charakter ruchu: ręczne próby logowania (brak sygnałów automatycznego brute-force)  
Obserwowani użytkownicy: u1, seweryn  
Zakres adresów: prywatna sieć lokalna, nie Internet.

---

## Status nauki po tym etapie
Opanowane:
- filtrowanie logów,
- wyszukiwanie wzorców,
- regex IPv4,
- grupowanie zdarzeń po IP,
- tworzenie osi czasu,
- podstawowa interpretacja incydentu SSH.

Następny krok:









