#!/bin/bash

#verbose ?
verbose=1

usage="Usage: `basename "$0"` INPUT_FOLDER OUTPUT_FOLDER"
# Check the arguments passed to the script
if [ $# -ne 2 ]; then
	echo "Wrong nb of args!"
	echo $usage
	exit 1
else 
	if [ $1 = $2 ]; then
		echo "Input & Output folders must be different. Too dangerous otherwise!"
		echo $usage
		exit 1
	fi
fi

# Create the destination folder if not existing
if [ ! -d "$2" ]; then
  	mkdir "$2"
# else make sure the destination is empty, we don't want to overwrite a processing
else
	if [ "$(ls -A "$2")" ]; then
		echo "Output folder must be empty!"
		echo $usage
		exit 1
	fi
fi



echo "[MyMozJPEG] ***** Copying, renaming & cleaning up *****"

# Calling other scripts
sh ./whitespace_to_underscore.sh $1 $2
sh ./convert_extensions_to_lowercase.sh $2
sh ./remove_stupid_files.sh $2


echo "[MyMozJPEG] ***** Optimizing jpeg *****"

# Processing all jpeg files in the output folder, overwritting them directly
if [ $verbose -eq 1 ]; then
	find $2 -type f \( -iname "*.jpg" -or -iname "*.jpeg" -or -iname "*.jpe" \) -print \
		-execdir /opt/mozjpeg/bin/jpegtran -copy all -optimize -progressive -outfile {} {} \;
else
	find $2 -type f \( -iname "*.jpg" -or -iname "*.jpeg" -or -iname "*.jpe" \) \
		-execdir /opt/mozjpeg/bin/jpegtran -copy all -optimize -progressive -outfile {} {} \;
fi


echo "[MyMozJPEG] ***** Creating 7z archives of subfolders *****"

# Optional, depends on the folder structure
#find $2 -mindepth 1 -maxdepth 1 -type d -exec ./maxi_compression.sh {} \;


echo "[MyMozJPEG] ***** Finished ! *****"
# A fun an portable way to get a sound feedback
spd-say "c'est fini"


