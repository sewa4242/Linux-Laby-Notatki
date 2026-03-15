## ANALYZER.SH ##
1. Pierwszy problem napotkałeś w zbyt szerokim filtrze, użyłeś tylko grep + failed password okazało się że trzeba użyc parę razy grepa aby np wyciągnać z auth.log szum komend sudo 
2. w logach sysloga 1 linia nie zawsze = 1 zdarzenie. Musisz brać pod uwagę na message repeated X times
3. Jak masz za duży bałagan w głowie jak w tym przypadku np policzyć i zsumować message repated i linijki z failed password, najłatwiej jest wtedy rozbić problem np na dwie zmienne 
4. Nasze $REPEATED_COUNT nie było jedną liczbą, w tym przypadku użyłeś prostą pętle bash bo była dla ciebie łatwiejsza 
        SUM=0	punkt startowy do liczenia. Bash musi mieć od czego zacząć 
for     NUM in $REPEATED_COUNT	--- NUM to tymczasowa zmienna która przechowuje nam jedną liczbę z listy dla każdej wartości w REPEATED-COUNT | przypisz ją do zmiennej NUM | i wykonaj kod w pętli
do
        SUM=$((SUM + NUM))
done
CAŁOŚĆ PĘTLI KROK PO KROKU:
REPEATED_COUNT="2 3 1"
START SUM=0
PĘTLA:
NUM=2 → SUM=2
NUM=3 → SUM=5
NUM=1 → SUM=6
KONIEC SUM=6
5.  sort | uniq -c | sort -rn | head Komenda uniq -c zlicza tylko te same lini dlatego przed tą komendą należy użyć komendy sort 
sort -rn  sortuje dane  -n sortuje wg wartości liczbowych bez tego "10" znalazła by się przed "2" -r odwraca wynik sortowania 
## Analiza TOP IP nie uwzględni wpisów z message repeated w wersji na prawdziwym serwerze należało by to ulepszyć 
6. USER=$(sudo grep "sshd" /var/log/auth.log | grep -i "failed password" | grep -v "message repeated" | awk '{print $7}' | sort | uniq -c | sort -rn | head)
   read USER_COUNT USERNAME <<< "$USER"
   read -- służy do wczytywania danych do zmiennych. Np. read name -- program czeka aż użytkownik coś wpisze w terminalu. Na przykład Seweryn wtedy bash robi name=Seweryn
   read potrafi automatycznie rozbić tekst po spacji. 
   Ty miałeś zmienną USER="2 Seweryn"
   Bash robi USER_COUNT=2 USERNAME=seweryn
   <<< here string -- potraktuj ten tekst jak wejście do polecenia 
   czyli <<< "$RESULT_USER" podaj zawartość zmiennej jako wejście do read
