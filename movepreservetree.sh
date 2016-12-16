#!/bin/bash
#future considerations for performance:
#one possible improved technique might be to move the original directory to the destination, then re-create the original, ie via something like:
#cp --attributes-only
#or rsync -ptgo -A -X -d --no-recursive --exclude=* first-dir/ second-dir
#or by a sequence of chmod/chown/touch/whatever with --reference="$sourcefile"
#but the actual usefulness of this approach is tbd

if [ "$#" -ne 2 ]; then
	echo "invalid number of arguments, expecting 2"
	echo "of the form movepreservetre.sh [from] [to]"
	exit 1
fi

if [ ! -d "$1" ]; then
	echo "$1 is not a valid directory"
	exit 2
fi

if [ ! -d "$2" ]; then
	echo "$2 does not exist, making it"
	mkdir -p "$2"
fi

if [[ ${2:0:1} = / ]]; then #$2 is an absolute path
	TODIR=$2
else #$2 is a relative path
	TODIR="$PWD/$2" #absolute path to our destination directory
fi

cd "$1"

#FLIST="$(find . -type f)"

echo -e "target dir is \e[38;5;204m$TODIR\e[0m"
echo "getting directory listing"

#get listing of all sub folders
SUBDIRS=$(find . -type d) #this includes empty folders, probably should fix that at some point, though note the -maxdepth 1 on the find in the below if statement

while read -r folder; do
	if [ "$(find "$folder" -type f -maxdepth 1)" ]; then
	#if [ "$(echo *(.))" ]; then #zsh only
		mkdir -p "$TODIR/$folder"
		echo -e "\e[38;5;204m$folder \e[38;5;34mhas files\e[0m, moving"
		find "$folder" -maxdepth 1 -type f -exec mv {} "$TODIR/$folder" \;
	else
		echo -e "\e[38;5;204m$folder \e[38;5;196mis empty\e[0m skipping"
	fi
done <<< "$SUBDIRS"