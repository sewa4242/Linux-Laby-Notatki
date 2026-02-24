### Serwer Ubuntu otrzymał nowy dysk 5GB,  celem jest:
#1 Przygotować go do użyca w LVM 
#2 Utworzyć przestrzeń dla katalogu /mnt/dane 
#3 Później rozszerzyć ja gdy zabraknie miejsca 

### Wykrycie nowego dysku ###
	Do wykrycia nowego dysku przyjdzie nam z pomocą komenda lsblk z jej wyniku możemy odczytać:
1. sda ---- dysk zawierający system 
2. sdb ---- nasz nowo dodany dysk o pojemności 5GB 
	Dyski zawszę są oznaczone literamii za to przy partycjii zawsze widnieje cyfra 
### Uwtorzenie partycji na dysku ###
	Partycję utworzyłem przy użyciu komendy sudo ` fdisk /dev/sdb `
	Później zferyfikowałem jego istnienie jak i rozmiar za pomocą lsblk. Rezultat: wyszstko jest poprawne, partycja o pojemności 5GB została utworzona
### Utworzenie fizycznego woluminu ###
	Fizyczny wolumin -- to pewna wielkość wolnych zasobów danych z dysku/partycji z której będziemy tworzyć grupę wolumenów 
	Fizyczny wolumin powstał za pomocą ` sudo pvcreate /dev/sdb1 ` 
	Sprawdzenie czy fizyczny wolumin powstał sudo pvdisplay 
	
### Tworzenie grupy wolumenów ### 
	Tworzenie grupy wolumenów odbyło się za pomocą ` sudo vgcreate vg_storage /dev/sdb1 `
	Komenda weryfikująca utworzenie grupy to ` sudo vgdisplay ` poinformuję ona nas także o tym jaka jest jej łączna wielkość oraz ile faktycznego wolnego miejsca na niej się znajduję w naszym przypadku to:
	1. Łączna wielkość 4.65 GiB
	2. Wolne miejsce 4.65 GiB
### Tworzenie logicznego woluminu ###
	Tworzenie logicznego woluminu ` sudo lvcreate --name lv_storage --size +3GiB vg_storage ` 
	Weryfikacja logicznego woluminu ` sudo lvdisplay ` 
	
### Przydzielnie systemów pliku ###
	Przydzielnie systemów pliku ` sudo mkfs.ext4 /dev/vg_storage/lv_storage `
	Zdecydowałem się system plików ext4 ponieważ:
	1. jest domyślny w Ubuntu
	2. jest stabilny
	3. idealny do środowiska ogólnego przeznaczenia
	4. System plików ext4 wspiera dynamiczne rozszerzanie (resize), co jest istotne przy pracy z LVM.
	Weryfikacja ` lsblk -f `
### Mount logicznego woluminu ###
	` sudo mount /dev/vg_storage/lv_storage /mnt/dane ` 
	Weryfikacja ` lsblk ` 

### Rozszerzenie LVM ### 
	` sudo lvextend --size +1GiB --resizefs /dev/vg_storage/lv_storage `
	Weryfikacja ` lsblk ` / ` df -h `

### Persistencja montowania ###
	Odczyt uid ` sudo blkid /dev/vg_storage/lv_storage ` 
	Edycja fstab za pomocą edytora tekstu nano 
### Wyciągnięte wnioskii ###
	ext4 rezerwuje miejsce
	testowanie fstab przed rebootem 


	Disk → Partition → PV → VG → LV → Filesystem → Mount
