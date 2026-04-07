# Dirb - Directory Bruteforce Tool

## Co to jest
Dirb to narzędzie do brute force katalogów i plików na serwerze WWW

## Do czego służy 
- znajdowanie ukrytych katalogów 
- znajodwanie paneli admina
- rekonesans web aplikacji 

## Podstawowa składania 
dirb http://IP

## Dirb z wordlistą ( sporządzona lista przez nas nazw ktalogów do sprawdzenia na serwerze ) 
dirb http://IP /usr/share/wordlists/common.txt

## Status kodu 
200 - istnieje
403 - brak dostępu 
404 - nie istnieje 

## Jak wykryć atak w logach:
- Dużo requestów
- Dużo wpisów z statusem kodu 404
- jeden adres IP 
- różne URL w krótkim czasie 
