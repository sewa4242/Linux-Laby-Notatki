#Instrukcje sterujące:
if -- początek instrukcji warunkowej
else -- alternatywna ścieżka
elif
fi -- koniec instrukcji
case
for
while
until
#Operatory testów:
1. Liczbowe: 
-gt	>	Greater Than
-ge	>=	Greater or Equal
-lt	<	Less Than
-le	<=	Less or Equal
-eq	==	Equal
-ne	!=	Not Equal
Powyższe operatory nie radzą sobie przy liczbach po przecinku!


#Opcje powłoki:
set -o pipefail -- Wyniki jest kod ostatniej komendy, która zawiodła np przy sprawdzaniu $? = 0
set -e
set -u
set -x

#AWK:
Poleceniem awk można wykonywać działania ( radzi sobie z liczbami po przecinku, działania w bashu mają z tym problem)
np. awk '{ print 100 - $13 }' $13 - Przykładowa zmienna pod którą może być przypsiana jakaś wartość).

`awk -n` - służy do przekazania wartości zmiennej wewnątrz awk. Bez tej flagi program awk nie użyje automatycznie zmiennej bashowej, będzie to dla programu osobna zmienna.
Przykład:
```text
name="Daro"

awk -v user="$name" 'BEGIN {
    print user
}'
```
BEGIN { ... } wykonuje się zazwyczaj raz na początku. Dobre do wykorzystawania w obliczeniach lub warunkach.
{ ... } wykonuje się raz dla każdej linii wejścia.

## Operatory używane do łączenia poleceń

`&&` - wykonaj następną komendę tylko wtedy kiedy poprzednia zwróci kod wyjścia 0.
`||` - wykonaj następną komendę tylko wtedy kiedy poprzednia zwróci kod wyjścia inny niż 0. np command2 wykona się tylko wtedy kiedy command1 zawiedzie.
`;` - wykonaj komendę niezależnie od poprzedniego wyniku.

