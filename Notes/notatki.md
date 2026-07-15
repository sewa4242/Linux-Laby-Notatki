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



#Opcje powłoki:
set -o pipefail -- Wyniki jest kod ostatniej komendy, która zawiodła np przy sprawdzaniu $? = 0
set -e
set -u
set -x

#AWK:
Poleceniem awk można wykonywać działania ( radzi sobie z liczbami po przecinku, działania w bashu mają z tym problem)
np. awk '{ print 100 - $13 }' $13 - Przykładowa zmienna pod którą może być przypsiana jakaś wartość).
