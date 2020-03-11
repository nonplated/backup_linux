backup-linux
===
Script to create a copy files in linux.


install
===
Make dir "/backup" and copy there "make.sh":
"""bash
mkdir /backup
cd /backup
git clone https://github.com/nonplated/backup-linux.git
"""

select files to backup
===
create file with paths (default /backup/files.txt):
"""
nano /backup/files.txt
"""
input for example and save:  
"""
/usr/var/www
"""

If you want to change dir and filename open:
"""
nano /backup/make.sh
"""


cron
===
To run script daily at 1:01 am:
"""
crontab -e
"""
add line: 
"""
1 1 * * * * bash /backup/make.sh
"""


output in /backup/backup
===
Backup directories made daily (day of week): 1 2 3 4 5 6 7

Backup directories made daily (month): 01 02 03 04 05 06 07 08 09 10 11 12

Existing backup dirs are overwriten by new.
Script dont delete old backup directories (only overwrites).
