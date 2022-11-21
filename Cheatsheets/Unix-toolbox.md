# Unix Toolbox 

Day to day most analysts use unix tools for a variety of purposes, to cut bread
for instance, or fry some delicious dinner, and make an espresso. Often times,
we have dedicated utensils and instruments for these tasks, which often do one
thing well. Have you ever walked past one of those 10-in-1 kitchen machines
which bake bread, boil rice, fry chicken, blend smoothies, and just thing why?
Unix tools are our trusty tools, they don't need to  

Contained here is a catalogue of day to day unix commands and references that I like to have
quick access to. I hope they help anybody who comes across this.    


Create a list of 'quick recipes' as per heng li's list https://lh3lh3.users.sourceforge.net/biounix.shtml


Basename recipe
1) Get the basename from a set of files using a loop
``   
FILES=(/some/path/to/files/*)
for f in ${FILES[@]} ; do
  basename ${f}   # we can output this into a file if we choose 
done 
``


2) Rename all files in a directory - nice as it incorporates use of a loop, a glob, and a wee bit more complex use of a variables

``
for x in *.xml; do 
  t=$(echo $x | sed 's/\.xml$/.txt/'); 
  mv $x $t && echo "moved $x -> $t"
done
```

3) Generate a random FASTA sequence - what this really means is up for debate.
If it mirrors any genomic sequences or not - anyways. 

``   
paste -d '\n' <(for i in {01..30}; do echo ">seq$i"; done) <( cat /dev/urandom
| tr -dc 'ATCG' | fold -w 300 | head -n 30 ) > output.fasta 
``  

4) Extract FASTA headers.    
``
grep "^>" input.fasta | sed -e "s/>//" > headers.txt
grep -oP "(?<=^>).*$" input.fasta > headers.txt  # Fancy regex called "positive
lookbehind"
``

5) Unwrap a FASTA file using a perl one-liner. 
`perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' in.fasta > out.fasta` 
Awk alternative.    
`awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END
{printf("\n");}' < file.fa`     



## Variables, filenames and symbolic links 

### Basename 
Straight from the gnu manual. Basename comes in very handy when looping through files from different directories, with various suffix extensions. 

Usage: `basename NAME [SUFFIX]`
Print NAME with any leading directory components removed.
If specified, also remove a trailing SUFFIX.

Examples:
  `basename /usr/bin/sort`          -> "sort" # most basic function
  `basename include/stdio.h .h`     -> "stdio" # specify the suffix to remove
  `basename -s .h include/stdio.h`  -> "stdio"  # -s option removes suffix
  `basename -a any/str1 any/str2`   -> "str1" followed by "str2" # -a option allows multiple argument

Worked example, print sample names to a txt file: 
input=/somedirectory/somewhere/ 
  `for f in ${samplesfolder}*; do basename -s .fastq ${} >> samplenames.txt ; done`    

### Symbolic Links (Symlinks) 

Create links which point to other files. "A symbolic link is a special type of
file whose contents are a string that is the pathname of another file, the file
to which the link refers. The contents of a symlink can be read using [readlink](https://man7.org/linux/man-pages/man2/readlink.2.html)." 

Usage: `ln -s <path to the file/folder to be linked> <the path of the link to be created>`

Examples: 
Create a symlink for a file - `ln -s /path/to/file.txt file.txt`   
A link to a folder - `ln -s /path/to/folder foldername`  
Remove a synlink - `unlink /path/to/symlink`    
Find broken links - `find /path/home -xtype l` and all `-delete` option to remove them.    


### Prefix-Suffix Removal

Pretty nicely demonstrated here
``
prefix="hell"
suffix="ld"
string="hello-world"
foo=${string#"$prefix"}
foo=${foo%"$suffix"}
echo "${foo}"
o-wor
``

Examples: 
Remove the suffix when outputting a file into a new format. Pay close attention
to the `%%.**` string, which essentially tells the program to %% remove
everything after and including the *.* character. If the input files were
formatted *something_fastq* then we would specify `%%_*` instead.   

`` for f in *.fastq ; do 
    minimap2 -options ${f} > ${f%%.*}.sam 
  done 
``   









## Resource used
https://learnmetabarcoding.github.io/LearnMetabarcoding/gettingstarted/cli_bioinformatics/cheatsheet.html`






