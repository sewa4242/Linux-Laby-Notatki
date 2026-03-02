## Analiza logów Apache (grep)

### Cel laba
Celem tego laba jest stworzenie prostego skryptu Bash, który przy użyciu narzędzia `grep` analizuje logi Apache.
Skrypt:
- wyszukuje w pliku access.log wystąpienia kodów odpowiedzi 404 oraz 200
- zlicza liczbę ich wystąpień
- zapisuje wyniki do plików tekstowych
- informuje użytkownika o rezultacie działania skryptu

#Opis działania skryptu:
- Przeszukuje plik `/var/log/apache2/access.log` w poszukiwaniu kodu **404**
- Zlicza wystąpienia i zapisuje wynik do pliku `errors.txt`
- Informuje użytkownika, czy błędy 404 zostały wykryte
- Następnie analizuje ten sam log pod kątem kodu **200**
- Zlicza wystąpienia i zapisuje wynik do pliku `logowania.txt`
- Informuje użytkownika o poprawnej komunikacji z serwerem
- Skrypt wykorzystuje kod wyjścia polecenia grep (exit status) do warunkowego tworzenia lub usuwania plików wynikowych.

### W przypadku dużej liczby błędów 404 administrator może następnie przeanalizować log ręcznie w celu identyfikacji przyczyny problemu (np. brakujących zasobów, błędnych ścieżek, ataków typu scanning).

### Narzędzia wykorzystane w labie
- Bash
- grep
- wc -l
- potoki (`|`)
