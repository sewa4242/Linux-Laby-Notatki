#!/bin/bash
data=$(date)
user=$(whoami)
host=$(hostname)
system=$(lsb_release -a | grep "Description" | awk '{print $2 $3 $4}')
kernel=$(uname -r)
czas=$(uptime -p | awk '{print $2 $3}')
free=100
cpuidle=$(mpstat | grep "all" | awk '{ print 100 - $13}')
totalram=$(free -h | grep -i "mem" | awk '{ print $2 }')
freeram=$(free -h | grep -i "mem" | awk '{ print $4 }')
dyski=$(ls /dev/sd?)
freespace=$(df -H | grep "sd.*" | awk '{ print $4}')
usespace=$(df -H | grep "sd.*" | awk '{ print $3}')
ip=$(ip addr | grep -i "enp0s3" | grep -i "inet" | awk '{print $2}')
gateway=$(ip route | grep -i "via" | awk '{print $3}')
inter=$(ip route | grep -i "via" | awk '{print $5}')
echo " ===== INFO ===== "
echo " Data: $data "
echo " Użytkownik: $user "
echo " Host: $host"
echo " System: $system "
echo " Kernel: $kernel "
echo " ===== CZAS PRACY / OBCIĄŻENIE ==== "
echo " Czas działania systemu: $czas "
echo " Obciążenie CPU: $cpuidle "
echo " ==== RAM ==== "
echo " Łączna ilość pamięci RAM: $totalram "
echo " Łączna ilość dostępnej użytkowej pamięci RAM: $freeram "
echo " ==== DYSK ==== "
echo " Podłączone dyski: $dyski "
echo " wolne miejsce na dysku: $freespace "
echo " zajęte miejsce na dysku: $usespace "
echo " ==== SIEĆ ==== "
echo " IP urządzenia: $ip "
echo " Brama domyślna: $gateway "
echo " Interfejs sieciowy: $inter "
        ping -c 3 192.168.50.1 >/dev/null
if [ "$?" = "0" ]
then
echo " Test bramy: OK "
else
echo " Test bramy: Niepowodzenie "
fi
