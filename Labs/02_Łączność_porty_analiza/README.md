### Celem laboratorium jest nauka diagnozowania połączeń sieciowych w systemie Linux przy użyciu narzędzia ss ###

### ETAP 1 --- Co nasłuchuje na serwerze ###

1. Wszystkie porty tcp `ss -t` 
2. Tylko nasłuchujące porty tcp `ss -t -l`
3. Powiązanie portu z procesem `sudo ss -t -l -p`
LISTEN         0              4096                        127.0.0.54:domain                        0.0.0.0:*             users:(("systemd-resolve",pid=533,fd=17)) 
systemd-resolve --- proces odpowiadający za tłumaczenie nazw domeny na adres ip 

### ETAP 2 --- LISTEN VS ESTABLISHED ###
	`sudo ss -t -p`
1. ESTAB              0                   0                                [::ffff:192.168.50.80]:ssh                            [::ffff:192.168.50.203]:49336               users:(("sshd",pid=1461,fd=4),("sshd",pid=1386,fd=4))

ssh = 22 port serwera 
port ephemeral = 49336 --- port klienta 
LISTEN = port jest w gotowości w nawiązaniu połączenia. 
ESTABLISHED = aktywna sesja TCP między klientem a serwerem. 

### ETAP 3 --- Co się dzieje gdy usługa znika ###

1. Sprawdzenie stanu wyjściowego usługi apache `sudo ss -t -l -p | grep http` 
	LISTEN 0      511                *:http              *:*    users:(("apache2",pid=1109,fd=4),("apache2",pid=1108,fd=4),("apache2",pid=1106,fd=4))
2. Zatrzymanie usługi `sudo systemctl stop apache2` 
3. Sprawdzenie czy port od apache2 przestał być w listen `sudo ss -t -l -p | grep http`. Tak ponieważ w wyniku komendy zniknął wpis na temat portu http oraz procesu apache2
Wniosek: Zniknięcie wpisu LISTEN po zatrzymaniu usługi potwierdza zależność między procesem a otwartym portem. 

### ETAP 4 --- Recv-Q / Send-Q ###
    Recv-Q   Send-Q 
### Celem laboratorium jest nauka diagnozowania połączeń sieciowych w systemie Linux przy użyciu narzędzi takich jak ss, netstat, lsof, tcpdump, oraz interpretacja stanów TCP. ###

### ETAP 1 --- Co nasłuchuje na serwerze ###

1. Wszystkie porty tcp `ss -t`
2. Tylko nasłuchujące porty tcp `ss -t -l`
3. Powiązanie portu z procesem `sudo ss -t -l -p`
LISTEN         0              4096                        127.0.0.54:domain                        0.0.0.0:*             users:(("systemd-resolve",pid=533,fd=17))
systemd-resolve --- proces odpowiadający za tłumaczenie nazw domeny na adres ip

### ETAP 2 --- LISTEN VS ESTABLISHED ###
        `sudo ss -t -p`
1. ESTAB              0                   0                                [::ffff:192.168.50.80]:ssh                            [::ffff:192.168.50.203]:49336               users:(("sshd",pid=1461,fd=4),("sshd",pid=1386,fd=4))

ssh = 22 port serwera
port ephemeral = 49336 --- port klienta
LISTEN = port jest w gotowości w nawiązaniu połączenia.
ESTABLISHED = aktywna sesja TCP między klientem a serwerem.

### ETAP 3 --- Co się dzieje gdy usługa znika ###

1. Sprawdzenie stanu wyjściowego usługi apache `sudo ss -t -l -p | grep http`
        LISTEN 0      511                *:http              *:*    users:(("apache2",pid=1109,fd=4),("apache2",pid=1108,fd=4),("apache2",pid=1106,fd=4))
2. Zatrzymanie usługi `sudo systemctl stop apache2`
3. Sprawdzenie czy port od apache2 przestał być w listen `sudo ss -t -l -p | grep http`. Tak ponieważ w wyniku komendy zniknął wpis na temat portu http oraz procesu apache2
Wniosek: Zniknięcie wpisu LISTEN po zatrzymaniu usługi potwierdza zależność między procesem a otwartym portem.

### ETAP 4 --- Recv-Q / Send-Q ###
    Recv-Q   Send-Q
ESTAB 0      0      [::ffff:192.168.50.80]:ssh  [::ffff:192.168.50.203]:57186
1. Recv-Q -- liczba bajtów odebranych przez kernel ale jeszcze NIE odebranych przez aplikację.
2. Send-Q -- liczba bajtów wysłanych przez aplikacje ale jeszcze nie potwierdzonych przez drugą stronę.

ESTABLISHED -- w tym stanie oznaczają bufor danych
LISTEN      -- w tym stanie oznaczają backlog połączeń
        Analiza Recv-Q i Send-Q pozwala określić gdzie leży problem, po stronie aplikacji lokalnej czy komunikacji zdalnej na przykład:

Recv-Q wysokie --- lokalna aplikacja nie odbiera danych
Send-Q wysokie --- klient/sieć nie potwierdza danych
LISTEN backlog pełny → problem z przyjmowaniem połączeń (accept) możliwy atak DoS
1. Recv-Q -- liczba bajtów odebranych przez kernel ale jeszcze NIE odebranych przez aplikację.
2. Send-Q -- liczba bajtów wysłanych przez aplikacje ale jeszcze nie potwierdzonych przez drugą stronę.

ESTABLISHED -- w tym stanie oznaczają bufor danych
LISTEN      -- w tym stanie oznaczają backlog połączeń 
	Analiza Recv-Q i Send-Q pozwala określić gdzie leży problem, po stronie aplikacji lokalnej czy komunikacji zdalnej na przykład:

Recv-Q wysokie --- lokalna aplikacja nie odbiera danych
Send-Q wysokie --- klient/sieć nie potwierdza danych
LISTEN backlog pełny → problem z przyjmowaniem połączeń (accept) możliwy atak DoS 


### WNIOSEK ###
	Narzędzie ss nie pokazuje nam tylko otwartych portów ale pozwala nam na anlizę połączenia jak i również znaleźienia wąskich gardeł komunikacji 


