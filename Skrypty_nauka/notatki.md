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
