  GNU nano 7.2                                             /home/u1/Dokumenntacja/LinuxCyberSec/poszukiwanie_pliku.md *                                                     ### 🔥 FIND + EXEC + GREP + PIPE → zapis do pliku z sudo
### 🔥 FIND + EXEC + GREP + PIPE → zapis do pliku z sudo
System: Ubuntu 20.04 (VM)
Cel: Analiza logów pod kątem ERROR/FAILED





u1@ubunt:~$ tree
.
├── {}
├── Incident_LAB
│   ├── Analiza
│   │   └── raport.txt
│   ├── Backup
│   └── Logi
│       └── auth.log
└── symlink
    ├── Lab_Hardlink
    ├── Lab_symlink -> Incident_LAB/Analiza/raport.txt
    └── test.txt

6 directories, 6 files
u1@ubunt:~$ sudo find Incident_LAB/Logi -type f -iname "*.log" -exec grep -iE "ERROR|FAILED" {} + | sudo tee Incident_LAB/Analiza/bledy.txt > /dev/null
u1@ubunt:~$ tree
.
├── {}
├── Incident_LAB
│   ├── Analiza
│   │   ├── bledy.txt
│   │   └── raport.txt
│   ├── Backup
│   └── Logi
│       └── auth.log
└── symlink
    ├── Lab_Hardlink
    ├── Lab_symlink -> Incident_LAB/Analiza/raport.txt
    └── test.txt

6 directories, 7 files
u1@ubunt:~$ cat Incident_LAB/Analiza/bledy.txt

          |Pokazuje co zapisało|


#### Wyjaśnienie:
| Element | Znaczenie |
|--------|-----------|
| `-exec {} \;`  | uruchamia grep dla każdego pliku osobno |
| `-exec {} +`   | **zbiera pliki naraz** → można podpiąć pipe |
| `|`            | przekazuje wynik do kolejnej komendy |
| `sudo tee`     | **zapis do pliku jako root** |
| `> /dev/null`  | ukrywa output na ekran |

Zapamiętać:
- `>` przekierowuje przez shell użytkownika (może dać `Permission denied`)
- `tee` zapisuje do pliku jako root (działa w pipe)
- `-exec {} +` lepsze do użycia z pipe niż `-exec {} \;` 

### Analiza zdarzeń z bieżącej daty
Filtr:
    grep "$(date +%b\ %e)" bledy.txt
    
    u1@ubunt:~$ sudo zgrep -a -E "^$(date +%Y-%m-%d)T" /var/log/auth.log         poprawniejszy format dla daty w pliku auth.log 



Wynik:
    Brak wpisów z dzisiejszą datą. 
    Brak oznak nieudanych logowań, błędów autoryzacji ani incydentów bezpieczeństwa.

Wniosek:
    System nie wykazuje oznak aktywnej ingerencji lub naruszeń w ostatnich 24h.

Polecenie jest poprawne jeśli nic nie wypluwa po prostu nic nie znalazł 


- exec {} \;   = osobne wywołania → trudniej pipe, wolniej
- exec {} +    = grupowanie → łatwo pipe → tee → zapis do pliku
- >            = robi shell usera → może dać Permission denied
- tee          = zapis przez root → idealne w pipe
- date +%b\ %e = format syslogowej daty (super ważne!)
