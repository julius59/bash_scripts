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



echo "[MyMozJPEG] ***** Copying & renaming *****"

# Calling other scripts
sh ./whitespace_to_underscore.sh $1 $2
sh ./convert_extensions_to_lowercase.sh $2

echo "[MyMozJPEG] ***** Optimizing jpeg *****"

# Processing all jpeg files in the output folder, overwritting them directly
if [ $verbose -eq 1 ] ; then
	find $2 -type f \( -iname "*.jpg" -or -iname "*.jpeg" -or -iname "*.jpe" \) -print \
		-execdir /opt/mozjpeg/bin/jpegtran -copy all -optimize -progressive -outfile {} {} \;
else
	find $2 -type f \( -iname "*.jpg" -or -iname "*.jpeg" -or -iname "*.jpe" \) \
		-execdir /opt/mozjpeg/bin/jpegtran -copy all -optimize -progressive -outfile {} {} \;
fi

echo "[MyMozJPEG] ***** Finished ! *****"

