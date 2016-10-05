#!/bin/bash

#verbose ?
verbose=0

usage="Usage: `basename "$0"` INPUT_FOLDER"
# Check the arguments passed to the script
if [ $# -ne 1 ]; then
	echo "Wrong nb of args!"
	echo $usage
	exit 1
fi


# Put all file extensions to lower case
if [ $verbose -eq 1 ]; then
	find $1 -depth -mindepth 1 -print -type f -execdir rename 's/\.([^.]+)$/.\L$1/' '{}' \;
else
	find $1 -depth -mindepth 1 -type f -execdir rename 's/\.([^.]+)$/.\L$1/' '{}' \;
fi
