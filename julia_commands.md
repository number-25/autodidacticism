# Goal
Take the csv file containing two columns, the first contains the reads, and
the second contains the query mapping. The goal of the analysis here is to
attempt to merge/impute closely spaced but discontinuous reads which map to the same query, thus 'reconstructing' the single transcript. As such, a basic
dictionary mapping will be created whereby the query read serves as the key,
and the reads mapping to the query as the values. Only those with multiple
mappings will be included. 




##### Load comma delimited file into julia as a string
```julia 
prot_raw = readlines(open("blastn_dRNA_cDNA_merged_to_refseq_dustmsk_many_to_one_protcoding_col1_2.csv"))

noncod_raw = readlines(open("blastn_dRNA_cDNA_merged_to_refseq_dustmsk_many_to_one_noncoding_col1_2.csv"))
```

##### Create an empty Dict to house read to gene mappings
```julia
using OrderedCollections

read_gene_mapping_prot = OrderedDict()
read_gene_mapping_noncod = OrderedDict()
```

##### Get the second column of reference mappings by itself
```julia
split_vector_prot = []
for row in prot_raw
    split_row = split(row, ',')
    push!(split_vector_prot, split_row[2])
end

split_vector_noncod = []
for row in noncod_raw
    split_row = split(row, ',')
    push!(split_vector_noncod, split_row[2])
end
```

##### Iterate through raw file and seed Dict 

Functioning code which seems to do what we want 
```julia
for row in split_vector_prot
    mapping_array = []
    for line in prot_raw
        split_line_prot = split(line, ',')
        if occursin(row, split_line_prot[2]) && split_line_prot[1] ∉ mapping_array
            push!(mapping_array, split_line_prot[1])
        elseif !occursin(row, split_line_prot[2])
            read_gene_mapping_prot[row] = mapping_array
        end
    end
end

for row in split_vector_noncod
    mapping_array = []
    for line in noncod_raw
        split_line_noncod = split(line, ',')
        if occursin(row, split_line_noncod[2]) && split_line_noncod[1] ∉ mapping_array
            push!(mapping_array, split_line_noncod[1])
        elseif !occursin(row, split_line_noncod[2])
            read_gene_mapping_noncod[row] = mapping_array
        end
    end
end
```


#### Write to file 
```julia
run(`touch "blastn_dRNA_cDNA_merged_to_refseq_dustmsk_many_to_one_protcoding_dict.tsv"`) 

open("blastn_dRNA_cDNA_merged_to_refseq_dustmsk_many_to_one_protcoding_dict.tsv", "r+") do writer
    for (key, value) in collect(read_gene_mapping_prot)
        the_key = key
        the_values = collect(value)
        if length(the_values) > 1 
            joined_values = join(the_values, ',')
            write(writer, "$the_key\t$joined_values\n")
        end
    end
end
```


# Create a bed file for each gene-read mapping 

Read the lines from the newly created mapping -> take the second column
containing the mapping reads by splitting using the tab delimiter -> split this
newly extracted column once more using the comma delimiter as they are
separated this way -> parse the chromosome name, the start and end co-ordinates
for each mapping and then re-join them using tab delimiter to conform to the
BED3 format. From here, a new bed file can be written, and worked on using bedtools `run(`bedtools <something>`)` 

```julia
first_row = readlines(open("blastn_dRNA_cDNA_merged_to_refseq_dustmsk_many_to_one_protcoding_dict.tsv"))[1]
first_row_values = split(first_row, "\t")[2]
# chop whitespace from string ends before or after? 
first_row_key = split(first_row, "\t")[1] 
split_first_row_values = split(first_row_values, ',')
```

Working code to create a local bed file from the rows in the dict mapping created above. Turn this into a function. This will take as argument, an already split row, 
```julia
function localBedGen(split_row)
    open("tmp.bed", "w") do writer
        for row in split_row
            split_values = split(row, [':', '-'])
            joined_tab_row = join(split_values, '\t')
            write(writer, "$joined_tab_row\n")
        end 
    end
end
```

Perform a distance calculation using bedtools, get the min, mean and median
distance between reads mapping to the same query. Do this for all the
read-query mappings, then decide on a suitable distance to merge the elements.
After the merging, we'll perform a subtract in order to preserve only the
merged reads, from which the fasta sequence will be extracted, and the reads
re-mapped using diamond/blast. One other option to use as a comparison is to merge all the reads mapping to the same query and perform this mapping as well, comparing whether there are any differences between the two sets.  

```bash
bedtools closest -io -d -a <bed> -b <bed> | cut -f 7 | datamash min 1 mean 1 median 1 | datamash round 1 round 2 round 3
```

Do execute bash/terminal command in julia, we can use the `run()` function, making sure to escape or quote any special characters such as pipe symbols `|`. Do make things a little easier, we can combine `run()` with `pipeline()` and place each different section of the pipe in it's own statement - see;
```julia
run(pipeline(`bedtools closest -io -d -a tmp.bed -b tmp.bed`, `cut -f 7`, `datamash min 1 mean 1 median 1`, `datamash round 1 round 2 round 3`))
```

The `run(pipeline())` combination is adequate if the pipeline contains only a single command, but runs into IO problems if more complicated combinations are used. Instead, to access the output we can use the `read` function. 
```julia
closest_values = read(pipeline(`bedtools closest -io -d -a tmp.bed -b tmp.bed`, `cut -f 7`, `datamash min 1 mean 1 median 1`, `datamash round 1 round 2 round 3`), String)
```
> "944\t3755\t2301\n" 

Join these outputs to the query mapping. This will give a row which contains the name of the query, followed by the minimum distance between the read mappings, the mean and then the median distance. 
```julia
query_closest = join([first_row_key, closest_values], '\t')
```

Encapsulate the above in a function 
```julia
function bedtoolsClosest(row_key)
     closest_values = read(pipeline(`bedtools closest -io -d -a tmp.bed -b tmp.bed`, `cut -f 7`, `datamash min 1 mean 1 median 1`, `datamash round 1 round 2 round 3`), String)
     query_closest = join([row_key, closest_values], '\t')
     query_closest
end
```

```julia
function query_map_statistics(query_read_map)
    key_value_bed = readlines(open(query_read_map))
    for entry in key_value_bed
    @show row
        row_values = split(entry, "\t")[2]
    # chop whitespace from string ends before or after? 
        row_key = split(entry, "\t")[1]
        @show split_row_values = split(row_values, ',')
        localBedGen(split_row_values)
        # perform bedtools operations 
        query_closest = bedtoolsClosest(row_key)
        open("closest_queries.tsv", 'w') do writer
            write(writer, "$query_closest\n") 
        end 
        # write the joined key with the descriptive statistics to a new 
        # line in a new file, ensuring that the file will be appended too not overwritten 
        # remove tmp.bed and proceed to next row
    end
end 

```

I would then write this line to a file, and get the distribution of the descriptive statistics, from which I could decide on the distance for merging. 

Those queries which have reads merged will be put in their own subset and then
subjected to remapping - the problem is then what we should do with those reads
which map to a query which has been merged, but it itself was not merged -
would this be handled with a bedtools subtract or intersect -v ? This way we
still retain them? 

What's also the goal when these merged reads do indeed map to the same query - do we re-incorporate them? Or put them to the side themselves?     

then bedtools merge -d N , bedtools subtract 


---------------------------------------------------------------------------
#### Old, not yet functional code - experimental 
```julia
for pair in collect(thisdict)
           @show firstone = pair.first
           @show secondone = pair.second
           @show joined_second = join(secondone, ',')
           #join(firstone, joined_second, '\t')
       end
```

zip/join/enumerate/collect

```julia
   for line in eachrow(tsv_df)
           if line[2] ∉ keys(read_to_gene_dict)
               read_to_gene_dict[line[2]] = line[1]
           else
               push!(read_to_gene_dict[line[2]], line[1])
           end
       end
```
