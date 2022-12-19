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

4) Extract FASTA headers    
``
grep "^>" input.fasta | sed -e "s/>//" > headers.txt
grep -oP "(?<=^>).*$" input.fasta > headers.txt  # This method uses the fancy
RegEX terminology called "look ahead".  
``

5) Find files in a directory 
`find ${dir} -name "*.fastq"`     

6) Find the file as above but not send them to be gzipped (or any other suitable command). 
`find ${dir} -name "*.fastq" -exec gzip {} \;`      

7) Search through all files and grep a string
`for f in *.txt ; do echo --${f}-- ; grep "APO32" ${f} ; done`      

8) Sed one liners https://edoras.sdsu.edu/doc/sed-oneliners.html   

9) Copy files securly using *scp* or *rsync*
``
scp samplefiles.txt username@serverdetails:/directory  
rsync samplefiles.txt username@serverdetails:/directory   
``      



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

`` 
for f in *.fastq ; do 
    minimap2 -options ${f} > ${f%%.*}.sam 
done 
``   

Let's loop over a list of files and remove both the basename prefix and the
suffix file extension.
`for f in Samples/*.txt ; do FILENAME=`basename ${f%%.*}`; echo ${FILENAME}; done`

This example combines multiple simple unix commands and procedures - the for
loop, glob matching, variable assignment, and finally the basename and suffix
removal. 

### Variable Assignment 

#### Complex Usage 

Often times variable assignment is used for shortening file paths and making
scripts more manageable, and visually appealing. To me revelation also,
variable assignment can be more intricate than just this, and can embed entire
commands which are called during a script. Below we'll see an example of a
variable, which when called, finds fastq files within a given directory and
composes them into a list.   

``
BASE="DIRECT-RNA"
FASTQS=$( find ./Raw/${BASE} -type f -name "*fastq.gz" -exec ls {} + )
``   
This variable can then also be called by another complex variable
assignment, and so on until your imagination cannot keep up with the string of
logic.   

Let's extend this further to demonstrate how the first complex variable can be called within another one.   

Here we will trim the .fastq suffix from the files and create a list of sample names. 
`SAMPVEC=$( ls $FASTQS | sed 's/.fastq.gz//g' | sort | uniq )` 

Another example along very similar lines as those above --- we will call sample
names using a combination of ls and grep chains/pipes. This is very handy when
running multiple files through the pipelines.     

``  
    R1=$( ls $FASTQS| grep ${SAMP} | grep "R1" )
    R2=$(  ls $FASTQS  | grep ${SAMP} | grep "R2" )
    echo "READ1####"
    ls -lh $R1
    echo "READ2####"
    ls -lh $R2
``   

## Looping
### For Loops

Perform operations on files from file list. The trick here is to encapsulate a *cat* command and insert it right after the *in* section of the for loop.  
`for f in cat filelist.txt; do minimap2 -in ${f} -out ${f%%.*}.sam ; done`  

Exclude samples that are already processed. Process input files *.fastq only if
result-files Result/*.txt does not exist. Be sure to close the *if* conditional with a *fi*.     
``
for f in Data/*.fastq; do 
  SAMPLE=`basename ${f%%.*}`;    # refactor sample names to remove basename 
  if [ ! -f Results/${SAMPLE}.txt ]; then # using the "if" conditional here  
    echo "processing sample ${SAMPLE}"; 
    # do something 
  fi; 
done
``      

Do something 10 times - can be useful for generating random numbers, testing scripts and so on. 
``
for n in {1..10}; do \
   echo ${n}; \
done
``

Use a **while** loop to iterate through a set of files.     
``
ls *.txt | while read f; do echo ${f}; done;
``


## Arrays

Most of us who have taken an introductory course in any programming language likely know what a basic array is, and how it differs from other types of data structures, such as tuples and so on. Bash too

Let's declare an array: `array = (a b c)` pay attention to the curled brackets in bash - many other programs used closed brackets for arrays.     

Some examples:
Put specific files into an array:
`files = ("/file/path/genes.csv" "/file/path/diffexpgenes.csv" "/file/path/groundgenes.csv")` 

Arrays get really great when we want to loop through values contained within them. We have to tell bash to evoke the values within the array using the *array[@]* symbology.   
``
for f in "${files[@]}" ; do   
    deseq $A $B ${f}     
done   
``

Another basic example demonstrating the logic of arrays. 
``
arr=("CP25" "FTX" "TSIX")
 
for index in "${!arr[@]}";
do
    echo "$index -> ${arr[$index]}"
done
``
This will print.... "1 -> CP25, 2 -> FTX......"     

## Wrangling 

### Reverse lines of a file 
I stumbled upon the usage of reverse on a looping tutorial, and it was the
first time seeing what appears to be a pretty niche usage of the tool. The
user was using rev to cut *n* ends off of a file name in a few simple steps,
the helpers being *cut -c n* and the faithful `sed`.


The .fastq files in the directory will be called, passed to sed which will
remove the end sequences, afterwhich the filename will be reversed, cut by 25
characters, and revered back to its original position, and pruned one last time
with sed. Quite clever! 
``
NCUT=25
ls *.fastqs | sed 's!.*/!!' | rev | cut -c ${NCUT}- | rev  | sed 's!.*/!!' 
``

### Handy piping with xargs

`cat sraname.txt | xargs -I{} fastqc -i {} -o report-format.csv`       



if [ ! -f  $INBAM ]; # if bam does not ! exist 



## Scheduling

### Crontab 

The remarkable and lovely cron jobs - when I first came across cron, for
strange reasons, I was confused and nervous, and I had a hard to understanding
why and how cron could fit into my workflows and daily operations. That was
until I began using more customised scripts and running my own server
instances, which required renewing certificates every few months, scanning
folders and running updates. Now, I see cron as ultra-powerful. Unfortunately,
my HPC cluster does not permit it's use by regular users, so much of this is
restricted to personal computing.  

First things first, we have to edit the crontab file.
`crontab -e` 

Add an entry to crontab which runs a spcific script ever 3 minutes -- the best
way to understand the cron positional syntax is to just find a handy online
guide, as [such](https://www.guru99.com/crontab-in-linux-with-examples.html).    
`*/3 * * * * /move.sh`     

Another entry to execute a script in speicific months. 
`* * * feb,jun,sep *  /script.sh`    

And let's say another entry yearly. 
`@yearly /scripts/script.sh`     


## File Transfers 

### RSync 

My personal favorite transfer client - secure, quick, has options to ensure transfers are completed with fidelity across poor transfer channels, provides progress bars, and so on. 

Transfer files between source and target, and include a progress bar. 
`rsync -av -P /data/uniref90.fasta user@server.edu.au:/input`   


Transfer some files between destinations and remove the source files after transfer.   
`rsync --remove-source-files -options /path/to/source/* /dest/path`     

Output a list of files in the source directory which do not exist in the target/destination directory.
`rsync -avun --delete $TARGET $SOURCE  |grep "^deleting "`     

A very rudimental sort of sync client can be instantiated with rsync and a scheduling script such as cron. 
`rsync -avh --update -e --ignore-existing user@server:/path/source /path/target`     

Transfer all files from a source directory but exclude those with specific file names. 
`rsync -amvz --progress rsync://hgdownload.cse.ucsc.edu/goldenPath/mm10/multiz60way/maf/chr*.maf.gz --exclude='*Un*' --exclude='*random*' ./`    







## Resources 

https://learnmetabarcoding.github.io/LearnMetabarcoding/gettingstarted/cli_bioinformatics/cheatsheet.html
https://www.metagenomics.wiki/tools/ubuntu-linux/shell-loop
https://lh3lh3.users.sourceforge.net/biounix.shtml
https://bioinformaticsbreakdown.com/bash-loop-rna-seq/







