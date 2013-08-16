#!/bin/bash
## Simple bash script to convert fasta files to single line character strings.
## Sequences is this format are handy for performing simple statistical analyses in R.
## Usage: 	./fastq-to-strings.sh /path/to/fastqs /desired/output/path
## 	or 	./fastq-to-strings.sh path/of/my.fastq /desired/output/path

## Required arguments
input=$1
outputPath=$2

## Spaces in paths will make a mess, lets avoid that happening
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
function cleanup {
	IFS=$SAVEIFS
	rm /tmp/fastq-to-strings.tmp 2> /dev/null
}
trap cleanup EXIT

## Make the output path if it doesn't exist
mkdir -p $outputPath

## Check whether input is a fastq file or a path
if [[ $(echo $input | grep \\.fastq ) ]] ;
then
	type=single
else
	type=mult
fi

## Choose the single or for loop form
if [[ $type == single ]] ; 
then 
	## Single file
	name=$(basename -s ".fastq" $input)
	fastaOutput=$outputPath/$name.sequence.txt
	qualityOutput=$outputPath/$name.quality.txt
	cat $input | sed 's/^@.*$/fasta,/g' | sed 's/^+.*$/quality,/g' | tr -d "\\n" | sed 's/\([a-z]\+\)/\n\1/g' > /tmp/fastq-to-strings.tmp
	cat /tmp/fastq-to-strings.tmp | grep 'fasta,' | sed 's/fasta,//g' > $fastaOutput
	cat /tmp/fastq-to-strings.tmp | grep 'quality,' | sed 's/quality,//g' > $qualityOutput
	echo "converted $name"
else
	## All files in input path
	## First check input path has some fastq files
	if [[ $(find $input | grep \\.fastq\$) ]] ; 
	then 
		for i in $(find $input | grep \\.fastq\$) ; do
			name=$(basename -s ".fastq" $i)
        		fastaOutput=$outputPath/$name.sequence.txt
			qualityOutput=$outputPath/$name.quality.txt
        		cat $i | sed 's/^@.*$/fasta,/g' | sed 's/^+.*$/quality,/g' | tr -d "\\n" | sed 's/\([a-z]\+\)/\n\1/g' > /tmp/fastq-to-strings.tmp
			cat /tmp/fastq-to-strings.tmp | grep 'fasta,' | sed 's/fasta,//g' > $fastaOutput
        		cat /tmp/fastq-to-strings.tmp | grep 'quality,' | sed 's/quality,//g' > $qualityOutput
			echo "converted $name"
		done
	else
		## No fastq files, we'll send a message to the user and quit
		echo "No fastq files found in input"
		exit 1
	fi
fi

exit 0
