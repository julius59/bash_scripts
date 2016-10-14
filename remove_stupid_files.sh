#!/bin/bash

#verbose ?
verbose=1

usage="Usage: `basename "$0"` INPUT_FOLDER"
# Check the arguments passed to the script
if [ $# -ne 1 ]; then
	echo "Wrong nb of args!"
	echo $usage
	exit 1
fi

echo "Removing Thumbs.db, .DS_Store etc..."
# Removing whitespaces from files & folders name
if [ $verbose -eq 1 ]; then
	find $1 -type f \( -name "Thumbs.db" -or -name "desktop.ini" -or -name ".picasa.ini" \
	-or -name ".DS_Store" -or -name "._DS_Store" -or -name "._.DS_Store" \) \
	-print -delete
	find $1 -type d -name ".dthumb" -print -delete
else
	find $1 -type f \( -name "Thumbs.db" -or -name "desktop.ini" -or -name ".picasa.ini" \
	-or -name ".DS_Store" -or -name "._DS_Store" -or -name "._.DS_Store" \) \
	-delete
	find $1 -type d -name ".dthumb" -delete
fi

