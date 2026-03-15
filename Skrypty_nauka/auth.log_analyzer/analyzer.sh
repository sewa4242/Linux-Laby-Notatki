#!/bin/bash
	echo "===== SSH LOGIN ANALYSIS ====="
	NORMAL_COUNT=$(sudo grep  "sshd" /var/log/auth.log | grep -i "failed password" | grep -v "message repeated" | wc -l)
	REPEATED_COUNT=$(sudo grep  "sshd" /var/log/auth.log | grep -i "failed password" | grep "message repeated" | awk '{print $6}')
	SUM=0
for	NUM in $REPEATED_COUNT
do
	SUM=$((SUM + NUM))
done
	TOTAL=$((NORMAL_COUNT + SUM))
	echo "Łączna liczba nieudanych logowań = $TOTAL"
	RESULT=$(sudo grep  "sshd" /var/log/auth.log | grep -i "failed password" | grep -v "message repeated" | awk '{print $9}' | sort | uniq -c | sort -rn | head)
	IP=$(echo "$RESULT" | awk '{print $2}')
	PROB=$(echo "$RESULT" | awk '{print $1}')
	echo "Najczęstszy adres IP: $IP - $PROB prób"
	USER=$(sudo grep  "sshd" /var/log/auth.log | grep -i "failed password" | grep -v "message repeated" | awk '{print $7}' | sort | uniq -c | sort -rn | head)
	read USER_COUNT USERNAME <<< "$USER"
	echo "Najczęstszy cel logowania: $USERNAME - $USER_COUNT prób"
