backup-linux
============
Script to create a copy files in linux.

### install

Make dir `/backup` and copy there `make.sh`:
```console
mkdir /backup
cd /backup
git clone https://github.com/nonplated/backup_linux.git
```

### select files to backup

create file with paths (default `/backup/files.txt`):
```console
nano /backup/files.txt
```
input ABSOLUTE paths to dirs and filenames (be sure that slash is at the and of dir name):
```
/var/www/
/root/mail.txt
```
Save.

If you want to change some settings like main backup dir open:
```console
nano /backup/make.sh
```

### run manually

To create a current copy right now:
```console
bash /backup/make.sh
```

### run automatically (cron)

To run script daily at 1:01 am open `crontab -e` and add line:
```
1 1 * * * bash /backup/make.sh >> /backup/cron.log
```
In `/backup/cron.log` you will find all backup history.


### output in /backup/backup (default)

Backup directories made daily (day of week): 
`/backup/backup/1` for Monday,
`/backup/backup/2` for Tuesday
etc.

Backup directories made daily (month): 
`/backup/backup/01` for January
`/backup/backup/02` for February
etc.

After every backup is created link for lastest dir:
`/backup/backup/latest`


### important 

Existing backup dirs are overwriten by new.
Script dont delete old backup directories (only overwrites).
