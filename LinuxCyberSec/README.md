## LinuxCyberSec

Ten katalog zawiera moje notatki i laboratoria z nauki systemu Linux oraz podstaw cyberbezpieczeństwa (Blue Team).
Wszystkie ćwiczenia były wykonywane ręcznie na maszynie wirtualnej z Ubuntu, z naciskiem na praktyczne zadania administracyjne i analizę logów.

## Co tu jest
Zbiór ćwiczeń i notatek z zakresu administracji Linuxem, pracy z usługami oraz analizy logów.

### Analiza prób logowania
Plik z analizą logów SSH i użycia sudo.
Sprawdzałem między innymi: 
- nieudane logowania,
- z jakich IP były próby,
- ile ich było,
- w jakim czasie się pojawiały.

Wnioski są na końcu pliku.

Plik: `Analiza_prob_logowania.md`

---

### Apache
Notatki z pracy z Apache:
- sprawdzenie usługi,
- zmiana DocumentRoot,
- gdzie są pliki konfiguracyjne,
- prosty troubleshooting (cache przeglądarki, curl).
### Wynik
- Zweryfikowano działanie usługi Apache
- Zlokalizowano pliki konfiguracyjne i katalog DocumentRoot
- Przeprowadzono podstawowy troubleshooting dostępu do strony
Plik: `Apache.md`

---

### Poszukiwanie plików i logów
Ćwiczenia z:
- `find` + `-exec`,
- `grep`, `zgrep`,
- pipe i przekierowań,
- zapisu wyników do plików z użyciem `tee`.
### Wynik
- Przećwiczono skuteczne wyszukiwanie plików i treści w systemie
- Połączono find z grep oraz -exec
- Zastosowano potoki i przekierowania do zapisu wyników
Plik: `poszukiwanie_pliku.md`
###
