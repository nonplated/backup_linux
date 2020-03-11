#!/bin/bash

###################### DESCRIPTION  ##########################

# This script is making backup for every day of week (ex. in dir 1 for Monday)
# and for month (ex. dir 01 for January).
# In month backup the last day of month is saved (or current if current month).

# Only overwriting is possible. Script cant delete old copies.


######################  SETTINGS  ############################

#dir to create folders with copies (use /backup/backup for clarity in /backup)
main_dir="/backup/backup"

#file with directories and files to copy (absolute path needed, every path in new line)
file_with_list="/backup/files.txt"

#backup for every month (relative subdir name)
subdir_month=$(date +'%m')	# example: 01

#backup for every day of week (relative subdir name)
subdir_day_of_week=$(date +'%w') #example: 1


#####################  FUNCTIONS ###############################

make_copy() {
	filename=$1
	main_dir=$2
	backup_destination="$main_dir/$3"

	echo "Backup will be in:  "$backup_destination
	rm -d -r $backup_destination
	mkdir -p $backup_destination

	while read -r line;
	do
		if [[ -n $line ]]
		then
			echo "Copying:  $line"

			mkdir -p $backup_destination$line
			rsync -avq --delete $line $backup_destination$line
		fi
	done < "$filename"
}

make_link() {
	main_dir=$1
	backup_destination=$2
	name_of_link=$3

	#remove old link
	rm "$main_dir/$name_of_link"
	#create new link to latest copy
	ln -s $backup_destination "$main_dir/$name_of_link"
}

#################################################################
##########################    MAIN   ############################

echo "=========================================================="
echo "Started: "$(date +'%Y-%m-%d %H:%M:%S')

make_copy $file_with_list $main_dir $subdir_month
make_copy $file_with_list $main_dir $subdir_day_of_week

make_link $main_dir $subdir_day_of_week "latest"

echo "Done."

##########################    END   #############################
#################################################################




