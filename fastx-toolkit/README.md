fastx-toolkit
=============

A pack of simple bash scripts to aid in reading, manipulating, and performing statistical analysis on fasta and fastq files.  

fasta-to-string.sh  
------------------  
A function that reads a single fasta file, or a number of fasta files from a directory, and converts them to text files of plain strings, each on a single line. This may be useful for reading the data into software such as R for further analysis. Meta data for the reads is stripped and discarded; this makes the file much easier to read into, and work with, in a statistical package, but obviously means that individual sequences no longer have names.  
Usage:  
For a single file, use  
`./fasta-to-string.sh path/to/my.fasta /desired/output/path`  
For a directory containing multiple fasta files, use  
`./fasta-to-string.sh /path/to/fastas /desired/output/path`  
Output:  
A text file for each fasta file, with the file extension changed to .txt from .fasta, containing only the sequences, in single line strings.  
  
fastq-to-strings.sh  
-------------------  
A function which reads a single fastq file, or a number of fastq files from a directory, and converts them to a pair of text files containing plain strings, each on a single line. Meta data for the reads is stripped and discarded; this makes the file much easier to read into, and work with, in a statistical software package, but obviously means that individual sequences no longer have names. The order of the sequences and quality data is, however, retained, so that the first sequence in the sequence text file matches the first sequence in the quality text file.  
Usage:  
For a single file, use  
`./fastq-to-strings.sh path/to/my.fastq /desired/output/path`  
For a directory containing multiple fasta files, use  
`./fastq-to-strings.sh /path/to/fastqs /desired/output/path`  
Output:  
A pair of text files for each fastq file, with the file extension changed to .sequence.txt and .quality.txt from .fastq, the sequences file containing only the sequences, in single line strings, and the quality file containing only the quality data, in single line strings.  
