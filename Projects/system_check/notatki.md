# system_check.sh - notatki techniczne

## Cel skryptu
`system_check.sh` to prosty skrypt Bash wykonujący podstawowy health check.

Skrypt zbiera informacje o:

- systemie,
- czasie działania,
- CPU,
- RAM,
- dysku,
- sieci,
- DNS,
- usługach systemowych,
- logach,
- końcowym statusie OK/UWAGA.

## INFO

Do czasu działania systemu zostało użyte `uptime -p` 
Przy prostym użyciu awk print wynik 1hour jest bez sklejony warto przy podobnych sytuacjach rozważyć awk z użyciem separtaora.

## CZAS PRACY/OBCIĄŻENIE

Do obliczenia obciążenia CPU wykorzystano `mpstat`.
Celem było odfiltrowanie wartości wolnej mocy % CPU i później odjęcię go od 100 za pomoca awk (liczby po przecinku nie radzą sobie z matematyką w bashu).

## RAM 

free -m dzięki użytej fladze, łatwiej jest się dowiedzieć ile faktycznie wolnego RAM posiadamy.

## Dyski
To jest największe ograniczenie obecnej wersji skryptu.
Wolne miejsce i zajętę miejsce na dysku odbywa się za pomocą prostego `df -H | grep "sd.*" | awk '{ print $4}'`. Przez co jeśli będzie więcej dysków, skrypt tego nie uwzględni.
Najprostsza naprawa tego problemu: Zrobić prostą pętlę z for do ? 

## Podsumowanie 
sekcja podusmowanie działa na prostym mechanizmie zapisywania wyników wcześniejszych testów do zmiennych ` if [ -n "$zmienna" ] ` 
Naprzykład:

```text
jeżeli test DNS się powiedzie → ustaw zmienną z wartością OK
jeżeli test DNS się nie powiedzie → ustaw zmienną z wartością UWAGA
```

Potem wykonujemy prostą pętlę z sprawdzeniem czy coś w zmiennej jest zapisane i odpowiedni status jest wyświetlany.
Przy zbiorczym statusie usług sprzydał się operator `&&`
Operator `&&` pozwala połączyć kilka warunków. Cały warunek przechodzi tylko wtedy, gdy wszystkie jego części są prawdziwe.
 
