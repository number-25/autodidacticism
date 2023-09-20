# Notes on learning the Nextflow workflow manager 

## The Basics

The nextflow workflow manager is designed to be a self contained - fully
enclosed workspace environment which has every necessary component present for
each step of a given analysis. As such, it can occupy large amounts of disk
space (relative to stand-alone programs) as the motivating concept behind its
use is that of 'plug and play' - anywhere.    

## The Nextflow skeleton 
Nextflow orients around three major concepts --- 1) Processes, 2) Channels and
3) Workflows. Together these constitute the contents of what one will typically
find within .nf files and pipeline directories.   

The first process created will take input data from a channel and output data
into another channel - simple no? The key here is that each process must be
tied to all other processes - "The only way data can be passed between process
tasks is via asynchronous queues, called *channels*." The processes define the
input-output of for a task/event, and channels are then used to guide the flow
of data between processes.    

### Scripting Hints and Tips

#### General
* Similar to what happens in bash, embedding a command within {} brackets will
allow one to use said command e.g. { ls -1 }. This is called "closure" in
Groovy".    
* "By default, closures take a single parameter called it. To define a
  different name use the `variable -> syntax."`   

#### Parameters   
* Parameters can be assigned throughout the script using the params.[something]
dot syntax, whereby something is the parameter name. This is in contrast to
declaring the parameter with --parameter, which requires the user to provide
input when launching the script. 
``   
  params.threads = 4
  script:
    """
    minimap2 -t ${params.threads} 
    """
``    
* If there are many parameters, we can create a separate "params" file which
are JSON or YAML format. The parameters file is then passed to the script using
the `-params-file` option.     
``
{
  "sleep": 5,
  "input": "data/yeast/reads/etoh60_1*.fq.gz"
}
``  

### Channels 
As the name would imply, the channel is a conduit or body for data to flow
through - it allows data to be integrated between processes, storing it for
input/output operations. "Nextflow distinguishes between two different kinds of
channels: **queue** channels and **value** channels."    

* A queue channel is typically the output of a process.   
* A value channel can be thought of as a constant - it is bound to a specific,
single value, which it carries throughout the entirety of the workflow and
can be reused multiple times.  
* For example, a genome reference file which will need to be used and reused
multiple times throughout the workflow, is a good candidate for a value
channel, as it won't "disappear".    
* A value channel can be assigned to a list, which itself contains several
values. The value channel itself cannot be assigned multiple values
however.    

#### Channel Factories 
##### Value Channels
* The value factory is used to create a value channel. Below are three
different types of value channels - a single value, a list, and a 'map'
(dictionary in Julia).    
``
  ch1 = Channel.value('mm10')   
  ch2 = Channel.value('chr1', 'chr2')   
  ch3 = Channel.value( ['chr1' : 248956422, 'chr2' : 242193529, 'chr3' : 198295559] )
``     

##### Queue Channels 
* There are various methods for creating queue channels.
``
  Channel.of
  Channel.fromList
  Channel.fromPath
  Channel.fromFilePairs
  Channel.fromSRA
``    
* The **Channel.of** method can create a list of values. The … operator will create
a range of values, similar to 1:22 in Julia and other languages. 
``   
  chromosome_ch = Channel.of( 'chr1', 'chr3', 'chr5', 'chr7' )   
  chromosome_ch.view()   

  chromosome_ch = Channel.of(1..22, 'X', 'Y')
``    
* To create a **fromList** channel, which may store the strings of certain
software, or values that need to be sequentially/iteratively input, we use the
following.    
``
  software_list = ['kallisto', 'sailfish', 'salmon']     
  aligner_ch = Channel.fromList(software_list)   
  aligner_ch.view() # let's view the channel contents!   
``    
* So what's the difference between the first type methods of channel factory?
They are both inputting lists no? Well, the first channel.of treats the list as
a single element, one whole set, whereas the channel.fromList treats each
element within the set as it's own, meaning it can be subset n^n times. 
* The **Channel.fromPath** method can be fairly easily guessed by its name - it
will create a channel from the contents of a provided path - this can often be
a single file.   
``
  read_ch = Channel.fromPath('/data/reads/sample*.fastq')
  read_ch.view()
``    
* You can also use glob syntax to specify pattern-matching behaviour for files.
A glob pattern is specified as a string and is matched against directory or
file names.   
  - An asterisk, '*', matches any number of characters (including none).   
  - Two asterisks, '**', works like * but will also search sub directories. This
syntax is generally used for matching complete paths.   
  - Braces {} specify a collection of subpatterns. For example: {bam,bai} matches
“bam” or “bai”.     

* Let's say we have some read pairs, such as read_1 and read_2 from illumina
  mate sequencing, how would be manage these? As nextflow is designed with
  bioinformaticians in mind, there is a specific Channel to manipulate these
  types of files - the **fromFilePairs** channel factory.    
* If we have a directory containing 9 sets of read-pairs, that is, 18 .fq files,
we can use glob operators along with the specific channel method -
`/reads/pairs/*_{1,2}.fastq`.     
* This will create a specific queue channel from each pair.    
``    
  read_pairs_ch = fromFilePairs('reads/pairs/*_{1,2}.fastq')    
  read_pairs_ch.view()   
``
* If we have sample sets which come in sizes of let's say, 4, we need to
specify this explicitly by adding more values to the glob pattern. To complicate
things further, if we have several files with similar prefixes e.g. ref_1_coli,
ref_1_sub, than we can also specify this, and how many sets of such files there
are. E.g. 10 sets of quad-paired reads, each set starts with the same prefix,
but has a different suffix.   
``    
  reads_quad_ch = fromFilePairs('reads/quads/ref_{1,2,3,4}*, size:10)    
  reads_quad_ch.view()   
``
* For more complex patterns it is best practice to create a sample sheet which
specifies the files and then create a channel from that.    

* One of the most impressive channel factory methods is the **fromSRA**
  factory, which, as one can imagine, would make large scale analyses and
  replication experiments a lot smoother than they would otherwise be.
* This factory creates a queue channel from the fastq files corresponding to the SRA ID. 
* You will need an NCBI API key for this.     
``
  sra_ch = Channel.fromSRA('SR3434A')
  sra_ch.view()
``    
* If we create a list object, we can pass through multiple SRA ids (probably
even have the ability to pass a file containing the IDs!)    
`` 
  ids = ['SRR334', "ENA34334', 'SRR4343']    
  sra_ch = Channel.fromSRA(ids)    
  sra_ch.view()    
``    

### Processes 
The bread and butter of Nextflow is the 'process' primitive. These processes are
discrete blocks which encapsulate specific commands, and can thus be thought of
as nodes in the analysis network. For instance, the first process can be quality
control - within this block the entire command for the qc is contained,
including output. The next process is then opened and the subsequent portion of
the analysis undertaken.     

* Processes are about execution - channels are about data flow!    
* Processes are independent, modular units which are not dependent on other
processes (of course, if they require input from a channel that is waiting for
output from another process, there there is an order and time asymmetry to it).
But they are parallel, independent processes, which when tied to channels can
do great things.   
* Once we've created a process we have to list it in our workflow block.   
`` 
  //process_index.nf
  nextflow.enable.dsl=2

  process INDEX {
    script:
    "salmon index -t
    ${projectDir}/data/yeast/transcriptome/Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa.gz
    -i data/yeast/salmon_index --kmerLen 31" }

  workflow {
    //process is called like a function in the workflow block
    INDEX()   
  }      
``     
* The basic skeleton of a process is outlined below. The bare minimum that this
block requires is a script command
``
  process < NAME > {
    [ directives ]        
    input:                
    < process inputs >
    output:               
    < process outputs >
    when:                 
    < condition >
  [script|shell|exec]:  
  < user script to be executed >
}
``

* The script in processes can span multiple lines, contain numerous commands
e.g. samtools sort, then index, then view etc.    
* "By default the process command is interpreted as a Bash script. However any
other scripting language can be used just simply starting the script with the
corresponding Shebang declaration. For example:" 
``
  process PYSTUFF {
    script:
    """
    #!/usr/bin/env julia
    using DataFrames, Plots, GadFly

    frame1 = DataFrames(vector{*.fastq},_
  """
``     
* It is terrific to do this for small jobs, but for larger pieces of code, it is recommended to save the script within it's own file and invoke it directly as such;
``
  process JULIO {
    script:
    """
    myscript.jl
    """
}
workflow {
  PYSTUFF()
}
``    
* Weaving together channels with processes can come in very handy when we are
seeking to run the same process but with different parameters for the program,
which we would provide as a list in the channel declaration. This will iterate
the scan but with different parameters every time.    
``
  ch1 = Channel.fromPath('data/proteins/*.fa')
  modes_list = ['sensitive', 'fast', 'divergent']

  process markov {
    
    input:
    path protein_seq from ch1
    each mode from modes_list
``

#### Scripts 
The script module is the final element of a process. There can only ever be one
script block.   

By default, the script block is executed with bash options `set -ue`, and the
user can add additional options in the first line declaration e.g. `shell
'/bin/bash', '-euox', 'pipefail' """insert commands here"""`. It is essential
to keep in mind that as it is in bash, commands/string delimited by double
quotes "" support $variable substitution/interpolation, whereas those delimited by
single '' quotes do not!    

When using string interpolation/substitution, make sure you don't get the
nextflow variables conflated with the bash system variables, you have to know
when you're using each and how to ease each, particularly if the two
intersect/shared.     

A beautiful aspect of workflows is the ability to run a program with different
parameters and inputs depending on user options and the conditions. For
instance, if we created a process called minimap2, and knowing that minimap2
can map gDNA, cDNA, dRNA and so on, we can create a conditional if/else
structure which will run minimap2 in different modes depending on what the
user provides. For instance;   
``
  mode = 'genomic nanopore'

  process minimap2 {
    input:
    path sequences

    script:
    if ( mode = 'genomic nanopore' )
        """
        minimap2 -in $sequences -ax gDNA -nanopore -o out_file
        """
    else if( mode = 'genomic pacbio' )
        """
        minimap2 -in $sequences -axt gDNA -pacbio -o out_file
        """   
    else  
        error "Incorrect sequence type provided" 
    }    
``    

These process scripts can be 'externalised', or in other words, saved as
discreet scripts and reused in other workflows. This is very handy for generic
processes such as read mapping, QC and so forth. No doubt, the commands and
variables between the script and the current workflow must be standardised in
order to allow true plug-play integration.    
``    
  process templateExample {
    input:
    val STR

    script:
    template 'my_script.sh'
  }

  workflow {
      Channel.of('this', 'that') | templateExample
  }
``        

**IMPORTANT**    
* The shell block is a string expression that defines the script
that is executed by the process. It is an alternative to the Script definition
with one important difference: it uses the exclamation mark ! character,
instead of the usual dollar $ character, to denote Nextflow variables.    
* By using the *shell* block rather than the typical *script* module, we can
use both $bash and !nextflow variables within the script without getting them
confused `echo $USER says !{str}`    
* 

#### Input blocks 
These are the portions of the workflow block which we declare the input channels
that we're using. A process has to have at most, and at least, one input block.
The input block follows the basic formality:  
``   
  input:  
    <input qualifer> <input name>    
``    
* The **qualifier** defines the *type* of data that is to be received -- is it
going to be a file path, a value, stdin, an environment, or commonly, a tuple
containing a combination of qualifier for different aspects of the job? A key
to defining input blocks, is that they must be utilised in the process block,
otherwise, they are redundant.  

It is probably best to learn by observing the way the different blocks are used
in a job   
##### Value input block
``
  process valueExample {
    input: 
    val x 

    "echo process job $x"
    }
  workflow {
    def num = Channel.of(1, 2, 3)  
    valueExample(num) 
  }
``   

##### Path input block 
Path is one of the most common input blocks, allowing users to create an input
channel from files contained in a specific directory, or sub-directories and
para-directories.   
``    
  process pathExample {
    input: 
    path protein_alignments 

    "gplot --pdf !{protein_alignments}"  
    }
  workflow {
  def proteins = Channel.fromPath('/path/to/proteins/*.{fa, fna}')
  pathExample(proteins)     
``   
* Quite straight forward no? In some instances, if our input file has a
specific name, we can explicitly specify this `input: path our_file,
name:'this_file.fa'` or even simpler `input: path 'this_file.fa'`            

* The path input type can also accept multiple files, and this must be declared
  in the workflow section to match. What one needs to pay attention to is the
  **.buffer**operator/function, which says that the files will come in sets of
  4, meaning each file will have the same name but with a prefix of 1...4 added
  to it.    
``   
  process multipleFilesExample { 
  input: 
    path funny_data_

    echo funny_data_*
  }
  workflow {
    def fasta = Channe.fromPath( "/some/funny/data/*.fa ).buffer(size: 4)
    multipleFilesExample
    }
``  

##### Env input block   
This essentially consists of creating an $ENVIRONMENT variable which can be
employed within the script. For instance we can create one corresponding to all
of the program versions that we are using in the workflow, and then at the
closure of the workflow, we can print these versions into a .txt file - this is
simply a novice example there are many more potential, and creative ways to use
this.   
``    
  process envExample {
  input:
   env PROGRAMS 

   '''
   echo $PROGRAMS
   ''' 
  }
  workflow {
    Channel.of('julia.1.8', 'minimap2.2.1', 'samtools.9.1', 'nextflow.20.19')  
    }
``      
> julia.1.8 
> minima2.2.1 etc etc ec 

##### STDIN input block 
A bit trickier to wrap ones head around given the fact that nextflow emphasizes
being explicit and employing thoughtful declaration and various symbols.
Nonetheless, learning by example we do.    
``    
  process printAll {
    input:
    stdin str

    """
    cat -
    """
  }

  workflow {
    Channel.of('hello', 'hola', 'bonjour', 'ciao')
      | map { it + '\n' }
      | printAll
  }
``     

##### Tuple input block
One of the most commonly encountered types of input block - as it's a tuple, it
by virtue of its type, will be able to 'store' multiple different values, and
so in nextflow this is also the case. We declare multiple values here. The
tuple values can contain other input blocks such as env, path, val and stdin --
this is what makes it powerful, but also order sensitive.    
``    
  process tupleExample {
      input:
      tuple val(x), path('latin.txt')

      """
      echo "Processing $x"
      cat - latin.txt > copy
      """
  }

  workflow {
    Channel.of( [1, 'alpha'], [2, 'beta'], [3, 'delta'] ) | tupleExample
  }
``   

##### Input iteration 
Let's say we are prototyping a simulation and we are looking to run the same
files with the same program, but with different parameters and options -
iterating through the parameters until we finish. One way of doing that in
nextflow is declaring this in the input block, saying that we have files in
path x, and then for **each** element in the list we provide, we will perform
functions on them.   

``
  process ExpMax {
    input: 
    path files
    each lambda 

    '''
    readsim --in $files --thresh $lambda 
    '''    
    }
  workflow {
    sequences = Channel.fromPath('/data/*.fa')
    values = ['2', '4', '16']   
    ExpMax(sequences, values)     
``   

##### Multiple input channels
We can declare multiple input channels that we wish to source data from -
getting creative we may provide an array of values or different parameters, or
rename file and directories in a specific order... the list of what we can do
is enourmous, and is mostly constrained by the demands of our task at hand.    
``  
  process multipleInputs {
    input: 
    param a
    string b 
    
    """
    echo "program !{b} used with params !{a}" > program-params.txt
    """ 
    }  

  workflow {
    a = Channel.of('1.2', '2.2', '3.2')   
    b = Channel.of('Stringtie-fast', 'Stringtie-deep', 'Stringtie-divergent') 
    multipleInputs(a, b)    
  }     
``     
* "In general, multiple input channels should be used to process combinations
of different inputs, using the each qualifier or value channels. Having
multiple queue channels as inputs is equivalent to using the merge operator,
which is not recommended as it may lead to inputs being combined in a
non-deterministic way."   

### Output blocks 
The output blocks specify where the output data will be funneled to - a path, a
specific file, into a specific value, and so output blocks create channels
which capture the data - often times we can link input/output channels by
declaring them using the exact same name in both input and output. If we create
an output channel and name it X, then if we want to use x as input for the next
process, this is what we declare and specify in the next processes input block. 
``   
  process outputExample {
    input: 
    path g 

    output:
    path g

    script:
    '''
    echo $g > read_ids.txt 
    '''
    }
    workflow {
    echo_ch = channel.fromPath('/files/in/path/*.fastq')
    outputExample(echo_ch) 
    }
``     
We could then use the contents of the output channel (pathnames.txt) as input
for the following process. Alternatively, we could end the output there without
creating another channel, but simply creating an end file `output: path
'reads.txt'`. 

Iterating through a set of files and outputting them in their respective order
can be performed quite smoothly using the correct pairing of glob patterns and
process flows. Say we have several .fq files with different prefixes inside a
directory, and we wanted to run QC on them all and ensure that each QC output
contained the respective matching prefix.   

``
  process something {
    input: 
    path read 

    output: 
    path "fq_qc/*"

    shell:
    '''
    mkdir fq_qc
    fastq !{read} -o fq_qc 
    '''     
    }
    workflow {
    read_ch = channel.fromPath("data/reads/some1*.fq.gz")  
    something(read_ch) 
    }     
``      

* There are some caveats on glob pattern behaviour    
  - Input files are not included in the list of possible matches.     
  - Glob pattern matches against both files and directories path.    
  - When a two stars pattern ** is used to recurse through subdirectories, only
  file paths are matched i.e. directories are not included in the result list.    
* **Remember that we can use variables and string interpolation to specify
unique output channel e.g. output: path reads_${kmer}**  

#### Grouping inputs and outputs 
Sometimes it is redundant to declare an output channel, when a basic output
such as an end file is produced -- particularly when that end file will not be
used as input later on and thus serves as it's own end. To do this we only
specify the input and then declare the script block.  

* Using the tuple declaration we are able to specify multiple output forms,
  such as values, paths, environments and so on. This is how we might undertake
  iteration and keep track of all our files correctly.     
``   
  process FASTP {
    input:
    tuple val(sample_id), path(reads)
  
    output:
    tuple val(sample_id), path("*FP*.fq.gz")
  
    script:
    """
    fastp \
    -i ${reads[0]} \
    -I ${reads[1]} \
    -o ${sample_id}_FP_R1.fq.gz \
    -O ${sample_id}_FP_R2.fq.gz
    """
  }
  reads_ch = Channel.fromFilePairs('data/yeast/reads/ref1_{1,2}.fq.gz')

  workflow {
    FASTP(reads_ch)
  } 
``       

##### Conditional Execution (If, when, for and so on)
As is common in most programming languages, nextflow allows conditional
execution and structuring of the code - running a process only when certain
conditions are met, or for every element in an array, and so on and so on. The
conditions, when declared outside of the script/shell block, are interpreted by
nextflows own logic, but, when they are use into the script block, unless
specified, they will default to shell/bash logic, so it is important to get
these right. Here's a light example.    
``   
  process conditional {
  input:
  val chr

  when:
  chr <= 5 

  script:
  """
  echo $chr
  """ 
  }
  chr_ch = channel.of(1..22)

  workflow {
  conditional(chr_ch)
  }    
``    





### Operators 
Operators are methods which allow you to connect channels, and perform various
manipulations, transforming the channel contents for many means and ends.   

From a naive outsiders perspective, it appears as though operators are similar
to a languages base functions, such as **sort**, **reverse** etc., built in
programs which allow one to do an assortment of common tasks without needing to
create and recreate your own scripts for performing these tasks.   

An example of an operator is the **.view()** , which will allow us to take a
look at what's inside a channel e.g. `this_ch.view()`.     

#### Some notes that I'm temporarily dumping here   
Channel.fromPath
    adaptive_fq = Channel.fromPath()
    non_adaptive_fq = Channel.fromPath()
    genome = Channel.fromPath( '/data/refgenomes/*.{fa,fasta,fna}', checkIfExists: true ) 

params.adaptive_reads = "path to adaptive" 
params.nonadaptive_reads = "path to nonadaptive"


