## Fail2ban -- Ochrona SSH przed atakaiem brute-force

## Opis laba

Lab przedstawia zabezpieczenia usługi SSH przed atakiem brute-force przy użyciu narzędzia fail2ban na systemie Linux
Fail2Ban obserwuje logi systemowe i automatycznie blokuje adresy IP, które wykonają zbyt wiele nieudanych prób logowania do systemu po przez usługę SSH

## Cel: 
1. Wykrycie prób brute-force na SSH
2. Konfiguracja Fail2Ban
3. Automatyczne blokowanie adresów IP

## Konfiguracja: 
1. Instalacja Fail2Ban
sudo apt search fail2ban
sudo apt update
sudo apt install fail2ban
2. Utworzenie pliku konfiguracyjnego /etc/fail2ban/jail.local
3. Minimalna konfiguracja: 
	[DEFAULT]
	bantime = 1h
	findtime = 10m
	maxretry = 5
	[sshd]
	enabled = true
	port = 22
	logpath = /var/log/auth.log
4. Symulacja ataku. Wygenerowano wiele nieudanych prób logowania:
	ssh seweryn@localhost -p 22 
   Wprowadzono błędne hasło w celu zasymulwoania ataku 
5. Rezultat:
Na aktywnej sesji SSH ukazał się  komunikat client_loop: send disconnect: Connection reset
To znak że przekroczyłem limit nieudanych prób logowania fail2bana, co poskutkowało dodaniem reguły do firewall przez co zerwałem połączenie z SSH i zablokowaniem mojego IP 
	Status
|- Number of jail: 1      -- Liczba usług dla których działa Fail2ban
`- Jail list: sshd

Status for the jail: sshd
|- Filter
|  |- Currently failed: 0
|  |- Total failed: 4		-- liczba nieudanych logowań
|  `- Journal matches: _SYSTEMD_UNIT=sshd.service + _COMM=sshd
`- Actions
   |- Currently banned: 1       -- liczba aktualnych zablokowanych użytkowników
   |- Total banned: 1
   `- Banned IP list: 192.168.50.203

## Fail2Ban to narzędzie typu log-based intrusion prevention system, które automatycznie wykrywa i blokuje podejrzane aktywności na podstawie analizy logów.
