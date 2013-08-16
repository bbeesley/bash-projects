#!/bin/bash
## Simple bash script to convert fasta files to single line character strings.
## Sequences is this format are handy for performing simple statistical analyses in R.
## Usage: 	./fasta-to-string.sh /path/to/fastas /desired/output/path
## 	or 	./fasta-to-string.sh path/of/my.fasta /desired/output/path

## Required arguments
input=$1
outputPath=$2

## Spaces in paths will make a mess, lets avoid that happening
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
function restoreifs {
	IFS=$SAVEIFS
}
trap restoreifs EXIT

## Make the output path if it doesn't exist
mkdir -p $outputPath

## Check whether input is a fasta file or a path
if [[ $(echo $input | grep \\.fasta ) ]] ; 
then
	type=single
else
	type=mult
fi

## Choose the single or for loop form
if [[ $type == single ]] ; 
then 
	## Single file
	name=$(basename -s ".fasta" $input)
	output=$outputPath/$name.txt
	cat $input | sed 's/^>.*/break/g' | tr -d "\\n" | sed 's/break/\n/g' > $output
	echo "converted $name"
else
	## All files in input path
	## First check input path has some fasta files
	if [[ $(find $input | grep \\.fasta\$) ]] ; 
	then 
		for i in $(find $input | grep \\.fasta\$) ; do
			name=$(basename -s ".fasta" $i)
        		output=$outputPath/$name.txt
        		cat $i | sed 's/^>.*/break/g' | tr -d "\\n" | sed 's/break/\n/g' > $output
			echo "converted $name"
		done
	else
		## No fasta files, we'll send a message to the user and quit
		echo "No fasta files found in input"
		exit 1
	fi
fi

restoreifs
exit 0
