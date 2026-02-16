## User & Group Management (Linux)

Cel: przećwiczenie tworzenia użytkowników/grup, uprawnień katalogów oraz sticky bit.
Środowisko: Ubuntu (VM).
Weryfikacja: id / getent / ls -l oraz test dostępu użytkowników.
### Tworzenie testowej grupy ###
	Grupę utworzyłem za pomocą komendy sudo groupadd labadmins
	Weryfikacji dodania grupy dokonałem za pomocą cat /etc/group | grep labadmins
### Tworzenie nowego usera ###
	Użytkownik został stworzony za pomocą sudo useradd labauser1
	Jego hasło zostało ustawione komendą sudo passwd labauser1
	Weryfikacja utworzenia getent passwd labauser1
### Dodanie usera do nowej grupy ###	
	Użytkownik został dodany do grupy za pomocą sudo usermod -aG labadmins labauser1
	sprawdzenie jego przynależności: id labauser1
### Symulacja dostępu do katalogu tylko dla grupy ##
	Stworzyłem nowy katalog /labuser 
	Zmieniłem właściciela (root ) oraz grupę (labadmins) która ma dostęp do zasobu za pomocą chown root:labadmins /labuser
	Zmieniłem uprawnienia do katalogu chmod 770 /labuser 
	W ramach testu uwtorzyłem nowego użytkownika (bez przynależności do labadmins) aby sprawdzić czy będzię mógł wejść w katalog. Tak jak przewidywałem wejście do katalogu za pomocą nowego użytkownika się nie udało.
	Również sprawdziłem czy użytkownik z przynależnością do grupy labadmins będzię mógł wejść w katalog. Tak użytkownik miał możliwość wejścia w katalog. 
### Sticky bit ### 
	Ustawiłem sticky bit (chmod 1770) na katalogu sticky, żeby sprawdzić
	jak działa ochrona przed usuwaniem cudzych plików.

	Każdy użytkownik z grupy labadmins może tworzyć pliki,
	ale nie może usuwać plików utworzonych przez innych użytkowników.
	Próby usunięcia cudzych plików kończą się błędem Operation not permitted.
### Usuwanie użytkowników oraz grup ###
	Do pozbycia się uzytkowników służacych mi w tym labie zastoswałem sudo deluser --remove-all-files --remove-home labuser1
	Analogicznie do usunięcia grup użyłem sudo delgroup labadmins 
	Wynik czyszczenia użytkowników sprawdziłem przy pomocy getent group | grep labadmins   oraz getent passwd | grep labuser1
## Wynik testu
- Użytkownik spoza grupy: brak dostępu do /labuser (permission denied) ✅
- Użytkownik w grupie labadmins: dostęp do /labuser ✅
