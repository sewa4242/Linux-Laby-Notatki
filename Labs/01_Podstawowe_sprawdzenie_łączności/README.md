###	Cel laba: Sprawdzenie czy host jest poprawnie skonfigurowany oraz stworzerzenie problemu i rozwiązanie go


### Rozpoznanie stanu systemu 
	Aktualną konfigurację sieci sprawdziłem za pomocą `ip a`
	Do sprawdzenie konfiguracji trasy sieci użyłem ` route -n `
### Test łączności ###

W taki sposób wykonałem diagnostykę:
1. Ping do bramy - potwierdził poprawną komunikację z routerem
2. Ping do publicznego IP - potwierdził poprawne działanie routingu i wyjście do internetu.
3. Ping po nazwie domeny - potwierdził poprawne działanie DNS.

Wszystkie testy zakończyły się sukcesem.

### Symulacja Awarii ###

Zasymulowałem awarię za pomocą zatrzymania usługi ` sudo systemctl stop systemd-resolved ` 
Do sprawdzenia stanu usługi użyłem ` systemctl status systemd-resolved ` , status tej komendy potwierdził moją zasymulowaną awarię 
Zatrzymanie tej usługi spowodowało brak możliwości rozwiązywania nazw domenowych. Ponieważ usługa systemd-resolved odpowiedzialna za rozwiązywanie nazw DNS była zatrzymana. 
Po sprawdzeniu konsekwencji zasymulowanej awarii, uruchomiłem usługę ponownię za pomocą systemctl start systemd-resolved.
Zgodnie z przewidywaniami, rozwiązywanie nazw domenowych poprzez DNS się wznowiła.


### Wnioski ###
Zatrzymanie usługi systemd-resolved nie wpłynęło na routing ani łączność IP,
a jedynie na rozwiązywanie nazw domenowych.
Lab pozwolił mi zrozumieć zależność między IP, routingiem a usługą DNS.
