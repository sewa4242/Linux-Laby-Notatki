## Pliki  fail2ban
1. jail.conf --> główny plik konfiguracyjny. Plik ten nie służy do edytownia. Używamy go jako wzoru
- pokazuje wszystkie możliwe opcje
- zawiera gotowe konfiguracje

2. jail.local --> plik konfiguracyjny stworzony przez użytkownika:
- tutaj robimy konfigurację 
- nadpisuje jail.conf

3. filter.d/ --> reguły wykrywania ataków:
- zawiera regexy
- pokazuje fail2ban jak wygląda atak

4. fail2ban.log --> log działania Fail2Ban
- informację o tym czy ban działa 

5. action.d/ --> co się dzieje po wykryciu ataku ( dodaję regułe firewall)
- iptables
- nftables
- mail

# Uproszczone działanie Fail2Ban 
Logi + regex (filter.d) + konfiguracja (jail.local) = ban IP (firewall)

# Komendy diagnostyczne
fail2ban-client status --> lista usług dla których działa fail2ban
fail2ban-client status sshd --> informację na temat liczby aktualnie zbanowanych, łącznie zbanowanych oraz ich IP
# Minimalna konfiguracja fail2ban

[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 5
[sshd]
enabled = true
port = 22
logpath = /var/log/auth.log
