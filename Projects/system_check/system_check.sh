#!/bin/bash
data=$(date)
user=$(whoami)
host=$(hostname)
system=$(lsb_release -a | grep "Description" | awk '{print $2 $3 $4}')
kernel=$(uname -r)
czas=$(uptime -p | awk '{print $2 $3}')
free=100
cpuse=$(mpstat | grep "all" | awk '{ print 100 - $13}')
totalram=$(free -m | grep -i "mem" | awk '{ print $2 }')
freeram=$(free -m | grep -i "mem" | awk '{ print $4 }')
dyski=$(ls /dev/sd?)
freespace=$(df -m | grep "sd.*" | awk '{ print $4}')
usespace=$(df -m | grep "sd.*" | awk '{ print $3}')
ip=$(ip addr | grep -i "enp0s3" | grep -i "inet" | awk '{print $2}')
gateway=$(ip route | grep -i "via" | awk '{print $3}')
inter=$(ip route | grep -i "via" | awk '{print $5}')
boot_error=$(journalctl -p err -b --no-pager | wc -l)
ssh=$(grep -ai "failed password" /var/log/auth.log | wc -l)
echo " ===== INFO ===== "
echo " Data: $data "
echo " Użytkownik: $user "
echo " Host: $host"
echo " System: $system "
echo " Kernel: $kernel "
echo " ===== CZAS PRACY / OBCIĄŻENIE ==== "
echo " Czas działania systemu: $czas "
echo " Obciążenie CPU: $cpuse "
echo " ==== RAM ==== "
echo " Łączna ilość pamięci RAM: $totalram M "
echo " Łączna ilość dostępnej użytkowej pamięci RAM: $freeram M "
echo " ==== DYSK ==== "
echo " Podłączone dyski: $dyski "
echo " wolne miejsce na dysku: $freespace MiB "
echo " zajęte miejsce na dysku: $usespace MiB"
echo " ==== SIEĆ ==== "
echo " IP urządzenia: $ip "
echo " Brama domyślna: $gateway "
echo " Interfejs sieciowy: $inter "

        ping -c 2 192.168.50.1 >/dev/null
if [ "$?" = "0" ]
then
echo " Test bramy: OK "
else
echo " Test bramy: Niepowodzenie "
fi

	ping -c  2 google.pl &>/dev/null
if [ "$?" = "0" ]
then
echo " Test DNS: OK "
sumdns1=OK
else
echo " Test DNS: Niepowodzenie "
sumdns2=UWAGA
fi
	ping -c 3 8.8.8.8 &>/dev/null
if [ "$?" = "0" ]
then
echo " Test łączności po adresie IP: OK "
sumint1=OK
else
echo " Test łączności po adresie IP: Niepowodzenie "
sumint2=UWAGA
fi

echo " ==== USŁUGI ==== "
if systemctl status sshd | grep -o "inactive" >/dev/null
then
echo " Usługa SSH: nieaktywna "
status_sshd1=UWAGA
else
echo " Usługa SSH: aktywna"
status_sshd2=OK
fi

if systemctl status apache2 | grep -o "inactive" >/dev/null
then
echo " Usługa apache: nieaktywna "
status_apache1=UWAGA
else
echo " Usługa apache: aktywna"
status_apache2=OK
fi

if systemctl status systemd-resolved.service | grep -o "inactive" >/dev/null
then
echo " Usługa rozwiązywania nazw domenowych: nieaktywna "
status_systemd1=UWAGA
else
echo " Usługa rozwiązywania nazw doemnowych: aktywna"
status_systemd2=OK
fi
echo " ==== LOGI ==== "
echo " Liczba błędów systemowych z aktaulnego rozruchu: $boot_error "
echo " Nieudane próby logowania za pomocą SSH: $ssh "
echo " ==== PODSUMOWANIE ===="

awk -v cpuse="$cpuse" 'BEGIN { if (cpuse > 70 ) print "CPU:UWAGA"; else print "CPU:OK" }'

awk -v usespace="$usespace" 'BEGIN { if (usespace > 30000) print "DYSK:UWAGA"; else print "DYSK:OK" }'

if [ "$freeram" -le 1000 ]
then echo " RAM:UWAGA "
else echo " RAM:OK"
fi

if [ -n "$sumint1" ]
then echo " INTERNET:$sumint1 "
else echo " INTERNET:$sumint2 "
fi

if [ -n "$sumdns1" ]
then echo " DNS:$sumdns1 "
else echo " DNS:$sumdns2"
fi

if [ "$status_sshd2" =  "OK" ] && [ "$status_apache2" = "OK" ] && [ "$status_systemd2" = "OK" ]
then echo " USŁUGI:OK "
else echo " USŁUGI:UWAGA"
fi
