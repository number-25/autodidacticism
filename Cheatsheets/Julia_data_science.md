# Data Science operations in Julia 

Much of this information is pulled from John Hopkins Data Science Coursera [notes](https://github.com/number-25/ComputationalBiology-for-Autodidacts/blob/main/Course_notes/Coursera_Data_Science_Track_JHOP/Mod3_Data_Cleaning/Week_3/Week3_Notes.ipynb) 

## Filtering 

Filter a data frame, selecting rows meeting a specific condition in column one. This uses vectorisation
```julia
filter(row -> row.col1 > 18, df)
```

Filtering with multiple conditions 
```julia
filter(row -> row.col1 > 18 || row.col2 > 1, df)
```

## Sort

Sort a specific column of a data frame
`sort(df, "col1")` or `sort(df, 1)`

Sort with specific ordering
`sort(df, order("col1", rev=true))` and `sort!(X, ["col1", "col2"], rev=[true, false])`

## Adding rows and columns 

Add a column by indexing into it as if it was there, providing the values to be added to that specific index
```julia
df.col4 = rand(100:200, 5)
```

## Summarising data

Top *n* rows 
`first(df)`

Bottom *n* rows
`last(df)` 

To get a brief summary of the data per column 
`describe(df)`

Output the quantiles of a vector
`quantile!(df.col1, [0.25, 0.5, 0.75, 1.0])`

Quantiles but skipmissing values 
`quantile(skipmissing(X.col3), 0.5)`

Sum the values column-wise 
`sum(eachcol(df))` or `sum.(eachrow(df))` 

Sum the values row-wise 
`sum.(collect(eachcol(df))` or `sum.(eachcol(df))`  

Sum the values and skip missing values
`sum.(skipmissing.(eachrow(df)))`

Size of the data in human-readable form 
`varinfo(df)`

Get the names of our dataframe columns
`names(df)`

## Missing values 

Get a sum of the number of missing values in a column 
`sum(c -> ismissing(x), df.col3)`

A boolean for whether there is ANY missing values in a column
`any(x -> ismissing(x), df.col3)`

Get only the rows which contain missing values 
`filter(x -> ismissing(x, df), df)`

## Split-apply-combine-subsetting

Get a dataframe in which the values in the first column are 1
`filter(row -> row.col1 == 1, df)`

Another more complex condition
`filter(row -> row.col1 > 1 && row.col1 < 15, df)`

Create a sequence of indices 
`seq_one = collect(1:3:10)` or `seq_one = Vector(1:3:10)` 

Melting and stacking

**The main idea behind melting is the presence of "id" and "value" variables -
the ID variables will represent the consistent identifiers we want to retain,
and the value variables will be "stacked" to form a group with its own column -
almost like a sub-data frame - it's hard to imagine but easier to understand
once we play with it a little bit ourselves - so when performing the melt and
stack functions, we need to always designate these two variables.**
```julia
mt_stack = stack(mtcars, [:MPG, :HP], [:Model, :Gear, :Cyl])
```
Casting 

Imagine we want to get a quick overview of how many values of a certain
variable we have in our dataset - say, the distribution of miles per gallon and
horse power based upon the cylinders a car has - the relation between cylinders
and engine performance. This is a littler trickier in Julia as there's not as
much supporting documentation yet, but this is called a "pivot table" in Julia
-- bogumil (who else?!) has a great post
[here](https://www.juliabloggers.com/pivot-tables-in-dataframes-jl/)
```julia
unstack(mt_stack, :Cyl, :variable, :Cyl, combine=length)

# Get the mean of these measures rather than length
unstack(mt_stack, :Cyl, :variable, :value, combine=mean)
```

Grouped dataframe with groups based on a specific variable - in this case Cylinder size
`groupby(df, :Cyl)`

Almost everything covered herein appears to be described somewhere on the
DataFrames.jl package site
https://dataframes.juliadata.org/stable/man/split_apply_combine/ and/or on the
DataFramesMeta site https://juliadata.org/DataFramesMeta.jl/stable/dplyr/ . It
may take some googling and forum scouring, but rest assured that the developers
have considered many many procedures and functions. As such it is best to work
through Bogumil's book and create your own projects that you're interested in -
passion and curiosity as the backbones of science and inquiry!

## Merging/Joining data

Joining datasets together is a common operation, especially within SQL - we can
think of the common terminology of inner join, outer join and so on that's
almost synonymous with databases 

Inner join - here we will join based on a shared ID between data frames/tables
```julia
people = DataFrame(ID=[20, 40], Name=["John Doe", "Jane Doe"])
jobs = DataFrame(ID=[20, 40], Job=["Lawyer", "Doctor"])
innerjoin(people, jobs, on = :ID)
```

Outer join
```julia
breaks = DataFrame(ID=[20, 60], Fruit=["Apple", "Watermelon"])
outerjoin(breaks, people, jobs, on = :ID)
```

## Creating binary-boolean variables

Create a vector of binary/boolean values based upon whether a specific column in a dataframe met a condition - the values in this new vector would be 1 if the condition is met and 0 if it isn't
`rest_data.nearMe = in.(rest_data.areacode, [["Sunnybank", "Runcorn"]])`

Do the same thing in a different fashion using the **ifelse()** funtion. This would isolate entries which have incorrectly formatted area codes 
`rest_data.wrongZip = ifelse.(rest_data.zipCode .< 0, true, false)` 

Summarise this binary-boolean using **countmap()** from the StatsBase.jl package
```julia
using StatsBase
countmap(rest_data.nearMe)
```
> Dict{Bool, Int64}(0 => 1314, 1 => 13)

## Creating categorical variables
We may want to summarise certain aspects of our dataset by chunking them into
categorical blocks - similar to percentiles. Say we want to get a look at the
distribution of gene lengths or zip codes in our dataset, at quartile ranges -
we can turn to categorical variables. For this we need the CategoricalArrays.jl package 

"Cut" the column into 4 quadrants/quintiles
`cut(df.col1, 4)`

Count the occurance of values in each quadrant
`countmap(cut(rest_data.zipCode, 4))`

## Frequency Tables 
We have to use the package [FreqTables.jl](https://github.com/nalimilan/FreqTables.jl)

Create a basic frequency table based on two select columns 
`freqtable(df, :col1, col:4)`

## Connecting to databases 

### SQL 

This will use the MySQL.jl package

Connect to the UCSC genome browser MySQL portal
`ucscDB = DBInterface.connect(MySQL.Connection, "genome-mysql.soe.ucsc.edu", "genome")`
Query the serve and store the query in a dataframe 
`result = DBInterface.execute(ucscDB, "show databases") |> DataFrame;` 
Is a certain genome build in the list?
`"hg38" in result.Database`       
Close the connection
`DBInterface.close!(ucscDB)`  

Another query - connect to the hg38 genome db 
`hg38 = DBInterface.connect(MySQL.Connection, "genome-mysql.soe.ucsc.edu", "genome", db="hg38")`
Get a list of all the available UCSC tables
`hg38Tables = DBInterface.execute(hg38, "show tables") |> DataFrame;`

Ask how many rows a specific table in the db contains
`countmRNA = DBInterface.execute(hg38, "select count(*) from all_mrna") |> DataFrame;`
Put the table into a dataframe now - the mRNA annotations
`mrnaData = DBInterface.execute(hg38, "select * from all_mrna;") |> DataFrame`

Some more refined queries 
`query = DBInterface.execute(hg38, "select * from all_mrna where misMatches between 1 and 3") |> DataFrame`

### HDF5 
HDF5 is a data format used for storing large datasets - FAST5 uses a HDF5 backbone, and we know how large FAST5 files are!!! It stands for Heirarchical Data Format. We will be working with the julia library HDF5.jl 

**"HDF5 stands for Hierarchical Data Format v5 and is closely modeled on file
systems. In HDF5, a "group" is analogous to a directory, a "dataset" is like a
file. HDF5 also uses "attributes" to associate metadata with a particular group
or dataset. HDF5 uses ASCII names for these different objects, and objects can
be accessed by Unix-like pathnames, e.g., "/sample1/tempsensor/firsttrial" for
a top-level group "sample1", a subgroup "tempsensor", and a dataset
"firsttrial"."**

Write an example file 
```julia
example_hd = h5open("example.h5", "cw")`
close(example_hd)
```

Since HDF5 files are hierarchical and based upon a file-system like structure,
we create groups. Once we have groups, we write to the groups, and perhaps
subgroups, subsubgroups etc. - remember, HDF5 is akin to a filesystem
```julia
create_group(example_hd, "foo")
samp = Array(rand(2,4))
example_hd["newgroup"] = "yes"
# To write to a pre-existing group, first initialize and load it into a variable
g = example_hd["foo"]
# Write to it by indexing 
g["mydataset"] = samp
g["mydataset"] = rand(3,5)
# Write to it using the create_dataset() function
create_dataset(g, "simplestring", zeros(1, 2))
```

Read the contents of the groups using the read() function
`create_dataset(g, "simplestring", zeros(1, 2))`

Read specific parts of the hierarchy
```julia
openh5 = h5open("example.h5", "r+")
read(openh5,"foo/mydataset")
```
For convience and consistency we can also use the do block conventions, which will take care of closing the stream for us
```julia
h5open("example.h5", "r+") do stream
    group = create_group(stream, "dogroup")
    dataset = create_dataset(group, "thisdata", Float64, (10,10))
    write(dataset, rand(10,10))
end 
```

### XML and Xpath 
A basic explanation of the use of XML in Julia is provided by a XML.jl snippet from github. Jeff Leek recommends this presentation as a nice [intro](https://www.stat.berkeley.edu/users/statcur/Workshop2/Presentations/XML.pdf)

```julia
filename = joinpath(dirname(pathof(XML)), "..", "test", "data", "books.xml")
doc = read(filename, Node)
children(doc)
# 2-Element Vector{Node}:
#  Node Declaration <?xml version="1.0"?>
#  Node Element <catalog> (12 children)

doc[end]  # The root node
# Node Element <catalog> (12 children)

doc[end][2]  # Second child of root
# Node Element <book id="bk102"> (6 children)
```

Find texts using an XPath query 
```julia
for species_name in nodecontent.(findall("//species/text()", primates))
    println("- ", species_name)
end
```

Parse a HTML file as an XML and query it. We'll use the EzXML.jl library. The basic steps are -
1. Load HTTP package, perform a HTTP get request on the url
2. Parse the URL as a string by accessing the requests body
3. Using the EzXML package, parse the html string using parsehtml()
4. Use the xpath query language with findall() and nodecontent() to extract the relevant information from the file
```julia
samp = HTTP.get(url, cookies=true);
data = String(samp.body)
q = parsehtml(data)
scholar_root = root(q)

# Using the nodecontent.() function of EzXML, find your query using the xpath language
nodecontent.(findall("//title", scholar_root))
# And a more elaborate query 
for citation in nodecontent.(findall("//td[@id='col-citedby']", scholar_root))
    println(citation)
end
```

### Excel XLSX 
Julia has it's own package for excel file, aptly titled "XLSX"

Reading an excel file in Julia is done in it's most basic form as XLSX.readxlsx("data') or XLSX.readdata("data", args...) - the documentation will be the best place to start. The inverse function XLSX.writexlsx("data) will appropriately write excel data.

## Real case examples 

### Subsetting 
"Create a logical vector that identifies the households on greater than 10
acres who sold more than $10,000 worth of agriculture products. Identify the rows of the data frame where the logical vector is TRUE."

```julia 
subset(first_q, :AGS => ByRow(==(6)), :ACR => ByRow(==(3)), skipmissing=true)`
first_q.largeLand = ifelse.((ismissing.(first_q.AGS)) .| (first_q.AGS .!= 6) .| (first_q.ACR .!= 3), false, true)
countmap(first_q.largeLand)
findall(first_q.largeLand .== 1)
```

"Match the data based on the country shortcode. How many of the IDs match? Sort
the data frame in descending order by GDP rank (so United States is last). What
is the 13th country in the resulting data frame?"

```julia
gdp_raw = CSV.read("gdp.csv", DataFrame, skipto=6, header=4) 
gdp_raw_nomissing = dropmissing(gdp_raw[:, [:1, :2, :4, :5]])
gdp_cleaned = rename!(gdp_raw_nomissing, ["CountryCode", "Rank", "Country", "US_dollars"])

gdp_cleaned.US_dollars .= replace.(gdp_cleaned.US_dollars, "," => "")
gdp_cleaned.US_dollars = parse.(Int, gdp_cleaned.US_dollars)
gdp_cleaned.Rank = parse.(Int, gdp_cleaned.Rank)

edu_raw = CSV.read("education.csv", DataFrame)
gdp_edu = innerjoin(gdp_cleaned, edu_raw, on=:CountryCode)
sort!(gdp_edu, :US_dollars, rev=false)
```

"What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?"

```julia
high_non = filter(row -> row.var"Income Group" == "High income: nonOECD", gdp_edu)
mean.(eachcol(high_non.Rank))
```


### Quantiles 
"Read in the following picture into Julia. What are the 30th and 80th quantiles
of the resulting data? (some Linux systems may produce an answer 638 different
for the 30th quantile)

```julia
download("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "leek.jpg")
Pkg.add(["ImageIO", "Images", "ImageMagick", "FileIO"]) ; using ImageIO, FileIO, ImageMagick
```

"Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?"

```julia
countmap(cut(gdp_edu.Rank, 5))
gdp_edu.quartile = cut(gdp_edu.Rank, 5)

stacked_income_quartile = stack(gdp_edu, :"Income Group", :quartile)
lower_middle_income_quartile = filter(row -> row.value == "Lower middle income", stacked_income_quartile)
countmap(lower_middle_income_quartile.quartile)
```






