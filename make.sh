#!/bin/bash

# This script is making backup for every day of week (ex. in dir 1 for Monday)
# and for month (ex. dir 01 for January).
# In month backup the last day of month is saved (or current if current month).

#TODO: add folder with the lastest copy: LASTEST (or link to it)



main_dir="/backup/backup"
filename="/backup/files.txt"

echo "==========================================================="
echo $(date +'%Y-%m-%d %H:%M:%S')

new_backup_dir_month="$main_dir/"$(date +'%m')
echo "Backup will be in:  "$new_backup_dir_month
rm -d -r $new_backup_dir_month
mkdir -p $new_backup_dir_month

new_backup_dir_day_of_week="$main_dir/"$(date +'%w')
echo "Backup will be in:  "$new_backup_dir_day_of_week
rm -d -r $new_backup_dir_day_of_week
mkdir -p $new_backup_dir_day_of_week

while read -r line;
do
	if [[ -n $line ]]
	then
		echo "Copying:  $line"

		mkdir -p $new_backup_dir_month$line
		rsync -avq --delete $line $new_backup_dir_month$line
		#cp -R $line $new_backup_dir_month$line

		mkdir="mkdir -p $new_backup_dir_day_of_week$line"
		#echo $mkdir
		$mkdir
		rsync="rsync -avq --delete $line $new_backup_dir_day_of_week$line"
		#echo $rsync
		$rsync
		#mkdir -p $new_backup_dir_day_of_week$line
		#cp -R $line $new_backup_dir_day_of_week$line
		###cp -R $line $new_backup_dir$line
	fi
done < "$filename"

#make link to latest backup
rm $main_dir/latest

ln -s $new_backup_dir_day_of_week $main_dir/latest





echo "Done."






