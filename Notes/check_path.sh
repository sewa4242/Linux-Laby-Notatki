#!/bin/bash
#Name: check_path.sh
#Purpose: Check if a file or directory exists
#Level: Linux Essentials practice

ls check_path.sh 2>/dev/null
if [ "$?" = "0" ]
then 
	echo "Katalog istnieje"
	exit 0 
else
	echo "Brak katalogu"
	exit 1
fi
