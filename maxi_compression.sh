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


if [ $verbose -eq 1 ]; then
	7za a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on "`dirname $1`/`basename $1`.7z" $1
fi


