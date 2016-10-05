#!/bin/bash

#verbose ?
verbose=1

usage="Usage: `basename "$0"` INPUT_FOLDER OUTPUT_FOLDER"
# Check the arguments passed to the script
if [ $# -ne 2 ] ; then
	echo "Wrong nb of args!"
	echo $usage
	exit 1

else 
	if [ $1 = $2 ] ; then
		echo "Input & Output folders must be different. Too dangerous otherwise!"
		echo $usage
		exit 1
	fi
fi

# (unused) Copy folder structure, while removing whitespaces
#find $1 -type d | sed "s|$1|| ; s| |_|g" | xargs -I {} mkdir -p "$2"/{}

# Copy source content, conserving attributes
cp -aR $1/. $2

# Removing whitespaces from files & folders name
if [ $verbose -eq 1 ] ; then
	find $2 -depth -mindepth 1 -print -execdir rename 's| |_|g' '{}' \;
else
	find $2 -depth -mindepth 1 -execdir rename 's| |_|g' '{}' \;
fi

