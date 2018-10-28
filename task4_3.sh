#!/usr/bin/env bash

bak_folder="/tmp/backups"
if [ ! -d "$bak_folder" ]
then
mkdir /tmp/backups
fi

#check if args num=2
if 
	[ $# -ne 2 ] 
then
	>&2 echo -e "$0: Invalid arguments entry\n Usage: task4_3.sh [BACKUP DIR PATH] [NUM BACKUPS]" 
	exit 1

#check if $1 is a dir
elif [ ! -d  $1 ]
then
	>&2 echo -e "Invalid backup dir path: $1 "
	exit 1

fi

#check if absolute path
case $1 in
  /*)
 ;;
  *) >&2 echo -e "Invalid backup dir path: $1\nPlease use an absolute path" 
  exit 1 
 ;;	
esac

#check if number is correct max=5
case $2 in
	1|2|3|4|5 )
;;
		*)
>&2 echo -e "Invalid backups number: $2\nPlease use a number from 1 to 5" 
exit 1
;;
esac

####

#name of the folder to backup
bak_file_name="$1"

#replace slash with hyphen
bak_file_name=${bak_file_name//\//\-} 
bak_file_name=$(echo "$bak_file_name" | cut -c 2-) 
#check if ends with slash and remove it
if 
	[ ${bak_file_name: -1} == "-" ]
then
bak_file_name=$(echo "$bak_file_name" | rev | cut -c 2- | rev)
fi


#count backups in folder /tmp/backups
if [ ! -f "("$bak_folder"/"$bak_file_name"*)" ]
then
bak_count=0
else 
bak_count="$(ls -l "$bak_folder"/"$bak_file_name"*| wc -l)"
#remove n oldest files
rm $(ls -t "$bak_folder"/"$bak_file_name"* | tail -"$bak_number")
fi

bak_number="$2"

#create archieves
for i in $(seq 1 $bak_number); do
	#create .tar.gz archive
        tar -P -czf "$bak_folder"/"$bak_file_name""$i".tar.gz "$1"
done
